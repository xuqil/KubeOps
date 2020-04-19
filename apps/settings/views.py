from rest_framework.viewsets import ModelViewSet

from settings.models import BackgroundSettings
from settings.serializers.color import BackgroundSettingsSerializer


class BackgroundSettingsViewSet(ModelViewSet):
    queryset = BackgroundSettings.objects.all()
    serializer_class = BackgroundSettingsSerializer
