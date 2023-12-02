from django.contrib.auth.models import User
from django.db import models

#
# class Customer(models.Model):
#     user = models.OneToOneField(User, on_delete=models.CASCADE, null=True, blank=True)
#     name = models.CharField(max_length=200, null=True)
#     email = models.CharField(max_length=200, null=True)
#
#     def __str__(self):
#         return self.name
#
#
# class Product(models.Model):
#     name = models.CharField(max_length=200, null=True)
#     price = models.FloatField()
#
#     def __str__(self):
#         return self.name
#
#
# class Order(models.Model):
#     customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
#     date_ordered = models.DateTimeField(auto_now_add=True)
#     complete = models.BooleanField(default=False, null=True, blank=False)
#     transaction_id = models.CharField(max_length=200, null=True)
#
#     def __str__(self):
#         return str(self.id)
#
#
# class OrderItem(models.Model):
#     product = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True)
#     order = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True)
#     quantity = models.IntegerField(default=0, null=True, blank=True)
#     date_added = models.DateTimeField(auto_now_add=True)
#
#
# class ShippingAddress(models.Model):
#     customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
#     order = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True)
#     address = models.CharField(max_length=200, null=True)
#     city = models.CharField(max_length=20, null=True)
#     state = models.CharField(max_length=20, null=True)
#     zipcode = models.CharField(max_length=20, null=True)
#     date_added = models.DateTimeField(auto_now_add=True)
#
#     def __str__(self):
#         return self.address


# Trang Tables

class Designer(models.Model):
    designer_id = models.IntegerField(primary_key=True)
    designer_name = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'designer'


class GameMechanic(models.Model):
    mechanic_id = models.IntegerField(primary_key=True)
    mechanic_name = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'game_mechanic'


class GameType(models.Model):
    type_id = models.IntegerField(primary_key=True)
    type_name = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'game_type'


class GameItem(models.Model):
    game_id = models.IntegerField(primary_key=True)
    game_name = models.CharField(unique=True, max_length=255)
    published_year = models.IntegerField()
    min_player = models.IntegerField()
    max_player = models.IntegerField()
    min_age = models.IntegerField()
    min_time = models.IntegerField()
    max_time = models.IntegerField()
    is_cooperative = models.IntegerField()
    num_review = models.IntegerField()
    avg_rating = models.FloatField()
    std_dev_rating = models.FloatField()
    rated_complexity = models.FloatField(blank=True, null=True)
    rated_language_dependency = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'gameitem'


class GameItemDesigner(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)  # The composite primary key (game_id, designer_id) found, that is not supported. The first column is selected.
    designer = models.ForeignKey(Designer, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_designer'
        unique_together = (('game', 'designer'),)


class GameItemGameMechanic(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)  # The composite primary key (game_id, mechanic_id) found, that is not supported. The first column is selected.
    mechanic = models.ForeignKey(GameMechanic, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_mechanic'
        unique_together = (('game', 'mechanic'),)


class GameItemGameType(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)  # The composite primary key (game_id, type_id) found, that is not supported. The first column is selected.
    type = models.ForeignKey(GameType, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_type'
        unique_together = (('game', 'type'),)


class GameItemPublisher(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)  # The composite primary key (game_id, publisher_id) found, that is not supported. The first column is selected.
    publisher = models.ForeignKey('Publisher', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_publisher'
        unique_together = (('game', 'publisher'),)


class Publisher(models.Model):
    publisher_id = models.IntegerField(primary_key=True)
    publisher_name = models.CharField(unique=True, max_length=255, blank=True, null=True)
    num_games_published = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'publisher'
