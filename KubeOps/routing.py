from channels.routing import ProtocolTypeRouter, URLRouter
from webssh import routing

application = ProtocolTypeRouter({
    'websocket': URLRouter(routing.websocket_urlpatterns)
})
