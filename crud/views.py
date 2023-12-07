from django.shortcuts import render, redirect, get_object_or_404

from .forms import GameItemForm, PublisherForm, DesignerForm, GameMechanicForm, GameTypeForm
from django.contrib import messages
from .models import GameItem, GameMechanic, GameType, Publisher, Designer
from django.contrib.auth.decorators import login_required, user_passes_test
from .decorators import staff_required


def view_game(request, game_id):
    context = {
        'action': 'view',
    }
    game = get_object_or_404(GameItem, game_id=game_id)
    form = GameItemForm(initial={
        'game_mechanic_options': game.mechanic,
        'game_type_options': game.type,
        'game_publisher_options': game.publisher,
        'game_designer_options': game.designer
    }, instance=game, action='view')
    context['form'] = form
    return render(request, 'crud/add_game.html', context)


@login_required
@staff_required
def add_game(request):
    context = {
        'action': 'add',
    }
    if request.method == 'POST':
        form = GameItemForm(request.POST)
        context['form'] = form
        if form.is_valid():
            if not hasattr(form.instance, 'game_id') or form.instance.game_id is None:
                form.save()
            messages.success(request, f'Game Item has been created')
            return redirect('store-home')
    else:
        form = GameItemForm(request.POST)
        context['form'] = form

    return render(request, 'crud/add_game.html', context)


@login_required
@staff_required
def manage_game(request):
    if 'search' in request.GET:
        search = request.GET['search']
        games = GameItem.objects.filter(game_name__icontains=search)
    else:
        games = GameItem.objects.all()
    context = {'games': games}
    return render(request, 'crud/manage_game.html', context)


@login_required
@staff_required
def update_game(request, game_id):
    context = {
        'action': 'update',
    }
    game = get_object_or_404(GameItem, game_id=game_id)

    if request.method == 'POST':
        form = GameItemForm(request.POST, instance=game)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Item has been updated')
            return redirect('manage_game')
    else:
        form = GameItemForm(instance=game, initial={
            'game_mechanic_options': game.mechanic,
            'game_type_options': game.type,
            'game_publisher_options': game.publisher,
            'game_designer_options': game.designer
        })
        context['form'] = form
    return render(request, 'crud/add_game.html', context)


@login_required
@staff_required
def delete_game(request, game_id):
    game = get_object_or_404(GameItem, game_id=game_id)
    game.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_game')


# Publisher

@login_required
@staff_required
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
    context = {}
    publisher = get_object_or_404(Publisher, publisher_id=publisher_id)
    form = PublisherForm(instance=publisher, action='view')
    context['form'] = form
    return render(request, 'crud/add_publisher.html', context)


@login_required
@staff_required
def manage_publisher(request):
    if 'search' in request.GET:
        search = request.GET['search']
        publishers = Publisher.objects.filter(publisher_name__icontains=search)
    else:
        publishers = Publisher.objects.all()
    context = {'publishers': publishers}
    return render(request, 'crud/manage_publisher.html', context)


@login_required
@staff_required
def update_publisher(request, publisher_id):
    context = {
        'action': 'update',
    }
    publisher = get_object_or_404(Publisher, publisher_id=publisher_id)

    if request.method == 'POST':
        form = PublisherForm(request.POST, instance=publisher)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Publisher has been updated')
            return redirect('manage_publisher')
    else:
        form = PublisherForm(instance=publisher)
        context['form'] = form
    return render(request, 'crud/add_publisher.html', context)


@login_required
@staff_required
def delete_publisher(request, publisher_id):
    publisher = get_object_or_404(Publisher, publisher_id=publisher_id)
    publisher.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_publisher')


# Designer
@login_required
@staff_required
def add_designer(request):
    context = {}
    if request.method == 'POST':
        form = DesignerForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Designer has been created')
        return redirect('store-home')
    else:
        form = DesignerForm()
        context['form'] = form

    return render(request, 'crud/add_designer.html', context)


def read_designer(request, designer_id):
    context = {}
    designer = get_object_or_404(Designer, designer_id=designer_id)
    form = DesignerForm(instance=designer, action="view")
    context['form'] = form
    return render(request, 'crud/add_designer.html', context)


@login_required
@staff_required
def manage_designer(request):
    if 'search' in request.GET:
        search = request.GET['search']
        designers = Designer.objects.filter(designer_name__icontains=search)
    else:
        designers = Designer.objects.all()
    context = {'designers': designers}
    return render(request, 'crud/manage_designer.html', context)


@login_required
@staff_required
def update_designer(request, designer_id):
    context = {
        'action': 'update',
    }
    designer = get_object_or_404(Designer, designer_id=designer_id)

    if request.method == 'POST':
        form = DesignerForm(request.POST, instance=designer)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'designer has been updated')
            return redirect('manage_designer')
    else:
        form = DesignerForm(instance=designer)
        context['form'] = form
    return render(request, 'crud/add_designer.html', context)


@login_required
@staff_required
def delete_designer(request, designer_id):
    designer = get_object_or_404(Designer, designer_id=designer_id)
    designer.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_designer')


# GameType
@login_required
@staff_required
def add_gametype(request):
    context = {}
    if request.method == 'POST':
        form = GameTypeForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Type has been created')
        return redirect('store-home')
    else:
        form = GameTypeForm()
        context['form'] = form

    return render(request, 'crud/add_gametype.html', context)


def read_gametype(request, type_id):
    context = {}
    gametype = get_object_or_404(GameType, type_id=type_id)
    form = GameTypeForm(instance=gametype, action="view")
    context['form'] = form
    return render(request, 'crud/add_gametype.html', context)


@login_required
@staff_required
def manage_gametype(request):
    if 'search' in request.GET:
        search = request.GET['search']
        gametypes = GameType.objects.filter(type_name__icontains=search)
    else:
        gametypes = GameType.objects.all()
    context = {'gametypes': gametypes}
    return render(request, 'crud/manage_gametype.html', context)


@login_required
@staff_required
def update_gametype(request, type_id):
    context = {
        'action': 'update',
    }
    gametype = get_object_or_404(GameType, type_id=type_id)

    if request.method == 'POST':
        form = GameTypeForm(request.POST, instance=gametype)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Type has been updated')
            return redirect('manage_gametype')
    else:
        form = GameTypeForm(instance=gametype)
        context['form'] = form
    return render(request, 'crud/add_gametype.html', context)


@login_required
@staff_required
def delete_gametype(request, type_id):
    gametype = get_object_or_404(GameType, type_id=type_id)
    gametype.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_gametype')


# Game Mechanic
@login_required
@staff_required
def add_gamemechanic(request):
    context = {}
    if request.method == 'POST':
        form = GameMechanicForm(request.POST)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Mechanic has been created')
        return redirect('store-home')
    else:
        form = GameMechanicForm()
        context['form'] = form

    return render(request, 'crud/add_gamemechanic.html', context)


def read_gamemechanic(request, mechanic_id):
    context = {}
    gamemechanic = get_object_or_404(GameMechanic, mechanic_id=mechanic_id)
    form = GameMechanicForm(instance=gamemechanic, action="view")
    context['form'] = form
    return render(request, 'crud/add_gamemechanic.html', context)


@login_required
@staff_required
def manage_gamemechanic(request):
    if 'search' in request.GET:
        search = request.GET['search']
        gamemechanics = GameMechanic.objects.filter(mechanic_name__icontains=search)
    else:
        gamemechanics = GameMechanic.objects.all()
    context = {'gamemechanics': gamemechanics}
    return render(request, 'crud/manage_gamemechanic.html', context)


@login_required
@staff_required
def update_gamemechanic(request, mechanic_id):
    context = {
        'action': 'update',
    }
    gamemechanic = get_object_or_404(GameMechanic, mechanic_id=mechanic_id)

    if request.method == 'POST':
        form = GameMechanicForm(request.POST, instance=gamemechanic)
        context['form'] = form
        if form.is_valid():
            form.save()
            messages.success(request, f'Game Mechanic has been updated')
            return redirect('manage_gamemechanic')
    else:
        form = GameMechanicForm(instance=gamemechanic)
        context['form'] = form
    return render(request, 'crud/add_gamemechanic.html', context)


@login_required
@staff_required
def delete_gamemechanic(request, mechanic_id):
    gamemechanic = get_object_or_404(GameMechanic, mechanic_id=mechanic_id)
    gamemechanic.delete()
    # Redirect to the search page or any other appropriate page
    return redirect('manage_gamemechanic')
