require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    page = Nokogiri::HTML(open(index_url))

    page.css('div.student-card').each do |student|

      students << {name: student.css('h4.student-name').text,
      location: student.css('p.student-location').text,
      profile_url: student.css('a').attribute('href').value}
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    student_profile = {}

    page = Nokogiri::HTML(open(profile_url))

    social_container = page.css("div.social-icon-container a").collect {|x| x.attribute("href").value}

   social_container.each do |social|

     if social.include?("linkedin")
       student_profile[:linkedin] = social

     elsif social.include?("github")
       student_profile[:github] = social

     elsif social.include?("twitter")
       student_profile[:twitter] = social

     else
       student_profile[:blog] = social
   end
   end
       student_profile[:profile_quote] = page.css("div.profile-quote").text
       student_profile[:bio] = page.css("div.bio-content.content-holder p").text
   student_profile
 end
end
