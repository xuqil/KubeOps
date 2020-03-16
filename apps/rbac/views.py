from django.contrib.auth.hashers import check_password

from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import mixins
from rest_framework import generics
from rest_framework.response import Response

from rbac import models
from utils.jwt_token import create_token
from rbac import serializers


class UsersCreateView(mixins.CreateModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet):
    """
    添加用户
    """
    queryset = models.UserInfo.objects.all()
    authentication_classes = []
    serializer_class = serializers.UserCreateSerializer


class LoginView(APIView):
    """
    用户登录
    """
    authentication_classes = []

    def post(self, request, *args, **kwargs):
        """ 用户登录 """
        username = request.POST.get('username')
        password = request.POST.get('password')
        obj = models.UserInfo.objects.filter(username=username).first()
        if not obj:
            return Response({'msg': '用户或密码错误', 'status': 400})
        db_password = models.UserInfo.objects.filter(username=username).first().password
        if not check_password(password=password, encoded=db_password):
            return Response({'msg': '用户或密码错误', 'status': 400})
        token = create_token({'username': username})
        return Response({'msg': '登录成功', 'status': 200, 'token': token})


class UsersListUpdateView(viewsets.ModelViewSet):
    """
    多个用户信息的改和查
    """
    queryset = models.UserInfo.objects.all()
    serializer_class = serializers.UserListSerializer


class Test(mixins.UpdateModelMixin, viewsets.GenericViewSet):
    queryset = models.UserInfo.objects.all()
    serializer_class = serializers.UserUpdateSerializer


class PermissionTest(APIView):
    def get(self, request, *args, **kwargs):
        obj = models.UserInfo.objects.filter(pk=13).first()
        print(type(obj.roles))
        print(obj.roles)
        print(obj.roles.permissions.values())
        return Response({'msg': 'ok'})
