module.exports = {
	order:
		total: 0
		people: []
		
	customer:
		id: 1
		name: "George Clooney"
		school: 1
		students: [
			{id: 1, name: 'Mark Haskins', school: 1, room:1}
			{id: 2, name: 'Kevin Archibald', school: 1, room:2}
			{id: 3, name: 'Paul Mooney', school: 2, room:1}
		]

	schools: [
		{
			id: 1
			name: 'School 1'
			rooms: [
				{
					id: 1
					name: 'Room1'
				}
				{
					id: 2
					name: 'Room2'
				}
			]
			menus: [
				{
					id: 1
					name: "March 20th"
					categories: [
						{
							id: 1
							name: "Sandwiches"
							items: [
								{ id: 4, name: "Western sandwich", price: 5.34}
								{ id: 5, name: "Tofu sandwich", price: 2.50}
								{ id: 6, name: "Cheese sandwich", price: 3.00}
							]
						},{
							id: 2
							name: "Pop"
							items: [
								{ id: 4, name: "Coca-Cola", price: 5.34}
								{ id: 5, name: "Sprite", price: 2.50}
								{ id: 6, name: "7-Up", price: 3.00}
							]
						}
					]
				},{
					id: 2
					name: "Father's Day, June 24th 2015"
					categories: [
						{
							id: 2
							name: "Sandwiches"
							items: [
								{ id: 4, name: "Meat sandwich on italian bread with swiss cheese and chicken nuggets", price: 5.34}
								{ id: 5, name: "Tofu sandwich", price: 2.50}
								{ id: 6, name: "Broccoli sandwich", price: 3.00}
							]
						},
						{
							id: 3
							name: "Soups"
							items: [
								{ id: 7, name: "Chicken soup", price: 5.34}
								{ id: 8, name: "Vegetable soup", price: 2.50}
								{ id: 9, name: "Artichoke with herbs soup", price: 3.00}
							]
						}
					]
				}
			]
		},
		{
			id: 2
			name: 'School 2'
			menus: [
				{
					id: 1
					name: "March 24th"
					categories: [
						{
							id: 1
							name: "Drinks"
							items: [
								{ id: 4, name: "Pepsi", price: 5.34}
								{ id: 5, name: "Sprite", price: 2.50}
								{ id: 6, name: "Fanta", price: 3.00}
							]
						}
					]
				}
			]
			rooms: [
				{id: 1, name: 'Big kids room'}
				{id: 2, name: 'Little kids room'}
				{id: 3, name: 'Toddlers room'}
			]
		}
	]
}
