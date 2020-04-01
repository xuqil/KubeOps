import os
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser

from KubeOps.settings import SFTP_DIR


class FileUploadView(APIView):
    parser_classes = (MultiPartParser,)

    def post(self, request, *args, **kwargs):
        server_info = request.POST.get('args')
        print(server_info)
        files = request.FILES.getlist('file', None)
        print(files)
        for file_obj in files:
            file_path = os.path.join(SFTP_DIR, file_obj.name)
            if not os.path.isfile(file_path):
                with open(file_path, 'wb') as f:
                    for chunk in file_obj.chunks():
                        f.write(chunk)
            else:
                pass
        return Response({'status': 200, 'message': '上传成功!'})
