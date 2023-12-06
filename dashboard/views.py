from django.shortcuts import render, redirect
from .models import Address, GameItem, StoreOrder, OrderItem, CreditCard
from django.http import JsonResponse
import json
from django.contrib.auth.models import User
from django.core.serializers import serialize
from .forms import AddressForm, CreditCardForm



# Create your views here.
def home(request):
    games_from_db = GameItem.objects.all().order_by('-published_year')[:10]
    game_items = [
        {
            'game_id': game.game_id,
            'name': game.game_name,
            'price': f'$10',  # Assuming you want to display avg_rating as the price
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


def checkout(request):
    if request.user:
        customer = request.user
        order = StoreOrder.objects.get(customer=customer, order_status='In progress')
        items = order.orderitem_set.all()
        cards = CreditCard.objects.filter(customer=customer)
        addresses = Address.objects.filter(customer=customer)
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
            return redirect(referring_page)
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
            referring_page = request.META.get('HTTP_REFERER', '/')
            return redirect(referring_page)
    else:
        form = AddressForm()
    
    context = {'customer_id': request.user.id, 'form': form}
    return render(request, 'dashboard/add_address.html', context)
