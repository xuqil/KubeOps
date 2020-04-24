import django_filters

from .models import *


class ServerFilter(django_filters.rest_framework.FilterSet):
    """
    服务器过滤器
    """
    hostname = django_filters.CharFilter(field_name='hostname')
    os_type = django_filters.CharFilter(field_name='os_type')
    ip = django_filters.CharFilter(field_name='ip', lookup_expr='contains')
    idc = django_filters.CharFilter(field_name='idc__name')

    class Meta:
        model = ServerAssets
        fields = ['hostname', 'os_type', 'ip', 'idc']


class IDCFilter(django_filters.rest_framework.FilterSet):
    """
    IDC过滤器
    """
    address = django_filters.CharFilter(field_name='address', lookup_expr='icontains')
    floor = django_filters.CharFilter(field_name='floor', lookup_expr='icontains')

    class Meta:
        model = IDC
        fields = ['address', 'floor']
