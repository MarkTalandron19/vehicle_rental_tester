from django.shortcuts import render,redirect
from api.models import Vehicle
from api.serializers import VehicleSerializer
from rest_framework import viewsets

# Create your views here.
class VehicleView(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer