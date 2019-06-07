require 'nokogiri'
require 'open-uri'
require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
  #  binding.pry
    student_hash.each do |key, val|
  #    binding.pry
      self.send("#{key}=", "#{val}")
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
  #  students_array


    students_array.each do |row|
      self.new(row)
      # row.each do |key,val|
      # self.send("#{key}=", "#{val}")
      # end
    end
    self
  end
  def add_student_attributes(attributes_hash)
      attributes_hash.each {|key, val| self.send("#{key}=", "#{val}")}


  end

  def self.all
    @@all
  end
end
