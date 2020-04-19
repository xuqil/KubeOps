from rest_framework import viewsets

from wiki.seriablizers.categorySerializer import *
from wiki.seriablizers.postSerializer import *
from wiki.seriablizers.tagSerializer import *
from wiki.seriablizers.commentSerializer import *
from utils.pagination import MaxPagination


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

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
