require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Burger.model')

get '/burgers' do
	@burgers = Burger.all
	erb(:'burgers/index')
end

get '/burgers/:id' do
	@burger = Burger.find(params[:id])
	erb(:'burgers/single')
end