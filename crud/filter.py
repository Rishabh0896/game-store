import django_filters

from .models import GameItem

class GameItemFilter(django_filters.FilterSet):
    class Meta:
        model = GameItem
        fields = '__all__'
