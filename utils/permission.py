from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    游客访问权限及创建者编辑权限
    """
    def has_object_permission(self, request, view, obj):
        # 游客权限
        if request.method in permissions.SAFE_METHODS:
            return True
        # 编辑权限
        return obj.owner == request.user


class AdminPermission(permissions.BasePermission):
    def has_permission(self, request, view):
        pass
