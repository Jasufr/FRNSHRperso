require 'open-uri'
require "nokogiri"

namespace :scrape do
  desc "TODO"
  task ikea: :environment do
    ScrapeIkeaService.new.call
  end

end
