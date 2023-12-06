import datetime
from django.shortcuts import render, redirect, get_object_or_404

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
    else:
        cards = []
        addresses = []
    context = {'cards': cards, 'addresses': addresses}
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
    
    context = {'customer_id':request.user.id, 'form': form}
    return render(request, 'dashboard/add_credit_card.html', context)

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

def execute_insert_review_and_update_score(p_customer_id, p_game_id, p_rating, p_text_review, p_complexity_rating, p_language_dependency_rating):
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

        execute_insert_review_and_update_score(customer.id, game.game_id, rating, text_review, complexity_rating, language_dependency_rating)
        return redirect("store-home")


def game_detail(request, game_id):
    game = GameItem.objects.get(game_id=game_id)

    context = {'game': game, 'reviews': get_reviews_by_game(game)}
    return render(request, 'dashboard/game_detail.html', context)

# Manager
@login_required
@manager_required
def manager_dashboard(request):
    orders = StoreOrder.objects.filter(order_status="Placed")
    total_fulfilled_orders = StoreOrder.objects.filter(order_status="Fulfilled").count();
    total_orders = StoreOrder.objects.all().count()
    context = {'orders': orders,
               'total_fulfilled_orders': total_fulfilled_orders,
               'total_orders': total_orders}
    return render(request, 'dashboard/manager_home.html', context)


@login_required
@manager_required
def fulfill_order(request, order_id):
    order = get_object_or_404(StoreOrder, order_id=order_id)
    if order.order_status == 'Placed':
        order.order_status = 'Fulfilled'
        order.save()
    return redirect('manager-dashboard')