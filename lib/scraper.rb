require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
# <<<<<<< HEAD

    students_hash = {}

    doc.css(".student-card").map do |student|
      students_hash[:name] = student.css("h4").text,
      students_hash[:location] = student.css("p").text,
      students_hash[:profile_url] = student.css('href').text
      binding.pry
    end


# =======
# >>>>>>> fbbbf0054a3755e90937e7eb94558c58212aaa77

    students_hash = {}

    doc.css(".student-card").map do |student|
      students_hash[:name] = student.css("h4.student-name").text,
      students_hash[:location] = student.css("p").text,
      students_hash[:profile_url] = student.css('href').text

    end

#
# <<<<<<< HEAD
# =======
#
#
# >>>>>>> fbbbf0054a3755e90937e7eb94558c58212aaa77
    # doc.css(".student-card").first
    #student_name = doc.css(".student-card").first.css("h4").text
    #student_location = doc.css(".student-card").first.css("p").text
    #student_URL = doc.css(".student-card a").attr('href').text

  end

    Scraper.scrape_index_page("./fixtures/student-site/index.html")

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
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
