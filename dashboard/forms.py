from django import forms
from .models import CreditCard

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

