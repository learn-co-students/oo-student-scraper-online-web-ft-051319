require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    roster = []
    
    doc.css("div.student-car").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a")[0].attribute("href").value
      roster << student_hash
    end
    roster
    
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

