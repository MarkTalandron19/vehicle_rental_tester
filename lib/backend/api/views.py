from django.utils import timezone
import json
from pstats import Stats
import statistics
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
            account = Account.objects.get(username=username)
            if account:
                account.last_login = timezone.now()
                account.save()
                serializer = AccountSerializer(account)
                return Response(serializer.data)
            else:
                return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)
        except Account.DoesNotExist:
            return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)
        
    @api_view(['GET'])
    def testAccount(request):
        queryset = Account.objects.get(password = 1234)
        serializer = AccountSerializer(queryset)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def updateAccount(request, accountID):
        account = Account.objects.get(pk = accountID)
        account.username = request.POST.get('username', account.username)
        account.password = request.POST.get('password', account.password)
        account.firstName = request.POST.get('firstName', account.firstName)
        account.lastName =  request.POST.get('lastName', account.password)
        account.save()

class VehicleView(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer
    
    @api_view(['GET'])
    def getVehicles(request):
        queryset = Vehicle.objects.all()
        serializer = VehicleSerializer(queryset, many=True)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def update_vehicle(request, vehicleID):
        vehicle = Vehicle.objects.get(pk = vehicleID)
        vehicle.vehicleName = request.POST.get('vehicleName', vehicle.vehicleName)
        vehicle.vehicleModel = request.POST.get('vehicleModel', vehicle.vehicleModel)
        vehicle.vehicleBrand = request.POST.get('vehicleBrand', vehicle.vehicleBrand)
        vehicle.vehicleManufacturer = request.POST.get('vehicleManufacturer', vehicle.vehicleManufacturer)
        vehicle.vehicleType = request.POST.get('vehicleType', vehicle.vehicleType)
        vehicle.vehicleRentRate = request.POST.get('vehicleRentRate', vehicle.vehicleRentRate)
        vehicle.available = request.POST.get('available', vehicle.available)
        vehicle.image = request.POST.get('image', vehicle.image)
        vehicle.save()
    
class RentalView(viewsets.ModelViewSet):
    queryset = RentalAgreement.objects.all()
    serializer_class = RentalAgreementSerializer
    
    @api_view(['GET'])
    def getAgreements(request):
        queryset = RentalAgreement.objects.all()
        serializer = RentalAgreementSerializer(queryset, many=True)
        return Response(serializer.data)

    @api_view(['POST'])
    def createRental(request, accountID, vehicleID):
        account = Account.objects.get(pk = accountID)
        vehicle = Vehicle.objects.get(pk = vehicleID)
        rent_data = json.loads(request.body)
        rent = RentalAgreement.objects.create(
            rentID = rent_data['rentID'],
            rentDate = rent_data['rentDate'],
            numberOfDays = rent_data['numberOfDays'],
            account = account,
            vehicle = vehicle,    
        )
        vehicle.available = False
        vehicle.save()
        serializer = RentalAgreementSerializer(rent)
        return Response(serializer.data, status=Stats.HTTP_201_CREATED)
    
    @api_view(['POST'])
    def updateRent(request, rentID):
        rent = RentalAgreement.objects.get(pk = rentID)
        rent.rentDate = request.POST.get('rentDate', rent.rentDate)
        rent.numberOfDays = request.POST.get('numberOfDays', rent.numberOfDays)
        rent.save()


