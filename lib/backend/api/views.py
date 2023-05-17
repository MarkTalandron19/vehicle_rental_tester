from django.utils import timezone
import json
import statistics
from api.models import Account, Vehicle, RentalAgreement
from api.serializers import AccountSerializer, VehicleSerializer, RentalAgreementSerializer
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response


# Create your views here.
class AccountView(viewsets.ModelViewSet):

    @api_view(['POST'])
    def register(request):
        account_data = json.loads(request.body)
        account = Account.objects.create(
            accountID = account_data['accountID'],
            username = account_data['username'],
            password = account_data['password'],
            firstName = account_data['firstName'],
            lastName = account_data['lastName'],
            accountRole = account_data['accountRole']
        )
        serializer = AccountSerializer(account)
        return Response(serializer.data)

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
            account = Account.objects.get(username = username, password = password)
            if account:
                account.last_login = timezone.now()
                account.save()
                serializer = AccountSerializer(account)
                return Response(serializer.data)
            else:
                return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)
        except Account.DoesNotExist:
            return Response({'error': 'Invalid credentials'}, status=statistics.HTTP_401_UNAUTHORIZED)
    
    @api_view(['POST'])
    def updateAccount(request):
        account_data = json.loads(request.body)
        account_id = account_data['accountID']
        account = Account.objects.get(pk = account_id)
        account.username = account_data['username']
        account.password = account_data['password']
        account.firstName = account_data['firstName']
        account.lastName =  account_data['lastName']
        account.accountRole = account_data['accountRole']
        account.is_active = account_data['is_active']
        account.is_staff = account_data['is_staff']
        account.is_superuser = account_data['is_superuser']
        account.save()

class VehicleView(viewsets.ModelViewSet):
  
    @api_view(['POST'])
    def addVehicle(request):
        vehicle_data = json.loads(request.body)
        vehicle = Vehicle.objects.create(
            vehicleID = vehicle_data['vehicleID'],
            vehicleName = vehicle_data['vehicleName'],
            vehicleModel = vehicle_data['vehicleModel'],
            vehicleBrand = vehicle_data['vehicleBrand'],
            vehicleManufacturer = vehicle_data['vehicleManufacturer'],
            vehicleType = vehicle_data['vehicleType'],
            vehicleRentRate = vehicle_data['vehicleRentRate'],
            available = vehicle_data['available'],
            image = vehicle_data['image']
        )
        serializer = VehicleSerializer(vehicle)
        return Response(serializer.data)
      
    @api_view(['GET'])
    def getVehicles(request):
        queryset = Vehicle.objects.all()
        serializer = VehicleSerializer(queryset, many=True)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def update_vehicle(request):
        vehicle_data = json.loads(request.body)
        vehicle_id = vehicle_data['vehicleID']
        vehicle = Vehicle.objects.get(vehicleID = vehicle_id)
        vehicle.vehicleName = vehicle_data['vehicleName']
        vehicle.vehicleModel = vehicle_data['vehicleModel']
        vehicle.vehicleBrand = vehicle_data['vehicleBrand']
        vehicle.vehicleManufacturer = vehicle_data['vehicleManufacturer']
        vehicle.vehicleType = vehicle_data['vehicleType']
        vehicle.vehicleRentRate = vehicle_data['vehicleRentRate']
        vehicle.available = vehicle_data['available']
        vehicle.image = vehicle_data['image']
        vehicle.save()
        serializer = VehicleSerializer(vehicle)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def getRentedCars(request):
        rent_data = json.loads(request.body)
        account_id = rent_data['account']
        try:
            account = Account.objects.get(pk = account_id)
        except Account.DoesNotExist:
            print(f"Account not found")
        rented_vehicles =  Vehicle.objects.filter(rentalagreement__account = account).distinct()
        serializer = VehicleSerializer(rented_vehicles, many = True)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def getRecentCar(request):
        data = json.loads(request.body)
        id = data['account']
        try:
            recent = RentalAgreement.objects.filter(account = id).order_by('-rentDate').first()
        except RentalAgreement.DoesNotExist:
            print('Agreement not found')
        recent_vehicle =  recent.vehicle
        serializer = VehicleSerializer(recent_vehicle)
        return Response(serializer.data)
    
class RentalView(viewsets.ModelViewSet):
    
    @api_view(['GET'])
    def getAgreements(request):
        queryset = RentalAgreement.objects.all()
        serializer = RentalAgreementSerializer(queryset, many=True)
        return Response(serializer.data)

    @api_view(['POST'])
    def createRental(request):
        rent_data = json.loads(request.body)
        account_id = rent_data['account']
        vehicle_id = rent_data['vehicle']
        try:
            account = Account.objects.get(pk = account_id)
        except Account.DoesNotExist:
            print(f"Account not found")
        try:
            vehicle = Vehicle.objects.get(pk = vehicle_id)
        except Vehicle.DoesNotExist:
            print(f"Vehicle not found")
        rent = RentalAgreement.objects.create(
            rentID = rent_data['rentID'],
            rentDate = rent_data['rentDate'],
            numberOfDays = rent_data['numberOfDays'],
            rentDue = rent_data['rentDue'],
            account = account,
            vehicle = vehicle,    
        )
        vehicle.available = False
        vehicle.save()
        serializer = RentalAgreementSerializer(rent)
        return Response(serializer.data)
    
    @api_view(['POST'])
    def updateRent(request):
        rent_data = json.loads(request.body)
        rent_id = rent_data['rentID']
        rent = RentalAgreement.objects.get(pk = rent_id)
        rent.rentDate = rent_data['rentDate']
        rent.numberOfDays = rent_data['numberOfDays']
        rent.save()
        serializer = RentalAgreementSerializer(rent)
        return Response(serializer.data)

    @api_view(['POST'])
    def getDue(request):
        data = json.loads(request.body)
        account_id = data['account']
        vehicle_id = data['vehicle']

        try:
            rental_agreement = RentalAgreement.objects.get(account = account_id, vehicle = vehicle_id)
            serializer = RentalAgreementSerializer(rental_agreement)
            return Response(serializer.data)
        except RentalAgreement.DoesNotExist:
            print('Agreement not found')

    @api_view(['POST'])
    def getRecentTransaction(request):
        data = json.loads(request.body)
        id = data['account']
        try:
            recent = RentalAgreement.objects.filter(account = id).order_by('-rentDate').first()
            serializer = RentalAgreementSerializer(recent)
            return Response(serializer.data)
        except RentalAgreement.DoesNotExist:
            print('Agreement not found')

        

