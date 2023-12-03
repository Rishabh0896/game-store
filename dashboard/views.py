from django.shortcuts import render
from .models import GameItem, StoreOrder, OrderItem
from django.http import JsonResponse
import json

gameItemsTest = [
    {
        'name': 'Bitoku',
        'price': '$11',
        'published_year': '2021',
        'min_player': '1',
        'max_player': '4',
        'min_age': '12',
        'min_time': '120',
        'max_time': '120',
        'is_cooperative': '0',
        'num_review': '4133',
        'avg_rating': '7.91579',
        'std_dev_rating': '1.36109',
        'rated_complexity': '3.7192',
        'rated_language_dependency': None
    },
    {
        'name': 'Blood Rage',
        'price': '$20',
        'published_year': '2021',
        'min_player': '1',
        'max_player': '4',
        'min_age': '12',
        'min_time': '120',
        'max_time': '120',
        'is_cooperative': '0',
        'num_review': '4133',
        'avg_rating': '7.91579',
        'std_dev_rating': '1.36109',
        'rated_complexity': '3.7192',
        'rated_language_dependency': None
    },
    {
        'name': 'Bora Bora',
        'price': '$29',
        'published_year': '2021',
        'min_player': '1',
        'max_player': '4',
        'min_age': '12',
        'min_time': '120',
        'max_time': '120',
        'is_cooperative': '0',
        'num_review': '4133',
        'avg_rating': '7.91579',
        'std_dev_rating': '1.36109',
        'rated_complexity': '3.7192',
        'rated_language_dependency': None
    }
]


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
        print(items)
    else:
        items = []
        order = {'get_cart_total': 0, 'get_cart_items': 0}
    context = {'items': items, 'order': order}
    return render(request, 'dashboard/cart.html', context)


def checkout(request):
    context = {}
    return render(request, 'dashboard/checkout.html', context)

def update_item(request):
    data = json.loads(request.body)
    productId = data['productId']
    customer = request.user
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