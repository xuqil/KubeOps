from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.hashers import make_password, check_password

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
        fields = ['id', 'username', 'password', 'mobile', 'email']

    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        user = super(UserCreateSerializer, self).create(validated_data=validated_data)
        user.save()
        return user


class UserUpdatePasswordSerializer(serializers.ModelSerializer):
    """
    修改用户密码序列化
    """
    old_password = serializers.CharField(required=True, max_length=100)
    password = serializers.CharField(required=True, max_length=100)

    class Meta:
        model = UserProfile
        fields = ['password', 'old_password']

    def validate(self, data):
        username = self.context.get('request').user.get('data').get('username')
        user_password = UserProfile.objects.filter(username=username).first().password
        if not check_password(data.get('old_password'), user_password):
            raise serializers.ValidationError({'old_password': '密码错误.'})
        return data

    def update(self, instance, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        user = super(UserUpdatePasswordSerializer, self).update(instance, validated_data=validated_data)
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

    class Meta:
        model = UserProfile
        fields = ['username', 'mobile', 'email', 'active', 'roles']


class UserUpdateRolesSerializer(serializers.ModelSerializer):
    """
    修改用户角色信息
    """

    class Meta:
        model = UserProfile
        fields = ['roles']


class UserUpdateActiveSerializer(serializers.ModelSerializer):
    """
    修改用户状态信息
    """

    class Meta:
        model = UserProfile
        fields = ['active']


class UserUpdateOtherActiveSerializer(serializers.ModelSerializer):
    """
    修改用户其他信息
    """
    username = serializers.CharField(required=True, allow_blank=False, help_text='用户名', label='用户名', validators=[
        UniqueValidator(queryset=UserProfile.objects.all(), message='用户已存在')])

    class Meta:
        model = UserProfile
        fields = ['username', 'mobile', 'email']
