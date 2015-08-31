module.exports = ['$scope', ($scope) ->
	$scope.signIn = ()->
		# $http.post "/login",
		# 	username: $scope.username
		# 	password: $scope.password
		# .success (data,status,headers,config)-> goto 'schools'
		# .error (data,status,headers,config)-> $scope.error = data.error

		$scope.goto 'customer/order'

	$scope.signUp = ()-> $scope.goto 'customer-register'
]
