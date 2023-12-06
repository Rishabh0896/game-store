from django import forms
from .models import CreditCard, Address, Review

class CreditCardForm(forms.ModelForm):
    class Meta:
        model = CreditCard
        fields = ['credit_card_number', 'expiration_month', 'expiration_year', 'security_code']

    widgets = {
        'credit_card_number': forms.TextInput(attrs={'placeholder': 'Enter Credit Card Number'}),
        'expiration_month': forms.TextInput(attrs={'placeholder': 'MM'}),
        'expiration_year': forms.TextInput(attrs={'placeholder': 'YYYY'}),
        'security_code': forms.TextInput(attrs={'placeholder': 'CVV/CVS Code'}),
    }

class AddressForm(forms.ModelForm):
    class Meta:
        model = Address
        fields = ['street_no', 'street_name', 'state_abbreviation']

    widgets = { 
        'street_no': forms.TextInput(attrs={'placeholder': 'Enter Street Number'}),
        'street_name': forms.TextInput(attrs={'placeholder': 'Enter Street Name'}),
        'state_abbreviation': forms.TextInput(attrs={'placeholder': 'Enter State Abbreviation'}),
    }

class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ['rating','text_review', 'complexity_rating', 'language_dependency_rating']


    widgets = {
        'rating': forms.NumberInput(attrs={'placeholder': 'Enter Rating'}),
        'text_review': forms.TextInput(attrs={'placeholder': 'Enter Text Review'}),
        'complexity_rating': forms.NumberInput(attrs={'placeholder': 'Enter Complexity Rating'}),
        'language_dependency_rating': forms.NumberInput(attrs={'placeholder': 'Enter Language Dependency Rating'})
    }