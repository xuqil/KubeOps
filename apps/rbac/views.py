from django.contrib.auth.hashers import check_password

from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import mixins
from rest_framework.response import Response

from rbac.models import *
from utils.jwt_token import create_token
from rbac.serializers import userSerializers


class UsersCreateView(mixins.CreateModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet):
    """
    添加用户
    """
    queryset = UserProfile.objects.all()
    authentication_classes = []
    serializer_class = userSerializers.UserCreateSerializer


class LoginView(APIView):
    """
    用户登录
    """
    authentication_classes = []

    def post(self, request, *args, **kwargs):
        """ 用户登录 """
        username = request.POST.get('username')
        password = request.POST.get('password')
        user_obj = UserProfile.objects.filter(username=username).first()
        if not user_obj:
            return Response({'msg': '用户或密码错误', 'status': 400})
        db_password = UserProfile.objects.filter(username=username).first().password
        if not check_password(password=password, encoded=db_password):
            return Response({'msg': '用户或密码错误', 'status': 400})
        permissions = user_obj.roles.all().values('permissions__action', 'permissions__path')
        paths = []
        actions = []
        for i in permissions:
            paths.append(i.get('permissions__path', ''))
            actions.append(i.get('permissions__action', ''))
        token = create_token({'username': username, 'paths': paths, 'actions': actions})
        return Response({'msg': '登录成功', 'status': 200, 'token': token})


class UsersListUpdateView(viewsets.ModelViewSet):
    """
    多个用户信息的改和查
    """
    queryset = UserProfile.objects.all()
    serializer_class = userSerializers.UserListSerializer


class Test(mixins.UpdateModelMixin, viewsets.GenericViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = userSerializers.UserUpdateSerializer

