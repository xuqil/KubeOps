from django.urls import path, include
from wiki import views
from rest_framework.routers import SimpleRouter, DefaultRouter

app_name = 'wiki'

router = SimpleRouter()
# router = DefaultRouter()
router.register(r'posts', views.PostViewSet, basename='posts')
router.register(r'tags', views.TagViewSet, basename='tags')
router.register(r'categories', views.CategoryViewSet, basename='categories')
router.register(r'comments', views.CommentViewSet, basename='comments')

urlpatterns = [
    path('', include(router.urls)),
]
