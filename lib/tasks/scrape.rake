namespace :scrape do

  task houses: :environment do
    url = 'https://www.yapo.cl/los_rios/arrendar?ca=11_s&l=0&w=1&cmn=243&ps=3&pe=5'
    HousesSpider.process(url)
  end

end
