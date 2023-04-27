from django.contrib import admin
from api.models import Account, Vehicle, RentalAgreement

# Register your models here.
admin.site.register(Account)
admin.site.register(Vehicle)
admin.site.register(RentalAgreement)
