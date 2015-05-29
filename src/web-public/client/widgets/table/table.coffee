module.exports = ()->
	restrict : 'E'
	scope:
		# bidirectional : "="
		config : "="
		data: "="
		# method : "&"

	templateUrl : '/widgets/table/table.html'
	controller: ($scope, $element, $attrs, $transclude) ->
	link : ($scope, element, attributes, controller) ->
		if $scope.config.page is undefined
			$scope.config.page = 1

		if $scope.config.getRecordCount
			$scope.config.getRecordCount()

		if $scope.config.getValue is undefined
			$scope.config.getValue = (item,key)-> item[key]

		$scope.select = (item)-> $scope.config.select(item) if $scope.config.select
