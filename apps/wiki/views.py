from rest_framework import viewsets, filters
from django_filters.rest_framework import DjangoFilterBackend

from wiki.seriablizers.categorySerializer import *
from wiki.seriablizers.postSerializer import *
from wiki.seriablizers.tagSerializer import *
from wiki.seriablizers.commentSerializer import *
from utils.pagination import MaxPagination
from wiki.filters import PostFilter


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter]
    filter_class = PostFilter
    search_fields = ['title', 'body', '=author__username']
    ordering_fields = ('c_time', 'u_time', 'author')
    ordering = ('-c_time', '-u_time')

    def get_serializer_class(self):
        if self.action == 'list':
            return PostListSerializer
        return PostSerializer


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    pagination_class = MaxPagination


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = MaxPagination


class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    pagination_class = MaxPagination
