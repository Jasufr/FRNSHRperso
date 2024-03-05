module PlannersHelper
  def hue_from_hex(hex)
    color = Color::RGB.by_hex(hex)
    hsl_color = color.to_hsl
    hue = hsl_color.h * 360 # Convert hue from [0, 1] range to [0, 360] degrees
    hue.round(2)
  end

  def saturation_from_hex(hex)
    color = Color::RGB.by_hex(hex)
    hsl_color = color.to_hsl
    saturation = hsl_color.s
    saturation.round(2)
  end

  def value_from_hex(hex)
    color = Color::RGB.by_hex(hex)
    hsl_color = color.to_hsl
    value = hsl_color.l
    value.round(2)
  end
end
