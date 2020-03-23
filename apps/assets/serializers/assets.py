from rest_framework import serializers

from assets.models import IDC, Tags, ServerAssets


class IDCSerializers(serializers.ModelSerializer):
    """
    IDC序列化
    """
    class Meta:
        model = IDC
        fields = '__all__'


class TagsSerializers(serializers.ModelSerializer):
    """
    标签序列化
    """
    class Meta:
        model = Tags
        fields = '__all__'


class ServerAssetsSerializers(serializers.ModelSerializer):
    """
    主机资产列化
    """
    class Meta:
        model = ServerAssets
        fields = '__all__'


class ServerAssetsListSerializers(serializers.ModelSerializer):
    """
    主机资产列化
    """
    class Meta:
        model = ServerAssets
        fields = '__all__'
        depth = 1
