module.exports =
	nextID: 100
	choices: [
		{id: 1, name: '6-inch', price: '3.99', imageURL: 'https://www.get-go.com/GetGoKitchen/Image/italianSub.jpg'}
		{id: 2, name: '12-inch', price:'5.99', imageURL: 'https://www.get-go.com/GetGoKitchen/Image/grilledSteakSub.jpg'}
		{id: 3, name: 'Italian', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry1.jpg'}
		{id: 4,	name: 'Honey Oat', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry2.jpg'}
		{id: 5,	name: 'Garlic', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry3.jpg'}
		{id: 6, name: '100% Ontario Ham', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry1.jpg'}
		{id: 7,	name: 'Romaine Lettuce', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry2.jpg'}
		{id: 8,	name: 'Exquisite Tomatoes', imageURL: 'http://www.calandrasbakery.com/food_whiteback/whitepastry3.jpg'}
	]

	options: [
		{id: 1, name: 'Size', required: 'yes', type: 'single', choices: [1,2]}
		{id: 2, name: 'Bread', required: 'yes', type: 'single', choices: [3,4,5]}
		{id: 3, name: 'Toppings', required: 'yes', type: 'multi', choices: [6,7,8]}
	]

	categories: [
		{id: 1, name: 'Premium Subs', text: '6-inch    $3.99\n12-inch $5.99', sequence: 1, products: [1,2], options: [1,2,3]}
		{id: 2, name: 'Drinks', sequence: 2, products: ['3']}
	]

	products: [
		{id: 1, name: 'Spicy Italian', thumbnailURL: 'http://w.subway.com/images/Menu/USA/Products/FlashFiles/RPLC_spicy_italian.jpg', categories: [1]}
		{id: 2, name: 'Sweet Onion Chicken Teriayki', thumbnailURL: 'http://www.subway.co.nz/images/Menu-Nutrition/Subs/6g-of-Fat-or-Less/SwtO-Chckn-Tryki.jpg', categories: [1]}
		{id: 3, name: 'Coca-Cola', price: '1.5', thumbnailURL: 'http://paneladebarrorestaurant.com/wp-content/uploads/2014/03/Coca-Cola-Soda.jpg', categories: [2]}
	]
