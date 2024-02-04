require_relative 'database_manager'

class JobCreator
  def initialize(job_data)
    @job_data = job_data
  end

  def create_job
    return if find_job

    Job.create(
      title: @job_data[:title],
      location: @job_data[:location],
      description: @job_data[:description],
      url: @job_data[:url]
    )

    puts "Job: #{@job_data[:title]} saved to the database."
  end

  private

  def find_job
    existing_job = Job.find_by(url: @job_data[:url])
  end
end