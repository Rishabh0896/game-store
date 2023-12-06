from django.db import models


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
    num_review = models.IntegerField(blank=True, null=True)
    avg_rating = models.FloatField(blank=True, null=True)
    std_dev_rating = models.FloatField(blank=True, null=True)
    rated_complexity = models.FloatField(blank=True, null=True)
    rated_language_dependency = models.FloatField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'gameitem'


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

    def __str__(self):
        return f"{self.mechanic_name}"


class GameType(models.Model):
    type_id = models.IntegerField(primary_key=True)
    type_name = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'game_type'

    def __str__(self):
        return f"{self.type_name}"


class GameItemDesigner(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)
    designer = models.ForeignKey(Designer, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_designer'
        unique_together = (('game', 'designer'),)


class Publisher(models.Model):
    publisher_id = models.IntegerField(primary_key=True)
    publisher_name = models.CharField(unique=True, max_length=255, blank=True, null=True)
    num_games_published = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'publisher'

    def __str__(self):
        return f"{self.publisher_name}"


class GameItemGameMechanic(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)
    mechanic = models.ForeignKey(GameMechanic, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_mechanic'
        unique_together = (('game', 'mechanic'),)


class GameItemGameType(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)
    type = models.ForeignKey(GameType, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_type'
        unique_together = (('game', 'type'),)


class GameItemPublisher(models.Model):
    game = models.OneToOneField(GameItem, models.DO_NOTHING,
                                primary_key=True)
    publisher = models.ForeignKey('Publisher', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_publisher'
        unique_together = (('game', 'publisher'),)
