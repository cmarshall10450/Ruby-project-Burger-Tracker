require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Deal.model')

get '/deals' do
	@deals = Deal.all
	erb(:'deals/index')
end
