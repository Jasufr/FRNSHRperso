require 'open-uri'
require "nokogiri"
require 'watir'
require 'colorscore'

namespace :color_analyze do
  desc "COLOR"
  task items: :environment do
    browser = Watir::Browser.new
    browser.goto('https://francfranc.com/search?q=sofa')
    images = []
    browser.elements(class: 'c-product-card__image').each do |card|
      card.elements(tag_name: 'img').each do |image|
        Watir::Wait.until { image.src.present? }
        images << image.src
      end
    end

    browser2 = Watir::Browser.new
    browser2.goto('https://www.colorpoint.io/free-tools-for-developers/color-palette-from-image-url/')
    images.each do |image|
      
    end
  end
end
