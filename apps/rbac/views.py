from django.shortcuts import HttpResponse
from django.views.decorators.http import require_http_methods
from django.contrib.auth.hashers import make_password
import json

from .models import UserInfo


@require_http_methods(["POST"])
def register(request):
    # 添加用户
    username = request.POST.get('username')
    password = request.POST.get('username')
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
