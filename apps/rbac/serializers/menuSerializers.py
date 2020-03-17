from rest_framework import serializers

from rbac.models import Menu


class MenuSerializer(serializers.ModelSerializer):
    """
    角色列表序列化
    """

    class Meta:
        model = Menu
        fields = '__all__'
