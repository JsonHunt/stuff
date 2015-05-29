module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.delivery = ->

		$scope.$parent.order.how = 'delivery'

		$scope.next()

	$scope.pickup = ->
		$scope.$parent.order.how = 'pickup'
		$scope.next()

	$scope.next = ->
		ngDialog.open
			template: 'order-location/order-location.html'
			controller: require './../order-location/order-location'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()
]
