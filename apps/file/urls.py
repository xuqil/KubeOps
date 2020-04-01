from django.urls import path
from file import views

app_name = 'file'

urlpatterns = [
    path('files/', views.FileUploadView.as_view()),
]
