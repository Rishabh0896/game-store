from django.contrib.auth.models import User
from django.db import models


class Designer(models.Model):
    designer_id = models.AutoField(primary_key=True)
    designer_name = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'designer'

    def __str__(self):
        return self.designer_name


class GameMechanic(models.Model):
    mechanic_id = models.AutoField(primary_key=True)
    mechanic_name = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'game_mechanic'

    def __str__(self):
        return self.mechanic_name


class GameType(models.Model):
    type_id = models.AutoField(primary_key=True)
    type_name = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'game_type'

    def __str__(self):
        return self.type_name


class Publisher(models.Model):
    publisher_id = models.AutoField(primary_key=True)
    publisher_name = models.CharField(unique=True, max_length=255)

    class Meta:
        managed = False
        db_table = 'publisher'

    def __str__(self):
        return self.publisher_name


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
    num_review = models.IntegerField(default=0)
    avg_rating = models.FloatField(default=0.0)
    std_dev_rating = models.FloatField(default=0.0)
    rated_complexity = models.FloatField(default=0.0)
    rated_language_dependency = models.FloatField(default=0.0)
    designer = models.ForeignKey(Designer, models.DO_NOTHING, blank=True, null=True)
    publisher = models.ForeignKey('Publisher', models.DO_NOTHING, blank=True, null=True)
    mechanic = models.ForeignKey(GameMechanic, models.DO_NOTHING, blank=True, null=True)
    type = models.ForeignKey(GameType, models.DO_NOTHING, blank=True, null=True)
    price = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'gameitem'
