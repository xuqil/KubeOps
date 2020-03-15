from rest_framework.authentication import BaseAuthentication
from rest_framework.exceptions import AuthenticationFailed
from utils.jwt_token import parse_payload


class MyAuthentication(BaseAuthentication):
    """
    自定义token认证
    对应的请求头：Authorization:jwt eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzM1NTU1NzksInVzZXJuYW1lIjoid3VwZWlxaSIsInVzZXJfaWQiOjF9.xj-7qSts6Yg5Ui55-aUOHJS4KSaeLq5weXMui2IIEJU
    """

    def authenticate(self, request):
        authorization = request.META.get('HTTP_AUTHORIZATION', '')
        auth = authorization.split()
        if not auth:
            raise AuthenticationFailed({'msg': '未获取到Authorization请求头', 'status': 403})
        if auth[0].lower() != 'jwt':
            raise AuthenticationFailed({'msg': 'Authorization请求头中认证方式错误', 'status': 403})
        if len(auth) == 1:
            raise AuthenticationFailed({'msg': "非法Authorization请求头", 'status': 403})
        elif len(auth) > 2:
            raise AuthenticationFailed({'msg': "非法Authorization请求头", 'status': 403})
        token = auth[1]
        result = parse_payload(token)
        if not result['status']:
            raise AuthenticationFailed(result)

        # 如果想要request.user等于用户对象，此处可以根据payload去数据库中获取用户对象。
        return result, token
