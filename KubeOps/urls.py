"""KubeOps URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, re_path, include
from django.contrib import admin
from rest_framework.documentation import include_docs_urls

urlpatterns = [
    path('admin/', admin.site.urls),
    path('docs/', include_docs_urls(title='KubeOps API文档', public=False)),
    re_path(r'^(?P<version>[v1|v2]+)/power/', include('rbac.urls', namespace='rbac')),
    re_path(r'^(?P<version>[v1|v2]+)/assets/', include('assets.urls', namespace='assets')),
    re_path(r'^(?P<version>[v1|v2]+)/webssh/', include('webssh.urls', namespace='webssh')),
    re_path(r'^(?P<version>[v1|v2]+)/monitor/', include('monitor.urls', namespace='monitor')),
    re_path(r'^(?P<version>[v1|v2]+)/file/', include('file.urls', namespace='file')),
    re_path(r'^(?P<version>[v1|v2]+)/wiki/', include('wiki.urls', namespace='wiki')),
    re_path(r'^(?P<version>[v1|v2]+)/platform/', include('settings.urls', namespace='settings')),
    re_path(r'^(?P<version>[v1|v2]+)/k8s/', include('k8s.urls', namespace='k8s')),
    re_path(r'^(?P<version>[v1|v2]+)/tasks/', include('tasks.urls', namespace='tasks')),
]
