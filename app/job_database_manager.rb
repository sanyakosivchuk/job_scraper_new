require 'active_record'
require_relative 'job'

class DatabaseManager
  DB_HOST = ENV['DB_HOST']
  DB_NAME = ENV['DB_NAME']
  DB_USER = ENV['DB_USER']
  DB_PASSWORD = ENV['DB_PASSWORD']

  def self.setup_connection
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: DB_HOST,
      database: DB_NAME,
      username: DB_USER,
      password: DB_PASSWORD
    )
  end

  def self.save_jobs(jobs)
    setup_connection

    jobs.each do |job|
      existing_job = Job.find_by(url: job[:url])
      next if existing_job

      Job.create(
        title: job[:title],
        description: job[:description],
        url: job[:url],
        location: job[:location],
        about_team: job[:about_team]
      )

      puts "Job: #{job[:title]} saved to the database."
    end
  end
end