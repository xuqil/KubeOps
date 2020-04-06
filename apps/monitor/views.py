from rest_framework.views import APIView
from rest_framework.response import Response
import time

from monitor import utils
from common.time_tools import now_time


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
        load_v1 = utils.load_stat()['lavg_1']
        load_v5 = utils.load_stat()['lavg_5']
        load_v15 = utils.load_stat()['lavg_15']
        this_time = now_time()
        context = {
            'time': this_time,
            'load_v1': load_v1,
            'load_v5': load_v5,
            'load_v15': load_v15
        }
        return Response(context)


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
        network_name = utils.get_net_name()
        ip = utils.get_ip(network_name)
        return Response({'ip': ip})


class FlowView(APIView):
    """
    获取网络流量
    """

    def get(self, request, *args, **kwargs):
        net_out = []
        net_in = []
        network_name = utils.get_net_name()
        net = utils.NetWork(network_name)
        for _ in range(5):
            time.sleep(1)
            net.flow()
            net_in.append(net.flow().get('rx_rate'))
            net_out.append(net.flow().get('tx_rate'))
        context = {
            'net_in': net_in,
            'net_out': net_out
        }
        return Response(context)


class MemoryView(APIView):
    """
    获取内存信息
    """

    def get(self, request, *args, **kwargs):
        memory = utils.memory_info()
        mem_total = memory.get('MemTotal').split()[0]
        mem_free = memory.get('MemFree').split()[0]
        mem_available = memory.get('MemAvailable').split()[0]
        buffers = memory.get('Buffers').split()[0]
        cached = memory.get('Cached').split()[0]
        context = {
            'MemTotal': mem_total,
            'MemFree': mem_free,
            'MemAvailable': mem_available,
            'Buffers': buffers,
            'Cached': cached,
        }
        return Response(context)
