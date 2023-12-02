from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit
from .models import GameItem


class GameItemForm(forms.ModelForm):
    class Meta:
        model = GameItem
        exclude = ['game_id']

    def __init__(self, *args, **kwargs):
        super(GameItemForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'game_name',
            'published_year',
            'min_player',
            'max_player',
            'min_age',
            'min_time',
            'max_time',
            'is_cooperative',
            'num_review',
            'avg_rating',
            'std_dev_rating',
            'rated_complexity',
            'rated_language_dependency',
            Submit('submit', 'Add GameItem')
        )
        self.helper.form_method = 'POST'


class GameSearchForm(forms.Form):
    game_name = forms.CharField(label='Game Name', max_length=255, required=False)
