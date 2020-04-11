from __future__ import absolute_import, unicode_literals
from django.http import JsonResponse
from rest_framework.viewsets import ModelViewSet

from apps.tasks import tasks

from tasks.serializer.serializer import *


def index(request, *args, **kwargs):
    res = tasks.add.delay(1, 3)
    return JsonResponse({'status': 'successful', 'task_id': res.task_id})


class PeriodicTaskView(ModelViewSet):
    """
    任务
    """
    queryset = PeriodicTask.objects.all()
    serializer_class = PeriodicTaskSerializer


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
