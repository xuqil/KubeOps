from django.db import models


class DateAbstract(models.Model):
    """
    时间公共继承模型
    """
    c_time = models.DateTimeField(verbose_name='创建时间', auto_now_add=True)
    u_time = models.DateTimeField(verbose_name='更新时间', auto_now_add=True)

    class Meta:
        abstract = True


class IDC(DateAbstract):
    """
    IDC机房
    """
    name = models.CharField(verbose_name='机房名', max_length=100)
    address = models.CharField(verbose_name='地址', max_length=200, blank=True)
    mobile = models.CharField(verbose_name='联系电话', max_length=100, blank=True)
    floor = models.CharField(verbose_name='楼层', max_length=100, blank=True, default='一楼')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'IDC数据中心'
        verbose_name_plural = verbose_name


class AssetsAbstract(models.Model):
    """
    资产公共继承模型
    """
    tags = models.ManyToManyField("Tags", verbose_name="资产标签", blank=True)
    marks = models.TextField(verbose_name='备注', blank=True)
    shelves_date = models.CharField(verbose_name='上架日期', blank=True, max_length=50)
    maintenance_date = models.CharField(verbose_name='维保日期', blank=True, max_length=50)
    sn = models.CharField(verbose_name='资产SN', max_length=50, blank=True)
    model = models.CharField(verbose_name='资产型号', max_length=100, blank=True)
    brand = models.CharField(verbose_name='资产品牌', max_length=100, blank=True)
    device_type = models.CharField(verbose_name='设备类型', blank=True, max_length=50)
    status = models.CharField(verbose_name='服务器状态', max_length=50, default='使用中')
    idc = models.ForeignKey(IDC, verbose_name='IDC', on_delete=models.CASCADE, blank=True)
    cabinet = models.CharField(verbose_name='所在机柜', max_length=100, blank=True)

    class Meta:
        abstract = True


class Tags(DateAbstract):
    """
    标签和描述
    """
    name = models.CharField(verbose_name='标签名', max_length=30, unique=True, blank=True)
    desc = models.CharField(verbose_name='描述', max_length=100, null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '标签表'
        verbose_name_plural = verbose_name


class ServerAssets(AssetsAbstract, DateAbstract):
    """
    主机
    """
    ip = models.GenericIPAddressField(verbose_name='服务器IP', max_length=120, null=True)
    hostname = models.CharField(verbose_name='主机名称', max_length=100, blank=True, default='localhost')
    type = models.CharField(verbose_name='服务器类型', max_length=100, blank=True)
    auth_type = models.CharField(verbose_name='登录类型', max_length=100, blank=True)
    app_env = models.CharField(verbose_name='应用环境', max_length=100, blank=True)
    os_type = models.CharField(verbose_name='操作系统类型', max_length=50, blank=True)
    os_version = models.CharField(verbose_name='操作系统版本', max_length=100, blank=True)
    username = models.CharField(verbose_name='服务器用户名', max_length=100, blank=True)
    password = models.CharField(verbose_name='服务器密码', max_length=100, blank=True)
    port = models.CharField(verbose_name='服务器端口号', blank=True, max_length=30)

    class Meta:
        verbose_name = '服务器资产表'
        verbose_name_plural = '服务器资产表'

    def __str__(self):
        return self.ip
