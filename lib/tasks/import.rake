namespace :import do
  desc "Import items from CSV file"
  task items: :environment do
    require 'csv'

    # Specify the path to your CSV file
    csv_file_path = "items.csv"

    CSV.foreach(csv_file_path, headers: true) do |row|
      item_attributes = row.to_hash

      # Create a new Item record using the attributes from the CSV file
      Item.create(item_attributes)
    end

    puts "Items imported from #{csv_file_path}"
  end
end
