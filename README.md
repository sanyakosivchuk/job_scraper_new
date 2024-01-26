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
