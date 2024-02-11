# Job Scraper
Job Scraper is a Ruby script designed to extract job listings from websites and store them in a database. It provides a flexible and customizable
solution for automating the process of gathering job opportunities from various sources.

Features
- Scalable: The script is capable of scraping job listings from different websites, allowing users to target specific platforms or sources.
- Modular Design: The codebase is organized into separate classes for scraping and database operations, promoting modularity and ease of maintenance.
- Customizable: Users can easily modify the script to adapt it to their specific requirements, such as adding support for additional job boards or - refining data extraction logic.
- Database Integration: Job listings are saved to a database, enabling users to store and manage scraped data efficiently.

## How to use a parser through script

### 1.Navigate to the project directory:
```
cd job_scraper_new
```

### 2.Install dependencies
```
bundle install
```

### 3.Configure environment variables:
Create a .env file in the project root and add the necessary environment variables:
```
#env
BASE_URL=https://example.com
DB_HOST=localhost
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password
```

### 4.Run scraper
```
ruby bin/main.rb
```

## How to use rspec tests
### 1.Install dependencies
```
bundle install
```

### 2.Edit spec/scraper_spec.rb data to the one you would like to test 
Example with testing the Account Associate:
```
let(:saved_link) { 'https://openai.com/careers/account-associate' }

expect(Job.first).to have_attributes(
      title: 'Account Associate',
      location: 'San Francisco, California, United States — Go To Market',
      apply_now_url: 'https://boards.greenhouse.io/openai/jobs/5059976004#app'
    )
```
Change these strings to whatever you want to test

### 3.Run rspec 
```
rspec spec/scraper_spec.rb
```

## How to use scraper gem
### 1.Make sure to have .env file to connect to your database in your folder 
Make it as on example:
```
#env
BASE_URL=https://example.com
DB_HOST=localhost
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password
```
### 2.Make sure to have scraper gem file cloned locally
It should look something like this:
```
scraper-0.1.5.gem
```
### 3.Run gem install command
```
gem install scraper
```
### 4.Call gem method through irb
```
irb(main):001:0> require "scraper"
=> true
irb(main):002:0> Scraper.call
```
