module.exports = ['$scope','ngDialog', ($scope,ngDialog) ->
	$scope.selectOption = (o)-> $scope.closeThisDialog()

	$scope.newOption = ()->
		$scope.$parent.option = o =
			id: $scope.menu.nextID
			required: 'true'
			type: 'single'
			choices: []

		$scope.menu.nextID++
		$scope.options.push o
		$scope.menu.options[o.id] = o
		ngDialog.open
			template: 'edit-option/edit-option.html'
			controller: require './../edit-option/edit-option'
			className: 'ngdialog-theme-default'
			showClose: false
			scope: $scope.$parent

		$scope.closeThisDialog()

]
