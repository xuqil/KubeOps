from django.contrib import admin
from .models import ServerAssets, IDC, Tags


admin.site.register(IDC)
admin.site.register(Tags)
admin.site.register(ServerAssets)
