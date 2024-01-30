# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'scraper'
  spec.version       = '0.1.4'
  spec.authors       = ['sanyakosivchuk']
  spec.email         = ['kosivcuks@gmail.com']
  spec.summary       = 'A job scraper is a gem for parsing jobs from openAi'
  spec.description   = 'A Ruby gem for scraping job data from a website and saving it to a database'
  spec.files         = Dir['app/*.rb']
  spec.require_paths = ['app']
  spec.add_runtime_dependency 'activerecord'
  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'nokogiri'
end
