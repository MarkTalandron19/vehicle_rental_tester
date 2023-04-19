from django.contrib import admin
from django.urls import path, include
from api.views import getAccounts, getVehicles, getAgreements, getLogIn

urlpatterns = [
    path('accounts/', getAccounts, name = 'accounts'),
    path('login/<str:username>/<str:password>/', getLogIn, name = 'log in'),
    path('vehicles/', getVehicles, name = 'vehicles'),
    path('agreements/', getAgreements, name = 'agreements'),
    path('admin/', admin.site.urls),
]
