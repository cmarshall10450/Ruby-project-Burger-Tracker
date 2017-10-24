require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Burger.model')
require_relative('../models/Eatery.model')

get '/burgers' do
	@burgers = Burger.all
	erb(:'burgers/index')
end

get '/burgers/new' do
	@eateries = Eatery.all
	erb(:'burgers/new')
end

get '/burgers/:id' do
	@burger = Burger.find(params[:id])
	erb(:'burgers/single')
end


post '/burgers' do
	burger = Burger.new(params)
	burger.save

	redirect to '/burgers'
end