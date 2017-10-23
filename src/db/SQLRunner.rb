require('pg')
require_relative('./config')

class SQLRunner

	def run(sql, values)
		begin
			db = PG.connect($db)
			db.prepare('query', sql)
			result = db.exec_prepared('query', values)
		ensure
			db.close
		end

		return result
	end

end