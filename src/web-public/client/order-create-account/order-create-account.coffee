module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.continue = ()->
		# ngDialog.open
		# 	template: 'order-payment-method/order-payment-method.html'
		# 	controller: require './../order-payment-method/order-payment-method'
		# 	className: 'ngdialog-theme-default'
		# 	scope: $scope.$parent
		ngDialog.open
			template: 'order-delivery-time/order-delivery-time.html'
			controller: require './../order-delivery-time/order-delivery-time'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
			
		$scope.closeThisDialog()
]
