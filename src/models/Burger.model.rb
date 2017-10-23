require_relative('../db/SQLRunner')
require_relative('Deal.model')
require_relative('Eatery.model')

class Burger

	attr_reader :id, :name, :price, :eatery_id, :image_url

	def initialize(options)
		@id        = options['id'].to_i if options['id']
		@name      = options['name']
		@price     = (options['price'].to_f).round(2)
		@eatery_id = options['eatery_id'].to_i
		@image_url = options['image_url']
	end

	def save
		sql    = 'INSERT INTO burger (name, price, eatery_id, image_url)
			VALUES (
  			$1, $2, $3, $4
 			)
			RETURNING id;'
		values = [@name, @price, @eatery_id, @image_url]

		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def self.all
		sql = 'SELECT * FROM burger;'

		burgers = SQLRunner.run(sql).map { |burger|
			Burger.new(burger)
		}

		return burgers
	end

	def self.find(id)
		sql    = 'SELECT * FROM burger WHERE id = $1'
		values = [id]

		burger = SQLRunner.run(sql, values)[0]
		return Burger.new(burger)
	end

	def deals
		sql    = 'SELECT deal.* FROM deal
					 INNER JOIN burger_deal
					 ON burger_id = $1;'
		values = [@id]
		deals  = SQLRunner.run(sql, values).map { |deal|
			Deal.new(deal)
		}

		return deals
	end

	def eatery
		sql    = 'SELECT * from eatery WHERE id = $1'
		values = [@eatery_id]

		eatery = SQLRunner.run(sql, values)[0]
		return Eatery.new(eatery)
	end

	def new_price
		sql    = 'SELECT (burger.price / 100) * (100 - deal.discount_rate) AS new_price FROM burger
					INNER JOIN burger_deal
					ON burger.id = burger_deal.burger_id
					INNER JOIN deal
					ON deal_id = burger_deal.deal_id
					WHERE burger.id = $1;'
		values = [@id]
		return SQLRunner.run(sql, values)[0]['new_price'].to_i
	end
end