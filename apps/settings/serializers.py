from rest_framework import serializers

from settings.models import BackgroundSettings


class BackgroundSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = BackgroundSettings
        fields = '__all__'
