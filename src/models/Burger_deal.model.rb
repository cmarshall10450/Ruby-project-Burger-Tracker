require_relative('../db/SQLRunner')
require_relative('./Burger.model')
require_relative('./Deal.model')

class BurgerDeal

	def initialize(options)
		@id        = options['id'].to_i if options['id']
		@burger_id = options['burger_id'].to_i
		@deal_id   = options['deal_id'].to_i
	end

	def save
		sql    = 'INSERT INTO burger_deal (burger_id, deal_id) VALUES ($1, $2) RETURNING id;'
		values = [@burger_id, @deal_id]
		@id    = SQLRunner.run(sql, values)[0]['id'].to_i
	end

end