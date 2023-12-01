from django.shortcuts import render,redirect
from .serializers import LoginSerializers,RegistrationSerializers,ProductSerializers,ReviewSerializers,CartSerializers,WishlistSerializers,CategorySerializers,OrderSerializers,PaymentSerializers
from .models import LoginTb,RegistrationTb,ProductTb,ReviewTb,CartTb,WishlistTb,CategoryTb,OrderTb,PaymentTb
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from django.db.models import Sum


# Create your views here.

#admin registraion
class AdminReg(GenericAPIView):
    serializer_class=RegistrationSerializers
    login_serializer_class=LoginSerializers
    def post(self, request):
        
        login_id=""
        Name = request.data.get('Name')
        Address = request.data.get('Address')
        Dateofbirth = request.data.get('Dateofbirth')
        Email = request.data.get('Email')
        Phone = request.data.get('Phone')
        Password = request.data.get('Password')
        UserName = Email
        Role="admin"
        Status='0'
        if LoginTb.objects.filter(UserName = UserName):
            return Response({'message':'User name allready Exist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
            loginserializer=self.login_serializer_class(data={'UserName':UserName,'Password':Password ,'Role':Role})
    
            if loginserializer.is_valid():
                log=loginserializer.save()
                login_id = log.id

            serializer=self.serializer_class(data={'Login':login_id,'Name':Name,'Address':Address,'Dateofbirth':Dateofbirth,'Email':Email,'Phone':Phone,'UserName':UserName,'Password':Password,'Role':Role,'Status':Status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'admin added successfully','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

#user registraion
class UserReg(GenericAPIView):
    serializer_class=RegistrationSerializers
    login_serializer_class=LoginSerializers
    def post(self, request):
        login_id=""
        Name = request.data.get('Name')
        Address = request.data.get('Address')
        Dateofbirth = request.data.get('Dateofbirth')
        Email = request.data.get('Email')
        Phone = request.data.get('Phone')
        Password = request.data.get('Password')
        UserName = Email
        Role="user"
        Status='0'
        if LoginTb.objects.filter(UserName = UserName):
            return Response({'message':'User name allready Exist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
            loginserializer=self.login_serializer_class(data={'UserName':UserName,'Password':Password,'Role':Role})
    
            if loginserializer.is_valid():
                log=loginserializer.save()
                login_id = log.id

            serializer=self.serializer_class(data={'Login':login_id,'Name':Name,'Address':Address,'Dateofbirth':Dateofbirth,'Email':Email,'Phone':Phone,'UserName':UserName,'Password':Password,'Role':Role,'Status':Status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'user added successfully','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

#seller registraion
class SellerReg(GenericAPIView):
    serializer_class=RegistrationSerializers
    login_serializer_class=LoginSerializers
    def post(self, request):
        login_id=""
        Name = request.data.get('Name')
        Address = request.data.get('Address')
        Dateofbirth = request.data.get('Dateofbirth')
        Email = request.data.get('Email')
        Phone = request.data.get('Phone')
        Password = request.data.get('Password')
        UserName = Email
        Role="seller"
        Status='0'
        if LoginTb.objects.filter(UserName = UserName):
            return Response({'message':'User name allready Exist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
            loginserializer=self.login_serializer_class(data={'UserName':UserName,'Password':Password,'Role':Role})
    
            if loginserializer.is_valid():
                log=loginserializer.save()
                login_id = log.id

            serializer=self.serializer_class(data={'Login':login_id,'Name':Name,'Address':Address,'Dateofbirth':Dateofbirth,'Email':Email,'Phone':Phone,'UserName':UserName,'Password':Password,'Role':Role,'Status':Status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'seller added successfully','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
        
        
#login 
class Login(GenericAPIView):
    serializer_class = LoginSerializers

    def post (self,request):
        u_id= ''
        UserName = request.data.get('UserName')
        Password = request.data.get('Password')
        # print(UserName)
        # print(Password)
        logreg=LoginTb.objects.filter(UserName=UserName,Password=Password)
        # print(logreg,"dddd")
        # print(logreg.count)
        if(logreg.count()>0):
            read_serializer = LoginSerializers(logreg, many=True)
            for i in read_serializer.data:
                id=i['id']
                #print(id)
                
                regdata = RegistrationTb.objects.all().filter(Login = id).values()
                print(regdata)

                for i in regdata:
                    u_id = i['id']
                    name = i['Name']
                    UserName=i['UserName']
                    Password=i['Password']
                    Role=i['Role']
                    Status=i['Status']
                    
                    print(u_id)

                return Response({'data':{
                    'name':name,
                    'userid':u_id,
                    'login_id':id,
                    'UserName':UserName,
                    'Password':Password,
                    'Role':Role,
                    'Status':Status,
                },
                'success':True,
                'message':'Logged In Successfully'
            },status=status.HTTP_200_OK)
        else:
            return Response({
                'message':'username or password is invalid',
                'success':False
                },status = status.HTTP_400_BAD_REQUEST)
            

#add items
class Addproduct(GenericAPIView):
    serializer_class=ProductSerializers
    def post(self, request):
        ProductName = request.data.get('ProductName')
        Price = request.data.get('Price')
        Category = request.data.get('Category')
        Color = request.data.get('Color')
        ProductImage = request.data.get('ProductImage')
        Description = request.data.get('Description')
        ItemCheck='0'
        serializer=self.serializer_class(data={'ProductName':ProductName,'Price':Price,'Category':Category,'Color':Color,'ProductImage':ProductImage,'Description':Description,'ItemCheck':ItemCheck})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Product added successfully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
#read items
class GetAllProducts(GenericAPIView):
    serializer_class = ProductSerializers
    def get(self,request):
        queryset = ProductTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Products','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
            
#read one item
class GetOneProduct(GenericAPIView):
    serializer_class = ProductSerializers
    def get(self,request,id):
        queryset = ProductTb.objects.get(pk=id)
        serializer=ProductSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Products','success':True},status=status.HTTP_200_OK)
    
#update item
class UpdateProduct(GenericAPIView):
    serializer_class = ProductSerializers
    def put(self,request,id):
        queryset = ProductTb.objects.get(pk=id)
        data = ProductSerializers(instance=queryset, data=request.data,partial=True)
        if data.is_valid():
            data.save()
            serializer=ProductSerializers(queryset)
            return Response({'data':serializer.data,'message':'All Products','success':True},status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

#delete item
class DeleteProduct(GenericAPIView):
    serializer_class = ProductSerializers
    def delete(self,request,id):
        queryset = ProductTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':'Product Deleted','success':True},status=status.HTTP_200_OK)
    
# search item
class Searchdata(GenericAPIView):
    def post(self, request):
        query = request.data.get('query')
        print(query)
        i = ProductTb.objects.filter(ProductName__icontains=query) | ProductTb.objects.filter(Category__icontains=query)
        data = [{'ProductName': info.ProductName,'Price': info.Price,'Category': info.Category,'Color': info.Color,'Description':info.Description}
        for info in i]
        return Response({'data': data, 'message': 'Successfully fetched', 'success': True}, status=status.HTTP_200_OK)
    
    
 #get all user   
class GetAllUser(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='user')
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All User','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
        
#get all admin
class GetAllAdmin(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='admin')
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Admin','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)

#get all seller status 0
class GetAllSeller(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='seller',Status='0' )
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Seller','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
 
 #get all seller status 1       
class GetAllSellerAccepted(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request):
        queryset = RegistrationTb.objects.filter(Role='seller',Status='1' )
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Seller','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
        
#admin accepted seller
class AccepetSeller(GenericAPIView):
    serializer_class = RegistrationSerializers
    def post(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        queryset.Status= 1
        queryset.save()
        serializer=RegistrationSerializers(queryset)
        
        return Response({'data':serializer.data,'message':'Accepted','success':True},status=status.HTTP_200_OK)
        
        
#items in registration table
#read one user/seller/admin
class GetOneRegister(GenericAPIView):
    serializer_class = RegistrationSerializers
    def get(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        serializer=RegistrationSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Register','success':True},status=status.HTTP_200_OK)
    
#update user/seller/admin
class UpdateRegister(GenericAPIView):
    serializer_class = RegistrationSerializers
    def put(self,request,id):
        queryset = RegistrationTb.objects.get(pk=id)
        data = RegistrationSerializers(instance=queryset, data=request.data,partial=True)
        if data.is_valid():
            data.save()
            return Response(data.data)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)
        
#delete user/seller/admin
class DeleteRegister(GenericAPIView):
    serializer_class = LoginSerializers
    def delete(self,request,id):
        try:
            queryset = LoginTb.objects.get(pk=id)
            queryset.delete()             
            return Response({'message':'Register Deleted','success':True},status=status.HTTP_200_OK)
        except:
            return Response({'message':'No data found','success':True},status=status.HTTP_400_BAD_REQUEST)
        
#review adding
class Review(GenericAPIView): 
    serializer_class = ReviewSerializers
   
    def post(self,request):
        UserId = request.data.get('UserId')
        ProductId = request.data.get('ProductId')
        Review = request.data.get('Review')
        Rating = request.data.get('Rating')
        UserName=''
        ProductName=''
        #get name from register table
        data = RegistrationTb.objects.filter(Login=UserId).values()
        for i in data:
            UserName=i['Name']
            
        #get productname from product table
        data1 = ProductTb.objects.filter(id=ProductId).values()
        for i in data1:
            ProductName= i['ProductName']
                
        serializer=self.serializer_class(data={'UserId':UserId,'ProductId':ProductId,'Review':Review,'Rating':Rating,'UserName':UserName,'ProductName':ProductName})

        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'review added successfully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
#read all reviews
class GetAllReviews(GenericAPIView):
    serializer_class = ReviewSerializers
    def get(self,request):
        queryset = ReviewTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All reviews','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
            
            
#read one review
class GetOneReview(GenericAPIView):
    serializer_class = ReviewSerializers
    def get(self,request,id):
        queryset = ReviewTb.objects.get(pk=id)
        serializer=ReviewSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single review','success':True},status=status.HTTP_200_OK)
    
#update review
class UpdateReview(GenericAPIView):
    serializer_class = ReviewSerializers
    def put(self,request,id):
        queryset = ReviewTb.objects.get(pk=id)
        data = ReviewSerializers(instance=queryset, data=request.data,partial=True)
        if data.is_valid():
            data.save()
            return Response(data.data)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

#delete review
class DeleteReview(GenericAPIView):
    serializer_class = ReviewSerializers
    def delete(self,request,id):
        queryset = ReviewTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':' Deleted','success':True},status=status.HTTP_200_OK)
    
# search review
class SearchReview(GenericAPIView):
    def post(self, request):
        query = request.data.get('query')
        print(query)
        i = ReviewTb.objects.filter(Review__icontains=query)
        data = [{'Review': info.Review,'Rating': info.Rating,'ProductName': info.ProductName}
        for info in i]
        return Response({'data': data, 'message': 'Successfully fetched', 'success': True}, status=status.HTTP_200_OK)
    
# add to cart
class Cart(GenericAPIView): 
    serializer_class = CartSerializers
   
    def post(self,request):
        UserId = request.data.get('UserId')
        ProductId = request.data.get('ProductId')
        UserName=''
        ProductName=''
        Price=''
        ProductImage=''
        CartStatus='0'
        Category=''
        ItemCheck='1'
        
        carts= CartTb.objects.filter(UserId=UserId,ProductId=ProductId)
        if carts.exists():
            return Response({'message':'Item already in cart','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
             #get name from register table
            data = RegistrationTb.objects.filter(Login=UserId).values()
            for i in data:
                UserName=i['Name']
          
            #get productname from product table
            data1 = ProductTb.objects.filter(id=ProductId).values()
            for i in data1:
                ProductName= i['ProductName']
                Price= i['Price']
                Category=i['Category']
            prdt= ProductTb.objects.get(id=ProductId)
            prdt_image = prdt.ProductImage
            
                
            serializer=self.serializer_class(data={'UserId':UserId,'ProductId':ProductId,'UserName':UserName,'ProductName':ProductName,'Price':Price,'ProductImage':prdt_image,'CartStatus':CartStatus,'Category':Category,'ItemCheck':ItemCheck})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'Product add to cart','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
            
        
        
       
    
#read all cart
class GetAllCart(GenericAPIView):
    
    #cartstatus 0 filter akanam
    serializer_class = CartSerializers
    def get(self,request):
        queryset = CartTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All cart','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
            
            
#read one Cart
class GetOneCart(GenericAPIView):
    serializer_class = CartSerializers
    def get(self,request,id):
        queryset = CartTb.objects.get(pk=id)
        serializer=CartSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Cart','success':True},status=status.HTTP_200_OK)
    

#delete Cart
class DeleteCart(GenericAPIView):
    serializer_class = CartSerializers
    def delete(self,request,id):
        queryset = CartTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':' Deleted','success':True},status=status.HTTP_200_OK)
    
#delete all cart    
class DeleteAllCart(GenericAPIView):
    serializer_class = CartSerializers
    def delete(self,request,UserId):
        queryset = CartTb.objects.filter(UserId=UserId)
        queryset.delete()
        return Response({'message':'All Products Deleted','success':True},status=status.HTTP_200_OK)
    
# add to Wishlist
class Wishlist(GenericAPIView): 
    serializer_class = WishlistSerializers
    def post(self,request):
        UserId = request.data.get('UserId')
        ProductId = request.data.get('ProductId')
        UserName=''
        ProductName=''
        Price=''
        ProductImage=''
        
        wishlists= WishlistTb.objects.filter(UserId=UserId,ProductId=ProductId)
        if wishlists.exists():
            return Response({'message':'Item already in whishlist','success':False},status=status.HTTP_400_BAD_REQUEST)
        else:
        #get name from register table
            data = RegistrationTb.objects.filter(Login=UserId).values()
            for i in data:
                UserName=i['Name']
            
        #get productname from product table
            data1 = ProductTb.objects.filter(id=ProductId).values()
            print(data1)
            for i in data1:
                ProductName= i['ProductName']
                Price= i['Price']
            prdt= ProductTb.objects.get(id=ProductId)
            prdt_image = prdt.ProductImage
         
            print(prdt_image)
            serializer=self.serializer_class(data={'UserId':UserId,'ProductId':ProductId,'UserName':UserName,'ProductName':ProductName,'Price':Price,'ProductImage':prdt_image})

            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data,'message':'Product add to Wishlist','success':True}, status=status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
#read all Wishlist
class GetAllWishlist(GenericAPIView):
    serializer_class = WishlistSerializers
    def get(self,request):
        queryset = WishlistTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Wishlist','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_200_OK)
            
            
#read one Wishlist
class GetOneWishlist(GenericAPIView):
    serializer_class = WishlistSerializers
    def get(self,request,id):
        queryset = WishlistTb.objects.get(pk=id)
        serializer=WishlistSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Wishlist','success':True},status=status.HTTP_200_OK)
    

#delete Wishlist
class DeleteWishlist(GenericAPIView):
    serializer_class = WishlistSerializers
    def delete(self,request,ProductId):
        queryset = WishlistTb.objects.get(ProductId=ProductId)
        queryset.delete()
        return Response({'message':' Deleted','success':True},status=status.HTTP_200_OK)
    
#add category    
class AddCategory(GenericAPIView):
    serializer_class=CategorySerializers
    def post(self, request):
        CategoryName = request.data.get('CategoryName')
        CategoryImage = request.data.get('CategoryImage')
        serializer=self.serializer_class(data={'CategoryName':CategoryName,'CategoryImage':CategoryImage})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Category added successfully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
    
#read categories
class GetAllCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def get(self,request):
        queryset = CategoryTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Category','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
            
#read one category
class GetOneCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def get(self,request,id):
        queryset = CategoryTb.objects.get(pk=id)
        serializer=CategorySerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Category','success':True},status=status.HTTP_200_OK)
    
# #update item
# class UpdateCategory(GenericAPIView):
#     serializer_class = CategorySerializers
#     def put(self,request,id):
#         queryset = CategoryTb.objects.get(pk=id)
#         data = CategorySerializers(instance=queryset, data=request.data,partial=True)
#         if data.is_valid():
#             data.save()
#             return Response(data.data)
#         else:
#             return Response(status=status.HTTP_404_NOT_FOUND)

#delete category
class DeleteCategory(GenericAPIView):
    serializer_class = CategorySerializers
    def delete(self,request,id):
        queryset = CategoryTb.objects.get(pk=id)
        queryset.delete()
        return Response({'message':'Category Deleted','success':True},status=status.HTTP_200_OK)
    
#place order
class PlaceOrder(GenericAPIView):
    serializer_class = OrderSerializers
    def post(self,request):
        UserId = request.data.get('UserId')
        carts= CartTb.objects.filter(UserId=UserId,CartStatus=0)
        if not carts.exists():
            return Response({'message':'No item in cart to place order','success':False},status=status.HTTP_400_BAD_REQUEST)
        
        tot = carts.aggregate(TotalAmount=Sum('Price'))['TotalAmount']
        TotalAmount=str(tot)
        
        print("total",TotalAmount)
        data = RegistrationTb.objects.filter(Login=UserId).values()
      
        for i in data:
            UserName=i['Name']
        
        order_data=[]
        for i in carts:
            order_data.append({
                'UserId':UserId,
                'ProductId':i.ProductId,
                'ProductName':i.ProductName,
                'Price':i.Price,
                'ProductImage':i.ProductImage,
                'Category':i.Category,
                'OrderStatus':"0",
                'TotalAmount':TotalAmount,
                'CartId':i.id,
                'UserName':UserName
                
            })
            
            print("order data",order_data)
            i.CartStatus="1"
            i.save()
    
        serializer=self.serializer_class(data=order_data,many=True)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Order placed successfully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

#place order
class PlaceOrderSingle(GenericAPIView):
    serializer_class = OrderSerializers
    def post(self,request):
        UserId = request.data.get('UserId')
        ProductId = request.data.get('ProductId')
        ProductName = ''
        Price = ''
        ProductImage = ''
        Category = ''
        
        data = RegistrationTb.objects.filter(Login=UserId).values()
        for i in data:
            UserName=i['Name']
            
        data1 = ProductTb.objects.filter(id=ProductId).values()
        # print(data1)
        for i in data1:
            ProductName= i['ProductName']
            Price= i['Price']
            ProductImage= i['ProductImage']
            Category= i['Category']
        prdt= ProductTb.objects.get(id=ProductId)
        prdt_image = prdt.ProductImage
         
        print(prdt_image)
        serializer = self.serializer_class(data={'UserId': UserId,'ProductId': ProductId,'UserName': UserName,'ProductName': ProductName,'ProductImage': prdt_image,'Category': Category,'OrderStatus': "0",'TotalAmount': Price,'Price':Price})

        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Order Placed Succefully','success':True}, status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)
 
 #all order   
class GetAllOrder(GenericAPIView):
    serializer_class = OrderSerializers
    def get(self,request):
        queryset = OrderTb.objects.all()
        if queryset.exists():
            serializer=self.serializer_class(queryset,many=True)
            return Response({'data':serializer.data,'message':'All Category','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data Available','success':False},status=status.HTTP_400_BAD_REQUEST)
            
#get one order 
class GetOneOrder(GenericAPIView):
    serializer_class = OrderSerializers
    def get(self,request,id):
        queryset = OrderTb.objects.get(pk=id)
        serializer=OrderSerializers(queryset)
        return Response({'data':serializer.data,'message':'Single Category','success':True},status=status.HTTP_200_OK)   
    

    
#get total amount in cart items    
class TotalPrice(GenericAPIView):
    def get(self,request,id):
        carts= CartTb.objects.filter(UserId=id,CartStatus=0)
        
        tot = carts.aggregate(TotalAmount=Sum('Price'))['TotalAmount']
        TotalAmount=str(tot)
        
        print("total",TotalAmount)
        
        return Response({'data':{'TotalAmount':TotalAmount},'message':'Get order price  successfully','success':True}, status=status.HTTP_201_CREATED)
    
#place order
class Payment(GenericAPIView):
    serializer_class = PaymentSerializers
    def post(self, request):
        UserId = request.data.get('UserId')
        PaymentMethod = request.data.get('PaymentMethod')
        Address = request.data.get('Address')
        TotalAmount = ''
        PaymentStatus = '0'

        data = OrderTb.objects.filter(UserId=UserId, OrderStatus='0')
        if not data.exists():
            return Response({'message': 'Payment Already done', 'success': False}, status=status.HTTP_400_BAD_REQUEST)

        datas = OrderTb.objects.filter(UserId=UserId, OrderStatus='0')
        for i in datas:
            TotalAmount = i.TotalAmount
            i.OrderStatus = "1"
            i.save()  # Save each individual object

        serializer = self.serializer_class(data={'UserId': UserId, 'PaymentMethod': PaymentMethod,
                                                 'Address': Address, 'TotalAmount': TotalAmount, 'PaymentStatus': PaymentStatus})

        if serializer.is_valid():
            serializer.save()
            return Response({'data': serializer.data, 'message': 'Payment Completed', 'success': True},
                            status=status.HTTP_201_CREATED)
        return Response({'data': serializer.errors, 'message': 'Failed', 'success': False},
                        status=status.HTTP_400_BAD_REQUEST)
 