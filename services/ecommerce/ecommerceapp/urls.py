from django.urls import path
from . import views

urlpatterns=[
    path('AdminReg',views.AdminReg.as_view(),name='AdminReg'),
    path('UserReg',views.UserReg.as_view(),name='UserReg'),
    path('SellerReg',views.SellerReg.as_view(),name='SellerReg'),
    path('Login',views.Login.as_view(),name='Login'),
    path('Addproduct',views.Addproduct.as_view(),name='Addproduct'),
    path('GetAllProducts',views.GetAllProducts.as_view(),name='GetAllProducts'),
    path('GetOneProduct/<int:id>',views.GetOneProduct.as_view(),name='GetOneProduct'),
    path('UpdateProduct/<int:id>',views.UpdateProduct.as_view(),name='UpdateProduct'),
    path('DeleteProduct/<int:id>',views.DeleteProduct.as_view(),name='DeleteProduct'),
    path('Searchdata',views.Searchdata.as_view(),name='Searchdata'),
    path('GetAllUser',views.GetAllUser.as_view(),name='GetAllUser'),
    path('GetAllAdmin',views.GetAllAdmin.as_view(),name='GetAllAdmin'),
    path('GetAllSeller',views.GetAllSeller.as_view(),name='GetAllSeller'),
    path('GetOneRegister/<int:id>',views.GetOneRegister.as_view(),name='GetOneRegister'),
    path('UpdateRegister/<int:id>',views.UpdateRegister.as_view(),name='UpdateRegister'),
    path('DeleteRegister/<int:id>',views.DeleteRegister.as_view(),name='DeleteRegister'),
    path('Review',views.Review.as_view(),name='Review'),
    path('GetAllReviews',views.GetAllReviews.as_view(),name='GetAllReviews'),
    path('GetOneReview/<int:id>',views.GetOneReview.as_view(),name='GetOneReview'),
    path('UpdateReview/<int:id>',views.UpdateReview.as_view(),name='UpdateReview'),
    path('DeleteReview/<int:id>',views.DeleteReview.as_view(),name='DeleteReview'),
    path('SearchReview',views.SearchReview.as_view(),name='SearchReview'),
    path('Cart',views.Cart.as_view(),name='Cart'),
    path('GetAllCart',views.GetAllCart.as_view(),name='GetAllCart'),
    path('GetOneCart/<int:id>',views.GetOneCart.as_view(),name='GetOneCart'),
    path('DeleteCart/<int:id>',views.DeleteCart.as_view(),name='DeleteCart'),
    path('Wishlist',views.Wishlist.as_view(),name='Wishlist'),
    path('GetAllWishlist',views.GetAllWishlist.as_view(),name='GetAllWishlist'),
    path('GetOneWishlist/<int:id>',views.GetOneWishlist.as_view(),name='GetOneWishlist'),
    path('DeleteWishlist/<int:ProductId>',views.DeleteWishlist.as_view(),name='DeleteWishlist'),
    path('AccepetSeller/<int:id>',views.AccepetSeller.as_view(),name='AccepetSeller'),
    path('GetAllSellerAccepted',views.GetAllSellerAccepted.as_view(),name='GetAllSellerAccepted'),
    path('AddCategory',views.AddCategory.as_view(),name='AddCategory'),
    path('GetAllCategory',views.GetAllCategory.as_view(),name='GetAllCategory'),
    path('GetOneCategory/<int:id>',views.GetOneCategory.as_view(),name='GetOneCategory'),
    path('DeleteCategory/<int:id>',views.DeleteCategory.as_view(),name='DeleteCategory'),
    path('PlaceOrder',views.PlaceOrder.as_view(),name='PlaceOrder'),
    path('PlaceOrderSingle',views.PlaceOrderSingle.as_view(),name='PlaceOrderSingle'),
    path('TotalPrice/<int:id>',views.TotalPrice.as_view(),name='TotalPrice'),
    path('Payment',views.Payment.as_view(),name='Payment'),
    path('DeleteAllCart/<int:UserId>',views.DeleteAllCart.as_view(),name='DeleteAllCart'),
     path('GetAllOrder',views.GetAllOrder.as_view(),name='GetAllOrder'),
    path('GetOneOrder/<int:id>',views.GetOneOrder.as_view(),name='GetOneOrder'),
]