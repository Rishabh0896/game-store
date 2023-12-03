from django.urls import path
from . import views

urlpatterns = [
    path('add_game/', views.add_game, name='add_game'),
    path('view_game/<int:game_id>/', views.view_game, name='view_game'),
    path('manage_game/', views.manage_game, name='manage_game'),
    path('update_game/<int:game_id>/', views.update_game, name='update_game'),
    path('delete_game/<int:game_id>/', views.delete_game, name='delete_game'),
]
