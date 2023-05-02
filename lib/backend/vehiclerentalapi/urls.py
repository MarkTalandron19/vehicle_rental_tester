from django.contrib import admin
from django.urls import path
from api.views import AccountView, VehicleView, RentalView

urlpatterns = [
    path('accounts/', AccountView.getAccounts, name = 'Accounts'),
    path('login/', AccountView.getLogIn, name = 'Log In'),
    path('vehicles/', VehicleView.getVehicles, name = 'Vehicles'),
    path('agreements/', RentalView.getAgreements, name = 'Agreements'),
    path('admin/', admin.site.urls),
    path('register/', AccountView.register, name = 'Register'),
    path('test/', AccountView.testAccount, name = 'Test'),
    path('rent/', RentalView.createRental, name = 'Create Rental'),
    path('rented/', VehicleView.getRentedCars, name = 'Rented')
]
