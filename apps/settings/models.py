from django.db import models


class BackgroundSettings(models.Model):
    color = models.CharField('背景颜色', max_length=50, default='rgba(255, 255, 255, 1)')
    name = models.CharField('区域', max_length=50)
    code = models.IntegerField('代号', default=1)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '背景颜色'
        verbose_name_plural = verbose_name
