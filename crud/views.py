from django.shortcuts import render, redirect, get_object_or_404

from django.db import models
from .forms import GameItemForm, PublisherForm, DesignerForm, GameMechanicForm, GameTypeForm
from django.contrib import messages
from .models import GameItem, GameMechanic, GameType, Publisher, GameItemGameMechanic, GameItemGameType, \
    GameItemPublisher

game_mechanic_options = []
game_type_options = []
game_publisher_options = []


def view_game(request, game_id):
    context = {
        'game_action': 'view',
    }
    game = get_object_or_404(GameItem, game_id=game_id)
    game_type = get_object_or_404(GameItemGameType, game=game_id)
    game_mechanic_options = get_object_or_404(GameItemGameMechanic, game=game_id)
    game_publisher = get_object_or_404(GameItemPublisher, game=game_id)
    form = GameItemForm(initial={
        'game_mechanic_options': game.mechanic,
        'game_type_options': game.game_type,
        'game_publisher_options': game.publisher
    })
    context['form'] = form
    return render(request, 'crud/add_game.html', context)


def add_game(request):
    # populate_dropdown_data()
    context = {
        'game_action': 'add',
        'game_mechanic_options': game_mechanic_options,
        'game_type_options': game_type_options,
        'game_publisher_options': game_publisher_options
    }
    if request.method == 'POST':
        form = GameItemForm(request.POST)
        context['form'] = form
        if form.is_valid():
            selected_publisher_id = form.cleaned_data['game_publisher_options']
            selected_game_type_id = form.cleaned_data['game_type_options']
            selected_mechanic_id = form.cleaned_data['game_mechanic_options']
            game_id = 0
            if not hasattr(form.instance, 'game_id') or form.instance.game_id is None:
                game_id = generate_next_game_id()
                form.instance.game_id = game_id
            form.save()
            if context['game_action'] == 'add':
                game_item_instance = GameItem.objects.get(game_id=game_id)

                for mechanic_id in selected_mechanic_id:
                    game_mechanic_instance = GameMechanic.objects.get(mechanic_id=mechanic_id)
                    relation_game_mechanic = GameItemGameMechanic(game=game_item_instance,
                                                                  mechanic=game_mechanic_instance)
                    relation_game_mechanic.save()

                for publisher_id in selected_publisher_id:
                    game_publisher_instance = Publisher.objects.get(publisher_id=publisher_id)
                    relation_game_publisher = GameItemPublisher(game=game_item_instance,
                                                                publisher=game_publisher_instance)
                    relation_game_publisher.save()

                for game_type_id in selected_game_type_id:
                    game_type_instance = GameType.objects.get(type_id=game_type_id)
                    relation_game_type = GameItemGameType(game=game_item_instance, type=game_type_instance)
                    relation_game_type.save()

            messages.success(request, f'Game Item has been created')
            return redirect('store-home')
    else:
        form = GameItemForm(request.POST)
        context['form'] = form

    return render(request, 'crud/add_game.html', context)


def generate_next_game_id():
    max_game_id = GameItem.objects.aggregate(models.Max('game_id'))['game_id__max']
    game_id = max_game_id + 1 if max_game_id else 1
    return game_id


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


# Publisher

def add_publisher(request):
    context = {}
    if request.method == 'POST':
        form = PublisherForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Publisher has been created')
        return redirect('store-home')
    else:
        form = PublisherForm()
        context['form'] = form

    return render(request, 'crud/add_publisher.html', context)


def read_publisher(request, publisher_id):

    return

def update_publisher(request,publisher_id):
    return

def delete_publisher(request, publisher_id):
    return


# Designer

def add_designer(request):
    context = {}
    if request.method == 'POST':
        form = DesignerForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'designer has been created')
        return redirect('store-home')
    else:
        form = DesignerForm()
        context['form'] = form

    return render(request, 'crud/add_designer.html', context)

def read_designer(request, designer_id):
    return

def update_designer(request,designer_id):
    return

def delete_designer(request, designer_id):
    return

# GameType

def add_gametype(request):
    context = {}
    if request.method == 'POST':
        form = GameTypeForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'gametype has been created')
        return redirect('store-home')
    else:
        form = GameTypeForm()
        context['form'] = form

    return render(request, 'crud/add_gametype.html', context)

def read_gametype(request, gametype_id):
    return

def update_gametype(request,gametype_id):
    return

def delete_gametype(request, gametype_id):
    return

# Game Mechanic
def add_gamemechanic(request):
    context = {}
    if request.method == 'POST':
        form = GameMechanicForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'gamemechanic has been created')
        return redirect('store-home')
    else:
        form = GameMechanicForm()
        context['form'] = form

    return render(request, 'crud/add_gamemechanic.html', context)

def read_gamemechanic(request, gamemechanic_id):
    return

def update_gamemechanic(request,gamemechanic_id):
    return

def delete_gamemechanic(request, gamemechanic_id):
    return
