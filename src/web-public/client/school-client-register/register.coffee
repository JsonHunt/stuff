module.exports = ['$scope', ($scope) ->
	model = require './../model'
	$scope.school = model.schools[0].id if model.schools.length > 0
	$scope.schools = model.schools

	$scope.register = ()->
		console.log "Registered"
		model.customer =
			id: 234
			school: $scope.school
			students: []

		$scope.goto 'customer/account'
]
