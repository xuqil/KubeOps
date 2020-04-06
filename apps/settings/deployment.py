from rest_framework.views import APIView
from rest_framework.response import Response
from kubernetes import client, config

from settings.serializers.deployment import DeploymentSerializers
from utils.pagination import MyPageNumberPagination

config.load_kube_config()
apps_v1 = client.AppsV1Api()


class DeploymentViews(APIView):
    """
    Deployment
    """
    def get(self, request, *args, **kwargs):
        namespace = request.data.get('namespace')
        context = {'status': 200, 'msg': '获取Deployment成功!', 'results': ''}
        try:
            if namespace:
                ret = apps_v1.list_namespaced_deployment(namespace=namespace)
            else:
                ret = apps_v1.list_deployment_for_all_namespaces()
            tmp_context = []
            for i in ret.items:
                tmp_dict = dict()
                tmp_dict['name'] = i.metadata.name
                tmp_dict['namespace'] = i.metadata.namespace
                tmp_dict['replicas'] = i.spec.replicas
                tmp_dict['available_replicas'] = i.status.available_replicas
                tmp_dict['ready_replicas'] = i.status.ready_replicas
                tmp_dict['unavailable_replicas'] = i.status.unavailable_replicas
                tmp_dict['updated_replicas'] = i.status.updated_replicas
                tmp_context.append(tmp_dict)
            paginator = MyPageNumberPagination()
            page_publish_list = paginator.paginate_queryset(tmp_context, self.request, view=self)
            ps = DeploymentSerializers(page_publish_list, many=True)
            response = paginator.get_paginated_response(ps.data)
            return response
        except Exception as e:
            context['status'] = 400
            context['msg'] = e
        return Response(context)
