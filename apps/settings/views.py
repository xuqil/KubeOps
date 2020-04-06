from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from rest_framework.response import Response
from kubernetes import client, config

from settings.models import BackgroundSettings
from settings.serializers.color import BackgroundSettingsSerializer
from settings.serializers.pod import PodSerializers
from utils.pagination import MyPageNumberPagination

config.load_kube_config()
v1 = client.CoreV1Api()


class BackgroundSettingsViewSet(ModelViewSet):
    queryset = BackgroundSettings.objects.all()
    serializer_class = BackgroundSettingsSerializer


class NodeVies(APIView):
    """
    节点
    """

    def get(self, request, *args, **kwargs):
        context = {'status': 200, 'msg': '获取节点成功!', 'results': ''}
        try:
            ret = v1.list_node()
            tmp_context = []
            for i in ret.items:
                tmp_dict = dict()
                tmp_dict['host'] = i.status.addresses[0].address
                tmp_dict['hostname'] = i.status.addresses[1].address
                tmp_dict['labels'] = i.metadata.namespace
                tmp_dict['capacity'] = i.status.capacity
                tmp_dict['allocatable'] = i.status.allocatable
                tmp_dict['status'] = i.status.conditions[-1].status
                tmp_context.append(tmp_dict)
            paginator = MyPageNumberPagination()
            page_publish_list = paginator.paginate_queryset(tmp_context, self.request, view=self)
            context['results'] = page_publish_list
        except Exception as e:
            print(e)
            context['msg'] = '获取失败'
            context['status'] = 400
        return Response(context)


class NamespaceView(APIView):
    """
    命名空间
    """

    def get(self, request, *args, **kwargs):
        context = {'status': 200, 'msg': '获取成功', 'results': ''}
        results = []
        try:
            ret = v1.list_namespace()
            for i in ret.items:
                results.append(i.metadata.name)
            context['results'] = results
        except Exception as e:
            print(e)
            context['msg'] = '获取失败'
            context['status'] = 400
        return Response(context)


class PodViews(APIView):
    """
    Pod
    """

    def get(self, request, *args, **kwargs):
        namespace = request.data.get('namespace')
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
