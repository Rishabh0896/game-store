from datetime import timezone
import datetime
from django.contrib.auth.models import User
from django.db import models

class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(User, models.DO_NOTHING)
    street_no = models.CharField(max_length=10)
    street_name = models.CharField(max_length=255)
    state_abbreviation = models.CharField(max_length=2)
    zip_code = models.CharField(max_length=5)

    class Meta:
        managed = False
        db_table = 'address'
        unique_together = (('customer', 'street_no', 'street_name', 'state_abbreviation', 'zip_code'),)


    @property
    def get_full_address(self):
        return self.street_no + " " + self.street_name + ", " + self.state_abbreviation + " " + self.zip_code

    def __str__(self):
        return self.street_no + " " + self.street_name + ", " + self.state_abbreviation + " " + self.zip_code


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
        return "**" + self.credit_card_number[-4:]

    def __str__(self):
        return "**" + self.credit_card_number[-4:]


class Designer(models.Model):
    designer_id = models.AutoField(primary_key=True)
    designer_name = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'designer'


class GameMechanic(models.Model):
    mechanic_id = models.AutoField(primary_key=True)
    mechanic_name = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'game_mechanic'


class GameType(models.Model):
    type_id = models.AutoField(primary_key=True)
    type_name = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'game_type'


class Publisher(models.Model):
    publisher_id = models.AutoField(primary_key=True)
    publisher_name = models.CharField(unique=True, max_length=255)
    num_published = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'publisher'



class GameItem(models.Model):
    game_id = models.AutoField(primary_key=True)
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
    rated_complexity = models.FloatField()
    rated_language_dependency = models.FloatField()
    designer = models.ForeignKey(Designer, models.DO_NOTHING, blank=True, null=True)
    publisher = models.ForeignKey('Publisher', models.DO_NOTHING, blank=True, null=True)
    mechanic = models.ForeignKey(GameMechanic, models.DO_NOTHING, blank=True, null=True)
    type = models.ForeignKey(GameType, models.DO_NOTHING, blank=True, null=True)
    price = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'gameitem'


class StoreOrder(models.Model):
    order_id = models.AutoField(primary_key=True)
    order_status = models.CharField(max_length=11)
    date_ordered = models.DateField(default=datetime.datetime.now())
    customer = models.ForeignKey(User, models.DO_NOTHING)
    address = models.ForeignKey(Address, models.DO_NOTHING, blank=True, null=True)
    credit_card = models.ForeignKey(CreditCard, models.DO_NOTHING, blank=True, null=True)

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

    def __str__(self):
        return StoreOrder.order_id




class OrderItem(models.Model):
    order_item_id = models.AutoField(primary_key=True)
    order = models.ForeignKey('StoreOrder', models.DO_NOTHING)
    game = models.ForeignKey(GameItem, models.DO_NOTHING)
    quantity = models.IntegerField(default=0)

    class Meta:
        managed = False
        db_table = 'order_item'
        unique_together = (('order', 'game'),)

    @property
    def get_total(self):
        total = self.game.price * self.quantity
        return total


class Review(models.Model):
    review_id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(User, models.DO_NOTHING)
    game = models.ForeignKey(GameItem, models.DO_NOTHING)
    rating = models.IntegerField()
    text_review = models.TextField(blank=True, null=True)
    complexity_rating = models.IntegerField()
    language_dependency_rating = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'review'