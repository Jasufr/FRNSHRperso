require 'json'
require 'open-uri'
require "nokogiri"
require 'watir'
require 'colorscore'

namespace :color_analyze do
  desc "COLOR"
  task items: :environment do
    browser = Watir::Browser.new
    browser.goto('https://francfranc.com/collections/sofa?color%5B0%5D=%E3%83%94%E3%83%B3%E3%82%AF&color%5B1%5D=%E3%83%96%E3%83%AB%E3%83%BC&color%5B2%5D=%E3%82%B0%E3%83%AA%E3%83%BC%E3%83%B3')
    images = []
    browser.elements(class: 'c-product-card__image').each do |card|
      card.elements(tag_name: 'img').each do |element|
        Watir::Wait.until { element.src.present? }
        images << element.src
      end
    end

    p images
    browser2 = Watir::Browser.new
    browser2.goto('https://www.colorpoint.io/free-tools-for-developers/color-palette-from-image-url/')
    rgb_colors = []
    images.each do |image|
      sleep(5)
      browser2.input(id: "inputImageUrl").set image
      browser2.send_keys :enter
      sleep(8)
      rgb = browser2.element(id: "dominant-rgb").innertext
      rgb_colors << rgb
      p rgb
      #browser2.input(id: "inputImageUrl").
    end

    rgb_colors.each do |rgb_color|
      url = "https://www.thecolorapi.com/id?rgb=#{rgb_color}"
      color_serialized = URI.open(url).read
      color = JSON.parse(color_serialized)
      hex_hash = color["hex"]
      hex_code = hex_hash["value"]
      p hex_code
    end
  end
end
