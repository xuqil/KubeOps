from django.db import models
from django.contrib.auth.models import AbstractUser


class UserInfo(models.Model):
    """
    用户信息
    """
    # 用户名称
    username = models.CharField(max_length=20, unique=True)
    # 密码
    password = models.CharField(max_length=100)
    # 联系方式
    mobile = models.CharField(max_length=11, blank=True)
    # 邮箱
    email = models.EmailField(max_length=50, blank=True)
    # 部门
    department = models.ForeignKey("Organization", null=True, blank=True, on_delete=models.CASCADE)
    # 职位
    position = models.CharField(max_length=50, blank=True,)
    # 上级主管
    superior = models.ForeignKey("self", null=True, blank=True, on_delete=models.CASCADE)
    # 角色
    roles = models.ManyToManyField("Role", null=True, blank=True)
    # 加入时间
    create_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_info'
        ordering = ['id']

    def __str__(self):
        return self.username


class Permission(models.Model):
    """
    权限
    """
    name = models.CharField(max_length=30, unique=True)
    # 权限代码
    code = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'permission'
        ordering = ['id']


class Role(models.Model):
    """
    角色
    """
    name = models.CharField(max_length=32, unique=True)
    # 角色代码
    code = models.CharField(max_length=100, unique=True)
    # 权限
    permissions = models.ManyToManyField("Permission", null=True, blank=True)
    # 描述
    desc = models.CharField(max_length=50, blank=True)

    class Meta:
        db_table = 'role'


class Organization(models.Model):
    """
    组织架构
    """
    organization_type_choices = (
        ("company", "公司"),
        ("department", "部门")
    )
    name = models.CharField(max_length=60)
    # 类型
    type = models.CharField(max_length=20, choices=organization_type_choices, default="company")
    # 父类组织
    pid = models.ForeignKey("self", null=True, blank=True, on_delete=models.CASCADE)

    class Meta:
        db_table = 'organization'

    def __str__(self):
        return self.name


class Menu(models.Model):
    """
    菜单
    """
    name = models.CharField(max_length=30, unique=True)
    # 图标
    icon = models.CharField(max_length=50, blank=True)
    # 路径
    path = models.CharField(max_length=158, blank=True)
    # 排序
    sort = models.IntegerField(blank=True)
    # 上级菜单
    pid = models.ForeignKey("self", null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'menu'
        ordering = ['id']
