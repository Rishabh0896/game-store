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
    path('credit_card/edit/<int:credit_card_id>', views.edit_credit_card, name='edit_credit_card'),
    path('credit_card/delete/<int:credit_card_id>', views.delete_credit_card, name='delete_credit_card'),
    path('address/add', views.add_address, name='add_address'),
    path('address/edit/<int:address_id>', views.edit_address, name='edit_address'),
    path('address/delete/<int:address_id>', views.delete_address, name='delete_address'),
    path('order/place', views.place_order, name='place_order'),
    path('review/add', views.add_review, name='add_review'),
    path('review/edit/<int:review_id>', views.edit_review, name='edit_review'),
    path('review/delete/<int:review_id>', views.delete_review, name='delete_review'),
    path('game/<int:game_id>', views.game_detail, name='game_detail'),
    # Manager
    path('manager_dashboard/', views.manager_dashboard, name='manager-dashboard'),
    path('fulfill_order/<int:order_id>/', views.fulfill_order, name='fulfill_order'),
    path('revenue_summary/', views.revenue_summary, name='revenue-summary'),
    path('game_leaderboard/', views.leader_board, name='game-leaderboard')
]
