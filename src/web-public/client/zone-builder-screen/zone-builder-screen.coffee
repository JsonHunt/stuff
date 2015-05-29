module.exports = ['$scope', ($scope) ->

	$scope.zones = []

	$scope.polyOptions =
		strokeColor: '#000000'
		strokeOpacity: 1.0
		strokeWeight: 3

	$scope.addZone = ()->
		zone =
			name: "New Zone"
			boundary: []

		$scope.zones.push zone
		$scope.selectZone zone

	$scope.selectZone = (zone)->
		$scope.zone = zone

	setTimeout ()->
		canvas = document.getElementById('mapCanvas')
		mapOptions =
			center:
				lat: 0
				lng: 0
			zoom: 8

		$scope.geoCoder = new google.maps.Geocoder()
		$scope.map = new google.maps.Map(canvas,mapOptions)

		for zone in $scope.zones
			zone.poly = new google.maps.Polyline($scope.polyOptions)
			zone.poly.setMap $scope.map
			path = zone.poly.getPath()
			for point in zone.boundary
				path.push point

		google.maps.event.addListener $scope.map, 'click', (event)->
			return if not $scope.zone
			$scope.zone.poly.getPath().push event.latLng
	,0
]
