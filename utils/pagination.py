from rest_framework.pagination import PageNumberPagination


class MyPageNumberPagination(PageNumberPagination):
    page_size = 10
    page_query_param = 'page'
    page_size_query_param = 'page_size'
    max_page_size = 20


class MenuPagination(PageNumberPagination):
    page_size = 100
    page_query_param = 'page'
    page_size_query_param = 'page_size'
    max_page_size = 100


class MaxPagination(PageNumberPagination):
    page_size = 1000
    page_query_param = 'page'
    page_size_query_param = 'page_size'
    max_page_size = 1000
