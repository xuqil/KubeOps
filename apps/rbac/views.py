from django.contrib.auth.hashers import check_password
from collections import defaultdict

from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import mixins
from rest_framework.response import Response
from rest_framework.generics import UpdateAPIView

from rbac.models import *
from utils.jwt_token import create_token
from rbac.serializers import userSerializers, rolesSerializers, permissionsSerializers, menuSerializers
from utils.pagination import MenuPagination


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
            return Response({'msg': '用户或密码错误', 'status': 400})
        db_password = UserProfile.objects.filter(username=username).first().password
        if not check_password(password=password, encoded=db_password):
            return Response({'msg': '用户或密码错误', 'status': 400})
        permissions_list = user_obj.roles.all().values('permissions__action', 'permissions__path')
        permissions = defaultdict(list)
        for i in permissions_list:
            permissions[i.get('permissions__path')].append(i.get('permissions__action'))
        for key in permissions.keys():
            permissions[key] = list(set(permissions[key]))
        pk = user_obj.id
        token = create_token({'username': username, 'permissions': permissions},
                             1440)
        return Response({'id': pk, 'username': username, 'status': 200, 'token': token})


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
            return userSerializers.UserUpdateSerializer
        return userSerializers.UserListSerializer

    def update(self, request, *args, **kwargs):
        if request.data.get('active') is not None:
            self.flag = 1
        elif request.data.get('roles') is not None:
            self.flag = 2
        elif request.data.get('mobile') is not None:
            self.flag = 3
        result = super(UsersListUpdateView, self).update(request, *args, **kwargs)
        return result


class RoleView(viewsets.ModelViewSet):
    """
    角色管理
    """
    queryset = Role.objects.all()
    serializer_class = rolesSerializers.RoleListSerializer

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return rolesSerializers.RoleListSerializer
        return rolesSerializers.RoleModifySerializer


class PermissionView(viewsets.ModelViewSet):
    """
    权限管理
    """
    queryset = Permissions.objects.all()
    serializer_class = permissionsSerializers.PermissionSerializer


class MenuView(viewsets.ModelViewSet):
    """
    菜单管理
    """
    pagination_class = MenuPagination
    permission_classes = []
    queryset = Menu.objects.all().order_by('sort')
    serializer_class = menuSerializers.MenuSerializer


class MenuTreeView(APIView):
    """
    菜单树
    """

    def get(self, request, *args, **kwargs):
        queryset = Menu.objects.all()
        serializer = menuSerializers.MenuSerializer(queryset, many=True)
        tree_dict = {}
        tree_data = []
        try:
            for item in serializer.data:
                tree_dict[item['id']] = item
            for i in tree_dict:
                if tree_dict[i]['pid']:
                    pid = tree_dict[i]['pid']
                    parent = tree_dict[pid]
                    parent.setdefault('children', []).append(tree_dict[i])
                else:
                    tree_data.append(tree_dict[i])
            results = tree_data
        except KeyError:
            results = serializer.data
        return Response(results)
