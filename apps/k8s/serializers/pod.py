from rest_framework import serializers


class PodSerializers(serializers.Serializer):
    """
    Pod的序列化
    """
    pod_ip = serializers.IPAddressField()
    namespace = serializers.CharField()
    name = serializers.CharField()
    host_ip = serializers.IPAddressField()
    status = serializers.CharField()