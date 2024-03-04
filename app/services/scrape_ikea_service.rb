class ScrapeIkeaService
  require "nokogiri"
  require "open-uri"
  def initialize
    url = "https://www.ikea.com/jp/en/"
    # url = "https://www.ikea.com/jp/en/search/?q=bed"
    # url = "https://www.ikea.com/jp/en/cat/beds-bm003/"
    # url = "https://ikea.com/jp/en/p/grimsbu-bed-frame-white-90577196/#content"
    # url = "https://www.ikea.com/jp/en/p/barsloev-3-seat-sofa-bed-with-chaise-longue-tibbleby-light-grey-turquoise-30541577/"
    # url = "https://www.ikea.com/jp/en/p/kleppstad-wardrobe-with-3-doors-white-80441759/"

    html = URI.open(url)
    @doc = Nokogiri::HTML.parse(html)
  end

  def call
    scrape_room_type_urls
    # scrape_items_urls
  end

  private

  def scrape_room_type_urls
    # p "scraping room types"
    room_type_urls = @doc.search(".hnf-tabs-navigation__card--rooms")
    # room_type_urls = @doc.search(".hnf-carousel-slide a")
    room_type_urls.first(2).map do |room_type_url|
      p new_url = room_type_url["href"]
      scrape_items_type_urls(new_url)
    end
  end

  def scrape_items_type_urls(url)
    p "def scrape_items_type_urls"
    html = URI.open(url)
    @doc = Nokogiri::HTML.parse(html)
    # items_type_urls = @doc.search(".hnf-tabs-navigation__card--products")
    items_type_urls = @doc.search(".hnf-carousel__body .hnf-carousel-slide a")
    # p items_type_urls
    items_type_urls.first(2).map do |item_type_url|
      p new_url = item_type_url["href"]
      # scrape_items_urls(new_url)
    end
  end

  # def scrape_items_urls#(url)
  #   p "def scrape_items_urls"
  #   # html = URI.open(url)
  #   # @doc = Nokogiri::HTML.parse(html)
  #   # p items_urls = @doc.search(".pip-product-compact a")
  #   p items_urls = @doc.search(".plp-mastercard__item a")
  #   items_urls.first(2).map do |item_url|
  #     p new_url = item_url["href"]
  #     scrape_item(new_url)
  #   end
  # end

  # def scrape_item(url)
  #   p "def scrape_item"
  #   html = URI.open(url)
  #   @doc = Nokogiri::HTML.parse(html)
  #   colors = ["white", "grey", "black", "beige", "turquoise", "brown"]
  #   types = ["bed", "wardrobe", "cushion", "blanket", "throw", "chest", "storage", "bedside", "side", "cabinet", "shelf", "desk", "sofa", "armchair", "chair", "bookcase", "tv", "coffee", "curtains", "sideboard", "table", "bathroom", "wash", "outside", "bench"]
  #   color = []
  #   furniture_type = []
  #   p name = @doc.search(".pip-header-section__title--big").text.strip
  #   p price = @doc.search(".pip-temp-price__integer").text.strip
  #   p width = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm").select! { |element| element.start_with?("Width") }[0].match(/\d+/)[0]
  #   p length = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm").select! { |element| element.start_with?("Length") || element.start_with?("Depth") }[0].match(/\d+/)[0]
  #   p height = @doc.search(".pip-product-dimensions__measurement-wrapper").text.strip.split("cm").select! { |element| element.start_with?("Height") }[0].match(/\d+/)[0]
  #   item_title = @doc.search(".pip-header-section__description-text").text.strip.split(/[^a-zA-Z]/)
  #   p item_title
  #   item_title.each do |title_word|
  #     if colors.include?(title_word)
  #       color << title_word
  #     end
  #   end
  #   item_title.each do |title_word|
  #     if types.include?(title_word.downcase!)
  #       furniture_type << title_word
  #     end
  #   end
  #   p shop_url = url
  #   p photo = @doc.search(".pip-image").attribute("src").value
  #   p shop_item_id = @doc.search(".pip-product-identifier__value")[0].text.strip

  #   p item_infos = {
  #     name: name,
  #     price: price,
  #     x_dimension: width,
  #     z_dimension: length,
  #     y_dimension: height,
  #     color: color,
  #     furniture_type: furniture_type,
  #     shop_url: shop_url,
  #     photo: photo,
  #     shop_item_id: shop_item_id,
  #   }

  #   item = Item.find_or_initialize_by(shop_item_id: shop_item_id)
  #   item.update!(item_infos)
  # end
end
