module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	moduleName = 'order-ask-account-controller'
	$scope.no = ()->
		ngDialog.open
			template: 'order-type/order-type.html'
			controller: require './../order-type/order-type'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()

	$scope.yes = ()->
		ngDialog.open
			template: 'customer-signin/customer-signin.html'
			controller: require './../customer-signin/customer-signin'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()
]
