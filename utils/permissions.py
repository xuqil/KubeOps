from rest_framework.permissions import BasePermission
from rest_framework.exceptions import PermissionDenied
import re
from utils.jwt_token import parse_payload


class MyPermission(BasePermission):
    """
    权限认证
    """

    def __init__(self):
        # 不需要权限的路径
        self.common_paths = ['/login/', '/user/', '/settings/', '/menu/tree/', '/cpu/', '/network/', '/hostip/',
                             '/systemload/', '/memory/']

    def has_permission(self, request, view):
        current_url = request.path_info
        method = request.method
        p = re.compile(r'(/api/v[a-zA-Z]|[0-9]|[.])(/.*)')
        url = p.findall(current_url)[0][1]
        for i in self.common_paths:
            i = '^{}$'.format(i)
            flag = re.match(i, url)
            if flag:
                return True
        try:
            token = request.auth
            if token is None:
                token = request.META.get('HTTP_AUTHORIZATION', '').split()[1]
            result = parse_payload(token)
            paths = []
            permissions = result['data'].get('permissions', {})
            for key in permissions.keys():
                paths.append(key)
        except Exception:
            raise PermissionDenied('权限认证失败')
        for path in paths:
            tmp = path
            path = '^{}$'.format(path)
            flag = re.match(path, url)
            if flag:
                if method in permissions[tmp]:
                    return True
        return False
