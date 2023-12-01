from django.contrib import admin
from .models import LoginTb,RegistrationTb,ProductTb,ReviewTb,CartTb,WishlistTb,CategoryTb,OrderTb,PaymentTb
# Register your models here.

admin.site.register(LoginTb)
admin.site.register(RegistrationTb)
admin.site.register(ProductTb)
admin.site.register(ReviewTb)
admin.site.register(CartTb)
admin.site.register(WishlistTb)
admin.site.register(CategoryTb)
admin.site.register(OrderTb)
admin.site.register(PaymentTb)