from imaplib import _Authenticator
import json
from pstats import Stats
import statistics
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.core.serializers import serialize
from api.models import Account, Vehicle, RentalAgreement
from api.serializers import AccountSerializer, VehicleSerializer, RentalAgreementSerializer
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response


# Create your views here.
class AccountView(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer

    @api_view(['POST'])
    def register(request):
        account_data = json.loads(request.body)
        account = Account.objects.create(
            accountID=account_data['accountID'],
            username=account_data['username'],
            password=account_data['password'],
            firstName=account_data['firstName'],
            lastName=account_data['lastName'],
            accountRole=account_data['accountRole']
        )
        serializer = AccountSerializer(account)
        return Response(serializer.data, status=Stats.HTTP_201_CREATED)

    @api_view(['GET'])
    def getAccounts(request):
        queryset = Account.objects.all()
        serializer = AccountSerializer(queryset, many=True)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def getLogIn(request):
        username = request.data.get('username')
        password = request.data.get('password')
    
    # validate username and password
        if not username or not password:
            return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)

        try:
            account = Account.objects.get(username=username, password=password)
            serializer = AccountSerializer(account)
            return Response(serializer.data)
        except Account.DoesNotExist:
            return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)
        
    @api_view(['GET'])
    def testAccount(request):
        queryset = Account.objects.get(password = 1234)
        serializer = AccountSerializer(queryset)
        return Response(serializer.data)

class VehicleView(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer
    
    @api_view(['GET'])
    def getVehicles(request):
        queryset = Vehicle.objects.all()
        serializer = VehicleSerializer(queryset, many=True)
        return Response(serializer.data)





class RentalView(viewsets.ModelViewSet):
    queryset = RentalAgreement.objects.all()
    serializer_class = RentalAgreementSerializer
    
    @api_view(['GET'])
    def getAgreements(request):
        queryset = RentalAgreement.objects.all()
        serializer = RentalAgreementSerializer(queryset, many=True)
        return Response(serializer.data)



