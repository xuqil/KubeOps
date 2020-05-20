from __future__ import absolute_import, unicode_literals
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet
from rest_framework.response import Response
from celery import current_app
# 注册任务
from apps.tasks import tasks

from tasks.serializer.serializer import *


class TasksView(APIView):
    """
    获取任务列表
    """
    celery_app = current_app

    def get(self, request, *args, **kwargs):
        context = {'status': 200, 'msg': '获取任务成功', 'results': ''}
        try:
            tasks_list = list(sorted(name for name in self.celery_app.tasks
                                     if not name.startswith('celery.')))
            context['results'] = tasks_list
        except Exception as e:
            print(e)
            context['status'] = 400
            context['msg'] = '获取任务失败!'
        return Response(context)


class PeriodicTaskView(ModelViewSet):
    """
    任务
    """
    queryset = PeriodicTask.objects.all()
    serializer_class = PeriodicTaskSerializer
    ordering_fields = ('name', 'interval', 'crontab', 'solar', 'clocked', 'one_off', 'start_time', 'enabled',
                       'total_run_count', 'date_changed')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.flag = 0

    def get_serializer_class(self):
        if self.action == 'list':
            return PeriodicTaskListSerializer
        if self.action == 'update' and self.flag == 1:
            return PeriodicTaskEnableSerializer
        return PeriodicTaskSerializer

    def update(self, request, *args, **kwargs):
        if request.data.get('enabled') is not None and request.data.get('name') is None:
            self.flag = 1
        result = super(PeriodicTaskView, self).update(request, *args, **kwargs)
        return result


class PeriodicTasksView(ModelViewSet):
    queryset = PeriodicTasks.objects.all()
    serializer_class = PeriodicTasksSerializer


class SolarScheduleView(ModelViewSet):
    queryset = SolarSchedule.objects.all()
    serializer_class = SolarScheduleSerializer


class IntervalScheduleView(ModelViewSet):
    queryset = IntervalSchedule.objects.all()
    serializer_class = IntervalScheduleSerializer


class ClockedScheduleView(ModelViewSet):
    queryset = ClockedSchedule.objects.all()
    serializer_class = ClockedScheduleSerializer


class CrontabScheduleView(ModelViewSet):
    queryset = CrontabSchedule.objects.all()
    serializer_class = CrontabScheduleSerializer
