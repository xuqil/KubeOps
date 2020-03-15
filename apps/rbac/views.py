from django.shortcuts import HttpResponse
from django.views.decorators.http import require_http_methods
from django.contrib.auth.hashers import make_password, check_password
import json

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.decorators import authentication_classes

from .models import UserInfo
from utils.jwt_token import create_token


@require_http_methods(["POST"])
@authentication_classes([])
def register(request):
    # 添加用户
    username = request.POST.get('username')
    password = request.POST.get('password')
    email = request.POST.get('email')
    mobile = request.POST.get('mobile')
    content = {'data': {}, 'msg': '', 'status': 200}
    if username is not None and password is not None:
        if UserInfo.objects.filter(username=username).first():
            content['msg'] = '用户已注册'
            content['status'] = 400
            return HttpResponse(json.dumps(content), content_type='application/json;charset = utf-8')
        try:
            if email is not None and mobile is not None:
                obj = UserInfo.objects.create(username=username, password=make_password(password), email=email,
                                              mobile=mobile)
                obj.save()
            if email is not None and mobile is None:
                obj = UserInfo.objects.create(username=username, password=make_password(password), email=email)
                obj.save()
            if email is None and mobile is not None:
                obj = UserInfo.objects.create(username=username, password=make_password(password), mobile=mobile)
                obj.save()
            else:
                obj = UserInfo.objects.create(username=username, password=make_password(password))
                obj.save()
        except Exception as e:
            print(e)
            content['msg'] = '注册失败'
            content['status'] = 400
            return HttpResponse(json.dumps(content), content_type='application/json;charset = utf-8')
        content['msg'] = '注册成功'
        content['status'] = 200
        return HttpResponse(json.dumps(content), content_type='application/json;charset = utf-8')
    content['msg'] = '注册失败'
    content['status'] = 400
    return HttpResponse(json.dumps(content), content_type='application/json;charset = utf-8')


class LoginView(APIView):
    authentication_classes = []

    def post(self, request, *args, **kwargs):
        """ 用户登录 """
        username = request.POST.get('username')
        password = request.POST.get('password')
        if not UserInfo.objects.filter(username=username).first():
            return Response({'msg': '用户或密码错误', 'status': 400})
        db_password = UserInfo.objects.filter(username=username).first().password
        if not check_password(password=password, encoded=db_password):
            return Response({'msg': '用户或密码错误', 'status': 400})
        token = create_token({'username': username})
        return Response({'msg': '登录成功', 'status': 200, 'token': token})

