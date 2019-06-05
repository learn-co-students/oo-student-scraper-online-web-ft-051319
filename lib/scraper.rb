# require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    students_array = []

    html.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value

      student_info = {
        :name => name,
        :location => location,
        :profile_url => profile_url
      }

      students_array << student_info
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))

    student_hash = {}

    html.css("div.social-icon-container a").each do |student|
    
      url = student.attribute("href")
  
    student_hash[:twitter] = url.value if url.value.include?("twitter")
    student_hash[:linkedin] = url.value if url.value.include?("linkedin")
    student_hash[:github] = url.value if url.value.include?("github")
    student_hash[:blog] = url.value if student.css("img").attribute("src").text.include?("rss")
    end
    student_hash[:profile_quote] = html.css("div.profile-quote").text
    student_hash[:bio] = html.css("div.description-holder p").text
student_hash
end

end

