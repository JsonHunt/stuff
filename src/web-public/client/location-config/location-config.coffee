module.exports = ['$scope', ($scope) ->
	$scope.loc_screen = "locations"
	$scope.locations = []

	$scope.locationsConfig =
		title: 'Locations'
		columns: "name"
		data: $scope.locations
		remove: (item)-> _.remove data, (i)-> i.id is item.id
		select: (item)->
			$scope.location = loc
			$scope.loc_screen = 'location'
		add: ()->
			$scope.locations ?= []
			loc =
				id: require('node-uuid').v4()
				name: "Location #{$scope.locations.length+1}"

			$scope.locations.push loc
			$scope.location = loc
			$scope.loc_screen = "location"
]
