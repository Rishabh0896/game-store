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
    num_review = models.IntegerField()
    avg_rating = models.FloatField()
    std_dev_rating = models.FloatField()
    rated_complexity = models.FloatField(blank=True, null=True)
    rated_language_dependency = models.FloatField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'gameitem'

    def save(self, *args, **kwargs):
        max_game_id = GameItem.objects.aggregate(models.Max('game_id'))['game_id__max']
        self.game_id = max_game_id + 1 if max_game_id else 1
        super(GameItem, self).save(*args, **kwargs)

