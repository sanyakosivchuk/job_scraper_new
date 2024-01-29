Gem::Specification.new do |spec|
  spec.name          = "scraper"
  spec.version       = "0.1.3"
  spec.authors       = ["sanyakosivchuk"]
  spec.email         = ["kosivcuks@gmail.com"]
  spec.summary       = %q{A job scraper is a gem for parsing jobs from openAi}
  spec.description   = %q{A Ruby gem for scraping job data from a website and saving it to a database}
  spec.files         = Dir["app/*.rb"]
  spec.require_paths = ["app"] 
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "activerecord"
  spec.add_runtime_dependency "dotenv"
end