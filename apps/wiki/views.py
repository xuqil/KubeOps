from rest_framework import viewsets, filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response

from utils.tree import treeFilter
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
        if self.action == 'list' or self.action == 'retrieve':
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
    filterset_fields = ('user', 'post')

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return CommentListSerializer
        return CommentSerializer

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            result = treeFilter(serializer.data)
            return self.get_paginated_response(result)

        serializer = self.get_serializer(queryset, many=True)
        result = treeFilter(serializer.data)
        return Response(result)
