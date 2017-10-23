require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Eatery.model')

get '/eateries' do
	@eateries = Eatery.all
	erb(:'eateries/index')
end