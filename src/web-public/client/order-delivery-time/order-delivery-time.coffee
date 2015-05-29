module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.now = ()->
		$scope.$parent.order.when = 'now'
		ngDialog.open
			template: 'order-payment-method/order-payment-method.html'
			controller: require './../order-payment-method/order-payment-method'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()

	$scope.continue = ()->
		$scope.$parent.order.when = 'sheduled'
		ngDialog.open
			template: 'order-payment-method/order-payment-method.html'
			controller: require './../order-payment-method/order-payment-method'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()
]
