require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry


    # students_hash = {}
    #doc.css(".student-card").first
    #student_name = doc.css(".student-card").first.css("h4").text
    #student_location = doc.css(".student-card").first.css("p").text
    #student_URL = doc.css(".student-card a").attr('href').text
    end

    Scraper.scrape_index_page("./fixtures/student-site/index.html")

  def self.scrape_profile_page(profile_url)

  end

end
