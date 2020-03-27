from django.urls import path
from webssh.views import UploadSHHKey

app_name = 'webssh'

urlpatterns = [
    path('upload_key', UploadSHHKey.as_view()),
]
