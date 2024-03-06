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
#require "nokogiri"

puts "Destroying Rooms, Users, Items..."
Wishlist.destroy_all
Planner.destroy_all
Room.destroy_all
# User.destroy_all
Item.destroy_all

# puts "Creating new seeds"
# user1 = User.create!(username: "Mario", email: "abc@gmail.com", password: "123456")
# user2 = User.create!(username: "Luidgi", email: "bac@gmail.com", password: "123456")
# user3 = User.create!(username: "Peach", email: "cba@gmail.com", password: "123456")


# room1 = Room.create!(palette: ["red", "orange"], room_type: "kitchen", name: "kitchen", user: user1)
# room2 = Room.create!(palette: ["yellow", "orange"], room_type: "living", name: "living", user: user2)
# room3 = Room.create!(palette: ["blue", "green"], room_type: "bathroom", name: "bathroom", user: user3)


# items = [
#   {
#     name: "World's Comfiest Sofa",
#     furniture_type: "sofa",
#     price: 15000,
#     color: "#7c2a25",
#     shop_name: "Bongo's House of Furnishings",
#     shop_item_id: "001",
#     shop_url: "https://flymee.jp/product/20258/?gad_source=1",
#     photo: "https://static2.flymee.jp/product_images/ba5c-20258/201811151533287003.jpg",
#     x_dimension: 240,
#     y_dimension: 85,
#     z_dimension: 85
#   },
#   {
#     name: "Dog-faced cushion",
#     furniture_type: "cushion",
#     price: 3500,
#     color: "#c5bcb0",
#     shop_name: "IKEA",
#     shop_item_id: "010",
#     shop_url: "https://www.ikea.com/jp/en/p/barndroem-cushion-with-pocket-beige-00511063/",
#     photo: "https://www.ikea.com/jp/en/images/products/barndroem-cushion-with-pocket-beige__0968689_pe810520_s5.jpg?f=s",
#     x_dimension: 45,
#     y_dimension: 45,
#     z_dimension: 20
#   },
#   {
#     name: "Dozemaster 4000",
#     furniture_type: "bed",
#     price: 58000,
#     color: "#b99368",
#     shop_name: "Nitori",
#     shop_item_id: "100",
#     shop_url: "https://www.nitori-net.jp/ec/product/5652860s/",
#     photo: "https://www.nitori-net.jp/ecstatic/image/product/5652860/565286001.jpg?ccp=1708934400&imwidth=415&imdensity=1&ts=20240216070457627",
#     x_dimension: 210,
#     y_dimension: 31.5,
#     z_dimension: 110
#   },
#   {
#     name: "Poisoned Chair",
#     furniture_type: "chair",
#     price: 2000,
#     color: "#0b4189",
#     shop_name: "IKEA",
#     shop_item_id: "110",
#     shop_url: "https://www.ikea.com/jp/ja/p/kyrre-stool-bright-blue-60555558/?source=google&medium=cpc&campaign=ikea_jp_jp_p_shopping_fy21&gad_source=1",
#     photo: "https://www.ikea.com/jp/ja/images/products/kyrre-stool-bright-blue__1181813_pe896805_s5.jpg?f=s",
#     x_dimension: 45,
#     y_dimension: 42,
#     z_dimension: 48
#   },
#   {
#     name: "Sheep Counter Mk.II",
#     furniture_type: "bed",
#     price: 80000,
#     color: "#1b3e39",
#     shop_name: "Just Furniture",
#     shop_item_id: "101",
#     shop_url: "https://www.justfurnitureonline.com/category/bedrooms/aiden-green-velvet-king-bed.html",
#     photo: "https://mfmd.rencdn.com/product/meridian/images/AidenGreen-K.jpg",
#     x_dimension: 220,
#     y_dimension: 115,
#     z_dimension: 210
#   },
#   {
#     name: "Cozytron VX-84",
#     furniture_type: "sofa",
#     price: 34000,
#     color: "#c59642",
#     shop_name: "Fine Kagu",
#     shop_item_id: "011",
#     shop_url: "https://www.finekagu.com/products/sf-cauto?currency=JPY&variant=43484255551747&stkn=45a7a757935c&gad_source=1",
#     photo: "https://www.finekagu.com/cdn/shop/products/sf-Cauto_MS_600x.jpg?v=1668994027",
#     x_dimension: 138,
#     y_dimension: 66,
#     z_dimension: 70
#   },
#   {
#     name: "PLATSA Opening Shelf Unit",
#     furniture_type: "shelf",
#     price: 8000,
#     color: "#1b61a4",
#     shop_name: "IKEA",
#     shop_item_id: "022",
#     shop_url: "https://www.ikea.com/jp/en/p/platsa-open-shelving-unit-blue-60566222/",
#     photo: "https://www.ikea.com/jp/en/images/products/platsa-open-shelving-unit-blue__1210277_pe909617_s5.jpg?f=xl",
#     x_dimension: 60,
#     y_dimension: 40,
#     z_dimension: 60
#   },
#   {
#     name: "MYLLRA Changing Table with Drawers",
#     furniture_type: "chest",
#     price: 9990,
#     color: "#f6eaec",
#     shop_name: "IKEA",
#     shop_item_id: "023",
#     shop_url: "https://www.ikea.com/jp/en/p/myllra-changing-table-with-drawers-pale-pink-50464667/",
#     photo: "https://www.ikea.com/jp/en/images/products/myllra-changing-table-with-drawers-pale-pink__0812335_pe771995_s5.jpg?f=xl",
#     x_dimension: 85,
#     y_dimension: 97,
#     z_dimension: 79
#   },
#   {
#     name: "KALLAX Insert With Door",
#     furniture_type: "shelf",
#     price: 2000,
#     color: "#8cbb8f",
#     shop_name: "IKEA",
#     shop_item_id: "024",
#     shop_url: "https://www.ikea.com/jp/en/p/kallax-insert-with-door-wave-shaped-green-80501357/",
#     photo: "https://www.ikea.com/jp/en/images/products/kallax-insert-with-door-wave-shaped-green__0959827_pe806227_s5.jpg?f=xl",
#     x_dimension: 33,
#     y_dimension: 33,
#     z_dimension: 33
#   },
#   {
#     name: "VINLIDEN 3-seat Sofa",
#     furniture_type: "sofa",
#     price: 69990,
#     color: "#6c9596",
#     shop_name: "IKEA",
#     shop_item_id: "025",
#     shop_url: "https://www.ikea.com/jp/en/p/vinliden-3-seat-sofa-hakebo-light-turquoise-s99304658/",
#     photo: "https://www.ikea.com/jp/en/images/products/vinliden-3-seat-sofa-hakebo-light-turquoise__0938990_pe794368_s5.jpg?f=xl",
#     x_dimension: 203,
#     y_dimension: 108,
#     z_dimension: 97
#   },
#   {
#     name: "STYRSPEL Gaming Chair",
#     furniture_type: "chair",
#     price: 29990,
#     color: "#574768",
#     shop_name: "IKEA",
#     shop_item_id: "026",
#     shop_url: "https://www.ikea.com/jp/en/p/styrspel-gaming-chair-purple-black-00522028/",
#     photo: "https://www.ikea.com/jp/en/images/products/styrspel-gaming-chair-purple-black__1115361_pe872047_s5.jpg?f=xl",
#     x_dimension: 71,
#     y_dimension: 142,
#     z_dimension: 69
#   },
#   {
#     name: "Small Bookcase Black",
#     furniture_type: "bookcase",
#     price: 14850,
#     color: "#000000",
#     shop_name: "Francfranc",
#     shop_item_id: "030",
#     shop_url: "https://francfranc.com/products/1108120014323",
#     photo: "https://francfranc.com/cdn/shop/products/1108120014323_d1_x600.jpg?v=1649317900",
#     x_dimension: 600,
#     y_dimension: 450,
#     z_dimension: 250
#   },
#   {
#     name: "Small Bookcase White",
#     furniture_type: "bookcase",
#     price: 14850,
#     color: "#ffffff",
#     shop_name: "Francfranc",
#     shop_item_id: "030",
#     shop_url: "https://francfranc.com/products/1108120014316",
#     photo: "https://francfranc.com/cdn/shop/products/1108120014316_d1_x600.jpg?v=1649317822",
#     x_dimension: 600,
#     y_dimension: 450,
#     z_dimension: 250
#   },
#   {
#     name: "Classic Bookcase Black",
#     furniture_type: "bookcase",
#     price: 39000,
#     color: "#000000",
#     shop_name: "Francfranc",
#     shop_item_id: "030",
#     shop_url: "https://francfranc.com/products/1108110035284",
#     photo: "https://francfranc.com/cdn/shop/files/1108110035284_d1_x600.jpg?v=1689217386",
#     x_dimension: 700,
#     y_dimension: 750,
#     z_dimension: 370
#   },
#   {
#     name: "Classic Bookcase White",
#     furniture_type: "bookcase",
#     price: 39000,
#     color: "#ffffff",
#     shop_name: "Francfranc",
#     shop_item_id: "031",
#     shop_url: "https://francfranc.com/products/1108110015682",
#     photo: "https://francfranc.com/cdn/shop/products/1108110015682_d1_x600.jpg?v=1674106910",
#     x_dimension: 700,
#     y_dimension: 750,
#     z_dimension: 370
#   },
#   {
#     name: "Classic Table",
#     furniture_type: "table",
#     price: 39000,
#     color: "#ffffff",
#     shop_name: "Francfranc",
#     shop_item_id: "032",
#     shop_url: "https://francfranc.com/products/1108100069404",
#     photo: "https://francfranc.com/cdn/shop/products/1108100069404_A_x600.jpg?v=1579159805",
#     x_dimension: 850,
#     y_dimension: 750,
#     z_dimension: 380
#   },
#   {
#     name: "Coffee Table",
#     furniture_type: "table",
#     price: 29800,
#     color: "#ffffff",
#     shop_name: "Francfranc",
#     shop_item_id: "033",
#     shop_url: "https://francfranc.com/products/1108100069305",
#     photo: "https://francfranc.com/cdn/shop/products/1108100069305_A_x600.jpg?v=1579159804",
#     x_dimension: 850,
#     y_dimension: 450,
#     z_dimension: 380
#   },
#   {
#     name: "Round Coffee Table",
#     furniture_type: "table",
#     price: 18240,
#     color: "#ffffff",
#     shop_name: "Francfranc",
#     shop_item_id: "034",
#     shop_url: "https://francfranc.com/products/1108100014411",
#     photo: "https://francfranc.com/cdn/shop/products/1108100014411_d1_x600.jpg?v=1660888600",
#     x_dimension: 850,
#     y_dimension: 450,
#     z_dimension: 380
#   },
#   {
#     name: "Modern Coffee Table",
#     furniture_type: "table",
#     price: 35000,
#     color: "#000000",
#     shop_name: "Francfranc",
#     shop_item_id: "035",
#     shop_url: "https://francfranc.com/products/9108100068308",
#     photo: "https://francfranc.com/cdn/shop/products/9108100068308_A_x600.jpg?v=1579159521",
#     x_dimension: 850,
#     y_dimension: 450,
#     z_dimension: 380
#   },
#   {
#     name: "LANGSTED Rug",
#     furniture_type: "rug",
#     price: 7999,
#     color: "#c59642",
#     shop_name: "IKEA",
#     shop_item_id: "036",
#     shop_url: "https://www.ikea.com/jp/ja/p/langsted-rug-low-pile-yellow-00408056/?source=google&medium=cpc&campaign=ikea_jp_jp_p_shopping_fy21&gad_source=1&gclid=Cj0KCQiA84CvBhCaARIsAMkAvkLYbhf34LfCVwgFNBUIQuTW4ALY7n-BrFR-O2oLIC4FN8jbfXBO6b0aAiCKEALw_wcB",
#     photo: "https://www.ikea.com/jp/ja/images/products/langsted-rug-low-pile-yellow__0893589_pe726546_s5.jpg?f=xl",
#     x_dimension: 195,
#     y_dimension: 13,
#     z_dimension: 133
#   },
#   {
#     name: "STOENSE Rug",
#     furniture_type: "rug",
#     price: 19990,
#     color: "#0b4189",
#     shop_name: "IKEA",
#     shop_item_id: "037",
#     shop_url: "https://www.ikea.com/jp/ja/p/stoense-rug-low-pile-blue-20562377/?source=google&medium=cpc&campaign=ikea_jp_jp_p_shopping_fy21&gad_source=1&gclid=Cj0KCQiA84CvBhCaARIsAMkAvkLZ8oA2uYQM-ly_1lJpVcDcyAq9UTyyb4GSBBdraYOb5RKm348DFgYaAiIaEALw_wcB",
#     photo: "https://www.ikea.com/jp/ja/images/products/stoense-rug-low-pile-blue__1201729_pe905717_s5.jpg?f=xs",
#     x_dimension: 195,
#     y_dimension: 18,
#     z_dimension: 195
#   },
#   {
#     name: "GURLI Cushion",
#     furniture_type: "cushion",
#     price: 399,
#     color: "#c59642",
#     shop_name: "IKEA",
#     shop_item_id: "038",
#     shop_url: "https://www.ikea.com/jp/ja/p/gurli-cushion-cover-golden-yellow-00395822/?source=google&medium=cpc&campaign=ikea_jp_jp_p_shopping_fy21&gad_source=1&gclid=Cj0KCQiA84CvBhCaARIsAMkAvkLCCmijI9r4UA0Xoe9mOTn38YnepfcU2laVp1dW7h_Fzje12-cMXUIaAiR8EALw_wcB",
#     photo: "https://www.ikea.com/jp/ja/images/products/gurli-cushion-cover-golden-yellow__0544894_pe655202_s5.jpg?f=xs",
#     x_dimension: 50,
#     y_dimension: 5,
#     z_dimension: 50
#   }
# ]

# items.each do |item|
#   p item
#   instance = Item.new(item)
#   p instance
#   p instance.valid?
#   instance.save
# end

# p room1
# Wishlist.create(room: room1, item: Item.all[0])
# Wishlist.create(room: room1, item: Item.all[1])
# Wishlist.create(room: room2, item: Item.all[2])
# Wishlist.create(room: room2, item: Item.all[3])
# Wishlist.create(room: room3, item: Item.all[4])
# Wishlist.create(room: room3, item: Item.all[5])
# Wishlist.create(room: room3, item: Item.all[6])

# Planner.create(room: room1, item: Item.all[0])
# Planner.create(room: room1, item: Item.all[1])
# Planner.create(room: room2, item: Item.all[2])
# Planner.create(room: room2, item: Item.all[3])
# Planner.create(room: room3, item: Item.all[4])
# Planner.create(room: room3, item: Item.all[5])
# Planner.create(room: room3, item: Item.all[6])

# puts "Seeds generated"
