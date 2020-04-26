#!/bin/bash

# shellcheck disable=SC2046
# shellcheck disable=SC2006
if [ `whoami` != "root" ];then
 echo "非root用户！请使用root用户执行!"
 exit;
fi

# shellcheck disable=SC2034
CELERYWORKER_LOG_PAGH="/var/log/celery"
CELERYWORKER_PID_PATH="/var/run/celery"
if [ ! -d "$CELERYWORKER_LOG_PAGH" ];then
   mkdir -p "$CELERYWORKER_LOG_PAGH"
fi

if [ ! -d "$CELERYWORKER_PID_PATH" ];then
   mkdir -p "$CELERYWORKER_PID_PATH"
fi

case $1 in
start)
  echo '正在启动Celery...'
  celery multi start worker1 -A KubeOps -l info --pidfile="$CELERYWORKER_PID_PATH/%n.pid" --logfile="$CELERYWORKER_LOG_PAGH/%n%I.log";;
stop)
  echo '正在关闭Celery...'
  celery multi stopwait worker1 --pidfile="$CELERYWORKER_PID_PATH/%n.pid";;
restart)
  echo '正在重启Celery...'
  celery multi restart worker1 -A KubeOps -l info --pidfile="$CELERYWORKER_PID_PATH/%n.pid" --logfile="$CELERYWORKER_LOG_PAGH/%n%I.log";;
esac
