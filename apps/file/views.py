import os
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser

from KubeOps.settings import SFTP_DIR
from .utils import ssh_put


class FileUploadView(APIView):
    """
    文件上传
    """
    parser_classes = (MultiPartParser,)

    def post(self, request, *args, **kwargs):
        server_info = eval(request.data.get('args'))
        files = request.FILES.getlist('file', None)
        ip = server_info.get('ip')
        port = int(server_info.get('port'))
        username = server_info.get('username')
        password = server_info.get('password')
        remote_path = server_info.get('path')
        try:
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
