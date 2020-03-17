from django.db import models


class Menu(models.Model):
    """
    菜单
    """
    title = models.CharField(verbose_name='菜单', max_length=32)
    icon = models.CharField(verbose_name='图标', max_length=32)
    sort = models.IntegerField(verbose_name='排序', blank=True)

    class Meta:
        ordering = ['sort']

    def __str__(self):
        return self.title


class Permission(models.Model):
    """
    权限表
    """
    title = models.CharField(verbose_name='标题', max_length=32)
    path = models.CharField(verbose_name='含正则的URL', max_length=128)
    action = models.CharField(verbose_name='动作', max_length=16, default='')
    pid = models.ForeignKey(verbose_name='默认选中权限', to='Permission', related_name='ps', null=True, blank=True,
                            help_text="对于无法作为菜单的URL，可以为其选择一个可以作为菜单的权限，那么访问时，则默认选中此权限",
                            limit_choices_to={'menu__isnull': False}, on_delete=models.CASCADE)
    menu = models.ForeignKey(verbose_name='菜单', to='Menu', null=True, blank=True, help_text='null表示非菜单',
                             on_delete=models.CASCADE)

    class Meta:
        ordering = ['id']

    def __str__(self):
        return self.title


class Role(models.Model):
    """
    角色
    """
    title = models.CharField(verbose_name='角色名称', max_length=32)
    permissions = models.ManyToManyField(verbose_name='拥有的所有权限', to='Permission', blank=True)
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
    active = models.BooleanField(verbose_name="状态", default=True)
    roles = models.ManyToManyField(verbose_name='拥有的所有角色', to='Role', blank=True)
    c_time = models.DateTimeField(verbose_name='加入时间', auto_now_add=True)

    class Meta:
        ordering = ['c_time']

    def __str__(self):
        return self.username
