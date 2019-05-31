require 'open-uri'
require 'pry'
# require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    student_array = []
    counter = 1 


    page = Nokogiri::HTML(File.read(index_url))
    roster_cards = page.css("div.roster-cards-container").children

    while counter < (roster_cards.length - 2)
      #students are accessed only by odd numbers due to ::before 
      student_name = roster_cards[counter].css("h4.student-name").text
      student_location = roster_cards[counter].css("p.student-location").text
      student_link = roster_cards[counter].css("a").attribute("href").text
  
      student_array << {name: student_name, location: student_location, profile_url: student_link}

      counter += 2
    end
    student_array
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)

    student_hash = {}
    page = Nokogiri::HTML(File.read(profile_url))


    # social_media = page.css("div.social-icon-container").children[1].attribute("href").text
    # social_media = page.css("div.social-icon-container").css("a")[4].attribute("href").text
    social_media = page.css("div.social-icon-container").css("a")
    quote = page.css("div.vitals-text-container").children.css("div").text #.gsub(/[\"]/, "")
    bio = page.css("div.bio-block.details-block").css("div.description-holder").css("p").text

    student_hash[:profile_quote] = quote
    student_hash[:bio] = bio
    social_media.each do |media|
      media_text = media.attribute("href").text
      case 
      when media_text.include?("linkedin")
        student_hash[:linkedin] = media_text
      when media_text.include?("github")
        student_hash[:github] = media_text
      when media_text.include?("twitter")
        student_hash[:twitter] = media_text
      else
        student_hash[:blog] = media_text
      end
    end

    student_hash    
    # binding.pry


    
  end

end

