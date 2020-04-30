from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(UserProfile)
admin.site.register(Role)
admin.site.register(Permission)
admin.site.register(Menu)

# 修改网页title和站点header。
admin.site.site_title = "KubeOps后台管理"
admin.site.site_header = "KubeOps"
