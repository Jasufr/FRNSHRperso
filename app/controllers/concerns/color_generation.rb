module ColorGeneration
  extend ActiveSupport::Concern

  def generate_color_range(hex_codes, num_colors, step_factor)
    colors = []

    hex_codes.each do |hex_code|
      rgb = Color::RGB.by_hex(hex_code)

      # Calculate step size for each RGB component
      step_r = 255 / (num_colors * step_factor)
      step_g = 255 / (num_colors * step_factor)
      step_b = 255 / (num_colors * step_factor)

      num_colors.times do |i|
        r = [rgb.r + step_r * i, 255].min
        g = [rgb.g + step_g * i, 255].min
        b = [rgb.b + step_b * i, 255].min
        colors << Color::RGB.new(r, g, b).html
      end
    end

    colors
  end
end
