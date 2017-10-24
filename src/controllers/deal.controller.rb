require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Deal.model')
require_relative('../models/Eatery.model')

get '/deals' do
	@deals    = Deal.all
	@eateries = Eatery.all
	erb(:'deals/index')
end

get '/deals/new' do
	@days     = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
	@eateries = Eatery.all
	erb(:'deals/new')
end

get '/deals/:id' do
	@deal= Deal.find(params[:id])
	erb(:'deals/single')
end


post '/deals' do
	deal = Deal.new(params)
	deal.save

	redirect to '/deals'
end
