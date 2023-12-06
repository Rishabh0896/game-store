from django.contrib.auth.models import User
from django.db import models


class CreditCard(models.Model):
    credit_card_id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(User, models.DO_NOTHING)
    credit_card_number = models.CharField(max_length=16)
    expiration_month = models.IntegerField()
    expiration_year = models.IntegerField()
    security_code = models.CharField(max_length=4)

    class Meta:
        managed = False
        db_table = 'credit_card'
        unique_together = (('customer', 'credit_card_number'),)
    
    @property
    def get_hidden_number(self):
        return "**"+ self.credit_card_number[-4:]

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
    price = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'gameitem'

class StoreOrder(models.Model):
    order_id = models.AutoField(primary_key=True)
    order_status = models.CharField(max_length=11)
    date_ordered = models.DateField(auto_now_add=True)
    customer = models.ForeignKey(User, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'store_order'

    @property
    def get_cart_items(self):
        items = self.orderitem_set.all()
        total = sum([item.quantity for item in items])
        return total

    @property
    def get_cart_total(self):
        items = self.orderitem_set.all()
        total = sum([item.get_total for item in items])
        return total



class OrderItem(models.Model):
    order_item_id = models.AutoField(primary_key=True)
    order = models.ForeignKey(StoreOrder, models.DO_NOTHING)
    game = models.ForeignKey(GameItem, models.DO_NOTHING)
    quantity = models.IntegerField(default=0, null=True, blank=True)

    class Meta:
        managed = False
        db_table = 'order_item'
        unique_together = (('order', 'game'),)

    @property
    def get_total(self):
        total = self.game.price * self.quantity
        return total

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
