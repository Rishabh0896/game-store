from django.urls import path
from . import views

urlpatterns = [
    path('game-create/', views.create_game_item, name='create_game_item'),
    path('search_update_delete_game/', views.search_update_delete_game, name='search_update_delete_game'),
]
