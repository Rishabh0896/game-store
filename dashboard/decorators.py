from django.contrib import messages

# Custom Decorator
from django.shortcuts import redirect


def manager_required(function):
    def _function(request, *args, **kwargs):
        if not request.user.groups.filter(name='manager_group').exists():
            messages.info(request, 'You do not have permission to access this page.')
            return redirect('store-home')
        return function(request, *args, **kwargs)

    return _function
