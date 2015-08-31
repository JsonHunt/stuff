module.exports = ['$scope', ($scope) ->
	model = require "./../model"
	$scope.schools = model.schools

	$scope.select = (s)->
		$scope.goto "school/#{s.id}"

	$scope.addSchool = ()->
		s =
			id: 3
			name: "New School"
			menus: []
			rooms: []

		$scope.schools.push s
		$scope.select (s)

]
