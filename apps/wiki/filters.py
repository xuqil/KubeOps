import django_filters

from .models import *


class PostFilter(django_filters.rest_framework.FilterSet):
    """
    文章过滤器
    """
    category = django_filters.CharFilter(field_name='category__name')
    tags = django_filters.CharFilter(field_name='tags__name')
    author = django_filters.CharFilter(field_name='author__username')

    class Meta:
        model = Post
        fields = ['category', 'tags', 'author']
