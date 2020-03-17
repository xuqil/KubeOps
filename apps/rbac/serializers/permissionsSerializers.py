from rest_framework import serializers

from rbac.models import Permissions


class PermissionListSerializer(serializers.ModelSerializer):
    """
    角色列表序列化
    """

    class Meta:
        model = Permissions
        fields = ['id', 'title', 'path', 'action', 'pid']
