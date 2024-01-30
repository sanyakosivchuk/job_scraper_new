# frozen_string_literal: true

require 'rspec'
require 'webmock/rspec'
require_relative '../app/scraper'

RSpec.describe Scraper do
  let(:base_url) { 'https://openai.com/careers/search' }
  let(:saved_link) { 'https://openai.com/careers/account-associate' }
  let(:job_list_html) { File.open('./spec/fixtures/job_list.html').read }
  let(:job_html) { File.open('./spec/fixtures/job.html').read }
  let(:invalid_html) { File.open('./spec/fixtures/invalid.html').read }

  before do
    stub_request(:get, "#{base_url}/").to_return(status: 200, body: job_list_html)
    stub_request(:get, saved_link).to_return(status: 200, body: job_html)
  end

  it 'parses job data correctly' do
    Scraper.call
    expect(Job.first).to have_attributes(
      title: 'Account Associate',
      location: 'San Francisco, California, United States — Go To Market',
      url: 'https://boards.greenhouse.io/openai/jobs/5059976004#app'
    )
  end

  context 'when the HTML structure is unexpected' do
    before do
      stub_request(:get, base_url).to_return(status: 200, body: invalid_html)
    end

    it 'handles the parsing error gracefully' do
      expect { Scraper.call }.not_to raise_error
    end
  end
end
