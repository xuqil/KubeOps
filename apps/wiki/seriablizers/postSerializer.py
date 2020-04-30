from rest_framework import serializers

from wiki.models import Post


class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'


class PostListSerializer(serializers.ModelSerializer):
    author = serializers.CharField(source='author.username')
    category = serializers.CharField(source='category.name', allow_null=True)
    tags = serializers.StringRelatedField(many=True)

    class Meta:
        model = Post
        fields = ['id', 'title', 'body', 'author', 'category', 'tags',
                  'c_time', 'u_time', 'excerpt', 'views']
