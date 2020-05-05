from rest_framework import serializers

from wiki.models import Post


class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'


class PostListSerializer(serializers.ModelSerializer):
    author = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    tags = serializers.StringRelatedField(many=True)

    class Meta:
        model = Post
        fields = ['id', 'title', 'body', 'author', 'category', 'tags',
                  'c_time', 'u_time', 'excerpt', 'views']
        depth = 1

    def get_author(self, row):
        return row.author.username

    def get_category(self, row):
        return row.category.name
