require 'open-uri'
require "nokogiri"
require 'watir'
require 'colorscore'
require "csv"

namespace :scrape do
  desc "TODO"
  task francfranc: :environment do
    browser = Watir::Browser.new

    colors = {
      グレー: "#c5bdbd",
      ピンク: "#e5c6c2",
      ホワイト: "#ffffff",
      ベージュ: "#a8917a",
      ブルー: "#617f86",
      ブラック: "#000000",
      ブラウン: "#392e25"
    }

    #colors.each do |color_name, hex|
    #p "https://francfranc.com/search?color%5B0%5D=ブルー&q=sofa"
    browser.goto("https://francfranc.com/search?color%5B0%5D=ブラウン&q=sofa")

    browser.elements(class: 'c-product-card__title').wait_until(message: "カラン フロアチェア S ブラウン")
    browser.scroll.to(:bottom)
        #browser.elements(class: 'ais-Hits-list').map do |result|
    browser.elements(class: 'ais-Hits-item').map do |card|
      p card.element(class: 'c-product-card__title').innertext
      item = Item.find_or_initialize_by(shop_url: card.element(tag_name: 'a').attribute_value(:href))
      item.update(
        {
          name: card.element(class: 'c-product-card__title').innertext,
          photo: card.element(tag_name: 'img').attribute_value(:src),
          price: card.element(css: '.c-product-card-price.medium').innertext.gsub(/\D+/, ""),
          color: "#392e25",
          furniture_type: "sofa",
          shop_name: "francfranc"
        }
      )
    end

    browser.close
  end
end
