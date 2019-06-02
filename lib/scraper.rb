require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    student_array = []
    page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_profile = {:name => name, :location => location, :profile_url => profile_url}
      student_array << student_profile
      end
    student_array
   end


  def self.scrape_profile_page(profile_url)
      page = Nokogiri::HTML(open(profile_url))
      student_hash = {}
      container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student_hash[:twitter] = link
        elsif link.include?("linkedin")
          student_hash[:linkedin] = link
        elsif link.include?("github")
          student_hash[:github] = link
        elsif link.include?(".com")
          student_hash[:blog] = link
        end
      end
      student_hash[:profile_quote] = page.css(".profile-quote").text
      student_hash[:bio] = page.css("div.description-holder p").text
      student_hash
    end
  end
