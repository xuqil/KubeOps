from django.contrib.auth.hashers import check_password
from collections import defaultdict
from django.utils import timezone

from rest_framework import status
from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import mixins
from rest_framework.response import Response
from rest_framework.generics import UpdateAPIView

from rbac.models import *
from utils.jwt_token import create_token
from rbac.serializers import userSerializers


class UsersCreateView(mixins.CreateModelMixin, mixins.UpdateModelMixin, mixins.RetrieveModelMixin,
                      viewsets.GenericViewSet):
    """
    添加用户，修改本人信息
    """
    queryset = UserProfile.objects.all()
    authentication_classes = []
    permission_classes = []
    serializer_class = userSerializers.UserCreateSerializer

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.flag = 0

    def get_serializer_class(self):
        if self.action == 'partial_update' or self.action == 'update':
            if self.flag == 1:
                return userSerializers.UserUpdateOtherActiveSerializer
            return userSerializers.UserCreateSerializer
        return userSerializers.UserCreateSerializer

    def update(self, request, *args, **kwargs):
        if request.data.get('password') is None and request.data.get('username') is not None:
            self.flag = 1
        result = super(UsersCreateView, self).update(request, *args, **kwargs)
        return result


class UpdatePasswordView(UpdateAPIView):
    """
    修改登录用户密码
    提示：通过token获取用户信息
    """
    serializer_class = userSerializers.UserUpdatePasswordSerializer
    model = UserProfile

    def get_object(self, queryset=None):
        username = self.request.user.get('data').get('username')
        user_obj = UserProfile.objects.filter(username=username).first()
        return user_obj


class LoginView(APIView):
    """
    用户登录
    """
    authentication_classes = []
    permission_classes = []

    def post(self, request, *args, **kwargs):
        """ 用户登录 """
        username = request.POST.get('username')
        password = request.POST.get('password')
        user_obj = UserProfile.objects.filter(username=username).first()
        if not user_obj:
            return Response({'msg': '用户或密码错误'}, status=status.HTTP_403_FORBIDDEN)
        db_password = UserProfile.objects.filter(username=username).first().password
        if not check_password(password=password, encoded=db_password):
            return Response({'msg': '用户或密码错误'}, status=status.HTTP_403_FORBIDDEN)
        if user_obj.is_active is False:
            return Response({'msg': '该用户已被禁止登录!'}, status=status.HTTP_403_FORBIDDEN)
        permissions_list = user_obj.roles.all().values('permissions__method', 'permissions__path')
        permissions = defaultdict(list)
        for i in permissions_list:
            permissions[i.get('permissions__path')].append(i.get('permissions__method'))
        for key in permissions.keys():
            permissions[key] = list(set(permissions[key]))
        pk = user_obj.id
        token = create_token({'username': username, 'permissions': permissions}, 1440)
        UserProfile.objects.filter(username=username).update(last_login=timezone.now())
        return Response({'id': pk, 'username': username, 'token': token})


class UsersListUpdateView(viewsets.ModelViewSet):
    """
    多个用户信息的改和查
    """
    queryset = UserProfile.objects.all()
    serializer_class = userSerializers.UserListSerializer

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.flag = 0

    def get_serializer_class(self):
        if self.action == 'partial_update' or self.action == 'update':
            if self.flag == 1:
                return userSerializers.UserUpdateActiveSerializer
            elif self.flag == 2:
                return userSerializers.UserUpdateRolesSerializer
            elif self.flag == 3:
                return userSerializers.UserUpdateOtherActiveSerializer
            elif self.flag == 4:
                return userSerializers.UserUpdateStaffSerializer
            return userSerializers.UserUpdateSerializer
        return userSerializers.UserListSerializer

    def update(self, request, *args, **kwargs):
        if request.data.get('is_active') is not None:
            self.flag = 1
        elif request.data.get('roles') is not None:
            self.flag = 2
        elif request.data.get('mobile') is not None:
            self.flag = 3
        elif request.data.get('is_staff') is not None:
            self.flag = 4
        result = super(UsersListUpdateView, self).update(request, *args, **kwargs)
        return result
