from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit
from django.forms import ModelChoiceField, ModelMultipleChoiceField

from .models import GameItem, GameMechanic, GameType, Publisher, Designer


class GameItemForm(forms.ModelForm):
    game_mechanic_options = ModelMultipleChoiceField(queryset=GameMechanic.objects.all()[:10],
                                                     widget=forms.SelectMultiple(attrs={'class': 'form-control'}))
    game_type_options = ModelMultipleChoiceField(queryset=GameType.objects.all()[:10],
                                                 widget=forms.SelectMultiple(attrs={'class': 'form-control'}))
    game_publisher_options = ModelMultipleChoiceField(queryset=Publisher.objects.all()[:10],
                                                      widget=forms.SelectMultiple(attrs={'class': 'form-control'}))

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
            'game_mechanic_options',
            'game_type_options',
            'game_publisher_options',
            # 'num_review',
            # 'avg_rating',
            # 'std_dev_rating',
            Submit('submit', 'Save')
        )
        self.helper.form_method = 'POST'

    def clean(self):
        cleaned_data = super().clean()

        # Exclude validation for ModelMultipleChoiceField fields
        cleaned_data['game_mechanic_options'] = self.cleaned_data.get('game_mechanic_options')
        cleaned_data['game_type_options'] = self.cleaned_data.get('game_type_options')
        cleaned_data['game_publisher_options'] = self.cleaned_data.get('game_publisher_options')

        return cleaned_data


class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        exclude = ['publisher_id']

    def __init__(self, *args, **kwargs):
        super(PublisherForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'publisher_name',
            'num_games_published',
            Submit('submit', 'Save')
        )
        self.helper.form_method = 'POST'


class DesignerForm(forms.ModelForm):
    class Meta:
        model = Designer
        exclude = ['designer_id']

    def __init__(self, *args, **kwargs):
        super(DesignerForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'designer_name',
            Submit('submit', 'Save')
        )
        self.helper.form_method = 'POST'


class GameMechanicForm(forms.ModelForm):
    class Meta:
        model = GameMechanic
        exclude = ['mechanic_id']

    def __init__(self, *args, **kwargs):
        super(GameMechanicForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'mechanic_name',
            Submit('submit', 'Save')
        )
        self.helper.form_method = 'POST'


class GameTypeForm(forms.ModelForm):
    class Meta:
        model = GameType
        exclude = ['type_id']

    def __init__(self, *args, **kwargs):
        super(GameTypeForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'type_name',
            Submit('submit', 'Save')
        )
        self.helper.form_method = 'POST'