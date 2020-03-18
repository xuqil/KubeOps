from rest_framework import serializers

from rbac.models import Role


class RoleListSerializer(serializers.ModelSerializer):
    """
    角色列表序列化
    """

    class Meta:
        model = Role
        fields = '__all__'
        depth = 1


class RoleModifySerializer(serializers.ModelSerializer):
    """
    角色增删改序列化
    """
    title = serializers.CharField(required=False)

    class Meta:
        model = Role
        fields = '__all__'
