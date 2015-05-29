
module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.paymentMethods = [
		{id: 'cc', name: 'Credit Card', itemLabel: 'Credit Card fee', fee: .99}
		{id: 'debit', name: 'Debit'}
		{id: 'cash', name: 'Cash'}
	]
	$scope.order =
		items: [
			id: 1
			quantity: 1
			name: $scope.menu.products[1].name
			options:
				1: 2
				2: 3
				3: [6,7]
			price: 12
		]
	$scope.customer =
		signedIn: false
		name: 'Lukasz Korzeniowski'

	$scope.selectProduct = (categoryID, productID)->
		return if $scope.edit
		product = $scope.menu.products[productID]
		category = $scope.menu.categories[categoryID]
		options = product.options
		options = category.options if (options is undefined or options.length is 0) and (category.options isnt undefined) and (category.options.length > 0)

		if options and options.length > 0
			ngDialog.open
				template: 'order-product/order-product.html'
				controller: require './../order-product/order-product'
				resolve:
					product: ()-> product
					menu: ()-> $scope.menu
			.closePromise.then (item)->
				$scope.order.items.push(item.value) if item.value.id
				$scope.calculateTotal()
		else
			item = _.find $scope.order.items, (i)-> i.id is productID
			if item
				item.quantity++
				item.price = product.price * item.quantity
			else
				item =
					id: product.id.toString()
					name: product.name
					price: product.price
					quantity: 1
					options: {}
				$scope.order.items.push item
			$scope.calculateTotal()

	$scope.removeItem = (item,index)->
		if item.quantity > 1
			item.quantity--
		else
			_.pullAt $scope.order.items, index

		$scope.calculateTotal()

	$scope.calculateTotal = ()->
		total = 0
		for item in $scope.order.items
			total += item.price
		$scope.order.total = total

		gst = total * .05
		total += gst
		pst = total * .075
		total += pst
		$scope.order.taxes = [
			{name: 'GST', amount: gst}
			{name: 'PST', amount: pst}
		]
		$scope.order.grandTotal = total

	$scope.placeOrder = ->
		if $scope.customer.signedIn
			ngDialog.open
				template: 'order-type/order-type.html'
				controller: require './../order-type/order-type'
				className: 'ngdialog-theme-default'
				scope: $scope
		else
			ngDialog.open
				template: 'order-ask-account/order-ask-account.html'
				controller: require './../order-ask-account/order-ask-account'
				className: 'ngdialog-theme-default'
				scope: $scope

	$scope.calculateTotal()
]
