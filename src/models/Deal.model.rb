require('time')
require_relative('../db/SQLRunner')
require_relative('Eatery.model')

class Deal

	attr_reader :id, :name, :day, :discount_rate, :eatery_id

	def initialize(options)
		@id            = options['id'].to_i if options['id']
		@name          = options['name']
		@day           = options['day']
		@discount_rate = options['discount_rate']
		@eatery_id     = options['eatery_id']
	end

	def save
		sql    = 'INSERT INTO deal (name, day, discount_rate, eatery_id)
					 VALUES (
							$1, $2, $3, $4
					 )
					 RETURNING id;'
		values = [@name, @day, @discount_rate, @eatery_id]

		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def delete
		# Delete all deals
		sql    = 'DELETE FROM burger WHERE id = $1'
		values = [@id]
		SQLRunner.run(sql, values)

		# Delete all BurgerDeals associated with the specific deal
		sql = 'DELETE FROM burger_deal WHERE deal_id= $1'
		SQLRunner.run(sql, values)
	end

	def self.all
		sql = 'SELECT * FROM deal;'

		deals = SQLRunner.run(sql).map { |deal|
			Deal.new(deal)
		}

		return deals
	end

	def self.find(id)
		sql    = 'SELECT * FROM deal WHERE id = $1;'
		values = [id]

		deal = SQLRunner.run(sql, values)[0]
		return Deal.new(deal)
	end

	def self.find_by_day(day)
		sql    = 'SELECT * FROM deal WHERE day = $1'
		values = [day]

		deals = SQLRunner.run(sql, values).map { |deal|
			Deal.new(deal)
		}

		return deals
	end

	def self.get_all_deals_by_day
		all_deals = {}

		days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

		current_day = Time.now.wday
		days.rotate!(current_day - 1)

		days.each do |day|
			deals          = Deal.find_by_day(day)
			all_deals[day] = deals
		end

		return all_deals
	end

	def full_name
		sql    = 'SELECT deal.name AS deal_name, eatery.name AS eatery_name FROM deal
					 INNER JOIN eatery
					 ON deal.eatery_id = eatery.id
					 WHERE deal.id = $1;'
		values = [@id]
		result = SQLRunner.run(sql, values)[0]

		return "#{result['deal_name']} at #{result['eatery_name']}"
	end

	def burgers
		sql     = 'SELECT burger.* FROM burger
							 INNER JOIN burger_deal
							 ON burger.id = burger_deal.burger_id
							 WHERE deal_id = $1;'
		values  = [@id]
		burgers = SQLRunner.run(sql, values).map { |burger|
			Burger.new(burger)
		}

		puts burgers

		return burgers
	end

	def eatery
		sql    = 'SELECT * FROM eatery WHERE id = $1'
		values = [@eatery_id]

		eatery = SQLRunner.run(sql, values)[0]
		return Eatery.new(eatery)
	end

end