# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require_relative 'job_creator'

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
    save_to_database
  end

  private

  def scrape_jobs
    html = self.class.get("#{BASE_URL}/")

    if html.body.nil? || html.body.empty?
      puts 'Error: Empty response body'
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
      ui_description = description_doc.at('.ui-description')
      description = ui_description.inner_html if ui_description

      apply_now_link = job_li.css('a[href*="greenhouse"]').first['href'] if job_li.css('a[href*="greenhouse"]').first

      @jobs << {
        title:,
        location:,
        description:,
        url: apply_now_link
      }
    end
  end

  def save_to_database
    @jobs.each do |job|
      JobCreator.new(job).create_job
    end
  end
end
