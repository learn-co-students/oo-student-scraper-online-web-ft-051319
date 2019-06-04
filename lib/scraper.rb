require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)


    students = []
    doc.css(".student-card").map do |student|
      students_hash = {}
      students_hash[:name] = student.css("h4.student-name").text
      students_hash[:location] = student.css("p").text
      students_hash[:profile_url] = student.css("a").attr('href').text
      students << students_hash
    end
    students



    # doc.css(".student-card").first
    #student_name = doc.css(".student-card").first.css("h4").text
    #student_location = doc.css(".student-card").first.css("p").text
    #student_URL = doc.css(".student-card a").attr('href').text

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes = {}
    social_media = doc.css("div.social-icon-container a").collect{|site| site.attribute("href").value}
      social_media.each do |link|
        if link.include?("twitter")
          attributes[:twitter] = link
        elsif link.include?("linkedin")
          attributes[:linkedin] = link
        elsif link.include?("github")
        attributes[:github] = link
      elsif link.include?(".com")
        attributes[:blog] = link
      end
    end
    attributes[:profile_quote] = doc.css("div.profile-quote").text
    attributes[:bio] = doc.css("div.bio-content div.description-holder p").text
    attributes
end
end
