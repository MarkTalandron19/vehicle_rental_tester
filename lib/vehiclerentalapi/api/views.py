from django.shortcuts import render,redirect
from api.models import Account,Vehicle,RentalAgreement
from api.serializers import AccountSerializer, VehicleSerializer, RentalAgreementSerializer
from rest_framework import viewsets

# Create your views here.
class AccountView(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer

class VehicleView(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer

class RentalView(viewsets.ModelViewSet):
    queryset = RentalAgreement.objects.all()
    serializer_class = RentalAgreementSerializer