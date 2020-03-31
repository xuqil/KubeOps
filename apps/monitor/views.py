from rest_framework.views import APIView
from rest_framework.response import Response

from monitor import utils


class CPUView(APIView):
    """
    获取CPU信息
    """

    def get(self, request, *args, **kwargs):
        cpu = utils.cpu_info()
        cpu_model = cpu['proc0']['model name']
        cpu_core = cpu['proc0']['cpu cores']
        thread_count = len(cpu)
        content = {
            'cpu_model': cpu_model,
            'cpu_core': cpu_core,
            'thread_count': thread_count
        }
        return Response(content)


class SystemLoadView(APIView):
    """
    获取系统负载
    """

    def get(self, request, *args, **kwargs):
        load = utils.load_stat()
        return Response(load)


class NetWorkView(APIView):
    """
    获取网卡信息
    """

    def get(self, request, *args, **kwargs):
        net = utils.net_info()
        return Response(net)


class HostIPView(APIView):
    """
    获取本地IP
    """

    def get(self, request, *args, **kwargs):
        net = utils.net_info()
        network_name = ''
        for i in net.values():
            network_name = i[1]
        ip = utils.get_ip(network_name)
        return Response({'ip': ip})
