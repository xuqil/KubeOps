from django.apps import apps
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet

from KubeOps import urls
from rbac.models import Permission
from rbac.serializers import permissionSerializers
from utils.pagination import MaxPagination
from utils.permissions import get_all_paths


class PermissionView(ModelViewSet):
    """
    权限管理
    """
    pagination_class = MaxPagination
    queryset = Permission.objects.all()
    serializer_class = permissionSerializers.PermissionSerializer


class InitPermission(APIView):
    """
    初始化权限表
    """

    def get(self, request, *args, **kwargs):
        methods = {'GET': '查看', 'POST': '添加', 'DELETE': '删除', 'PUT': '修改'}
        model = apps.get_models()
        try:
            for i in model:
                if i._meta.app_label in ['auth', 'contenttypes', 'sessions']:
                    continue
                for method, desc in methods.items():
                    Permission.objects.update_or_create(method=method, name=str(desc) + str(i._meta.verbose_name))
        except Exception as e:
            print(e)
            content = {'msg': '初始化失败!'}
            return Response(content, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        return Response({'msg': '初始化成功!'})


class PermissionPath(APIView):
    """
    获取权限path
    """

    def get(self, request, *args, **kwargs):
        path = get_all_paths(urls.urlpatterns, pre_fix="/", result=[], )
        result = list(map(lambda x: '/' + x, path))
        return Response({'path': result})
