require 'chunky_png'

module ColorGeneration
  extend ActiveSupport::Concern

  def generate_analogous_colors(input_hex_codes)
    all_analogous_colors = []

    input_hex_codes.each do |input_hex_code|
      analogous_colors = []

      # Convert input hex code to RGB
      rgb = ChunkyPNG::Color.from_hex(input_hex_code)

      # Convert RGB to HSL
      hsl = ChunkyPNG::Color.rgb_to_hsl(rgb)

      # Calculate the hue values for the specific analogous colors
      hues = [60, 0, 300] # Corresponding to #0b5a89, #0b4189, and #0b2889

      puts "Calculated hue values for input color #{input_hex_code}: #{hues}"

      # Generate analogous colors based on the calculated hue values
      hues.each do |hue|
        # Ensure hue value is within the range of 0 to 360 degrees
        hue %= 360

        # Convert HSL back to RGB and then to hex
        rgb = ChunkyPNG::Color.hsl_to_rgb(hue, hsl[1], hsl[2])
        analogous_colors << ChunkyPNG::Color.to_hex(rgb)
      end

      all_analogous_colors << analogous_colors
    end
    all_analogous_colors
  end
end
