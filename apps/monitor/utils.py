from collections import OrderedDict
import socket, struct, fcntl


def cpu_info():
    """
    获取CPU信息
    """
    cpu = OrderedDict()
    proc = OrderedDict()
    proc_number = 0
    with open('/proc/cpuinfo') as f:
        for line in f:
            if not line.strip():
                cpu['proc%s' % proc_number] = proc
                proc_number = proc_number + 1
                proc = OrderedDict()
            else:
                if len(line.split(':')) == 2:
                    proc[line.split(':')[0].strip()] = line.split(':')[1].strip()
                else:
                    proc[line.split(':')[0].strip()] = ''
    return cpu


def load_stat():
    """
    获取系统负载
    """
    loadavg = {}
    with open('/proc/loadavg', 'r') as f:
        con = f.read().split()
    loadavg['lavg_1'] = con[0]
    loadavg['lavg_5'] = con[1]
    loadavg['lavg_15'] = con[2]
    loadavg['nr'] = con[3]
    loadavg['last_pid'] = con[4]
    return loadavg


def memory_info():
    """
    获取内存使用情况
    """
    memory = OrderedDict()
    with open('/proc/meminfo') as f:
        for line in f:
            memory[line.split(':')[0]] = line.split(':')[1].strip()
    return memory


def net_info():
    """
    获取网卡信息
    :return:
    """
    net = OrderedDict()
    with open('/proc/net/arp') as f:
        ip_count = 1
        flag = False
        for line in f:
            if flag:
                res = line.split()
                ip = 'ip' + str(ip_count)
                ip_count += ip_count
                net[ip] = (res[0], res[-1])
            flag = True
    return net


class NetWork:

    def __init__(self, net):
        self.net = net
        self.stats = []
        self.rx()
        self.tx()

    def rx(self):
        """
        入口流量
        :return:
        """
        with open('/proc/net/dev') as f:
            ip_stat = f.readlines()
            for interface in ip_stat:
                if self.net in interface:
                    stat = float(interface.split()[1])
                    self.stats[0:] = [stat]
        return self.stats

    def tx(self):
        """
        出口流量
        :return:
        """
        with open('/proc/net/dev') as f:
            ip_stat = f.readlines()
            for interface in ip_stat:
                if self.net in interface:
                    stat = float(interface.split()[9])
                    self.stats[1:] = [stat]
        return self.stats

    def flow(self):
        """
        流量
        :return:
        """
        rx_stat = list(self.stats)
        self.rx()
        self.tx()
        rx = float(self.stats[0])
        rx_out = rx_stat[0]
        tx = float(self.stats[1])
        tx_out = rx_stat[1]
        rx_rate = round((rx - rx_out) / 1024 / 1024, 3)
        tx_rate = round((tx - tx_out) / 1024 / 1024, 3)
        return {'rx_rate': rx_rate, 'tx_rate': tx_rate}


def get_ip(ifname):
    """
    获取本机IP
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(s.fileno(), 0x8915, struct.pack('256s', bytes(ifname[:15], 'utf-8')))[20:24])


def get_net_name():
    """
    获取本机网卡名称
    """
    net = net_info()
    network_name = ''
    for i in net.values():
        network_name = i[1]
    return network_name
