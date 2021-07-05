require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :attribute_hash
  @@students = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    index_page.css(".roster-cards-container .student-card").each do |student|
      @@students << {
        :name => student.css("a div.card-text-container h4.student-name").text, 
        :location => student.css("a div.card-text-container p.student-location").text, 
        :profile_url => student.css("a").first['href']
      }
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    social_links = []
    
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    
    profile_page.css("div.social-icon-container a").each do |social_sites|
      social_links << social_sites["href"]
    end
    
    attributes = {
      :twitter => social_links.find { |link| link.include?("twitter.com") },
      :linkedin => social_links.find { |link| link.include?("linkedin.com") },
      :github => social_links.find { |link| link.include?("github.com") },
      :blog => social_links.find { |link| !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github") },
      :bio => profile_page.css(".description-holder p").text,
      :profile_quote => profile_page.css(".vitals-text-container div.profile-quote").text
    }
    
    @attribute_hash = {}
    
    attributes.each do |key, value|
      if value != nil
        @attribute_hash[key] = value
      end
    end
    
    @attribute_hash
  end

end

