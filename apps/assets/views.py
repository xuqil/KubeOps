from rest_framework import viewsets

from assets.models import Tags, IDC, ServerAssets
from assets.serializers.assets import TagsSerializers, IDCSerializers, ServerAssetsSerializers, \
    ServerAssetsListSerializers
from assets.filters import ServerFilter, IDCFilter


class TagsView(viewsets.ModelViewSet):
    """
    tag管理
    """
    queryset = Tags.objects.all().order_by('id')
    serializer_class = TagsSerializers


class IDCView(viewsets.ModelViewSet):
    """
    IDC管理
    """
    queryset = IDC.objects.all()
    serializer_class = IDCSerializers
    filter_class = IDCFilter
    ordering_fields = ('c_time', 'u_time', 'name', 'address', 'floor')
    ordering = ('address', 'floor')


class ServerAssetsView(viewsets.ModelViewSet):
    """
    Server管理
    """
    queryset = ServerAssets.objects.all()
    serializer_class = ServerAssetsSerializers
    filter_class = ServerFilter
    ordering_fields = ('c_time', 'u_time', 'hostname', 'ip', 'os_type', 'os_version', 'device_type', 'app_env',
                       'status', 'idc', 'sn', 'shelves_date', 'maintenance_date', 'shelves_date', 'maintenance_date')
    ordering = ('ip', '-c_time')

    def get_serializer_class(self):
        if self.action == 'list':
            return ServerAssetsListSerializers
        return ServerAssetsSerializers
