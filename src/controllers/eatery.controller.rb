require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Eatery.model')

get '/eateries' do
	@eateries = Eatery.all
	erb(:'eateries/index')
end

get '/eateries/new' do
	erb(:'eateries/new')
end

get '/eateries/:id' do
	@eatery = Eatery.find(params[:id])
	erb(:'eateries/single')
end

post '/eateries' do
	eatery = Eatery.new(params)
	eatery.save

	redirect to '/eateries'
end

post '/eateries/:id' do
	eatery = Eatery.find(params[:id])
	eatery.delete

	redirect to '/eateries'
end