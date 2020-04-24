from rest_framework import viewsets, filters
from django_filters.rest_framework import DjangoFilterBackend

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
    queryset = IDC.objects.all().order_by('-c_time')
    serializer_class = IDCSerializers
    filter_class = IDCFilter


class ServerAssetsView(viewsets.ModelViewSet):
    """
    Server管理
    """
    queryset = ServerAssets.objects.all()
    serializer_class = ServerAssetsSerializers
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filter_class = ServerFilter
    ordering_fields = ('c_time', 'u_time')
    ordering = ('-c_time', '-u_time')

    def get_serializer_class(self):
        if self.action == 'list':
            return ServerAssetsListSerializers
        return ServerAssetsSerializers
