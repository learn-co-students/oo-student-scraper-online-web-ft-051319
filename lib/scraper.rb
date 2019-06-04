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

    Scraper.scrape_index_page("./fixtures/student-site/index.html")

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes = {}
    doc.css("div.social-icon-container a").each do |social_media|
      case social_media
      when /twitter/
        attributes[:twitter] = social_media.attribute("href").value
      when /linkedin/
        attributes[:linkedin] = social_media.attribute("href").value
      when /github/
        attributes[:github] = social_media.attribute("href").value
      else
        attributes[:blog] = social_media.attribute("href").value
      end
      attributes[:profile_quote] = doc.css("div.profile-quote").text
      attributes[:bio] = doc.css("div.bio-content div.description-holder p").text.strip
    end
    attributes
  end
      # twitter url: doc.css("div.social-icon-container a").attr("href").value
    # linkedin url: doc.css("div.social-icon-container a")attr("href").value
    # github url:  doc.css("div.social-icon-container a").attr("href").value
    # blog url : doc.css("div.social-icon-container a").attr("href").value
    # profile quote :doc.css("div.profile-quote").text
    #bio : doc.css("div.description-holder p").text








    Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
end
