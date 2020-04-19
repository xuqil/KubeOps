from django.urls import path, include
from settings import views
from rest_framework.routers import SimpleRouter

app_name = 'settings'

router = SimpleRouter()
router.register(r'settings', views.BackgroundSettingsViewSet, basename='settings')

urlpatterns = [
    path('', include(router.urls)),
]
