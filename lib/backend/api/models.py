from django.db import models

class Account(models.Model):
    accountID = models.CharField(max_length=100, primary_key=True)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    accountRole = models.CharField(max_length=100)
    class Meta:
        db_table = "account"

class Vehicle(models.Model):
    vehicleID = models.CharField(max_length=100, primary_key= True,)
    vehicleName = models.CharField(max_length=100)
    vehicleModel = models.CharField(max_length=100)
    vehicleBrand = models.CharField(max_length=100)
    vehicleManufacturer = models.CharField(max_length=100)
    vehicleType = models.CharField(max_length=100)
    vehicleRentRate = models.FloatField()
    class Meta:
        db_table = "vehicle"

class RentalAgreement(models.Model):
    rentID = models.CharField(max_length=100, primary_key=True)
    rentDate = models.DateField()
    numberOfDays = models.PositiveIntegerField()
    account = models.ForeignKey(Account, on_delete=models.CASCADE)
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    class Meta:
        db_table = "rental_agreement"