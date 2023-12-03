from django.shortcuts import render, redirect, get_object_or_404
from .forms import GameItemForm
from django.contrib import messages
from .models import GameItem


def view_game(request, game_id):
    context = {
        'game_action': 'view',
    }
    game = get_object_or_404(GameItem, game_id=game_id)
    form = GameItemForm(instance=game)
    context['form'] = form
    return render(request, 'crud/add_game.html', context)


def add_game(request):
    context = {
        'game_action': 'add',
    }
    if request.method == 'POST':
        form = GameItemForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Item has been created')
            return redirect('store-home')  # Redirect to a view that lists all GameItems
    else:
        form = GameItemForm()
        context['form'] = form

    return render(request, 'crud/add_game.html', context)


def manage_game(request):
    if 'search' in request.GET:
        search = request.GET['search']
        games = GameItem.objects.filter(game_name__icontains=search)
    else:
        games = GameItem.objects.all()
    context = {'games': games}
    return render(request, 'crud/manage_game.html', context)


def update_game(request, game_id):
    context = {
        'game_action': 'update',
    }
    game = get_object_or_404(GameItem, game_id=game_id)

    if request.method == 'POST':
        form = GameItemForm(request.POST, instance=game)
        context['form'] = form
        if form.is_valid():
            print(f"Published Year Input: {form.cleaned_data['published_year']}")
            form.save()
            messages.success(request, f'Game Item has been updated')
            return redirect('manage_game')
    else:
        form = GameItemForm(instance=game)
        context['form'] = form
    return render(request, 'crud/add_game.html', context)


def delete_game(request, game_id):
    game = get_object_or_404(GameItem, game_id=game_id)
    game.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_game')

