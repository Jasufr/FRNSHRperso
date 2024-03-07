class ColorAnalyze
  require 'json'
  require 'open-uri'
  require "nokogiri"
  require 'watir'

  def initialize(image_url)
    @image_url = image_url
  end

  def call
    sleep(3)
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto("https://www.colorpoint.io/free-tools-for-developers/color-palette-from-image-url/")
    sleep(3)
    browser.input(id: "inputImageUrl").set @image_url
    browser.send_keys :enter
    sleep(2)
    Watir::Wait.until { browser.element(id: "dominant-rgb").present? }
    rgb_color = browser.element(id: "dominant-rgb").innertext

    url = "https://www.thecolorapi.com/id?rgb=#{rgb_color}"
    color_serialized = URI.open(url).read
    color = JSON.parse(color_serialized)
    hex_hash = color["hex"]
    hex_code = hex_hash["value"]
    #browser.close
    return hex_code.downcase
  end
end
