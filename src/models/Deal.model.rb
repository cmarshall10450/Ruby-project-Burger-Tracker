require_relative('../db/SQLRunner')

class Deal

	attr_reader :name, :day, :discount_rate, :eatery_id

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

end