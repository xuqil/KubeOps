from rest_framework import serializers

from rbac.models import Permissions


class PermissionSerializer(serializers.ModelSerializer):
    """
    权限列化
    """

    class Meta:
        model = Permissions
        fields = ['id', 'title', 'path', 'action', 'pid']
