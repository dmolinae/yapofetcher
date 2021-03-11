class HousesSpider < Kimurai::Base

  MONTHS = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic']

  @name = 'HousesSpider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//table[@class='listing_thumbs']/tr").each do |house|

      yapo_date = house.css('span.date')&.text
      yapo_time = house.css('span.hour')&.text

      identifiers = {
        title: house.css('a.title')&.text&.squish,
        price: house.css('span.price')&.text&.squish.gsub('$ ','').gsub('.','').to_i,
        rooms: house.css('span.icons__element-text')&.text&.squish.first.to_i
      }
      
      next if identifiers[:title] == ''

      entire_house = identifiers.merge({
        publish_date: parse_yapo_datetime(yapo_date, yapo_time),
        url:   house.css('a.title').first.present? ? house.css('a.title').first.attributes["href"].value : 'not found'
      })

      House.create(entire_house) if House.where(identifiers).empty?
    end
  end

  def parse_yapo_datetime(yapo_date, yapo_time)
    hour = yapo_time.split(':').first.to_i
    min = yapo_time.split(':').last.to_i

    case yapo_date
    when "Hoy"
      DateTime.now.change(hour: hour, min: min)
    when "Ayer"
      DateTime.now.yesterday.change(hour: hour, min: min)
    else
      splitted = yapo_date.split(' ')

      day   = splitted.first.to_i
      month = MONTHS.index(splitted.last.downcase) + 1

      DateTime.now.change(day: day, month: month)
    end
  end
end
