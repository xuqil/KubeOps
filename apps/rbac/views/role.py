from rest_framework.viewsets import ModelViewSet

from rbac.models import Role
from rbac.serializers import rolesSerializers


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
