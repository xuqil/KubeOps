from django.db import models


class Menu(models.Model):
    """
    菜单
    """
    title = models.CharField(verbose_name='菜单', max_length=32)
    icon = models.CharField(verbose_name='图标', max_length=32)
    path = models.CharField(verbose_name="链接地址", help_text="如果有子菜单，不需要填写该字段", blank=True, max_length=100)
    sort = models.IntegerField(verbose_name='排序', blank=True)
    pid = models.ForeignKey("self", verbose_name="父级菜单", null=True, blank=True, on_delete=models.SET_NULL)

    class Meta:
        ordering = ['sort']

    def __str__(self):
        return self.title


class Permissions(models.Model):
    """
    权限表
    """
    title = models.CharField(verbose_name='标题', max_length=32)
    path = models.CharField(verbose_name='含正则的URL', max_length=128)
    action = models.CharField(verbose_name='动作', max_length=16, default='')

    class Meta:
        ordering = ['id']

    def __str__(self):
        return self.title


class Role(models.Model):
    """
    角色
    """
    title = models.CharField(verbose_name='角色名称', max_length=32)
    permissions = models.ManyToManyField(verbose_name='拥有的所有权限', to='Permissions', blank=True)
    desc = models.CharField(verbose_name='描述', max_length=50, blank=True)

    class Meta:
        ordering = ['id']

    def __str__(self):
        return self.title


class UserProfile(models.Model):
    """
    用户表
    """
    username = models.CharField(verbose_name='用户名', max_length=32, unique=True)
    password = models.CharField(verbose_name='密码', max_length=100)
    email = models.CharField(verbose_name='邮箱', max_length=32, blank=True)
    mobile = models.CharField(verbose_name='电话', max_length=32, blank=True)
    active = models.BooleanField(verbose_name="状态", default=True, blank=True)
    roles = models.ManyToManyField(verbose_name='拥有的所有角色', to='Role', blank=True)
    c_time = models.DateTimeField(verbose_name='加入时间', auto_now_add=True)

    class Meta:
        ordering = ['c_time']

    def __str__(self):
        return self.username
