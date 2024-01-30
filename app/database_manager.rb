# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require_relative 'job'

DB_HOST = ENV['DB_HOST']
DB_NAME = ENV['DB_NAME']
DB_USER = ENV['DB_USER']
DB_PASSWORD = ENV['DB_PASSWORD']

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: DB_HOST,
  database: DB_NAME,
  username: DB_USER,
  password: DB_PASSWORD
)

unless ActiveRecord::Base.connection.table_exists?(:jobs)
  ActiveRecord::Base.connection.create_table :jobs do |t|
    t.string :title
    t.string :location
    t.text :description
    t.string :url

    t.timestamps
  end
end
