require('pry')
require_relative('../models/Eatery.model')
require_relative('../models/Burger.model')
require_relative('../models/Deal.model')
require_relative('../models/Burger_deal.model')

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
	'name'        => 'Chicken, Cheese & Bacon',
	'price'       => 9.50,
	'description' => 'With American cheese, slow onions, pickle and burger sauce.',
	'eatery_id'   => 1,
	'image_url'   => 'http://breadmeatsbread.com/perch/resources/cali-burger.jpg'
})
burger_1.save

burger_2 = Burger.new({
	'name'        => 'Melty Moo Moo',
	'price'       => 5.99,
	'description' => 'Double smashed burger with American cheese, candied bacon, spicy beefy mayo and crispy fried onions inside a grilled glazed ring Donut.',
	'eatery_id'   => 1,
	'image_url'   => 'http://breadmeatsbread.com/images/about-image-3.jpg'
})
burger_2.save

deal_1 = Deal.new({
	'name'          => '15% off',
	'day'           => 'Monday',
	'discount_rate' => 15,
	'eatery_id'     => 1
})
deal_1.save

burger_deal_1 = BurgerDeal.new({
	'burger_id' => 1,
	'deal_id'   => 1
})
burger_deal_1.save

burger_deal_2 = BurgerDeal.new({
	'burger_id' => 2,
	'deal_id'   => 1
})
burger_deal_2.save

binding.pry
nil