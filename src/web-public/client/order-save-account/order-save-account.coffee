module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.save = ->
		ngDialog.open
			template: 'order-create-account/order-create-account.html'
			controller: require './../order-create-account/order-create-account'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()

	$scope.dontSave = ->
		# ngDialog.open
		# 	template: 'order-review/order-review.html'
		# 	controller: require './../order-review/order-review'
		# 	className: 'ngdialog-theme-default'
		# 	scope: $scope.$parent
		ngDialog.open
			template: 'order-delivery-time/order-delivery-time.html'
			controller: require './../order-delivery-time/order-delivery-time'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent

		$scope.closeThisDialog()
]
