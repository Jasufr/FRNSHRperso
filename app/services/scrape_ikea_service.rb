class ScrapeIkeaService
  require "nokogiri"
  require "open-uri"
  require "watir"

  def initialize
    # url = "https://www.ikea.com/jp/en/"
    # url = "https://www.ikea.com/jp/en/search/?q=bed"
    # url = "https://www.ikea.com/jp/en/cat/beds-bm003/"
    # url = "https://ikea.com/jp/en/p/grimsbu-bed-frame-white-90577196/#content"
    # url = "https://www.ikea.com/jp/en/p/barsloev-3-seat-sofa-bed-with-chaise-longue-tibbleby-light-grey-turquoise-30541577/"
    # url = "https://www.ikea.com/jp/en/p/kleppstad-wardrobe-with-3-doors-white-80441759/"

    # "https://www.ikea.com/jp/en/cat/sofas-fu003/", "https://www.ikea.com/jp/en/cat/armchairs-chaise-longues-fu006/", "https://www.ikea.com/jp/en/cat/bookcases-shelving-units-st002/", "https://www.ikea.com/jp/en/cat/tv-media-furniture-10475/", "https://www.ikea.com/jp/en/cat/coffee-side-tables-10705/"

    # @item_category_page_urls = ["https://www.ikea.com/jp/en/cat/beds-bm003/", "https://www.ikea.com/jp/en/cat/wardrobes-19053/", "https://www.ikea.com/jp/en/cat/cushions-cushion-covers-10659/"]
      #"https://www.ikea.com/jp/en/cat/chests-of-drawers-10451/","https://www.ikea.com/jp/en/cat/bedside-tables-20656/", "https://www.ikea.com/jp/en/cat/sofas-fu003/", "https://www.ikea.com/jp/en/cat/armchairs-chaise-longues-fu006/", "https://www.ikea.com/jp/en/cat/bookcases-shelving-units-st002/", "https://www.ikea.com/jp/en/cat/cabinets-cupboards-st003/", "https://www.ikea.com/jp/en/cat/tv-media-furniture-10475/", "https://www.ikea.com/jp/en/cat/coffee-side-tables-10705/", "https://www.ikea.com/jp/en/cat/rugs-10653/", "https://www.ikea.com/jp/en/cat/curtains-blinds-tl002/" ]
    # bedroom: bed, wardorbe, cushion, chest, bedside table
    # living: sofa, armchair chair,

    # html = URI.open(url)
    # @doc = Nokogiri::HTML.parse(html)

    @living_room_item_category_page_urls = ["https://www.ikea.com/jp/en/cat/rugs-10653/", "https://www.ikea.com/jp/en/cat/curtains-blinds-tl002/", "https://www.ikea.com/jp/en/cat/cushions-cushion-covers-10659/"]
  end

  def call
    # scrape_room_type_urls
    # @item_category_page_urls.each do |url|
    #   scrape_items_urls(url)
    # end
    @living_room_item_category_page_urls.each do |url|
      scrape_items_urls(url)
    end
    # scrape_items_urls
  end

  private

  # def scrape_room_type_urls
  #   # p "scraping room types"
  #   room_type_urls = @doc.search(".hnf-tabs-navigation__card--rooms")
  #   # room_type_urls = @doc.search(".hnf-carousel-slide a")
  #   room_type_urls.first(2).map do |room_type_url|
  #     p new_url = room_type_url["href"]
  #     scrape_items_type_urls(new_url)
  #   end
  # end

  # def scrape_items_type_urls(url)
  #   p "def scrape_items_type_urls"
  #   html = URI.open(url)
  #   @doc = Nokogiri::HTML.parse(html)
  #   # items_type_urls = @doc.search(".hnf-tabs-navigation__card--products")
  #   items_type_urls = @doc.search(".hnf-carousel__body .hnf-carousel-slide a")
  #   # p items_type_urls
  #   items_type_urls.first(2).map do |item_type_url|
  #     p new_url = item_type_url["href"]
  #     # scrape_items_urls(new_url)
  #   end
  # end

  def scrape_items_urls(url)
    # browser = Watir::Browser.new
    # browser.goto(url)

    p "def scrape_items_urls"
    # sleep(3)
    html = URI.open(url)
    @doc = Nokogiri::HTML.parse(html)
    p items_urls = @doc.search(".pip-product-compact a.pip-product-compact a", ".plp-product-thumbnail")
    # p items_urls = @doc.search(".plp-product-thumbnail")
    # p items_urls = @doc.search(".plp-mastercard__item a")
    items_urls.map do |item_url|
      p new_url = item_url["href"]
      scrape_item(new_url)
    end
  end

  def scrape_item(url)
    p "def scrape_item"
    html = URI.open(url)
    @doc = Nokogiri::HTML.parse(html)
    colors = ["white", "grey", "black", "anthracite", "beige", "turquoise", "brown", "green", "blue", "yellow", "red", "pink", "oak"]
    types = ["bed", "wardrobe", "cushion", "blanket", "throw", "chest", "storage", "bedside", "side", "cabinet", "shelf", "desk", "sofa", "armchair", "chair", "bookcase", "tv", "coffee", "curtains", "sideboard", "table", "bathroom", "wash", "outside", "bench", "curtain", "curtains", "rug", "shelving", "box"]
    # types = {"sofa" => "sofa", "seats section" => "sofa"}
    color = []
    furniture_type = []
    p name = @doc.search(".pip-header-section__title--big").text.strip
    p price = @doc.search(".pip-temp-price__integer")[0].text.gsub(/\D+/, "")
    p width_elem = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm")

    return if width_elem.select { |element| element.start_with?("Width") }.empty?

    p width = width_elem.select { |element| element.start_with?("Width") }[0].match(/\d+/)[0]



    p length_elem = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm")

    return if length_elem.select { |element| element.start_with?("Length") || element.start_with?("Depth") }.empty?

    p length = length_elem.select { |element| element.start_with?("Length") || element.start_with?("Depth") }[0].match(/\d+/)[0]

    p height_elem = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm")

    return if height_elem.select { |element| element.start_with?("Height") }.empty?

    p height = height_elem.select { |element| element.start_with?("Height") }[0].match(/\d+/)[0]

    item_title = @doc.search(".pip-header-section__description-text")[0].text.strip.split(/[^a-zA-Z]/)
    original_item_title = @doc.search(".pip-header-section__description-text")[0].text.strip
    p item_title
    item_title.each do |title_word|
      if colors.include?(title_word.downcase)
        color << title_word.downcase
      end
    end
    item_title.each do |title_word|
      if types.include?(title_word.downcase)
        furniture_type << title_word.downcase
      # elsif original_item_title.downcase.include?("seat section")
      #   furniture_type << "Sofa"
      # elsif original_item_title.downcase.include?("blind")
      #   furniture_type << "Curtain"
      end
    end

    if original_item_title.downcase.include?("seat section")
      furniture_type << "Sofa"
    elsif original_item_title.downcase.include?("blind")
      furniture_type << "Curtain"
    end


    p shop_url = url
    p photo = @doc.search(".pip-image").attribute("src")&.value
    return unless photo

    p shop_item_id = @doc.search(".pip-product-identifier__value")[0].text.strip
    p color
    return if color.empty?
    color = PairColorsIkea.new(color.last.downcase).call

    p item_infos = {
      name: name,
      price: price,
      x_dimension: width,
      z_dimension: length,
      y_dimension: height,
      color: color,
      furniture_type: furniture_type.join,
      shop_url: shop_url,
      shop_name: "IKEA",
      photo: photo,
      shop_item_id: shop_item_id,
    }

    item = Item.find_or_initialize_by(shop_item_id: shop_item_id)
    item.update(item_infos)
  end
end
