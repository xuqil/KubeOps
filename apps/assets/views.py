from rest_framework import viewsets

from assets.models import Tags, IDC, ServerAssets
from assets.serializers.assets import TagsSerializers, IDCSerializers, ServerAssetsSerializers, \
    ServerAssetsListSerializers


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


class ServerAssetsView(viewsets.ModelViewSet):
    """
    Server管理
    """
    queryset = ServerAssets.objects.all()
    serializer_class = ServerAssetsSerializers

    def get_serializer_class(self):
        if self.action == 'list':
            return ServerAssetsListSerializers
        return ServerAssetsSerializers
