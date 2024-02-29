<script>
var droppedItems = [];

function allowDrop(ev) {
  ev.preventDefault();
}
function drag(ev, shopItemId) {
  ev.dataTransfer.setData("shopItemId", shopItemId);
}
function drop(ev) {
  ev.preventDefault();
  var shopItemId = ev.dataTransfer.getData("shopItemId");
  var item = items.find(item => item.shop_item_id == shopItemId);
  droppedItems.push(item);
  renderItems();
}
function renderItems() {
  var container = document.getElementById("wishlist-container");
  container.innerHTML = "";
  droppedItems.forEach(function(item) {
    var card = document.createElement("div");
    card.classList.add("card");
    card.innerHTML = `
    <div class="wishlist-item">
    <div class="wishlist-photo" style="background-image: url('<%= wishlist.item.photo %>');">
    </div>
    <div class="d-flex flex-column wishlist-details ">
      <div class ="d-flex justify-content-between">
        <h3 class="text-center"><%= wishlist.item.name %></h3>
        <div><%= button_to wishlist_path(wishlist), method: :delete, data: {turbo_method: :delete, turbo_confirm: "Are you sure?"}, class: "remove-from-wishlist-button" do %>
            <i class="fas fa-trash"></i>
          <% end %>
        </div>
      </div>
      <div class="d-flex">
        <p>¥ <%= wishlist.item.price %></p>
      </div>
    </div>
    <% if current_page?(room_planners_path) %>
      <%= render "room_planners", wishlist: wishlist %>
    <% end %>
  </div>
    `;
    container.appendChild(card);
  });
}
function removeItem(itemId) {
  droppedItems = droppedItems.filter(item => item.id !== itemId);
  renderItems();
}
</script>
