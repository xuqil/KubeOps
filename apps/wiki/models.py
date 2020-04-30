from django.db import models
from rbac.models import UserProfile


class Category(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name=u"类别")

    class Meta:
        verbose_name = u"wiki分类"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class Tag(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name=u"标签")

    class Meta:
        verbose_name = u"wiki标签"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class Post(models.Model):
    title = models.CharField(max_length=70, unique=True, verbose_name="文章标题")
    body = models.TextField(verbose_name="正文")
    c_time = models.DateTimeField(verbose_name='创建时间', auto_now_add=True)
    u_time = models.DateTimeField(verbose_name='更新时间', auto_now=True)
    excerpt = models.CharField(max_length=200, blank=True, verbose_name="文章摘要")
    views = models.PositiveIntegerField(default=0, verbose_name="阅读量")
    category = models.ForeignKey(Category, blank=True, null=True, on_delete=models.CASCADE, verbose_name="类别")
    tags = models.ManyToManyField(Tag, blank=True, verbose_name="标签")
    author = models.ForeignKey(UserProfile, on_delete=models.CASCADE, verbose_name="作者")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = u"wiki文章"
        verbose_name_plural = verbose_name
        ordering = ['-c_time']

    def increase_views(self):
        self.views += 1
        self.save(update_fields=['views'])

    def save(self, *args, **kwargs):
        if not self.excerpt:
            self.excerpt = self.body[:150] + '...'
        super(Post, self).save(*args, **kwargs)


class Comment(models.Model):
    nid = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, verbose_name=u"用户")
    post = models.ForeignKey(Post, on_delete=models.CASCADE, verbose_name=u"文章")
    content = models.TextField(verbose_name=u"评论内容")
    c_time = models.DateTimeField(auto_now_add=True, verbose_name=u"添加时间")
    parent_id = models.ForeignKey('Comment', verbose_name=u"子评论内容", blank=True, null=True,
                                  related_name='c_comment', on_delete=models.CASCADE)

    class Meta:
        verbose_name = u'wiki评论'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.content[:20]
