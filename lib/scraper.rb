require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  
  def self.scrape_index_page(index_url)
    students = []
    url = File.read(index_url)
    doc = Nokogiri::HTML(url)
    
   doc.css('.student-card').each do |element|
     name = element.css("h4").text
     location = element.css("p.student-location").text
     student_url = element.css("a").attr("href").text
     students << {:name => name, :location => location, :profile_url => student_url}
   end
   students
  end
  
  def self.scrape_profile_page(profile_url)
    attributes = {}
    url = File.read(profile_url)
    doc = Nokogiri::HTML(url)
  #binding.pry
    social_links = doc.css(".social-icon-container").children.css('a').map { |element| element.attribute('href').value}
   
     
     social_links.each do |link|
       if link.include?("linkedin")
         attributes[:linkedin] = link
       elsif link.include?("github")
          attributes[:github] = link
       elsif link.include?("twitter")
          attributes[:twitter] = link
       else
          attributes[:blog] = link
        end
     end
    attributes[:profile_quote] = doc.css('.profile-quote').text
    attributes[:bio] = doc.css('.description-holder p').text

attributes

end
end

