require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url) #=> index_url = "../fixtures/student-site/index.html"
    list = Nokogiri::HTML(html)

    # This block returns a list of student names
    names = list.css(".student-name")
    names_array = []
    names.each do |item|
      names_array << item.text
    end
    names_array

    # This block returns a list of locations.
    locations = list.css(".student-location")
    location_array = []
    locations.each do |item|
      location_array << item.text
    end
    location_array

    # This block returns a list of student HTML pages.
    webpages = list.css(".student-card a[href]")
    webpage_array = []
    webpages.select do |item|
      webpage_array << item['href']
    end
    webpage_array


    master_array = []
    hash = {}
    x = 0
    names_array.each do |name|
      master_array << {:name => name, :location => location_array[x], :profile_url => webpage_array[x]}
      x = x + 1
    end
    master_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    
     profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end

    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile
  end

end

