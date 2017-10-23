require_relative('../db/SQLRunner')

class Burger

	def initialize(options)
		@id        = options['id'].to_i if options['id']
		@name      = options['name']
		@price     = (options['price'].to_f).round(2)
		@eatery_id = options['eatery_id'].to_i
	end

	def save
		sql    = 'INSERT INTO burger (name, price, eatery_id)
			VALUES (
  			$1, $2, $3
 			)
			RETURNING id;'
		values = [@name, @price, @eatery_id]

		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

end