from rest_framework import serializers
from api.models import Account, Vehicle, RentalAgreement


class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['accountID', 'username', 'password',
                  'firstName', 'lastName', 'accountRole',]


class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = ['vehicleID',  'vehicleName', 'vehicleModel', 'vehicleBrand',
                  'vehicleManufacturer',  'vehicleType', 'vehicleRentRate', 'image']


class RentalAgreementSerializer(serializers.ModelSerializer):
    class Meta:
        model = RentalAgreement
        fields = ['rentID', 'rentDate', 'numberOfDays', 'account_id', 'vehicle_id'
                  ]
