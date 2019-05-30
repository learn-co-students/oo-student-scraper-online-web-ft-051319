require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=File.read(index_url)
    index_page=Nokogiri::HTML(html)
    students=[]
    index_page.css("div.student-card").each do |student| #div.student-card is the tag that each student has to store its details
      hash={
        name:student.css("div.card-text-container h4.student-name").text,
        #extracting from
        #<div class=card-text-container>
        # => <h4 class="student-name">Ryan Johnson</h4>
        location: student.css("div.card-text-container p.student-location").text,
        #extracting from
        #<div class=card-text-container>
        # => <p class="student-location">New York, NY</p>
        profile_url: student.css("a").attribute("href").value
        #extracting from <a href="xxx.html">
      }
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url) #this is open-uri that we need to use to access the html
    profile_page=Nokogiri::HTML(File.read(html)) #take the string of HTML returned by open-uri's open method
    #and convert it into a NodeSet (aka, a bunch of nested "nodes")
    binding.pry
    hash={
      twitter: profile_page.css("div.social-icon-container :nth-child(1n)").attribute("href").value,
      linkedin: profile_page.css("div.social-icon-container :nth-child(2n)").attribute("href").value,
      github: profile_page.css("div.social-icon-container :nth-child(3n)").attribute("href").value,
      blog: ,
      profile_quote: profile_page.css("div.profile-quote").text,
      bio: profile_page.css("div.description-holder p").text
    }
  end

end
