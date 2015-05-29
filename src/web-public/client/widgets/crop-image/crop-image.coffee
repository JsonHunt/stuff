module.exports = ['$scope','$http','config','image','arg', ($scope,$http,config,image,arg) ->
	$scope.$on 'ngDialog.opened', (e, $dialog)->
		$scope.config = config
		$scope.cropImage = image
		pic = $(".crop-image img")
		$(".crop-image").width config.width
		$(".crop-image").height config.height
		$(".crop-image").hide()

		pic.bind "load", (e)->
			pic.on 'mousewheel', (event)->
				pic.guillotine('zoomIn') if event.deltaY > 0
				pic.guillotine('zoomOut') if event.deltaY < 0
				console.log event.deltaY

			pic.guillotine {width: config.width, height: config.height}
			pic.guillotine('fit')
			$(".crop-image").show()

	$scope.save = ()->
		picture = $(".crop-image img")
		data = picture.guillotine('getData')
		console.log data
		$http.post "/rest/crop",
			data: data
			imageURL: $scope.cropImage
		.success (data,status,headers,config)->
			newImageName = $scope.cropImage + "?" + require('node-uuid').v4()
			$scope.config.onSuccess(newImageName,arg) if $scope.config.onSuccess
			$scope.closeThisDialog()
		.error (data,status,headers,config)->
			console.log data
			$scope.closeThisDialog()
]

# module.exports = ()->
# 	restrict : 'E'
# 	scope:
# 		imageurl: "@"
# 		width : "@"
# 		height : "@"
#
# 	templateUrl : 'widgets/crop-image/crop-image.html'
# 	controller: ($scope, $element, $attrs, $transclude) ->
# 		pic = $(".crop-image > img")
# 		pic.bind "load", (e)->
# 			pic.guillotine {width: 200, height: 200}
# 			pic.on 'mousewheel', (event)->
# 				pic.guillotine('zoomIn') if event.deltaY > 0
# 				pic.guillotine('zoomOut') if event.deltaY < 0
# 				console.log event.deltaY



	# link : ($scope, element, attributes, controller) ->
