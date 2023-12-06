var updateBtns = document.getElementsByClassName('update-cart')
for (var i = 0; i < updateBtns.length; i++) {
    updateBtns[i].addEventListener('click', function() {
        var productId = this.dataset.product;
        var action = this.dataset.action

        updateUserOrder(productId, action)
    });
}

function updateUserOrder(productId, action) {
    var url = '/update_item/'
    console.log(productId, action);
    fetch(url, {
    method: 'POST',
    headers: {
    'Content-Type': 'application/json',
     'X-CSRFToken': csrfToken},
    body: JSON.stringify({'productId': productId, 'action': action})})
    .then((response) =>
    {
        return response.json();
    })
    .then((data) => {
        alert(data)
        location.reload()
    })
}
