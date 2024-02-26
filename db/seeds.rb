# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts "Destroying Rooms, Users, Items..."
Room.destroy_all
User.destroy_all
Item.destroy_all

puts "Creating new seeds"
user1 = User.create(username: "Mario", email: "abc@gmail.com", password: "123456")
user2 = User.create(username: "Luidgi", email: "bac@gmail.com", password: "123456")
user3 = User.create(username: "Peach", email: "cba@gmail.com", password: "123456")

room1 = Room.create(palette: ["red", "orange"], room_type: "kitchen", name: "kitchen", user: user1)
room2 = Room.create(palette: ["yellow", "orange"], room_type: "living", name: "living", user: user2)
room3 = Room.create(palette: ["blue", "green"], room_type: "bathroom", name: "bathroom", user: user3)

items = [
  {
    name: "World's Comfiest Sofa",
    furniture_type: "sofa",
    price: 15000,
    color: "red",
    shop_name: "Bongo's House of Furnishings",
    shop_item_id: "001",
    shop_url: "https://flymee.jp/product/20258/?gad_source=1",
    photo: "https://static2.flymee.jp/product_images/ba5c-20258/201811151533287003.jpg",
    x_dimension: 240,
    y_dimension: 85,
    z_dimension: 85
  },
  {
    name: "Dog-faced cushion",
    furniture_type: "cushion",
    price: 3500,
    color: "brown",
    shop_name: "IKEA",
    shop_item_id: "010",
    shop_url: "https://www.ikea.com/jp/en/p/barndroem-cushion-with-pocket-beige-00511063/",
    photo: "https://www.ikea.com/jp/en/images/products/barndroem-cushion-with-pocket-beige__0968689_pe810520_s5.jpg?f=s",
    x_dimension: 45,
    y_dimension: 45,
    z_dimension: 20
  },
  {
    name: "Dozemaster 4000",
    furniture_type: "bed",
    price: 58000,
    color: "brown",
    shop_name: "Nitori",
    shop_item_id: "100",
    shop_url: "https://www.nitori-net.jp/ec/product/5652860s/",
    photo: "https://www.nitori-net.jp/ecstatic/image/product/5652860/565286001.jpg?ccp=1708934400&imwidth=415&imdensity=1&ts=20240216070457627",
    x_dimension: 210,
    y_dimension: 31.5,
    z_dimension: 110
  },
  {
    name: "Poisoned Chair",
    furniture_type: "chair",
    price: 2000,
    color: "blue",
    shop_name: "IKEA",
    shop_item_id: "110",
    shop_url: "https://www.ikea.com/jp/ja/p/kyrre-stool-bright-blue-60555558/?source=google&medium=cpc&campaign=ikea_jp_jp_p_shopping_fy21&gad_source=1",
    photo: "https://www.ikea.com/jp/ja/images/products/kyrre-stool-bright-blue__1181813_pe896805_s5.jpg?f=s",
    x_dimension: 45,
    y_dimension: 42,
    z_dimension: 48
  },
  {
    name: "Sheep Counter Mk.II",
    furniture_type: "bed",
    price: 80000,
    color: "green",
    shop_name: "Just Furniture",
    shop_item_id: "101",
    shop_url: "https://www.justfurnitureonline.com/category/bedrooms/aiden-green-velvet-king-bed.html",
    photo: "https://mfmd.rencdn.com/product/meridian/images/AidenGreen-K.jpg",
    x_dimension: 220,
    y_dimension: 115,
    z_dimension: 210
  },
  {
    name: "Cozytron VX-84",
    furniture_type: "sofa",
    price: 34000,
    color: "yellow",
    shop_name: "Fine Kagu",
    shop_item_id: "011",
    shop_url: "https://www.finekagu.com/products/sf-cauto?currency=JPY&variant=43484255551747&stkn=45a7a757935c&gad_source=1",
    photo: "https://www.finekagu.com/cdn/shop/products/sf-Cauto_MS_600x.jpg?v=1668994027",
    x_dimension: 138,
    y_dimension: 66,
    z_dimension: 70
  }
]

items.each do |item|
  p item
  instance = Item.new(item)
  p instance
  p instance.valid?
  instance.save
end

Wishlist.create(room: room1, item: Item.all[0])
Wishlist.create(room: room1, item: Item.all[1])
Wishlist.create(room: room2, item: Item.all[2])
Wishlist.create(room: room2, item: Item.all[3])
Wishlist.create(room: room3, item: Item.all[4])
Wishlist.create(room: room3, item: Item.all[5])

Planner.create(room: room1, item: Item.all[0])
Planner.create(room: room1, item: Item.all[1])
Planner.create(room: room2, item: Item.all[2])
Planner.create(room: room2, item: Item.all[3])
Planner.create(room: room3, item: Item.all[4])
Planner.create(room: room3, item: Item.all[5])

puts "Seeds generated"
