from django.urls import path, include
from assets import views
from rest_framework.routers import SimpleRouter, DefaultRouter

app_name = 'assets'

# router = SimpleRouter()
router = DefaultRouter()
router.register(r'tags', views.TagsView, basename='tags')
router.register(r'idc', views.IDCView, basename='idc')
router.register(r'servers', views.ServerAssetsView, basename='servers')


urlpatterns = [
    path('', include(router.urls)),
]
