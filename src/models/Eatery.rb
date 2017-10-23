require_relative('../../db/SQLRunner')

class Eatery

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
		);
		RETURNING id'

		values = [@name, @address, @telephone, @email, @website_url, @image_url]

		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def update(options)

	end

	def delete

	end

	def self.find(id)

	end

	def self.all

	end


end