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
    browser.goto("https://francfranc.com/search?color%5B0%5D=%E3%83%94%E3%83%B3%E3%82%AF&color%5B1%5D=%E3%83%96%E3%83%AB%E3%83%BC&color%5B2%5D=%E3%83%91%E3%83%BC%E3%83%97%E3%83%AB&color%5B3%5D=%E3%82%B0%E3%83%AA%E3%83%BC%E3%83%B3&color%5B4%5D=%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC&color%5B5%5D=%E3%82%AA%E3%83%AC%E3%83%B3%E3%82%B8&q=%E3%82%AF%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3&tag%5B0%5D=-out_of_stock&price_ratio=le0.95")

    browser.elements(class: 'c-product-card__title').wait_until(message: "EMBオーナメント クッションカバー 600×600 ブルー （F-133）")
    browser.scroll.to(:bottom)
        #browser.elements(class: 'ais-Hits-list').map do |result|
    browser.elements(class: 'ais-Hits-item').map do |card|
      p card.element(class: 'c-product-card__title').innertext
      item = Item.find_or_initialize_by(shop_url: card.element(tag_name: 'a').attribute_value(:href))
      item.update(
        {
          name: card.element(class: 'c-product-card__title').innertext,
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
