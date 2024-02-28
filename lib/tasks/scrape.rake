require 'open-uri'
require "nokogiri"

namespace :scrape do
  desc "TODO"
  task ikea: :environment do
    url = "https://www.ikea.com/jp/en/cat/tables-desks-fu004/?sort=MOST_POPULAR&filters=f-colors%3A10033%7C10152%7C10042%7C10119%7C10064%7C10112"

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    debugger
    html_doc.search(".plp-mastercard").each do |element|
    end

  end

end
