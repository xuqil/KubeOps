from django.urls import path, include
from settings import views
from rest_framework.routers import SimpleRouter, DefaultRouter

app_name = 'settings'

# router = SimpleRouter()
router = DefaultRouter()
router.register(r'settings', views.BackgroundSettingsViewSet, basename='settings')  # 用户管理

urlpatterns = [
    path('', include(router.urls)),

]
