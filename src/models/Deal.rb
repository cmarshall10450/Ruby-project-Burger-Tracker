require_relative('../db/SQLRunner')

class Deal

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

end