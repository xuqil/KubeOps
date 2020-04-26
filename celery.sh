#!/bin/bash

# shellcheck disable=SC2046
# shellcheck disable=SC2006
if [ `whoami` != "root" ];then
 echo "非root用户！请使用root用户执行!"
 exit;
fi

echo "启动请输入start"
echo "重启请输入restart"
echo "关闭请输入stop"
# shellcheck disable=SC2162
read -p "请输入选项 > " sele

case $sele in
start)
  ./celery_beat.sh start
  ./celery_worker.sh start
  ;;
stop)
  ./celery_beat.sh stop
  ./celery_worker.sh stop
  ;;
restart)
  ./celery_beat.sh stop
  ./celery_beat.sh start
  ./celery_worker.sh restart
  ;;
*)
  echo "错误选项"
esac
