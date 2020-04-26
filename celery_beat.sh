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
  echo '正在启动Celery-Beat...'
  celery -A KubeOps beat -l info -S django --pidfile="$CELERYWORKER_PID_PATH/celerybeat.pid" >  "$CELERYWORKER_LOG_PAGH/celery-beat.log"  2>&1  &;;
stop)
  echo '正在关闭Celery-Beat...'
  # shellcheck disable=SC2009
  # PROCESS=`ps -ef|grep celery|grep beat|grep -v grep|grep -v PPID|awk '{ print $2}'`
  PROCESS=`cat "$CELERYWORKER_PID_PATH/celerybeat.pid"`
  for i in $PROCESS
  do
    echo "Kill the $1 process [ $i ]"
    kill -9 "$i"
  done
  ;;
esac
