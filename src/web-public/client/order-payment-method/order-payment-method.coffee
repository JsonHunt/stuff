module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.onMethod = (m)->
		$scope.$parent.order.paymentMethod = m.id
		_.remove $scope.$parent.order.items, (i)-> i.id is 'payment-fee'
		if m.fee
			$scope.$parent.order.items.push
				id: 'payment-fee'
				name: m.itemLabel
				price: m.fee
			$scope.calculateTotal()

		ngDialog.open
			template: 'order-review/order-review.html'
			controller: require './../order-review/order-review'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent

		$scope.closeThisDialog()
]
