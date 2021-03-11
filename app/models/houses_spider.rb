class HousesSpider < Kimurai::Base
  @name = 'HousesSpider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//table[@class='listing_thumbs']/tr").each do |house|

      item = {
        title: house.css('a.title')&.text&.squish,
        price: house.css('span.price')&.text&.squish.gsub('$ ','').gsub('.','').to_i,
        rooms: house.css('span.icons__element-text')&.text&.squish.first.to_i,
        url:   house.css('a.title').first.present? ? house.css('a.title').first.attributes["href"].value : 'not found'
      }

      House.where(item).first_or_create
    end
  end
end
