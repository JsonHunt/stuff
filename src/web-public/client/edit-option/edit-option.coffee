sourcemap_anchor = 'edit-option-controller'

module.exports = ['$scope','$timeout', ($scope,$timeout)->
	setTimeout ()->
		$('.option-name').focus()
	,100

	# uploader = $scope.uploader = new FileUploader
	# uploader.scope = $scope
	# uploader.url = 'rest/uploadGraphic'
	# uploader.formData = [ {
	# 	action: 'uploadGraphic'
	# 	projectID: '123'
	# } ]

	$scope.choiceImageConfig =
		class: 'choice-image-icon'
		width: 300
		height: 200
		getImage: (choice)-> choice.imageURL
		onSuccess: (filename,choice)->
			choice.imageURL = filename

	# uploader.onAfterAddingFile = (event, item) ->
	# 	$scope.uploader.uploadAll()
	#
	# uploader.onSuccessItem = (item,response,status,headers) ->
	# 	if response.result == 'success'
	# 		$scope.uploadChoice.imageURL = "graphic/#{response.file}"

	$scope.save = ()-> $scope.closeThisDialog $scope.option

	$scope.addChoice = ()->

		$scope.menu.choices[$scope.menu.nextID] =
			id: $scope.menu.nextID
			name: "Choice #{$scope.option.choices.length+1}"

		$scope.option.choices.push $scope.menu.nextID
		if ($scope.option.choices.length is 1) and ($scope.option.type is 'single') and ($scope.option.default is undefined)
			$scope.option.default = $scope.option.choices[0].id
		$scope.menu.nextID++

	$scope.removeChoice = (choice)-> _.remove $scope.option.choices, (ch)-> ch.id is choice.id

	# $scope.uploadChoiceImage = (choice)->
	# 	$scope.uploadChoice = choice
	# 	$timeout ()->
	# 		$("#upload_#{choice.id}").click()


	# $scope.save = ()-> $scope.closeThisDialog()
]
