from rest_framework import serializers


class DeploymentSerializers(serializers.Serializer):
    """
    Deployment的序列化
    """
    namespace = serializers.CharField()
    name = serializers.CharField()
    replicas = serializers.CharField()
    available_replicas = serializers.CharField()
    ready_replicas = serializers.CharField()
    unavailable_replicas = serializers.CharField()
    updated_replicas = serializers.CharField()
