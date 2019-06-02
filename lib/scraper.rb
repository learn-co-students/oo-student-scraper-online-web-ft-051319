require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    students = index_page.css("div.student-card").map do |student|
      {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  html = File.read(profile_url)
  profile_page = Nokogiri::HTML(html)

  student_profile = {}
  profile_page.css(".main-wrapper").map do |profile|

  links = profile.css(".vitals-container").children.css("a").map { |link| link.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
      student_profile[:linkedin] = link
      elsif link.include?("github")
      student_profile[:github] = link
      elsif link.include?("twitter")
      student_profile[:twitter] = link
      else
      student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = profile.css("div.profile-quote").text
    student_profile[:bio] = profile.css("div.details-container p").text
  end
  student_profile
  end

end
Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html")
