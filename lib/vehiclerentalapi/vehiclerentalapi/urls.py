from django.contrib import admin
from django.urls import path, include
from api.views import getVehicles
from rest_framework import routers

urlpatterns = [
    path('vehicles/', getVehicles, name = 'vehicles'),
    path('admin/', admin.site.urls),
]
