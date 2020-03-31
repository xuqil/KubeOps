from django.urls import path, include
from monitor import views

app_name = 'monitor'

urlpatterns = [
    path('cpu/', views.CPUView.as_view()),
    path('systemload/', views.SystemLoadView.as_view()),
    path('network/', views.NetWorkView.as_view()),
    path('hostip/', views.HostIPView.as_view()),
]
