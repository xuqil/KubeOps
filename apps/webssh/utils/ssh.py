import paramiko
from threading import Thread
import socket
import json

from webssh.utils.tools import get_key_obj


class SSH:
    def __init__(self, websocket, message):
        """
        :param websocket: WebsocketConsumer的继承者
        :param message: 发送的消息
        """
        self.websocket = websocket
        self.message = message

    def connect(self, host, user, password=None, ssh_key=None, port=22, timeout=30,
                term='xterm', pty_width=80, pty_height=24):
        """
        与服务器建立连接
        :param host: 主机IP
        :param user: 用户名
        :param password: 密码
        :param ssh_key: 秘钥
        :param port: 端口，默认22
        :param timeout: 连接超时时间
        :param term:
        :param pty_width:
        :param pty_height:
        :return:
        """
        try:
            # 建立一个sshclient对象
            ssh_client = paramiko.SSHClient()
            # 允许将信任的主机自动加入到host_allow 列表
            ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            if ssh_key:
                key = get_key_obj(paramiko.RSAKey, pkey_obj=ssh_key, password=password) or \
                      get_key_obj(paramiko.DSSKey, pkey_obj=ssh_key, password=password) or \
                      get_key_obj(paramiko.ECDSAKey, pkey_obj=ssh_key, password=password) or \
                      get_key_obj(paramiko.Ed25519Key, pkey_obj=ssh_key, password=password)

                # 调用connect方法连接服务器
                ssh_client.connect(username=user, hostname=host, port=port, pkey=key, timeout=timeout)
            else:
                ssh_client.connect(username=user, password=password, hostname=host, port=port, timeout=timeout)

            transport = ssh_client.get_transport()
            self.channel = transport.open_session()
            # 创建模拟的终端高度
            self.channel.get_pty(term=term, width=pty_width, height=pty_height)
            # 交互式she'll会话
            self.channel.invoke_shell()

            for i in range(2):
                recv = self.channel.recv(1024).decode('utf-8')
                self.message['status'] = 0
                self.message['message'] = recv
                message = json.dumps(self.message)
                self.websocket.send(message)
        except socket.timeout:
            self.message['status'] = 1
            self.message['message'] = 'ssh 连接超时'
            message = json.dumps(self.message)
            self.websocket.send(message)
            self.close()
        except Exception as e:
            print(e)
            self.close()

    def resize_pty(self, cols, rows):
        """
        调整终端的大小
        :param cols:
        :param rows:
        :return:
        """
        self.channel.resize_pty(width=cols, height=rows)

    def django_to_ssh(self, data):
        try:
            self.channel.send(data)
        except Exception as e:
            print(e)
            self.close()

    def websocket_to_django(self):
        try:
            while True:
                data = self.channel.recv(1024).decode('utf-8')
                if not len(data):
                    return
                self.message['status'] = 0
                self.message['message'] = data
                message = json.dumps(self.message)
                self.websocket.send(message)
        except Exception as e:
            print(e)
            self.close()

    def close(self):
        """
        关闭会话
        :return:
        """
        self.message['status'] = 1
        self.message['message'] = '关闭连接'
        message = json.dumps(self.message)
        self.websocket.send(message)
        self.channel.close()
        self.websocket.close()

    def shell(self, data):
        Thread(target=self.django_to_ssh, args=(data,)).start()
        Thread(target=self.websocket_to_django).start()
