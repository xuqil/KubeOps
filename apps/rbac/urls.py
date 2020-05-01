from django.urls import path, include
from rbac.views import menu, permission, role, user
from rest_framework.routers import SimpleRouter

app_name = 'rbac'

router = SimpleRouter()
router.register(r'users', user.UsersListUpdateView, basename='users')  # 用户管理
router.register(r'user', user.UsersCreateView, basename='user')  # 用户注册和更新
router.register(r'roles', role.RoleView, basename='roles')  # 权限管理
router.register(r'permissions', permission.PermissionView, basename='permissions')  # 权限管理
router.register(r'menu', menu.MenuView, basename='menu')  # 菜单管理


urlpatterns = [
    path('login/', user.LoginView.as_view()),
    path('password/', user.UpdatePasswordView.as_view()),
    path('menu/tree/', menu.MenuTreeView.as_view()),
    path('init_permission/', permission.InitPermission.as_view()),
    path('paths/', permission.PermissionPath.as_view()),
    path('permissions/tree/', permission.PermissionTree.as_view()),
    path('permissions/all/', permission.PermissionAll.as_view()),

    path('', include(router.urls)),

]
