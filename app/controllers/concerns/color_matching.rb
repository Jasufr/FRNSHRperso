module ColorMatching
  extend ActiveSupport::Concern

  # Method to calculate Euclidean distance between two colors
  def color_distance(color1, color2)
    Math.sqrt((color1[:red] - color2[:red]) ** 2 + (color1[:green] - color2[:green]) ** 2 + (color1[:blue] - color2[:blue]) ** 2)
  end

  def convert_hex_to_rgb(str)
    [:red, :green, :blue].zip(str.gsub('#', '').chars.each_slice(2).to_a.map(&:join).map { |string| string.to_i(16) }).to_h
  end

  # Method to find closest matching images to user-selected colors
  def closest_matching_images(user_colors, num_images = 50)
    all_items = Item.all

    all_items.map do |item|
      item_rgb_color = convert_hex_to_rgb(item.color)

      most_similar_color = user_colors.map do |user_color|
        user_rgb_color = convert_hex_to_rgb(user_color)

        color_distance(item_rgb_color, user_rgb_color)
      end.min

      [item, most_similar_color]
    end.sort_by { |image, distance| distance }.first(num_images).map(&:first)
  end
end
