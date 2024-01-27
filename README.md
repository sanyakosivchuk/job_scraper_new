How to use a parser

1.Navigate to the project directory:
cd job_scraper_new

2.Install dependencies
bundle install

3.Configure environment variables:
Create a .env file in the project root and add the necessary environment variables:
#env
BASE_URL=https://example.com
DB_HOST=localhost
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password

4.Run scraper
ruby app/main.rb

How to use tests

1.Install dependencies
bundle install

2.Edit spec/scraper_spec.rb data to the one you would like to test 
example with testing the Account Associate:

let(:saved_link) { 'https://openai.com/careers/account-associate' }

expect(Job.first).to have_attributes(
      title: 'Account Associate',
      url: saved_link,
      location: 'San Francisco, California, United States — Go To Market',
      apply_now_url: 'https://boards.greenhouse.io/openai/jobs/5059976004#app'
    )

change these strings to whatever you want to test

3.Run rspec spec/scraper_spec.rb