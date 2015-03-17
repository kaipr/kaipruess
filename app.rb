require 'sinatra'
require 'slim'

get '/' do
  slim :index
end

get '/portfolio' do
  slim :portfolio
end

get '/contact' do
  slim :contact
end
