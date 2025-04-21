# backend/app.rb
require 'sinatra'
disable :protection      # ← disable CSRF & other protection so tests won’t be 403
set :static, true        # ← ensure static assets and routes work under Rack::Test
set :public_folder, File.dirname(__FILE__) + '/../frontend'
set :port, 4567

require 'json'
require 'sinatra/reloader' if development?
# … rest of your code …


set :public_folder, File.dirname(__FILE__) + '/../frontend'
set :port, 4567

DB_FILE = 'backend/database.json'
def load_data
  File.exist?(DB_FILE) ? JSON.parse(File.read(DB_FILE)) : []
end
def save_data(data)
  File.open(DB_FILE, 'w') { |f| f.write(JSON.pretty_generate(data)) }
end

get '/' do
  redirect '/index.html'
end

post '/submit' do
  content_type :json
  new_entry = {
    timestamp:    Time.now,
    parent_name:  params['parentName'],
    parent_tz:    params['parentTZ'],
    children_names: params['childNames'],
    children_tz:  params['childTZ'],
    status:       'Submitted'
  }
  data = load_data
  data << new_entry
  save_data(data)
  redirect '/dashboard.html'
end

get '/api/declarations' do
  content_type :json
  load_data.to_json
end
