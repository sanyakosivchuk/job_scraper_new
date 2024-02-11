# frozen_string_literal: true

require_relative 'database_manager'

class JobCreator
  def initialize(job_data)
    @job_data = job_data
  end

  def save_job
    return if find_job

    Job.create(
      title: @job_data[:title],
      location: @job_data[:location],
      description: @job_data[:description],
      url: @job_data[:url]
    )

    puts "Job: #{@job_data[:title]} saved to the database."
  rescue StandardError => e
    puts "An error occurred while creating the job: #{e.message}"
  end

  private

  def find_job
    @find_job ||= Job.find_by(url: @job_data[:url])
  end
end
