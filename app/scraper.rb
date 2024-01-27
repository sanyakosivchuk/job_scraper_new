require 'nokogiri'
require 'httparty'
require 'active_record'
require 'dotenv/load'
require_relative 'job.rb'

class Scraper
  include HTTParty

  def self.call
    new.call
  end

  BASE_URL = ENV['BASE_URL']
  DB_HOST = ENV['DB_HOST']
  DB_NAME = ENV['DB_NAME']
  DB_USER = ENV['DB_USER']
  DB_PASSWORD = ENV['DB_PASSWORD']
  
  def initialize
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: DB_HOST,
      database: DB_NAME,
      username: DB_USER,
      password: DB_PASSWORD
    )
    @jobs = []

    unless ActiveRecord::Base.connection.table_exists?(:jobs)
      ActiveRecord::Base.connection.create_table :jobs do |t|
        t.string :title
        t.text :description
        t.string :url
        t.string :location
        t.text :about_team
        t.string :apply_now_url

        t.timestamps
      end
    end
  end

  def call
    scrape_jobs
    save_to_database
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

      next if url.nil?

      description_url = URI.join(BASE_URL, url).to_s
      description_html = self.class.get(description_url)
      description_doc = Nokogiri::HTML(description_html.body)
      description = description_doc.css('.section').text.strip

      about_team = ""
      ui_description = description_doc.at('.ui-description')
      about_team = ui_description.inner_html if ui_description

      apply_now_link = job_li.css('a[href*="greenhouse"]').first['href'] if job_li.css('a[href*="greenhouse"]').first

      @jobs << {
        title: title,
        description: description,
        url: description_url,
        location: location,
        about_team: about_team,
        apply_now_url: apply_now_link
      }
    end
  end

  def save_to_database
    @jobs.each do |job|
      existing_job = Job.find_by(url: job[:url])
      next if existing_job

      Job.create(
        title: job[:title],
        description: job[:description],
        url: job[:url],
        location: job[:location],
        about_team: job[:about_team],
        apply_now_url: job[:apply_now_url]
      )

      puts "Job: #{job[:title]} saved to the database."
    end
  end
end

Scraper.call
