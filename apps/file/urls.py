from django.urls import path
from file import views

app_name = 'file'

urlpatterns = [
    path('up_files', views.FilesView.as_view()),
    path('down_files', views.DownloadView.as_view()),
]
