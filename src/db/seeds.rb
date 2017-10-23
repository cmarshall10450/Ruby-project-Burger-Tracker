require('pry')
require_relative('../models/Eatery.model')
require_relative('../models/Burger.model')
require_relative('../models/Deal.model')

eatery_1 = Eatery.new({
	'name'        => 'Bread Meats Bread',
	'address'     => '92 Lothian Road, Edinburgh, EH3 9BE',
	'telephone'   => '0131 225 3000',
	'email'       => 'info@breadmeatsbread.com',
	'website_url' => 'http://breadmeatsbread.com/',
	'image_url'   => 'http://breadmeatsbread.com/images/bread-meats-bread-logo.png'
})
eatery_1.save

burger_1 = Burger.new({
	'name'      => 'Chicken, Cheese & Bacon',
	'price'     => 9.50,
	'eatery_id' => 1
})
burger_1.save

deal_1 = Deal.new({
	'name'          => '15% off',
	'day'           => 'Monday',
	'discount_rate' => 15,
	'eatery_id'     => 1
})
deal_1.save

binding.pry
nil