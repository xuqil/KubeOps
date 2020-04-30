from rest_framework import serializers

from rbac.models import Permission


class PermissionSerializer(serializers.ModelSerializer):
    """
    权限列化
    """

    class Meta:
        model = Permission
        fields = '__all__'
