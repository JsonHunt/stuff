module.exports = ['$scope','$ocModal', ($scope,$ocModal) ->
	$scope.part = 0
	$scope.location = {}
	$scope.order.date = "Jan 20th"


			# init:
	$scope.createAccount = ()->
		$ocModal.open
			id: 'create-account'
			url: 'customer-create-account/customer-create-account.html'
			controller: 'CreateCustomerAccountController'
			cls: 'slide-down'
			onClose: ()-> console.log "Hello"
			# init:

	$scope.review = ()->
		$ocModal.close()
		$ocModal.open
			id: 'review-order'
			url: 'order-review/order-review.html'
			controller: 'OrderReviewController'
			cls: 'slide-down'
			onClose: ()-> console.log "Damn yo"
			init:
				order: $scope.order
				customer: $scope.customer



	$scope.selectDelivery = (mode)->
		$('.content').removeClass 'back'
		$scope.order.delivery = mode
		$scope.part = 2
		setTimeout ()->
			$('#deliveryCity').focus()
		,100

	$scope.selectTime = (time)->
		$('.content').removeClass 'back'
		$scope.order.when = time
		if time is 'asap'
			$scope.part = 4
		else
			setTimeout ()->
				$('input.time').focus()
			,100

	$scope.prevPart = ()->
		return if $scope.part is 0
		$('.content').addClass 'back'
		$scope.part--

	$scope.nextPart = ()->
		$('.content').removeClass 'back'
		$scope.part++

	$scope.geoCoder = new google.maps.Geocoder()


	$scope.$watch 'location.address', (place)->
		return if place is undefined or place.geometry is undefined
		canvas = document.getElementById('mapCanvas')
		mapOptions =
			center:
				lat: 0
				lng: 0
			zoom: 8
		$scope.map = new google.maps.Map(canvas,mapOptions)
		if place.geometry.viewport
			$scope.map.fitBounds place.geometry.viewport
			$scope.map.panToBounds place.geometry.viewport
		else if place.geometry.location
			$scope.map.panTo place.geometry.location
			$scope.map.setZoom 12

		$scope.order.address = place.formatted_address

]
