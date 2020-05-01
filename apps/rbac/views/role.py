from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet

from rbac.models import Role
from rbac.serializers import rolesSerializers
from utils.tree import treeFilter


class RoleView(ModelViewSet):
    """
    角色管理
    """
    queryset = Role.objects.all()
    serializer_class = rolesSerializers.RoleListSerializer

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return rolesSerializers.RoleListSerializer
        return rolesSerializers.RoleModifySerializer

    def list(self, request, *args, **kwargs):
        """
        树型化权限和菜单
        """
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            for item in serializer.data:
                permissions = treeFilter(item['permissions'])
                menus = treeFilter(item['menus'])
                item['permissions'] = permissions
                item['menus'] = menus
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        for item in serializer.data:
            permissions = treeFilter(item['permissions'])
            menus = treeFilter(item['menus'])
            item['permissions'] = permissions
            item['menus'] = menus
        return Response(serializer.data)

    def retrieve(self, request, *args, **kwargs):
        """
        树型化权限和菜单
        """
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        permissions = treeFilter(serializer.data['permissions'])
        menus = treeFilter(serializer.data['menus'])
        serializer.data['permissions'] = permissions
        serializer.data['menus'] = menus
        return Response(serializer.data)

