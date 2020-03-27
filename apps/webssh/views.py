from rest_framework.views import APIView
from rest_framework.response import Response
import os

from webssh.utils.tools import unique
from KubeOps.settings import TMP_DIR


class UploadSHHKey(APIView):
    """
    上传SSH KEY
    """
    def post(self, request, *args, **kwargs):
        pkey = request.FILES.get('pkey')
        ssh_key = pkey.read().decode('utf-8')
        while True:
            filename = unique()
            ssh_key_path = os.path.join(TMP_DIR, filename)
            if not os.path.isfile(ssh_key_path):
                with open(ssh_key_path, 'w') as f:
                    f.write(ssh_key)
                break
            else:
                return

        return Response(filename)
