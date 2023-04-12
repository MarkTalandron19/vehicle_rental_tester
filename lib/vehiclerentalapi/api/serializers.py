from rest_framework import serializers
from api.models import Vehicle

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = [
            'vehicleID',
            'vehicleName',
            'vehicleModel',
            'vehicleBrand',
            'vehicleManufacturer',
            'vehicleType',
            'vehicleRentRate'  
        ]