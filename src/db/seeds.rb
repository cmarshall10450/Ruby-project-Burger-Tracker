require('pry')
require_relative('../../src/models/Eatery')

eatery_1 = Eatery.new({
	'name'        => 'Bread Meats Bread',
	'address'     => '92 Lothian Road, Edinburgh, EH3 9BE',
	'telephone'   => '0131 225 3000',
	'email'       => 'info@breadmeatsbread.com',
	'website_url' => 'http://breadmeatsbread.com/',
	'image_url'   => 'http://breadmeatsbread.com/images/bread-meats-bread-logo.png'
})

eatery_1.save

binding.pry
nil