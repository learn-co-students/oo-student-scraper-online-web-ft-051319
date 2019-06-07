require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)

    html = File.open(index_url)

    studentindex = Nokogiri::HTML(html)

    studhasharr= []

  #  studindarr=studentindex.css("div.student-card")

    # studindarr.each do |stud_el|
    #   puts "#{stud_el}"
    # end

    studentindex.css("div.student-card").each do |stud_el|
        studhash={}
        studhash[:name]=stud_el.css("h4").text
        studhash[:location]=stud_el.css("p").text
        studhash[:profile_url]=stud_el.css("a").attr("href").text

        studhasharr << studhash


    end
    studhasharr

    # binding.pry
    #
    # studentindex.css("h4").each_with_index {|stud_el, i| puts "#{i}. #{stud_el.children.text}"}
  end

    # studentindex.css("div.student-card a").attr("href").value
    # studentindex.css("div.student-card a").map do |stud_el| stud_el.attr("href") end

    # studentindex.css("div.student-card a p")[3].children.text
    #
    #  name: studentindex.css("div.student-card")[0].css("h4").text
    # location:  studentindex.css("div.student-card")[0].css("p").text
  # studentindex.css("div.student-card")[3].css("a").attr("href").text

    # studentindex.css("div.student-card")[0].css("h4").text

    # studentindex.css("li.project.grid_4").each do |project|
    #   title = project.css("h2.bbcard_name strong a").text
    #   projects[title.to_sym] = {
    #     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    #     :description => project.css("p.bbcard_blurb").text,
    #     :location => project.css("ul.project-meta span.location-name").text,
    #     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    #   }
    # end



  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)

    studentprofile = Nokogiri::HTML(html)
    # binding.pry

    studhash={}
    # studhash[:name]= studentprofile.css("div.vitals-container").css("div.vitals-text-container h1").text
    # studhash[:location] = studentprofile.css("div.vitals-container").css("div.vitals-text-container h2").text
    studhash[:bio]=(studentprofile.css("div.bio-block.details-block").css ("div.description-holder")).css("p").text

    studhash[:profile_quote]= studentprofile.css("div.vitals-container").css("div.vitals-text-container div").text
    socialmedarr=  studentprofile.css("div.vitals-container").css("div.social-icon-container a")

    if socialmedarr !=[]
        socialmedarr.each do |socmedrow|
          socmed_link=socmedrow.attr("href")
          socmed_picname=socmedrow.css("img").attr("src").text
          # binding.pry
          if socmed_picname.include?("github")
            socmed_type=:github
          elsif socmed_picname.include?("twitter")
            socmed_type=:twitter
          elsif socmed_picname.include?("linkedin")
            socmed_type=:linkedin
          elsif socmed_picname.include?("rss")
            socmed_type=:blog
          end

          studhash[socmed_type]=socmed_link
          # binding.pry
        end

      end
  #  binding.pry
    studhash
    # bio=(studentprofile.css("div.bio-block.details-block").css ("div.description-holder")).css("p").text
    # social media link: studentprofile.css("div.vitals-container").css("div.social-icon-container a")[1].attr("href")
    # social media picname: studentprofile.css("div.vitals-container").css("div.social-icon-container a")[0].css("img").attr("src").text
    # profile_quote:  studentprofile.css("div.vitals-container").css("div.vitals-text-container div").text
    # name:  pry(Scraper)> studentprofile.css("div.vitals-container").css("div.vitals-text-container h1").text
    # "profile_name" : studentprofile.css("div.vitals-container").css("div.vitals-text-container h1").attr("class").value
    # location:  studentprofile.css("div.vitals-container").css("div.vitals-text-container h2").text


  end

end
