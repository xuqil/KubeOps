import time
import random
import hashlib


def get_key_obj(key_type, pkey_file=None, pkey_obj=None, password=None):
    """
    通过秘钥文件获取key秘钥
    :param key_type: paramiko KEY对象
    :param pkey_file: key文件
    :param pkey_obj: KEY对象
    :param password: 密码
    :return:
    """
    if pkey_file:
        with open(pkey_file) as f:
            try:
                pkey = key_type.from_private_key(f, password=password)
                return pkey
            except Exception as e:
                print(e)
                pass
    else:
        try:
            pkey = key_type.from_private_key(pkey_obj, password=password)
            return pkey
        except Exception as e:
            print(e)
            pkey_obj.seek(0)


def unique():
    """
    生成hex唯一值
    :return:
    """
    ctime = str(time.time())
    salt = str(random.random())
    m = hashlib.md5(bytes(salt, encoding='utf-8'))
    m.update(bytes(ctime, encoding='utf-8'))
    return m.hexdigest()
