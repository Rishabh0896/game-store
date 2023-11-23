from django.shortcuts import render

items = [
    {
        'author': 'Rishabh',
        'title': 'Blog Post 1',
        'content': 'First Post Content',
        'date_posted': 'November 16, 2023'
    },
    {
        'author': 'Jane Doe',
        'title': 'Blog Post 2',
        'content': 'Second Post Content',
        'date_posted': 'November 17, 2023'
    }
]


# Create your views here.
def home(request):
    context = {
        'posts': items
    }
    return render(request, 'dashboard/home.html', context)


def about(request):
    return render(request, 'dashboard/about.html', {'title': 'About'})
