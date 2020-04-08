from django.urls import path, include
from settings import views
from settings import deployment
from settings import pod
from rest_framework.routers import SimpleRouter

app_name = 'settings'

router = SimpleRouter()
router.register(r'settings', views.BackgroundSettingsViewSet, basename='settings')

urlpatterns = [
    path('', include(router.urls)),
    path('nodes/', views.NodeVies.as_view(), name='nodes'),
    path('namespaces/', views.NamespaceView.as_view(), name='namespaces'),
    path('pods/', pod.PodViews.as_view(), name='pods'),
    path('pod', pod.DetailPodView.as_view(), name='pod'),
    path('deployments/', deployment.DeploymentViews.as_view(), name='deployments'),
    path('deployment', deployment.DetailDeploymentViews.as_view(), name='deployment'),
]
