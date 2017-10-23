require_relative('../db/SQLRunner')
require_relative('./Burger.model')
require_relative('./Deal.model')

class Eatery

	attr_reader :id, :name, :image_url, :website_url, :email, :address, :telephone

	def initialize(options)
		@id          = options['id'].to_i if options['id']
		@name        = options['name']
		@address     = options['address']
		@telephone   = options['telephone']
		@email       = options['email']
		@website_url = options['website_url']
		@image_url   = options['image_url']
	end

	def save
		sql = 'INSERT INTO eatery (name, address, telephone, email, website_url, image_url)
		VALUES (
			$1, $2, $3, $4, $5, $6
		)
		RETURNING id;'

		values = [@name, @address, @telephone, @email, @website_url, @image_url]

		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def update(options)

	end

	def delete

	end

	def self.find(id)
		sql    = 'SELECT * FROM eatery WHERE id = $1'
		values = [id]

		result = SQLRunner.run(sql, values)[0]
		return Eatery.new(result)
	end

	def self.all
		sql = 'SELECT * FROM eatery;'

		eateries = SQLRunner.run(sql).map { |eatery|
			Eatery.new(eatery)
		}

		return eateries
	end

	def burgers
		sql    = 'SELECT *FROM burger WHERE eatery_id = $1;'
		values = [@id]

		burgers = SQLRunner.run(sql, values).map { |burger|
			Burger.new(burger)
		}

		return burgers
	end

	def deals
		sql    = 'SELECT * FROM deal WHERE eatery_id = $1;'
		values = [@id]

		deals = SQLRunner.run(sql, values).map { |deal|
			Deal.new(deal)
		}

		return deals
	end
end