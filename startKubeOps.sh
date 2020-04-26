#!/bin/bash

# shellcheck disable=SC2046
# shellcheck disable=SC2006
if [ `whoami` != "root" ];then
 echo "非root用户！请使用root用户执行!"
 exit;
fi

# shellcheck disable=SC2034
CELERYWORKER_LOG_PAGH="/var/log/kubeops"
if [ ! -d "$CELERYWORKER_LOG_PAGH" ];then
   mkdir -p "$CELERYWORKER_LOG_PAGH"
fi

echo "启动KubeOps..."
daphne -b 0.0.0.0 -p 8000 KubeOps.asgi:application >  "$CELERYWORKER_LOG_PAGH/kubeops.log"  2>&1  &
#python3 manage.py runserver 0.0.0.0:8000 >  "$CELERYWORKER_LOG_PAGH/kubeops.log"  2>&1  &