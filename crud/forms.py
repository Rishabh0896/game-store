from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit
from django.forms import ModelChoiceField, ModelMultipleChoiceField

from .models import GameItem, GameMechanic, GameType, Publisher, Designer


class GameItemForm(forms.ModelForm):
    game_designer_options = ModelChoiceField(queryset=Designer.objects.all())
    game_publisher_options = ModelChoiceField(queryset=Publisher.objects.all())
    game_mechanic_options = ModelChoiceField(queryset=GameMechanic.objects.all())
    game_type_options = ModelChoiceField(queryset=GameType.objects.all())

    class Meta:
        model = GameItem
        exclude = ['game_id', 'num_review', 'avg_rating', 'std_dev_rating', 'rated_complexity',
                   'rated_language_dependency']

    def __init__(self, *args, **kwargs):
        action = kwargs.pop('action', False)
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
            'price',
            'game_designer_options',
            'game_mechanic_options',
            'game_type_options',
            'game_publisher_options'
        )
        if action != "view":
            self.helper.layout.append(Submit('submit', 'Submit'))
        self.helper.form_method = 'POST'

    def save(self, commit=True):
        instance = super(GameItemForm, self).save(commit=False)
        instance.mechanic = self.cleaned_data['game_mechanic_options']
        instance.type = self.cleaned_data['game_type_options']
        instance.publisher = self.cleaned_data['game_publisher_options']
        instance.designer = self.cleaned_data['game_designer_options']

        if commit:
            instance.save()


class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        exclude = ['publisher_id']

    def __init__(self, *args, **kwargs):
        action = kwargs.pop('action', False)
        super(PublisherForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'publisher_name'
        )
        if action != "view":
            self.helper.layout.append(Submit('submit', 'Submit'))
        self.helper.form_method = 'POST'

    def save(self, commit=True):
        instance = super(PublisherForm, self).save(commit=False)

        if commit:
            instance.save()


class DesignerForm(forms.ModelForm):
    class Meta:
        model = Designer
        exclude = ['designer_id']

    def __init__(self, *args, **kwargs):
        action = kwargs.pop('action', False)
        super(DesignerForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'designer_name'
        )
        if action != "view":
            self.helper.layout.append(Submit('submit', 'Submit'))
        self.helper.form_method = 'POST'


class GameMechanicForm(forms.ModelForm):
    class Meta:
        model = GameMechanic
        exclude = ['mechanic_id']

    def __init__(self, *args, **kwargs):
        action = kwargs.pop('action', False)
        super(GameMechanicForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'mechanic_name'
        )
        if action != "view":
            self.helper.layout.append(Submit('submit', 'Submit'))
        self.helper.form_method = 'POST'


class GameTypeForm(forms.ModelForm):
    class Meta:
        model = GameType
        exclude = ['type_id']

    def __init__(self, *args, **kwargs):
        action = kwargs.pop('action', False)
        super(GameTypeForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            'type_name'
        )
        if action != "view":
            self.helper.layout.append(Submit('submit', 'Submit'))
        self.helper.form_method = 'POST'
