from django.urls import path, include
from rbac import views
from rest_framework.routers import DefaultRouter

app_name = 'rbac'

router = DefaultRouter()
router.register(r'users', views.UsersListUpdateView, basename='users')  # 用户管理
router.register(r'user', views.UsersCreateView, basename='user')  # 用户注册和更新
router.register(r'roles', views.RoleView, basename='roles')  # 权限管理
router.register(r'permissions', views.PermissionView, basename='permissions')  # 权限管理
router.register(r'menu', views.MenuView, basename='menu')  # 菜单管理


urlpatterns = [
    path('login/', views.LoginView.as_view()),
    path('menu/tree/', views.MenuTreeView.as_view()),

    path('', include(router.urls)),

]
