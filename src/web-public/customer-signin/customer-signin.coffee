module.exports = ['$scope','$modal', ($scope,$modal) ->
	$scope.onSignIn = ()->
		customer =
			name: "Lukasz"
			address:
				city: "Hamilton"
				streetNumber: "123"
				streetName: "St Joseph's Drive"
				suite: "803"
				buzzer: "803"
				postalCode: "L8N2G1"
			phone: "905-921-5199"
		$modal.close(customer)

	$scope.onSignInCancel = ()->
		$modal.close()
]
