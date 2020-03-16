from django.db import models
from django.contrib.auth.models import AbstractUser


class UserInfo(models.Model):
    """
    用户信息
    """
    # 用户名称
    username = models.CharField(max_length=20, unique=True, verbose_name='账号')
    # 密码
    password = models.CharField(max_length=100, verbose_name='密码')
    # 联系方式
    mobile = models.CharField(max_length=11, blank=True, verbose_name='电话')
    # 邮箱
    email = models.EmailField(max_length=50, blank=True, verbose_name='邮箱')
    # 角色
    roles = models.ForeignKey("Role", null=True, blank=True, verbose_name='角色', on_delete=models.CASCADE,
                              related_name='user_roles')
    # 状态
    active = models.BooleanField(default=True)
    # 加入时间
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='加入时间')

    class Meta:
        db_table = 'user_info'
        ordering = ['id']

    def __str__(self):
        return self.username


class Permission(models.Model):
    """
    权限
    """
    name = models.CharField(max_length=30, unique=True, verbose_name='权限')
    # 权限代码
    code = models.CharField(max_length=100, unique=True, verbose_name='权限代号')

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'permission'
        ordering = ['id']


class Role(models.Model):
    """
    角色
    """
    name = models.CharField(max_length=32, unique=True, verbose_name='角色')
    # 角色代码
    code = models.CharField(max_length=100, unique=True, verbose_name='角色代号')
    # 权限
    permissions = models.ManyToManyField("Permission", blank=True, verbose_name='权限')
    # 描述
    desc = models.CharField(max_length=50, blank=True, verbose_name='描述')

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'role'


class Menu(models.Model):
    """
    菜单
    """
    name = models.CharField(max_length=30, unique=True, verbose_name='名称')
    # 图标
    icon = models.CharField(max_length=50, blank=True, verbose_name='图标')
    # 路径
    path = models.CharField(max_length=158, blank=True, verbose_name='路径')
    # 排序
    sort = models.IntegerField(blank=True, verbose_name='排序')
    # 上级菜单
    pid = models.ForeignKey("self", null=True, blank=True, on_delete=models.CASCADE, verbose_name='上级菜单')

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'menu'
        ordering = ['id']
