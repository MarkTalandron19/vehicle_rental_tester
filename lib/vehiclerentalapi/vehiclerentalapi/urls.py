from django.contrib import admin
from django.urls import path, include
from api.views import getAccounts, getVehicles, getAgreements
from rest_framework import routers

urlpatterns = [
    path('accounts/', getAccounts, name = 'accounts'),
    path('vehicles/', getVehicles, name = 'vehicles'),
    path('agreements/', getAgreements, name = 'agreements'),
    path('admin/', admin.site.urls),
]
