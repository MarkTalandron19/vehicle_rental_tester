from django.contrib import admin
from django.urls import path, include
from api import views
from rest_framework import routers

router = routers.DefaultRouter(trailing_slash = False)
router.register('vehicledetails', views.VehicleView)    

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
]
