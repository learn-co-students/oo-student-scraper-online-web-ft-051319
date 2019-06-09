require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    roster = {}
    
    doc.css("div.student-car").each do |student|
      roster[:name] = student.css("h4").text
      roster[:location] = student.css("p").text
      roster[:profile_url] = student.css("a")[0].attribute("href").value
    end
  
    # {name: , location: , profile_url: }
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

