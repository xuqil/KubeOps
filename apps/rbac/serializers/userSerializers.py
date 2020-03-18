from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.hashers import make_password

from rbac.models import UserProfile


class UserCreateSerializer(serializers.ModelSerializer):
    """
    创建用户序列化
    """
    username = serializers.CharField(required=True, allow_blank=False, help_text='用户名', label='用户名', validators=[
        UniqueValidator(queryset=UserProfile.objects.all(), message='用户已存在')])
    password = serializers.CharField(required=True, write_only=True, help_text='密码', label='密码',
                                     style={'input_type': 'password'})

    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'password', 'mobile', 'email', 'roles']

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

    def get_roles(self, obj):
        return obj.roles.values()

    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'mobile', 'email', 'c_time', 'active', 'roles']


class UserUpdateSerializer(serializers.ModelSerializer):
    """
    修改用户信息
    """
    username = serializers.CharField(required=False, read_only=True, allow_blank=False, help_text='用户名', label='用户名',
                                     validators=[UniqueValidator(queryset=UserProfile.objects.all(), message='用户已存在')])
    active = serializers.BooleanField(required=False, allow_null=True)

    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'mobile', 'email', 'active', 'roles']
