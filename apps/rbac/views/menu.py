from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet

from rbac.models import Menu, UserProfile
from rbac.serializers import menuSerializers
from utils.pagination import MenuPagination


class MenuView(ModelViewSet):
    """
    菜单管理
    """
    pagination_class = MenuPagination
    permission_classes = []
    queryset = Menu.objects.all()
    serializer_class = menuSerializers.MenuSerializer


class MenuTreeView(APIView):
    """
    菜单树
    """

    def get(self, request, *args, **kwargs):
        try:
            username = request.user.get('data').get('username')
        except Exception:
            username = request.user
        try:
            user_obj = UserProfile.objects.filter(username=username).first()
            menus_list = user_obj.roles.all().values('menus')
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_403_FORBIDDEN)
        menus = [i.get('menus') for i in menus_list]
        queryset = Menu.objects.all()
        serializer = menuSerializers.MenuSerializer(queryset, many=True)
        tree_dict = {}
        tree_data = []
        try:
            for item in serializer.data:
                tree_dict[item['id']] = item
            for i in tree_dict:
                if i not in menus:
                    continue
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
