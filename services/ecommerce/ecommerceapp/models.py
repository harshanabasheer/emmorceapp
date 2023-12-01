from django.db import models

# Create your models here.
#login table
class LoginTb(models.Model):
    UserName=models.CharField(max_length=50)
    Password=models.CharField(max_length=50)
    Role=models.CharField(max_length=50)
    
    def __str__(self):
        return self.UserName

#registration table
class RegistrationTb(models.Model):
    Name=models.CharField(max_length=50)
    Address=models.CharField(max_length=50)
    Dateofbirth=models.CharField(max_length=50)
    Email=models.CharField(max_length=50)
    Phone=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    Password=models.CharField(max_length=50)
    Role=models.CharField(max_length=50)
    Status=models.CharField(max_length=50)
    Login=models.ForeignKey(LoginTb, on_delete=models.CASCADE)

    def __str__(self):
        return self.Name

#product tbale    
class ProductTb(models.Model):
    ProductName=models.CharField(max_length=50)
    Price=models.CharField(max_length=50)
    Category=models.CharField(max_length=50)
    Color=models.CharField(max_length=50)
    ProductImage=models.ImageField(upload_to='images/',null=True)
    Description=models.CharField(max_length=50)
    ItemCheck =models.CharField(max_length=50)
    
    
    
    def __str__(self):
        return self.ProductName
    
#ReviewTb table
class ReviewTb(models.Model):
    UserId=models.CharField(max_length=50)
    ProductId=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    ProductName=models.CharField(max_length=50)
    Review=models.CharField(max_length=50)
    Rating=models.CharField(max_length=50)
    
    def __str__(self):
        return self.Review

#cart table
class CartTb(models.Model):
    UserId=models.CharField(max_length=50)
    ProductId=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    ProductName=models.CharField(max_length=50)
    ProductImage=models.ImageField(upload_to='images/',null=True)
    Price=models.CharField(max_length=50)
    CartStatus=models.CharField(max_length=50)
    Category=models.CharField(max_length=50)
    ItemCheck =models.CharField(max_length=50)
    
    def __str__(self):
        return self.ProductName

#wishlist table
class WishlistTb(models.Model):
    UserId=models.CharField(max_length=50)
    ProductId=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    ProductName=models.CharField(max_length=50)
    ProductImage=models.ImageField(upload_to='images/',null=True)
    Price=models.CharField(max_length=50)
    
    def __str__(self):
        return self.ProductName
    
#category table
class CategoryTb(models.Model):
    CategoryName=models.CharField(max_length=50)
    CategoryImage=models.ImageField(upload_to='images/',null=True)
    def __str__(self):
        return self.CategoryName
    
#order table
class OrderTb(models.Model):
    UserId=models.CharField(max_length=50)
    UserName=models.CharField(max_length=50)
    ProductId=models.CharField(max_length=50)
    ProductName=models.CharField(max_length=50)
    ProductImage=models.ImageField(upload_to='images/',null=True)
    Category=models.CharField(max_length=50)
    CartId=models.CharField(max_length=50,null=True,blank=True)
    TotalAmount=models.CharField(max_length=50)
    OrderStatus=models.CharField(max_length=50)
    Price=models.CharField(max_length=50)
    
    def __str__(self):
        return self.ProductName
    
#payment table
class PaymentTb(models.Model):
    UserId=models.CharField(max_length=50)
    TotalAmount=models.CharField(max_length=50)
    PaymentMethod=models.CharField(max_length=50)
    PaymentStatus=models.CharField(max_length=50)
    Address=models.CharField(max_length=50)
    
    


