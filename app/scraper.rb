require 'nokogiri'
require 'httparty'
require 'dotenv/load'
require_relative 'job_database_manager'

class Scraper
  include HTTParty

  BASE_URL = ENV['BASE_URL']

  def self.call
    new.call
  end

  def initialize
    @jobs = []
  end

  def call
    scrape_jobs
    DatabaseManager.save_jobs(@jobs)
  end

  private

  def scrape_jobs
    html = self.class.get("#{BASE_URL}/")

    if html.body.nil? || html.body.empty?
      puts "Error: Empty response body"
      return
    end

    doc = Nokogiri::HTML(html.body)

    doc.css('li.pt-16').each do |job_li|
      title = job_li.css('h3.f-subhead-2').text.strip
      location = job_li.css('span.f-body-1').text.strip
      url = job_li.css('a.ui-link').attr('href')&.value
      description_url = "#{BASE_URL}#{url}"

      next if url.nil?

      description_html = self.class.get(description_url)
      description_doc = Nokogiri::HTML(description_html.body)
      description = description_doc.css('.section').text.strip

      about_team = ""
      ui_description = description_doc.at('.ui-description')
      about_team = ui_description.inner_html if ui_description

      @jobs << {
        title: title,
        description: description,
        url: description_url,
        location: location,
        about_team: about_team
      }
    end
  end
end