from django.db import models


class Account(models.Model):
    accountID = models.CharField(max_length=100, primary_key=True)
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=100, unique=True)
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    accountRole = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['password', 'firstName', 'lastName', 'accountRole']

    class Meta:
        db_table = "account"
    
    @property
    def is_anonymous(self):
        return False
    
    @property
    def is_authenticated(self):
        return True


class Vehicle(models.Model):
    vehicleID = models.CharField(max_length=100, primary_key=True,)
    vehicleName = models.CharField(max_length=100)
    vehicleModel = models.CharField(max_length=100)
    vehicleBrand = models.CharField(max_length=100)
    vehicleManufacturer = models.CharField(max_length=100)
    vehicleType = models.CharField(max_length=100)
    vehicleRentRate = models.FloatField()
    image = models.CharField(max_length=1000, default=None)

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
