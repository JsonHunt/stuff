module.exports = ['FileUploader','$timeout','ngDialog', (FileUploader,$timeout,ngDialog) ->
	restrict : 'E'
	scope:
		config : "="
		arg : "="

	templateUrl : 'widgets/up-image/up-image.html'
	controller: ($scope, $element, $attrs, $transclude) ->
		uploader = $scope.uploader = new FileUploader
		uploader.scope = $scope
		uploader.url = 'rest/uploadGraphic'
		# uploader.formData = [ {
		# 	projectID: '123'
		# } ]
		$scope.image = $scope.config.getImage($scope.arg)

		uploader.onAfterAddingFile = (event, item) ->
			$scope.uploader.uploadAll()

		uploader.onSuccessItem = (item,response,status,headers) ->
			if response.result == 'success'
				# service = require './image-service'
				# service.cropImage = response.file
				# service.onSuccess = $scope.onSuccess
				# service.imageWidth = $scope.imageWidth
				# service.imageHeight = $scope.imageHeight
				# service.model = $scope.model
				ngDialog.open
					template: 'widgets/crop-image/crop-image.html'
					controller: require './../crop-image/crop-image'
					className: 'ngdialog-theme-default'
					resolve:
						config: ()-> $scope.config
						arg: ()-> $scope.arg
						image: ()-> response.file
				.closePromise.then ()->
					$scope.image = $scope.config.getImage($scope.arg)

		$scope.onClick = ()-> $timeout ()-> $element.find("input").click()

	# link : ($scope, element, attributes, controller) ->

		# $scope.randID = require ('node-uuid').v4()


]
