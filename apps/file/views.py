import os

from django.http import StreamingHttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, JSONParser

from KubeOps.settings import SFTP_DIR
from .utils import ssh_put, file_iterator, ssh_get
from monitor.utils import get_net_name, get_ip


class FilesView(APIView):
    """
    文件上传
    """
    parser_classes = (MultiPartParser, JSONParser)

    def post(self, request, *args, **kwargs):
        server_info = eval(request.data.get('args'))
        files = request.FILES.getlist('file', None)
        ip = server_info.get('ip')
        port = int(server_info.get('port'))
        username = server_info.get('username')
        password = server_info.get('password')
        remote_path = server_info.get('path')
        try:
            # 获取本地IP
            network_name = get_net_name()
            local_ip = get_ip(network_name)
            if local_ip == ip:
                for file_obj in files:
                    file_path = os.path.join(remote_path, file_obj.name)
                    with open(file_path, 'wb') as f:
                        for chunk in file_obj.chunks():
                            f.write(chunk)
            else:
                for file_obj in files:
                    file_path = os.path.join(SFTP_DIR, file_obj.name)
                    with open(file_path, 'wb') as f:
                        for chunk in file_obj.chunks():
                            f.write(chunk)
                    remote_path = remote_path + '/' + file_obj.name
                    ssh_put(ip=ip, port=port, username=username, password=password, local_path=file_path,
                            remote_path=remote_path)
        except Exception as e:
            print(e)
            return Response({'status': 400, 'message': e})
        return Response({'status': 200, 'message': '上传成功!'})


class DownloadView(APIView):
    """
    文件下载
    """

    def post(self, request, *args, **kwargs):
        ip = request.data.get('ip')
        port = int(request.data.get('port'))
        username = request.data.get('username')
        password = request.data.get('password')
        filename = request.data.get('path')
        # 获取本地IP
        network_name = get_net_name()
        local_ip = get_ip(network_name)
        if local_ip == ip:
            response = StreamingHttpResponse(file_iterator(filename))
            response['Content-Type'] = 'application/octet-stream'
            response['Content-Disposition'] = 'attachment;filename="{0}"'.format(filename)
            return response
        else:
            tmp_file = os.path.join(SFTP_DIR, filename.split('/')[-1])
            ssh_get(ip=ip, port=port, username=username, password=password, local_path=tmp_file, remote_path=filename)
            response = StreamingHttpResponse(file_iterator(tmp_file))
            response['Content-Type'] = 'application/octet-stream'
            response['Content-Disposition'] = 'attachment;filename="{0}"'.format(filename)
            return response

    def put(self, request, *args, **kwargs):
        """
        删除临时文件
        """
        filename = request.data.get('path')
        print(filename)
        ip = request.data.get('ip')
        network_name = get_net_name()
        local_ip = get_ip(network_name)
        if local_ip != ip:
            tmp_file = os.path.join(SFTP_DIR, filename.split('/')[-1])
            os.remove(tmp_file)
        return Response({'message': 'deleted'})
