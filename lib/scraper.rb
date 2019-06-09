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
    
    student_info = {}
    
    doc.css("div.social-icon-container a").each do |link_data| 
      link = link_data.attribute("href").value
      if link.include?("twitter") == true
        student_info[:twitter] = link
      elsif link.include?("linkedin") == true
        student_info[:linkedin] = link
      elsif link.include?("github") == true
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info[:profile_quote] = doc.css("div.profile-quote").text
    student_info[:bio] = doc.css("p").text
    student_info
  end
end