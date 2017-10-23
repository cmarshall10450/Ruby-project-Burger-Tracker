require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Eatery.model')

get '/eateries' do
	@eateries = Eatery.all
	erb(:'eateries/index')
end

get '/eateries/:id' do
	@eatery = Eatery.find(params[:id])
	erb(:'eateries/single')
end