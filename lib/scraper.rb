require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    roster = []
    doc.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a")[0].attribute("href").value
      roster << student_hash
    end
    roster
  end
  
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    binding.pry 
    
    student_info = {}
    student_info[:linkedin] = doc.css()
    student_info[:github] = 
    student_info[:blog]
    student_info[:blog][:profile_quote]
    
  end

end

