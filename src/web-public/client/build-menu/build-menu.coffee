module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.order =
		items: []

	$scope.screen = 'categories'

	$scope.productImageConfig =
		class: 'product-image'
		width: 300
		height: 200
		getImage: ()-> $scope.product.imageURL
		onSuccess: (filename)->
			$scope.product.imageURL = filename

	$scope.categoriesTableConfig =
		title: 'Categories'
		columns: ['name']
		remove: (cat)->
			delete $scope.menu.categories[cat.id]
			_.remove $scope.categories, (c)-> c.id is cat.id
		select: (cat)->
			$scope.category = cat
			$scope.screen = 'category'
			$scope.options = _.filter $scope.menu.options, (o)-> _.contains cat.options, o.id
			$scope.products = _.filter $scope.menu.products, (p)-> _.contains cat.products, p.id
		add: ()->
			cat = {
				id: $scope.menu.nextID
				options: []
				products: []
			}
			$scope.menu.nextID++
			$scope.menu.categories[cat.id] = cat
			$scope.categories.push cat
			$scope.selectCategory cat
			$scope.options = _.filter $scope.menu.options, (o)-> _.contains cat.options, o.id
			$scope.products = _.filter $scope.menu.products, (p)-> _.contains cat.products, p.id

	$scope.categoryOptionsTableConfig =
		title: 'Options for products in this category'
		columns: ['name']
		remove: (opt)-> _.pull $scope.category.options, opt.id
		select: (opt)-> $scope.selectOption opt
		add: ()-> $scope.addOption()

	$scope.productsTableConfig =
		title: 'Products'
		columns: ['name', 'price']
		remove: (p)->
			$scope.menu.products[p.id] = undefined
			_remove $scope.category.products, (pr)-> p.id is pr
		getValue: (item,key)->
			return "$#{item[key]}" if key is 'price' and item[key] isnt undefined
			return item[key]

		select: (p)->
			$scope.product = p
			$scope.screen = 'product'
			p.options ?= []
			$scope.options = _.filter $scope.menu.options, (o)-> _.contains p.options, o.id

		add: ()->
			p = {
				id: $scope.menu.nextID
				categories: [$scope.category.id]
			}
			$scope.product = p
			$scope.category.products.push p.id
			$scope.menu.products[p.id] = p
			$scope.selectProduct(p)

	$scope.backToCategories = ()-> $scope.screen = 'categories'
	$scope.backToCategory = ()->
		$scope.screen = 'category'
		$scope.options = _.filter $scope.menu.options, (o)-> _.contains $scope.category.options, o.id
		$scope.products = _.filter $scope.menu.products, (p)-> _.contains $scope.category.products, p.id

	$scope.saveProduct = ()-> $scope.screen = 'category'

	$scope.selectOption = (o)->
		$scope.option = o
		ngDialog.open
			template: 'edit-option/edit-option.html'
			controller: require './../edit-option/edit-option'
			className: 'ngdialog-theme-default'
			scope: $scope

	$scope.addOption = (parent)->
		$scope.option = o =
			id: $scope.menu.nextID
			required: 'true'
			type: 'single'
			choices: []

		$scope.menu.nextID++
		$scope.menu.options[o.id] = o
		parent.options.push o.id
		ngDialog.open
			template: 'edit-option/edit-option.html'
			controller: require './../edit-option/edit-option'
			className: 'ngdialog-theme-default'
			showClose: false
			scope: $scope

	$scope.onImageSuccess = ()-> console.log "ON IMAGE SUCCESS !!!"

		# ngDialog.open
		# 	template: 'add-option/add-option.html'
		# 	controller: require './../add-option/add-option'
		# 	className: 'ngdialog-theme-default'
		# 	showClose: false
		# 	scope: @

]
