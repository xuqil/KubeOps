import paramiko
import os


def ssh_put(ip, port, username, password, local_path, remote_path):
    """
    上传文件
    """
    trans = paramiko.Transport((ip, port))
    trans.connect(username=username, password=password)
    sftp = paramiko.SFTPClient.from_transport(trans)
    sftp.put(localpath=local_path, remotepath=remote_path)
    os.remove(local_path)
    trans.close()


def ssh_get(ip, port, username, password, local_path, remote_path):
    """
    下载文件
    """
    trans = paramiko.Transport((ip, port))
    trans.connect(username=username, password=password)
    sftp = paramiko.SFTPClient.from_transport(trans)
    sftp.get(remotepath=remote_path, localpath=local_path)
    trans.close()


def file_iterator(file_name, chunk_size=512):
    """
    大型文件迭代读取
    """
    try:
        with open(file_name, 'rb') as f:
            while True:
                data = f.read(chunk_size)
                if data:
                    yield data
                else:
                    break
    except IOError as e:
        print(e)
