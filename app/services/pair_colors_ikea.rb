class PairColorsIkea
  def initialize(color)
    @color = color
    @colors = {
      "white" => "#ffffff",
      "grey" => "#808080",
      "black" => "#000000",
      "anthracite" => "#000000",
      "beige" => "#fff2cc",
      "turquoise" => "#40e0d0",
      "brown" => "#783f04",
      "oak" => "#783f04",
      "green" => "#008000",
      "blue" => "#0000ff",
      "yellow" => "#ffff00",
      "red" => "#ff0000",
      "pink" => "#ffc0cb"
    }
  end

  def call
    @colors[@color]
  end
end
