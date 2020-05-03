from django_celery_beat.models import *
from rest_framework import serializers


class PeriodicTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = PeriodicTask
        fields = '__all__'


class PeriodicTaskListSerializer(serializers.ModelSerializer):
    interval = serializers.SerializerMethodField()
    solar = serializers.SerializerMethodField()
    crontab = serializers.SerializerMethodField()
    clocked = serializers.SerializerMethodField()

    class Meta:
        model = PeriodicTask
        fields = ['name', 'task', 'interval', 'crontab', 'solar', 'clocked', 'args', 'kwargs', 'queue', 'exchange',
                  'routing_key', 'headers', 'priority', 'expires', 'expire_seconds', 'one_off', 'start_time', 'enabled',
                  'last_run_at', 'total_run_count', 'date_changed', 'description']
        depth = 1

    def get_interval(self, row):
        return str(row.interval)

    def get_crontab(self, row):
        return str(row.crontab)

    def get_solar(self, row):
        return str(row.solar)

    def get_clocked(self, row):
        return str(row.clocked)


class PeriodicTasksSerializer(serializers.ModelSerializer):
    class Meta:
        model = PeriodicTasks
        fields = '__all__'


class SolarScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = SolarSchedule
        fields = '__all__'


class IntervalScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = IntervalSchedule
        fields = '__all__'


class ClockedScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClockedSchedule
        fields = '__all__'


class CrontabScheduleSerializer(serializers.ModelSerializer):
    minute = serializers.CharField(
        max_length=60 * 4, default='*',
        help_text='Cron Minutes to Run. Use "*" for "all". (Example: "0,30")',
        validators=[validators.minute_validator],
    )
    hour = serializers.CharField(
        max_length=24 * 4, default='*',
        help_text='Cron Hours to Run. Use "*" for "all". (Example: "8,20")',
        validators=[validators.hour_validator],
    )
    day_of_week = serializers.CharField(
        max_length=64, default='*',
        help_text='Cron Days Of The Week to Run. Use "*" for "all". '
                  '(Example: "0,5")',
        validators=[validators.day_of_week_validator],
    )
    day_of_month = serializers.CharField(
        max_length=31 * 4, default='*',
        help_text='Cron Days Of The Month to Run. Use "*" for "all". '
                  '(Example: "1,15")',
        validators=[validators.day_of_month_validator],
    )
    month_of_year = serializers.CharField(
        max_length=64, default='*',
        help_text='Cron Months Of The Year to Run. Use "*" for "all". '
                  '(Example: "0,6")',
        validators=[validators.month_of_year_validator],
    )
    timezone = serializers.CharField(
        default='Asia/Shanghai',
        help_text='Timezone to Run the Cron Schedule on.  Default is Asia/Shanghai.',
    )

    class Meta:
        model = CrontabSchedule
        fields = ['id', 'minute', 'hour', 'day_of_week', 'day_of_month', 'month_of_year', 'timezone']
