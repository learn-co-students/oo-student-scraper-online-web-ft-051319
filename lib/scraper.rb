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
    
    link = doc.css("div.social-icon-container a").attribute("href").value
    binding.pry
    if link.include?("twitter") == true
      student_info[:twitter] = link
    elsif link.include?("linkedin") == true
      student_info[:linkedin] = link
    elsif link.include?("github") == true
      student_info[:github] = link
    else
      student_info[:blog] = link
    end
      
   
    # doc.css("div.social-icon-container a img")each_with_index
    
    
    
    # if doc.css("div.social-icon-container a img") include?(http://178.128.14.28:58884/fixtures/student-site/assets/img/twitter-icon.png)
    # end
    
   
    # student_info[:linkedin] = doc.css()
    # student_info[:github] = 
    # student_info[:blog] = 
    # student_info[:profile_quote] =
    student_info
    
  end

  

end

# doc.css("div.social-icon-container a").attribute("href").value 