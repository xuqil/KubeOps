import pytz
from datetime import datetime, timedelta

utc_tz = pytz.timezone('Asia/Shanghai')


def now():
    return datetime.now(tz=utc_tz).strftime('%Y-%m-%d %H:%M:%S')


def now_time():
    return datetime.now(tz=utc_tz).strftime('%H:%M:%S')


def today():
    return datetime.now(tz=utc_tz)


def last_day():
    return datetime.now(tz=utc_tz) - timedelta(days=1)
