module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	moduleName = 'order-location-controller'
	$scope.continue = ->
		if $scope.$parent.order.how is 'delivery'
			$scope.getDeliveryCost (cost)->
				if cost
					$scope.$parent.deliveryCost = cost
					ngDialog.open
						template: 'order-delivery-cost/order-delivery-cost.html'
						controller: require './../order-delivery-cost/order-delivery-cost'
						className: 'ngdialog-theme-default'
						scope: $scope.$parent

		else if $scope.$parent.customer?.signedIn

		else
			ngDialog.open
				template: 'order-save-account/order-save-account.html'
				controller: require './../order-save-account/order-save-account'
				className: 'ngdialog-theme-default'
				scope: $scope.$parent
		$scope.closeThisDialog()

	$scope.getDeliveryCost = (callback)-> callback 4.99

]
