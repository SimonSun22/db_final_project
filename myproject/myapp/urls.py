from django.urls import path
from . import views

urlpatterns = [
    path('add-customer/', views.add_customer, name='add_customer'),
    path('calculate-quote/', views.calculate_quote, name='calculate_quote'),
]
