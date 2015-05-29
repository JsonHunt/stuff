module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	_.remove $scope.$parent.order.items, (i)-> i.id is 'delivery'
	$scope.$parent.calculateTotal()

	$scope.continue = ()->
		$scope.$parent.order.items.push
			id: 'delivery'
			name: 'Delivery'
			price: 4.99

		$scope.next()

	$scope.pickup = ()-> $scope.next()

	$scope.next = ()->
		if $scope.$parent.customer?.signedIn
			# ngDialog.open
			# 	template: 'order-payment-method/order-payment-method.html'
			# 	controller: require './../order-payment-method/order-payment-method'
			# 	className: 'ngdialog-theme-default'
			ngDialog.open
				template: 'order-delivery-time/order-delivery-time.html'
				controller: require './../order-delivery-time/order-delivery-time'
				className: 'ngdialog-theme-default'
				scope: $scope.$parent
		else
			ngDialog.open
				template: 'order-save-account/order-save-account.html'
				controller: require './../order-save-account/order-save-account'
				className: 'ngdialog-theme-default'
				scope: $scope.$parent
		$scope.closeThisDialog()
]
