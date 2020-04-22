#!/bin/bash

echo '启动Celery...'
celery -A KubeOps  worker --beat --scheduler django --loglevel=info