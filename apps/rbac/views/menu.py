from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet

from rbac.models import Menu, UserProfile
from rbac.serializers import menuSerializers
from utils.pagination import MenuPagination
from utils.tree import treeFilter


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
        results = treeFilter(serializer.data, menus)
        return Response(results)
