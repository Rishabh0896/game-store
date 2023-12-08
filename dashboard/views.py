import datetime

from django.db.models import Count
from django.shortcuts import render, redirect, get_object_or_404

from crud.models import Publisher, Designer, GameType, GameMechanic
from .decorators import manager_required
from .models import Address, GameItem, Review, StoreOrder, OrderItem, CreditCard
from django.http import JsonResponse
import json
from django.contrib.auth.decorators import login_required
from .forms import AddressForm, CreditCardForm, ReviewForm
from django.db import connection


# Create your views here.
def home(request):
    games_from_db = GameItem.objects.all().order_by('-published_year')[:10]
    game_items = [
        {
            'game_id': game.game_id,
            'name': game.game_name,
            'price': game.price,
            'published_year': game.published_year,
            'min_player': game.min_player,
            'max_player': game.max_player,
            'min_age': game.min_age,
            'min_time': game.min_time,
            'max_time': game.max_time,
            'is_cooperative': game.is_cooperative,
            'num_review': game.num_review,
            'avg_rating': game.avg_rating,
            'std_dev_rating': game.std_dev_rating,
            'rated_complexity': game.rated_complexity,
            'rated_language_dependency': game.rated_language_dependency,
        }
        for game in games_from_db
    ]
    context = {'gameItems': game_items}
    return render(request, 'dashboard/home.html', context)


def about(request):
    return render(request, 'dashboard/about.html', {'title': 'About'})


def cart(request):
    if request.user:
        customer = request.user
        order, created = StoreOrder.objects.get_or_create(customer=customer, order_status='In progress')
        items = order.orderitem_set.all()
    else:
        items = []
        order = {'get_cart_total': 0, 'get_cart_items': 0}
    context = {'items': items, 'order': order}
    return render(request, 'dashboard/cart.html', context)


def account(request):
    if request.user:
        customer = request.user
        cards = get_credit_cards(customer)
        addresses = get_addresses(customer)
        reviews = get_reviews_by_customer(customer)
        placed_orders = StoreOrder.objects.filter(customer=customer, order_status='Placed')
        fulfilled_orders = StoreOrder.objects.filter(customer=customer, order_status='Fulfilled')

    else:
        cards = []
        addresses = []
        reviews = []
        placed_orders = []  
        fulfilled_orders = []
    context = {'cards': cards, 'addresses': addresses, 'reviews': reviews, 'placed_orders': placed_orders, 'fulfilled_orders': fulfilled_orders}
    return render(request, 'dashboard/account.html', context)


def get_credit_cards(customer):
    cards = CreditCard.objects.filter(customer=customer)
    return cards


def get_addresses(customer):
    addresses = Address.objects.filter(customer=customer)
    return addresses


def get_reviews_by_customer(customer):
    reviews = Review.objects.filter(customer=customer)
    return reviews


def get_reviews_by_game(game):
    reviews = Review.objects.filter(game=game)
    return reviews


def checkout(request):
    if request.user:
        customer = request.user
        order = StoreOrder.objects.get(customer=customer, order_status='In progress')
        items = order.orderitem_set.all()
        cards = get_credit_cards(customer)
        addresses = get_addresses(customer)
    else:
        items = []
        cards = []
        order = {'get_cart_total': 0, 'get_cart_items': 0}
    context = {'items': items, 'order': order, 'cards': cards, 'addresses': addresses}
    return render(request, 'dashboard/checkout.html', context)


def update_cart_item(request):
    data = json.loads(request.body)
    productId = data['productId']
    customer = request.user

    if customer == "AnonymousUser":
        return JsonResponse("Please login to add to cart", safe=False);

    action = data['action']

    product = GameItem.objects.get(game_id=productId)
    order, created = StoreOrder.objects.get_or_create(customer=customer, order_status='In progress')

    orderItem, created = OrderItem.objects.get_or_create(order=order, game=product)

    if action == 'add':
        orderItem.quantity = (orderItem.quantity + 1)
    elif action == 'remove':
        orderItem.quantity = (orderItem.quantity - 1)

    orderItem.save()

    if orderItem.quantity <= 0:
        orderItem.delete()

    return JsonResponse("Item Updated", safe=False);

def cancel_order(request, order_id):
    order = get_object_or_404(StoreOrder, order_id=order_id)
    if order.order_status == 'Placed':
        order.delete()
    return redirect('account')

def add_credit_card(request):
    if request.method == 'POST':
        form = CreditCardForm(request.POST)
        if form.is_valid():
            credit_card = form.save(commit=False)
            credit_card.customer = request.user
            credit_card.save()
            referring_page = request.META.get('HTTP_REFERER', '/')
            return redirect("checkout")
    else:
        form = CreditCardForm()

    context = {'customer_id': request.user.id, 'form': form}
    return render(request, 'dashboard/add_credit_card.html', context)


def edit_credit_card(request, credit_card_id):
    context = {'action': 'update'}

    if request.method == 'GET':
        credit_card = CreditCard.objects.get(credit_card_id=credit_card_id)
        form = CreditCardForm(instance=credit_card)
        context['credit_card'] = credit_card
        context['form'] = form
        return render(request, 'dashboard/add_credit_card.html', context)

    elif request.method == 'POST':
        credit_card = CreditCard.objects.get(credit_card_id=credit_card_id)
        form = CreditCardForm(request.POST, instance=credit_card)
        if form.is_valid():
            form.save()
            return redirect("account")


def delete_credit_card(request, credit_card_id):
    credit_card = CreditCard.objects.get(credit_card_id=credit_card_id)
    credit_card.delete()
    return redirect("account")


def add_address(request):
    if request.method == 'POST':
        form = AddressForm(request.POST)
        if form.is_valid():
            address = form.save(commit=False)
            address.customer = request.user
            address.save()
            return redirect("checkout")
    else:
        form = AddressForm()

    context = {'customer_id': request.user.id, 'form': form}
    return render(request, 'dashboard/add_address.html', context)


def edit_address(request, address_id):
    context = {'action': 'update'}

    if request.method == 'GET':
        address = Address.objects.get(address_id=address_id)
        form = AddressForm(instance=address)
        context['address'] = address
        context['form'] = form
        return render(request, 'dashboard/add_address.html', context)

    elif request.method == 'POST':
        address = Address.objects.get(address_id=address_id)
        form = AddressForm(request.POST, instance=address)
        if form.is_valid():
            form.save()
            return redirect("account")


def delete_address(request, address_id):
    address = Address.objects.get(address_id=address_id)
    address.delete()
    return redirect("account")


def place_order(request):
    if request.method == 'POST':
        customer = request.user
        order = StoreOrder.objects.get(customer=customer, order_status='In progress')
        order.address = Address.objects.get(address_id=request.POST['selected_address'])
        order.credit_card = CreditCard.objects.get(credit_card_id=request.POST['selected_credit_card'])
        order.order_status = 'Placed'
        order.date_ordered = datetime.datetime.now()
        order.save()
        referring_page = request.META.get('HTTP_REFERER', '/')
        return redirect("store-home")


def execute_insert_review_and_update_score(p_customer_id, p_game_id, p_rating, p_text_review, p_complexity_rating,
                                           p_language_dependency_rating):
    with connection.cursor() as cursor:
        # Call the stored procedure
        cursor.callproc(
            'insert_review_and_update_score',
            [p_customer_id, p_game_id, p_rating, p_text_review, p_complexity_rating, p_language_dependency_rating]
        )






def add_review(request):
    if request.method == 'GET':
        form = ReviewForm()
        game_id = request.GET['game_id']
        game = GameItem.objects.get(game_id=game_id)
        context = {'game': game, 'form': form}
        return render(request, 'dashboard/add_review.html', context)

    elif request.method == 'POST':
        customer = request.user
        game = GameItem.objects.get(game_id=request.POST['game_id'])
        rating = request.POST['rating']
        text_review = request.POST['text_review']
        complexity_rating = request.POST['complexity_rating']
        language_dependency_rating = request.POST['language_dependency_rating']

        try:
            execute_insert_review_and_update_score(customer.id, game.game_id, rating, text_review, complexity_rating,
                                               language_dependency_rating)
            return redirect('game_detail', game_id=game.game_id)
        except Exception as e:
            form.add_error(None, str(e))
        


def edit_review(request, review_id):
    context = {'action': 'update'}

    if request.method == 'GET':
        review = Review.objects.get(review_id=review_id)
        form = ReviewForm(instance=review)
        context['review'] = review
        context['form'] = form
        return render(request, 'dashboard/add_review.html', context)

    elif request.method == 'POST':
        review = Review.objects.get(review_id=review_id)
        print(review)
        form = ReviewForm(request.POST, instance=review)
        if form.is_valid():
            form.save()
            return redirect("account")


def delete_review(request, review_id):
    review = Review.objects.get(review_id=review_id)
    review.delete()
    return redirect("account")


def game_detail(request, game_id):
    game = GameItem.objects.get(game_id=game_id)

    context = {'game': game, 'reviews': get_reviews_by_game(game)}
    return render(request, 'dashboard/game_detail.html', context)


# Manager
@login_required
@manager_required
def manager_dashboard(request):
    pending_to_approve_orders = StoreOrder.objects.filter(order_status="Placed")
    total_fulfilled_orders = StoreOrder.objects.filter(order_status="Fulfilled").count()
    total_pending_orders = StoreOrder.objects.filter(order_status="Placed").count()
    total_orders_in_cart = StoreOrder.objects.filter(order_status="In progress").count()
    total_orders = total_fulfilled_orders + total_pending_orders + total_orders_in_cart
    context = {'pending_orders': pending_to_approve_orders,
               'total_fulfilled_orders': total_fulfilled_orders,
               'total_orders_in_cart': total_orders_in_cart,
               'total_orders': total_orders}
    return render(request, 'dashboard/manager_order_summary.html', context)


@login_required
@manager_required
def fulfill_order(request, order_id):
    order = get_object_or_404(StoreOrder, order_id=order_id)
    if order.order_status == 'Placed':
        order.order_status = 'Fulfilled'
        order.save()
    return redirect('manager-dashboard')


@login_required
@manager_required
def revenue_summary(request):
    try:
        game_revenue = call_stored_procedure(proc_name='calculate_game_revenue')
    except Exception as e:
        print(e)
        game_revenue = []
    for gr in game_revenue:
        print(f"Game: {gr[0]}, Total Revenue: {gr[1]}")
    total_revenue = get_total_revenue()
    context = {"game_revenue": game_revenue, "total_revenue": total_revenue}
    return render(request, 'dashboard/manager_revenue_summary.html', context)


@login_required
@manager_required
def leader_board(request):
    top_publisher = Publisher.objects.annotate(game_count=Count('gameitem')).order_by('-game_count').first()
    top_designer = Designer.objects.annotate(game_count=Count('gameitem')).order_by('-game_count').first()
    top_gametype = GameType.objects.annotate(game_count=Count('gameitem')).order_by('-game_count').first()
    top_gamemechanic = GameMechanic.objects.annotate(game_count=Count('gameitem')).order_by('-game_count').first()
    grossing_publisher = get_most_grossing_publisher();
    grossing_designer = get_most_grossing_designer();
    grossing_gametype = get_most_grossing_game_type();
    grossing_gamemechanic = get_most_grossing_game_mechanic();

    context = {
        'publisher_with_most_games': top_publisher.publisher_name,
        'publisher_game_count': top_publisher.game_count,
        'designer_with_most_games': top_designer.designer_name,
        'designer_game_count': top_designer.game_count,
        'gametype_with_most_games': top_gametype.type_name,
        'gametype_game_count': top_gametype.game_count,
        'gamemechanic_with_most_games': top_gamemechanic.mechanic_name,
        'gamemechanic_game_count': top_gamemechanic.game_count,
        'most_grossing_publisher': grossing_publisher[0][0],
        'most_grossing_publisher_revenue': grossing_publisher[0][1],
        'most_grossing_designer': grossing_designer[0][0],
        'most_grossing_designer_revenue': grossing_designer[0][1],
        'most_grossing_gametype': grossing_gametype[0][0],
        'most_grossing_gametype_revenue': grossing_gametype[0][1],
        'most_grossing_gamemechanic': grossing_gamemechanic[0][0],
        'most_grossing_gamemechanic_revenue': grossing_gamemechanic[0][1],
    }
    return render(request, 'dashboard/manager_leaderboard.html', context)


def call_stored_procedure(proc_name):
    with connection.cursor() as cursor:
        cursor.callproc(proc_name)
        results = cursor.fetchall()
    return results


def get_total_revenue():
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT calculate_total_revenue()")
            total_revenue = cursor.fetchone()[0]
        return total_revenue
    except Exception as e:
        print(e)
        return "Error"

def get_most_grossing_publisher():
    try:
        with connection.cursor() as cursor:
            cursor.callproc('get_most_grossing_publisher')
            results = cursor.fetchall()
        return results
    except Exception as e:
        print(e)
        return [["Error", "Error"]]


def get_most_grossing_designer():
    try:
        with connection.cursor() as cursor:
            cursor.callproc('get_most_grossing_designer')
            results = cursor.fetchall()
        return results
    except Exception as e:
        print(e)
        return [["Error", "Error"]]


def get_most_grossing_game_type():
    try:
        with connection.cursor() as cursor:
            cursor.callproc('get_most_grossing_game_type')
            results = cursor.fetchall()
        return results
    except Exception as e:
        print(e)
        return [["Error", "Error"]]


def get_most_grossing_game_mechanic():
    try:
        with connection.cursor() as cursor:
            cursor.callproc('get_most_grossing_game_mechanic')
            results = cursor.fetchall()
        return results
    except Exception as e:
        print(e)
        return [["Error", "Error"]]

# Staff


def staff_dashboard(request):
    context = {}
    queryset = GameItem.objects.select_related('publisher', 'designer', 'type', 'mechanic').values(
        'game_id',
        'game_name',
        'publisher__publisher_id',
        'publisher__publisher_name',
        'designer__designer_id',
        'designer__designer_name',
        'type__type_id',
        'type__type_name',
        'mechanic__mechanic_id',
        'mechanic__mechanic_name',
        'price'
    )
    context['game_items'] = queryset
    return render(request, 'dashboard/staff_dashboard.html', context)

