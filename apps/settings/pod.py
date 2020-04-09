from rest_framework.views import APIView
from rest_framework.response import Response
from kubernetes import client, config

from settings.serializers.pod import PodSerializers
from utils.pagination import MyPageNumberPagination

config.load_kube_config()
v1 = client.CoreV1Api()


class PodViews(APIView):
    """
    Pod
    """

    def get(self, request, *args, **kwargs):
        namespace = request.query_params.dict().get('namespace')
        context = {}
        try:
            if namespace:
                ret = v1.list_namespaced_pod(namespace=namespace)
            else:
                ret = v1.list_pod_for_all_namespaces(watch=False)
            tmp_context = []
            for i in ret.items:
                tmp_dict = dict()
                tmp_dict['pod_ip'] = i.status.pod_ip
                tmp_dict['namespace'] = i.metadata.namespace
                tmp_dict['name'] = i.metadata.name
                tmp_dict['host_ip'] = i.status.host_ip
                tmp_dict['status'] = i.status.phase
                tmp_context.append(tmp_dict)
            paginator = MyPageNumberPagination()
            page_publish_list = paginator.paginate_queryset(tmp_context, self.request, view=self)
            ps = PodSerializers(page_publish_list, many=True)
            response = paginator.get_paginated_response(ps.data)
            return response
        except Exception as e:
            context['status'] = 400
            context['msg'] = e
            context['results'] = ''
        return Response(context)


class DetailPodView(APIView):
    """
    对具体的Pod操作
    """

    def get(self, request, *args, **kwargs):
        name = request.query_params.dict().get('name')
        namespace = request.query_params.dict().get('namespace', 'default')
        context = {'status': 200, 'msg': '获取Pod信息成功!', 'results': ''}
        try:
            ret = v1.read_namespaced_pod(name=name, namespace=namespace)
            context['results'] = ret.to_dict()
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = '获取Pod信息失败'
        return Response(context)

    def delete(self, request, *args, **kwargs):
        name = request.query_params.dict().get('name')
        namespace = request.query_params.dict().get('namespace', 'default')
        context = {'status': 200, 'msg': '删除成功!', 'results': ''}
        try:
            ret = v1.delete_namespaced_pod(name=name, namespace=namespace)
            if ret.status is None:
                context['status'] = 400
                context['msg'] = ret
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = '删除失败'
        return Response(context)

    def put(self, request, *args, **kwargs):
        import json
        name = request.data.get('name')
        namespace = request.data.get('namespace', 'default')
        body = request.data.get('body')
        if isinstance(body, str):
            body = json.loads(request.data.get('body'))
        else:
            pass
        metadata = body.get('metadata', '')
        spec = body.get('spec', '')
        context = {'status': 200, 'msg': '更新成功!', 'results': ''}
        try:
            old_resp = v1.read_namespaced_pod(name=name, namespace=namespace)
            old_resp.metadata.annotations = metadata.get('annotations')
            old_resp.metadata.labels = metadata.get('labels')
            old_resp.metadata.name = metadata.get('name')
            old_resp.metadata.namespace = metadata.get('namespace')

            old_resp.spec.affinity = spec.get('affinity')
            for i in range(len(old_resp.spec.containers)):
                old_resp.spec.containers[i].args = spec.get('containers')[i].get('args')
                old_resp.spec.containers[i].command = spec.get('containers')[i].get('command')
                old_resp.spec.containers[i].env = spec.get('containers')[i].get('env')
                old_resp.spec.containers[i].env_from = spec.get('containers')[i].get('env_from')
                old_resp.spec.containers[i].image = spec.get('containers')[i].get('image')
                old_resp.spec.containers[i].image_pull_policy = spec.get('containers')[i].get('image_pull_policy')
                old_resp.spec.containers[i].lifecycle = spec.get('containers')[i].get('lifecycle')
                old_resp.spec.containers[i].liveness_probe = spec.get('containers')[i].get('liveness_probe')
                old_resp.spec.containers[i].name = spec.get('containers')[i].get('name')
            v1.replace_namespaced_pod(name=name, namespace=namespace, body=old_resp)
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = e
        return Response(context)

    def post(self, request, *args, **kwargs):
        import yaml
        context = {'status': 200, 'msg': '部署成功!', 'results': ''}
        namespace = request.data.get('namespace', 'default')
        try:
            body = yaml.safe_load(request.data.get('body'))
            deploy_type = body.get('kind')
            print(deploy_type)
            if deploy_type != 'Pod':
                context['status'] = 400
                context['msg'] = '部署类型错误!'
                return Response(context)
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = e
            return Response(context)
        print("ok")
        try:
            v1.create_namespaced_pod(namespace=namespace, body=body)
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = e
        return Response(context)
