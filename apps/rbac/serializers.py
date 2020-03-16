from rest_framework import serializers
from rbac import models
from django.contrib.auth.hashers import make_password
from rest_framework.validators import UniqueValidator


class UserCreateSerializer(serializers.ModelSerializer):
    """
    创建用户序列化
    """
    username = serializers.CharField(required=True, allow_blank=False, help_text='用户名', label='用户名', validators=[
        UniqueValidator(queryset=models.UserInfo.objects.all(), message='用户已存在')])
    password = serializers.CharField(required=True, write_only=True, help_text='密码', label='密码',
                                     style={'input_type': 'password'})

    class Meta:
        model = models.UserInfo
        fields = ['id', 'username', 'password', 'mobile', 'email',
                  'department', 'position', 'roles']

    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        user = super(UserCreateSerializer, self).create(validated_data=validated_data)
        user.save()
        return user


class UserListSerializer(serializers.ModelSerializer):
    """
    用户列表的序列化
    """
    roles = serializers.SerializerMethodField()

    def get_roles(self, row):
        try:
            role_obj = row.roles.name
        except Exception:
            return
        return role_obj

    class Meta:
        model = models.UserInfo
        fields = ['id', 'username', 'mobile', 'email', 'create_time', 'active', 'roles']
        depth = 1


class UserUpdateSerializer(serializers.ModelSerializer):
    """
    修改用户信息
    """

    class Meta:
        model = models.UserInfo
        fields = ['username', 'mobile', 'email', 'active', 'roles']
