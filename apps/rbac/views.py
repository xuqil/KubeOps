from django.contrib.auth.hashers import check_password

from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import mixins
from rest_framework.response import Response

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
        permissions = user_obj.roles.all().values('permissions__action', 'permissions__path')
        paths = []
        actions = []
        for i in permissions:
            paths.append(i.get('permissions__path', ''))
            actions.append(i.get('permissions__action', ''))
        pk = user_obj.id
        token = create_token({'username': username, 'paths': paths, 'actions': actions})
        return Response({'id': pk, 'username': username, 'status': 200, 'token': token})


class UsersListUpdateView(viewsets.ModelViewSet):
    """
    多个用户信息的改和查
    """
    queryset = UserProfile.objects.all()
    serializer_class = userSerializers.UserListSerializer

    def get_serializer_class(self):
        if self.action == 'partial_update' or self.action == 'update':
            return userSerializers.UserUpdateSerializer
        return userSerializers.UserListSerializer


class RoleView(viewsets.ModelViewSet):
    """
    角色管理
    """
    queryset = Role.objects.all()
    serializer_class = rolesSerializers.RoleListSerializer

    def get_serializer_class(self):
        if self.action == 'list':
            return rolesSerializers.RoleListSerializer
        elif self.action == 'retrieve':
            return rolesSerializers.RoleRetrieveSerializer
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
