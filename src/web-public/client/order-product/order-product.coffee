module.exports = ['$scope','ngDialog','menu','product', ($scope,ngDialog,menu,product) ->
	console.log "New Product Order controller"
	$scope.product = product
	$scope.menu = menu
	$scope.item = {
		id: $scope.product.id
		name: $scope.product.name
		price: $scope.product.price
		quantity: 1
		options: {}
	}

	options = []
	for cID in $scope.product.categories
		category = $scope.menu.categories[cID]
		options = options.concat(category.options) if category.options isnt undefined
	options = _.unique options

	$scope.options = _.map options, (oID)-> $scope.menu.options[oID]

	if $scope.options.length > 0
		$scope.activeOptionIndex = 0

	$scope.activateOption = (index)-> $scope.activeOptionIndex = index

	$scope.less = ()->
		$scope.item.quantity--
		if $scope.item.quantity == 0
			$scope.item.quantity = 1

	$scope.more = ()-> $scope.item.quantity++

	$scope.onChoice = (chID, opt, optIndex)->
		if opt.type is 'single'
			$scope.item.options[opt.id] = chID
		if opt.type is 'multi'
			$scope.item.options[opt.id] ?= []
			if _.contains $scope.item.options[opt.id], chID
				_.pull $scope.item.options[opt.id], chID
			else
				$scope.item.options[opt.id].push chID

		$scope.ready = _.every $scope.options, (o)-> $scope.item.options[o.id] isnt undefined

	$scope.isActive = (opt,choiceID)->
		if opt.type is 'single'
			return $scope.item.options[opt.id] is choiceID
		if opt.type is 'multi'
			return false if $scope.item.options[opt.id] is undefined
			return _.contains $scope.item.options[opt.id], choiceID

	$scope.getItemPrice = (item)->
		# product = $scope.menu.products[item.productID]
		price = 0
		if item.categories
			category = item.categories[0]
			price = category.price if category.price
		price = item.price if item.price
		if item.options
			for optionID,choice of item.options
				if _.isArray choice
					for multiChoice in choice
						c = $scope.menu.choices[multiChoice]
						price += c.price if c.price
				else
					c = $scope.menu.choices[choice]
					price += c.price if c.price

		if item.quantity
			price = price * item.quantity

	$scope.confirm = ()->
		return if !$scope.ready
		$scope.item.price = $scope.getItemPrice $scope.item
		$scope.closeThisDialog $scope.item
]
