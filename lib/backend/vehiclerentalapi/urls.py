from django.contrib import admin
from django.urls import path
from api.views import getAccounts, getVehicles, getAgreements, getLogIn, AccountView

urlpatterns = [
    path('accounts/', getAccounts, name = 'Accounts'),
    path('login/<str:username>/<str:password>/', getLogIn, name = 'Log In'),
    path('vehicles/', getVehicles, name = 'Vehicles'),
    path('agreements/', getAgreements, name = 'Agreements'),
    path('admin/', admin.site.urls),
    path('register/', AccountView.register, name = 'Register')
]
