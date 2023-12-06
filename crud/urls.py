from django.urls import path
from . import views

urlpatterns = [
    path('add_game/', views.add_game, name='add_game'),
    path('view_game/<int:game_id>/', views.view_game, name='view_game'),
    path('manage_game/', views.manage_game, name='manage_game'),
    path('update_game/<int:game_id>/', views.update_game, name='update_game'),
    path('delete_game/<int:game_id>/', views.delete_game, name='delete_game'),

    # Publisher
    path('add_publisher/', views.add_publisher, name='add_publisher'),
    path('view_publisher/<int:publisher_id>/', views.read_publisher, name='view_publisher'),
    path('manage_publisher/', views.manage_publisher, name='manage_publisher'),
    path('update_publisher/<int:publisher_id>/', views.update_publisher, name='update_publisher'),
    path('delete_publisher/<int:publisher_id>/', views.delete_publisher, name='delete_publisher'),

    # Designer
    path('add_designer/', views.add_designer, name='add_designer'),
    path('view_designer/<int:designer_id>/', views.read_designer, name='view_designer'),
    path('manage_designer/', views.manage_designer, name='manage_designer'),
    path('update_designer/<int:designer_id>/', views.update_designer, name='update_designer'),
    path('delete_designer/<int:designer_id>/', views.delete_designer, name='delete_designer'),

    # GameType
    path('add_gametype/', views.add_gametype, name='add_gametype'),
    path('view_gametype/<int:type_id>/', views.read_gametype, name='view_gametype'),
    path('manage_gametype/', views.manage_gametype, name='manage_gametype'),
    path('update_gametype/<int:type_id>/', views.update_gametype, name='update_gametype'),
    path('delete_gametype/<int:type_id>/', views.delete_gametype, name='delete_gametype'),

    # GameMechanic
    path('add_gamemechanic/', views.add_gamemechanic, name='add_gamemechanic'),
    path('view_gamemechanic/<int:mechanic_id>/', views.read_gamemechanic, name='view_gamemechanic'),
    path('manage_gamemechanic/', views.manage_gamemechanic, name='manage_gamemechanic'),
    path('update_gamemechanic/<int:mechanic_id>/', views.update_gamemechanic, name='update_gamemechanic'),
    path('delete_gamemechanic/<int:mechanic_id>/', views.delete_gamemechanic, name='delete_gamemechanic'),

]
