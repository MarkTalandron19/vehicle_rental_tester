from django.shortcuts import render,redirect
from django.core.serializers import serialize
from api.models import Account,Vehicle,RentalAgreement
from api.serializers import AccountSerializer, VehicleSerializer, RentalAgreementSerializer
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response


# Create your views here.
class AccountView(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer

@api_view(['GET'])
def getAccounts(request):
    queryset = Account.objects.all()
    serializer = AccountSerializer(queryset, many = True)
    return Response(serializer.data)

class VehicleView(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer    

@api_view(['GET'])
def getVehicles(request):
    queryset = Vehicle.objects.all()
    serializer = VehicleSerializer(queryset, many = True)
    return Response(serializer.data)

class RentalView(viewsets.ModelViewSet):
    queryset = RentalAgreement.objects.all()
    serializer_class = RentalAgreementSerializer

@api_view(['GET'])
def getAgreements(request):
    queryset = RentalAgreement.objects.all()
    serializer = RentalAgreementSerializer(queryset, many = True)
    return Response(serializer.data)
