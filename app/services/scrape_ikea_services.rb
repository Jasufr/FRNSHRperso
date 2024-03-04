class ScrapeIkeaService
  require "nokogiri"
  require "open-uri"
  url = "https://www.ikea.com/jp/en/"
  html = URI.open(url)
  doc = Nokogiri::HTML.parse(html)

  def call
    element = doc.search()
  end
end
# ScrapeIkeaService.new.call (create a rake task for it)
