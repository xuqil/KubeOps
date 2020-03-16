from django.urls import path, include
from rbac import views
from rest_framework.routers import DefaultRouter

app_name = 'rbac'

router = DefaultRouter()
router.register(r'users', views.UsersListUpdateView)
router.register(r'user', views.UsersCreateView)  # 用户注册
router.register(r'test', views.Test)  # 测试


urlpatterns = [
    path('login/', views.LoginView.as_view()),
    path('permission/', views.PermissionTest.as_view()),


    path('', include(router.urls)),

]
