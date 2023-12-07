from django.shortcuts import render
from django.shortcuts import redirect
from django.contrib import messages
from django.urls import reverse

from .forms import UserRegisterForm, ProfileUpdateForm, UserUpdateForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User, Group
from django.contrib.auth.views import LoginView


def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            group = Group.objects.get(name='customer_group')
            user.groups.add(group)
            username = form.cleaned_data.get('username')
            messages.success(request, f'Your account has been created! You are now able to login')
            return redirect('login')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})


@login_required
def profile(request):
    if request.method == 'POST':
        u_form = UserUpdateForm(request.POST, instance=request.user)
        p_form = ProfileUpdateForm(request.POST, request.FILES, instance=request.user.profile)
        if u_form.is_valid() and p_form.is_valid():
            u_form.save()
            p_form.save()
            messages.success(request, f'Your account has been updated')
            return redirect('profile')
    else:
        u_form = UserUpdateForm(instance=request.user)
        p_form = ProfileUpdateForm(instance=request.user.profile)

    context = {
        'u_form': u_form,
        'p_form': p_form
    }
    return render(request, 'users/profile.html', context)


class CustomLoginView(LoginView):
    def get_success_url(self):
        user = self.request.user
        # Add your condition to check the user's attributes
        if user.groups.filter(name='manager_group').exists():
            return reverse('manager-dashboard')  # Redirect to the dashboard for manager users
        elif user.groups.filter(name='staff_group').exists():
            return reverse('store-home')  # TODO : Change this to staff dashboard
        else:
            return reverse('store-home')
