from rest_framework.viewsets import ModelViewSet

from settings.serializers import *


class BackgroundSettingsViewSet(ModelViewSet):
    queryset = BackgroundSettings.objects.all()
    serializer_class = BackgroundSettingsSerializer
