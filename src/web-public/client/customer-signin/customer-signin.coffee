module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	setTimeout ()->
		$('.username').focus()
	,100

	$scope.onSignIn = ()->
		$scope.$parent.customer =
			name: "Lukasz"
			signedIn: true
			address:
				city: "Hamilton"
				streetNumber: "123"
				streetName: "St Joseph's Drive"
				suite: "803"
				buzzer: "803"
				postalCode: "L8N2G1"
			phone: "905-921-5199"

		ngDialog.open
			template: 'order-type/order-type.html'
			controller: require './../order-type/order-type'
			className: 'ngdialog-theme-default'
			scope: $scope.$parent
		$scope.closeThisDialog()

	$scope.onSignInCancel = ()->
		$scope.closeThisDialog()
]
