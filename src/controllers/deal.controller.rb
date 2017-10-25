require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/Burger_deal.model')
require_relative('../models/Deal.model')
require_relative('../models/Eatery.model')
require_relative('../models/Burger.model')

get '/deals' do

	return redirect to '/deals' if params['selected_day'] == 'all'

	if params['selected_day']
		@sshow_all_deals = false
		@deals           = Deal.find_by_day(params['selected_day'])
		@selected_day    = params['selected_day']
	else
		@show_all_deals = true
		@deals          = Deal.get_all_deals_by_day
	end

	@days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
	erb(:'deals/index')
end

get '/deals/new' do
	@days     = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
	@eateries = Eatery.all
	@burgers  = Burger.all
	erb(:'deals/new')
end

get '/deals/:id' do
	@deal   = Deal.find(params[:id])
	@eatery = @deal.eatery
	erb(:'deals/single')
end


post '/deals' do
	deal = Deal.new(params)
	deal.save

	params["burger_id"].each do |burger_id|
		options              = {}
		options["deal_id"]   = deal.id
		options["burger_id"] = burger_id
		burger_deal          = BurgerDeal.new(options)
		burger_deal.save
	end

	redirect to '/deals'
end

post '/deals/:id' do
	deal = Deal.find(params[:id])
	deal.delete

	redirect to '/deals'
end
