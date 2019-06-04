require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)



    doc.css(".student-card").map do |student|
      students_hash = {}
      students_hash[:name] = student.css("h4.student-name").text
      students_hash[:location] = student.css("p").text
      students_hash[:profile_url] = student.css("a").attr('href').text
      students_hash
    end


    # doc.css(".student-card").first
    #student_name = doc.css(".student-card").first.css("h4").text
    #student_location = doc.css(".student-card").first.css("p").text
    #student_URL = doc.css(".student-card a").attr('href').text

  end

    Scraper.scrape_index_page("./fixtures/student-site/index.html")

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    # twitter = doc.css(".social-icon-container").css("a")[0].attr("href")
    # linkedin =  doc.css(".social-icon-container").css("a")[1].attr("href")
    # github =  doc.css(".social-icon-container").css("a")[2].attr("href")
    # blog url =  doc.css(".social-icon-container").css("a")[3].attr("href")




    binding.pry

    # twitter url:
    # linkedin url:
    # github url:
    # blog url:
    # profile quote:
    # bio:

  end
  Scraper.scrape_index_page("./fixtures/student-site/students/eric-chu.html")


end
