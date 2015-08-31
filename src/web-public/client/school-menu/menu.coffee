module.exports = ['$scope','$routeParams', ($scope,$routeParams) ->
	model = require './../model'
	$scope.school = _.find model.schools, (s)-> s.id is parseInt($routeParams.school)
	$scope.menu = _.find $scope.school.menus, (s)-> s.id is parseInt($routeParams.menu)

	$scope.newCategory = ()-> $scope.menu.categories.push { id: 2, name: 'New food category', items: []}
	$scope.removeCategory = (cat)-> _.remove $scope.menu.categories, (c)-> c.id is cat.id

	$scope.addItem = (cat)-> cat.items.push { id: 5, price: 0.00 }
	$scope.removeItem = (cat,item)-> _.remove cat.items, (i)-> i.id is item.id

	$scope.save = ()->
		$scope.saved = true
		$scope.$apply = ()->
			$scope.saved = false
		,1000
]
