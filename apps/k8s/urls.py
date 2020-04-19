from django.urls import path
from k8s import views
from k8s import deployment
from k8s import pod

app_name = 'k8s'

urlpatterns = [
    path('nodes/', views.NodeVies.as_view(), name='nodes'),
    path('namespaces/', views.NamespaceView.as_view(), name='namespaces'),
    path('pods/', pod.PodViews.as_view(), name='pods'),
    path('pod', pod.DetailPodView.as_view(), name='pod'),
    path('deployments/', deployment.DeploymentViews.as_view(), name='deployments'),
    path('deployment', deployment.DetailDeploymentViews.as_view(), name='deployment'),
]
