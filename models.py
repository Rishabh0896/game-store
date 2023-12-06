# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Designer(models.Model):
    designer_id = models.IntegerField(primary_key=True)
    designer_name = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'designer'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'

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


class Gameitem(models.Model):
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


class GameitemDesigner(models.Model):
    game = models.OneToOneField(Gameitem, models.DO_NOTHING, primary_key=True)  # The composite primary key (game_id, designer_id) found, that is not supported. The first column is selected.
    designer = models.ForeignKey(Designer, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_designer'
        unique_together = (('game', 'designer'),)


class GameitemGameMechanic(models.Model):
    game = models.OneToOneField(Gameitem, models.DO_NOTHING, primary_key=True)  # The composite primary key (game_id, mechanic_id) found, that is not supported. The first column is selected.
    mechanic = models.ForeignKey(GameMechanic, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_mechanic'
        unique_together = (('game', 'mechanic'),)


class GameitemGameType(models.Model):
    game = models.OneToOneField(Gameitem, models.DO_NOTHING, primary_key=True)  # The composite primary key (game_id, type_id) found, that is not supported. The first column is selected.
    type = models.ForeignKey(GameType, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_game_type'
        unique_together = (('game', 'type'),)


class GameitemPublisher(models.Model):
    game = models.OneToOneField(Gameitem, models.DO_NOTHING, primary_key=True)  # The composite primary key (game_id, publisher_id) found, that is not supported. The first column is selected.
    publisher = models.ForeignKey('Publisher', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'gameitem_publisher'
        unique_together = (('game', 'publisher'),)


class OrderItemTest(models.Model):
    game = models.ForeignKey(Gameitem, models.DO_NOTHING)
    order = models.ForeignKey('OrdersTest', models.DO_NOTHING)
    quantity = models.IntegerField()
    date_added = models.DateField()

    class Meta:
        managed = False
        db_table = 'order_item_test'


class OrdersTest(models.Model):
    customer = models.ForeignKey(AuthUser, models.DO_NOTHING)
    order_id = models.AutoField(primary_key=True)
    is_complete = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'orders_test'


class Publisher(models.Model):
    publisher_id = models.IntegerField(primary_key=True)
    publisher_name = models.CharField(unique=True, max_length=255, blank=True, null=True)
    num_games_published = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'publisher'


class UsersProfile(models.Model):
    id = models.BigAutoField(primary_key=True)
    image = models.CharField(max_length=100)
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'users_profile'
