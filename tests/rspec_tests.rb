# tests/rspec_tests.rb
require 'rspec'
require 'json'
require 'fileutils'
require 'rack/test'
require_relative '../backend/app'

RSpec.describe 'Backend JSON Storage' do
  let(:db_file) { File.expand_path('../backend/database.json', __dir__) }
  let(:sample) do
    {
      'timestamp'      => Time.now.iso8601,
      'parent_name'    => 'Test Parent',
      'parent_tz'      => '111111111',
      'children_names' => 'Child One',
      'children_tz'    => '222222222',
      'status'         => 'Submitted'
    }
  end

  before(:each) { FileUtils.rm_f(db_file) }

  it 'saves and loads data correctly' do
    save_data([sample])
    loaded = load_data
    expect(loaded).to be_an(Array)
    expect(loaded.first['parent_name']).to eq('Test Parent')
  end
end

RSpec.describe 'Sinatra Routes', type: :request do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'redirects GET / to index.html' do
    get '/'
    expect(last_response.status).to eq(302)
    expect(last_response.location).to include('index.html')
  end

  it 'returns an array from /api/declarations' do
    get '/api/declarations'
    expect(last_response.status).to eq(200)
    parsed = JSON.parse(last_response.body)
    expect(parsed).to be_a(Array)
  end
end
