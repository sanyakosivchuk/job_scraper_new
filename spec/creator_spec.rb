# frozen_string_literal: true

require_relative '../app/job_creator'
require_relative '../app/job'
require_relative '../app/database_manager'
require 'rspec'

describe JobCreator do
  let(:job_data) do
    {
      title: 'Account Director',
      location: 'Some place',
      description: 'Cool job apply for it',
      url: 'https://fake.link'
    }
  end

  describe '#save_job' do
    after do
      Job.last&.destroy
    end

    it 'adds a new job to the database' do
      # Make sure that there are no jobs in the database
      expect(Job.count).to eq(0)

      JobCreator.new(job_data).save_job
      expect(Job.count).to eq(1)

      saved_job = Job.last
      expect(saved_job.title).to eq(job_data[:title])
      expect(saved_job.location).to eq(job_data[:location])
      expect(saved_job.description).to eq(job_data[:description])
      expect(saved_job.url).to eq(job_data[:url])
    end
  end
end
