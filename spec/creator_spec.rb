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

  describe '#create_job' do
    after do
      Job.last&.destroy
    end

    it 'adds a new job to the database' do
      # Make sure that there are no jobs in the database
      expect(Job.count).to eq(0)

      JobCreator.new(job_data).create_job
      expect(Job.count).to eq(1)

      created_job = Job.last
      expect(created_job.title).to eq(job_data[:title])
      expect(created_job.location).to eq(job_data[:location])
      expect(created_job.description).to eq(job_data[:description])
      expect(created_job.url).to eq(job_data[:url])
    end
  end
end
