module.exports = ['$scope','$routeParams', ($scope,$routeParams) ->
	model = require './../model'

	$scope.school = _.find model.schools, (s)-> s.id is parseInt($routeParams.id)
	$scope.menus = $scope.school.menus
	$scope.menu = $scope.menus[0] if $scope.menus.length > 0
	$scope.tab = 'menus'

	$scope.openMenus = ()-> $scope.tab = 'menus'
	$scope.openRooms = ()-> $scope.tab = 'rooms'

	$scope.newMenu = ()->
		menu =
			id: 2
			name: "New Menu"
			categories: []
		$scope.menus.push menu
		$scope.menu = menu

	$scope.removeMenu = (menu)->
		_.remove $scope.menus, (m)-> m.id is menu.id
		$scope.menu = undefined

	$scope.newRoom = ()->
		room =
			id: 34
			name: "Room"
		$scope.school.rooms.push room

	$scope.removeRoom = (room)->
		_.remove $scope.school.rooms, (r)-> r.id is room.id

	$scope.save = ()->
		$scope.saved = true
		setTimeout ()->
			$scope.$apply ()->
				$scope.saved = false
		,1000

	$scope.selectMenu = (menu)-> $scope.goto "school/#{$scope.school.id}/menu/#{menu.id}"

]
