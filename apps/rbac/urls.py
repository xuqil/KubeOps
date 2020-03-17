from django.urls import path, include
from rbac import views
from rest_framework.routers import DefaultRouter

app_name = 'rbac'

router = DefaultRouter()
router.register(r'users', views.UsersListUpdateView)  # 用户管理
router.register(r'user', views.UsersCreateView)  # 用户注册和更新
router.register(r'roles', views.RoleView)  # 权限管理
router.register(r'permissions', views.PermissionView)  # 权限管理
router.register(r'menu', views.MenuView)  # 菜单管理


urlpatterns = [
    path('login/', views.LoginView.as_view()),
    path('menu/tree/', views.MenuTreeView.as_view()),

    path('', include(router.urls)),

]
