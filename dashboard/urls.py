from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='store-home'),
    path('about/', views.about, name='store-about'),
    path('account/', views.account, name='account'),
    path('cart/', views.cart, name="cart"),
    path('checkout/', views.checkout, name="checkout"),
    path('update_item/', views.update_cart_item, name="update_item"),
    path('credit_card/add', views.add_credit_card, name='add_credit_card'),
    path('address/add', views.add_address, name='add_address'),
    path('order/place', views.place_order, name='place_order'),
]
