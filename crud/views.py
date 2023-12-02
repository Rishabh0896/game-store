from django.shortcuts import render, redirect, get_object_or_404
from .forms import GameItemForm, GameSearchForm
from django.contrib import messages
from .models import GameItem
from .filter import GameItemFilter


# Create your views here.
def create_game_item(request):
    print("I'm here create_game_item")
    print("Request Method:", request.method)
    if request.method == 'POST':
        print("I'm here inside POST")
        form = GameItemForm(request.POST)
        if form.is_valid():
            print("I'm here inside form valid")
            form.save()
            messages.success(request, f'Game Item has been created')
            print("I'm here after save")
            return redirect('store-home')  # Redirect to a view that lists all GameItems
    else:
        print("I'm in else")
        form = GameItemForm()

    return render(request, 'crud/create_game_item.html', {'form': form})


def search_update_delete_game(request):
    if request.method == 'POST':
        search_form = GameSearchForm(request.POST)
        game_item_filter = GameItemFilter()
        if search_form.is_valid():
            game_name = search_form.cleaned_data['game_name']
            print("Game name is :" + game_name)
            # Perform a search based on the entered game name
            games = GameItem.objects.filter(game_name__icontains=game_name)
            context = {
                'search_form': search_form,
                'games': games,
                'filter': game_item_filter
            }
            return render(request, 'crud/search_update_delete_game.html', context)
    else:
        search_form = GameSearchForm()
        games = GameItem.objects.all()

    return render(request, 'crud/search_update_delete_game.html', {'search_form': search_form, 'games': games})

