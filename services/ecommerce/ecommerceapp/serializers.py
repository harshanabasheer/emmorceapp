from rest_framework import serializers
from .models import LoginTb,RegistrationTb,ProductTb,ReviewTb,CartTb,WishlistTb,CategoryTb,OrderTb,PaymentTb

class LoginSerializers(serializers.ModelSerializer):
    class Meta:
        model = LoginTb
        fields = '__all__'
    def create(self,validated_data):
        return LoginTb.objects.create(**validated_data)
    
class RegistrationSerializers(serializers.ModelSerializer):
    class Meta:
        model = RegistrationTb
        fields = '__all__'
    def create(self,validated_data):
        return RegistrationTb.objects.create(**validated_data)
    
class ProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = ProductTb
        fields = '__all__'
    def create(self,validated_data):
        return ProductTb.objects.create(**validated_data)
    
class ReviewSerializers(serializers.ModelSerializer):
    class Meta:
        model = ReviewTb
        fields = '__all__'
    def create(self,validated_data):
        return ReviewTb.objects.create(**validated_data)
    
class CartSerializers(serializers.ModelSerializer):
    class Meta:
        model = CartTb
        fields = '__all__'
    def create(self,validated_data):
        return CartTb.objects.create(**validated_data)
    
class WishlistSerializers(serializers.ModelSerializer):
    class Meta:
        model = WishlistTb
        fields = '__all__'
    def create(self,validated_data):
        return WishlistTb.objects.create(**validated_data)
    
class CategorySerializers(serializers.ModelSerializer):
    class Meta:
        model = CategoryTb
        fields = '__all__'
    def create(self,validated_data):
        return CategoryTb.objects.create(**validated_data)
    
    
class OrderSerializers(serializers.ModelSerializer):
    class Meta:
        model = OrderTb
        fields = '__all__'
    def create(self,validated_data):
        return OrderTb.objects.create(**validated_data)
    
class PaymentSerializers(serializers.ModelSerializer):
    class Meta:
        model = PaymentTb
        fields = '__all__'
    def create(self,validated_data):
        return PaymentTb.objects.create(**validated_data)
    

    
    
    