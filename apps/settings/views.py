from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from rest_framework.response import Response
from kubernetes import client, config

from settings.models import BackgroundSettings
from settings.serializers.color import BackgroundSettingsSerializer
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
        try:
            ret = v1.list_namespace()
            tmp_context = []
            for i in ret.items:
                tmp_dict = dict()
                tmp_dict['name'] = i.metadata.name
                tmp_dict['status'] = i.status.phase
                tmp_context.append(tmp_dict)
            context['results'] = tmp_context
        except Exception as e:
            print(e)
            context['msg'] = '获取失败'
            context['status'] = 400
        return Response(context)

    def post(self, request, *args, **kwargs):
        namespace = request.data.get('namespace')
        context = {'status': 200, 'msg': '创建成功'}
        try:
            body = client.V1Namespace(api_version='v1', kind='Namespace', metadata={'name': namespace})
            ret = v1.create_namespace(body=body)
            if ret.status.phase == 'Active':
                return Response(context)
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = '创建失败'
        return Response(context)

    def delete(self, request, *args, **kwargs):
        query_params = request.query_params.dict()
        namespace = query_params.get('namespace')
        context = {'status': 200, 'msg': '删除成功'}
        try:
            v1.delete_namespace(name=namespace)
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = '删除失败'
        return Response(context)

