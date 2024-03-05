namespace :export do
  desc "Export items to CSV file"
  task items: :environment do
    require 'csv'

    items = Item.all

    CSV.open("items.csv", "w") do |csv|
      csv << ["name", "furniture_type", "price", "color", "shop_name", "shop_item_id", "shop_url", "x_dimension", "y_dimension", "z_dimension", "photo"]
      items.each do |item|
        csv << [item.name, item.furniture_type, item.price, item.color, item.shop_name, item.shop_item_id, item.shop_url, item.x_dimension, item.y_dimension, item.z_dimension, item.photo]
      end
    end

    puts "Items exported to items.csv"
  end
end
