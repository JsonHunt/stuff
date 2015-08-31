module.exports = ['$scope','$routeParams', ($scope,$routeParams) ->
	model = require './../model'

	$scope.schools = model.schools
	$scope.person = {}
	if model.customer
		$scope.person = _.find model.customer.students, (s)-> s.id is parseInt($routeParams.id)
		$scope.school =  _.find model.schools, (s)-> s.id is $scope.person.school

	$scope.selectSchool = ()->
		$scope.school =  _.find model.schools, (s)-> s.id is $scope.person.school

	$scope.save = ()->
		$scope.saved = true
		setTimeout ()->
			$scope.$apply ()->
				$scope.saved = false
		,1000
]
