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
    browser.goto("https://francfranc.com/search?color%5B0%5D=%E3%82%B0%E3%83%AC%E3%83%BC&color%5B1%5D=%E3%83%94%E3%83%B3%E3%82%AF&color%5B2%5D=%E3%83%9B%E3%83%AF%E3%82%A4%E3%83%88&color%5B3%5D=%E3%83%96%E3%83%A9%E3%82%A6%E3%83%B3&color%5B4%5D=%E3%82%B0%E3%83%AA%E3%83%BC%E3%83%B3&color%5B5%5D=%E3%83%96%E3%83%AB%E3%83%BC&facet%5B0%5D=%E3%83%AD%E3%83%BC%E3%82%BD%E3%83%95%E3%82%A1%E3%83%BB%E3%83%95%E3%83%AD%E3%82%A2%E3%82%BD%E3%83%95%E3%82%A1&facet%5B1%5D=%E3%83%95%E3%82%A1%E3%83%96%E3%83%AA%E3%83%83%E3%82%AF%E3%82%BD%E3%83%95%E3%82%A1&facet%5B2%5D=%E3%82%A2%E3%83%BC%E3%83%A0%E3%83%AC%E3%82%B9%E3%82%BD%E3%83%95%E3%82%A1&facet%5B3%5D=2%E4%BA%BA%E6%8E%9B%E3%81%91%E3%82%BD%E3%83%95%E3%82%A1&facet%5B4%5D=1%E4%BA%BA%E6%8E%9B%E3%81%91%E3%82%BD%E3%83%95%E3%82%A1&facet%5B5%5D=%E3%82%B3%E3%83%BC%E3%83%8A%E3%83%BC%E3%82%BD%E3%83%95%E3%82%A1&facet%5B6%5D=%E3%82%AB%E3%82%A6%E3%83%81%E3%82%BD%E3%83%95%E3%82%A1&facet%5B7%5D=%E3%82%A2%E3%83%BC%E3%83%A0%E3%82%BD%E3%83%95%E3%82%A1&facet%5B8%5D=%E3%82%AA%E3%83%83%E3%83%88%E3%83%9E%E3%83%B3&facet%5B9%5D=3%E4%BA%BA%E6%8E%9B%E3%81%91%E3%82%BD%E3%83%95%E3%82%A1&q=sofa&tag%5B0%5D=-out_of_stock")

    browser.elements(class: 'c-product-card__title').wait_until(message: "ジェム スツール ホワイト")
    browser.scroll.to(:bottom)
        #browser.elements(class: 'ais-Hits-list').map do |result|
    browser.elements(class: 'ais-Hits-item').map do |card|
      p card.element(class: 'c-product-card__title').innertext.gsub(/[\p{Punct}\p{Digit}]/, '')
      item = Item.find_or_initialize_by(shop_url: card.element(tag_name: 'a').attribute_value(:href))
      item.update(
        {
          name: card.element(class: 'c-product-card__title').innertext.gsub(/[\p{Punct}\p{Digit}]/, ''),
          photo: card.element(tag_name: 'img').attribute_value(:src),
          price: card.element(class: 'c-product-card-price medium').innertext.gsub(/\D+/, ""),
          color: "#e5c6c2",
          furniture_type: "sofa",
          shop_name: "francfranc",
          shop_item_id: (1000..2000).to_a.sample
        }
      )
    end

    browser.close
  end
end
