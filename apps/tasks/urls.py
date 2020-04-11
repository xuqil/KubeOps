from django.urls import path, include
from rest_framework.routers import DefaultRouter, SimpleRouter
from tasks import views

app_name = 'tasks'

router = DefaultRouter()
router.register('periodic_task', views.PeriodicTaskView, basename='periodic_task')
router.register('periodic_tasks', views.PeriodicTasksView, basename='periodic_tasks')
router.register('solar_schedule', views.SolarScheduleView, basename='solar_schedule')
router.register('interval_schedule', views.IntervalScheduleView, basename='interval_schedule')
router.register('clocked_schedule', views.ClockedScheduleView, basename='clocked_schedule')
router.register('crontab_schedule', views.CrontabScheduleView, basename='crontab_schedule')

urlpatterns = [
    path('', include(router.urls))
]
