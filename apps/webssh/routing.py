from django.urls import path
from webssh.consumer import WebSSH

websocket_urlpatterns = [
    path('webssh/', WebSSH),
]
