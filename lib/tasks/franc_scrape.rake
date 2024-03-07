require 'open-uri'
require "nokogiri"
require 'watir'
require 'colorscore'
require "csv"

namespace :scrape do
  desc "TODO"
  task francfranc: :environment do
    browser = Watir::Browser.new #:chrome, headless: true

    # colors = {
    #   グレー: "#c5bdbd",
    #   ピンク: "#e5c6c2",
    #   ホワイト: "#ffffff",
    #   ベージュ: "#a8917a",
    #   ブルー: "#617f86",
    #   ブラック: "#000000",
    #   ブラウン: "#392e25"
    # }

    #colors.each do |color_name, hex|
    #p "https://francfranc.com/search?color%5B0%5D=ブルー&q=sofa"
    browser.goto("https://francfranc.com/search?facet%5B0%5D=%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%AB%E3%83%90%E3%83%BC45x45cm&facet%5B1%5D=%E3%83%95%E3%83%AD%E3%82%A2%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3&facet%5B2%5D=%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%AB%E3%83%90%E3%83%BC60x60cm&facet%5B3%5D=%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%9C%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3&page=2&q=%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3&tag%5B0%5D=-out_of_stock&price_ratio=le0.95")

    browser.elements(class: 'c-product-card__title').wait_until(message: "ベルベットギャザー クッションカバー 450×450 オレンジ（B-070）")
    browser.scroll.to(:bottom)
        #browser.elements(class: 'ais-Hits-list').map do |result|
    browser.elements(class: 'ais-Hits-item').map do |card|
      p card.element(class: 'c-product-card__title').innertext.gsub(/[\p{Punct}\p{Digit}]/, '')
      item = Item.find_or_initialize_by(shop_url: card.element(tag_name: 'a').attribute_value(:href))
      item.update(
        {
          name: card.element(class: 'c-product-card__title').innertext.gsub(/[\p{Punct}\p{Digit}]/, ''),
          photo: card.element(tag_name: 'img').attribute_value(:src),
          price: card.element(class: 'c-product-card-price sale medium').innertext.gsub(/\D+/, ""),
          color: "#e5c6c2",
          furniture_type: "cushion",
          shop_name: "francfranc"
        }
      )
    end

    browser.close
  end
end
