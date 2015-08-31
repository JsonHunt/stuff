module.exports = ['$scope', '$routeParams','$location', ($scope,$routeParams,$location) ->

	$scope.stripeKey = 'pk_test_mjErRLTsA3qHkFdBfztCFlOF'

	$scope.selectStudent = (s)->
		$scope.student = s
		$scope.school = _.find $scope.schools, (sch)-> sch.id is s.school
		$scope.rooms = []
		$scope.room = undefined
		if $scope.school
			$scope.menus = $scope.school.menus
			$scope.rooms = $scope.school.rooms
			if $scope.student.room
				$scope.room = _.find $scope.school.rooms, (r)-> r.id is $scope.student.room

			$scope.menu = _.find $scope.school.menus, (m)-> m.id is s.menu
			if $scope.menu is undefined and $scope.menus.length > 0
				$scope.menu = _.last $scope.menus

	model = require './../model'

	$scope.order = model.order
	$scope.order ?= {
		total: 0
		people: []
	}

	$scope.customer = model.customer
	$scope.schools = model.schools
	$scope.students = $scope.customer.students
	if $scope.students.length > 0
		$scope.selectStudent $scope.students[0]



	$scope.tab = $routeParams.tab

	$scope.togglePass = ()-> $scope.changePass = !$scope.changePass

	$scope.showOrder = ()-> $location.path "customer/order"

	$scope.showAccount = ()-> $location.path "customer/account"





	$scope.editPerson = (p)->
		$scope.goto "person/#{p.id}"

	$scope.removePerson = (p)->
		_.remove $scope.students, (s)-> s.id is p.id

	$scope.addPerson = ()->
		person =
			id: 34
		$scope.students.push person
		$scope.goto "person/#{person.id}"

	$scope.selectMenu = (m)->
		$scope.order.menu = m
		_.remove $scope.order.people, (p)-> p.id is $scope.student.id
		$scope.calculateTotal()

	$scope.selectRoom = (r)->
		$scope.order.room = r

	$scope.less = (item)->
		person = _.find $scope.order.people, (p)-> p.id is $scope.student.id
		return if person is undefined
		orderitem = _.find person.items, (i)-> i.id is item.id
		return if orderitem is undefined
		if orderitem.quantity == 1
			_.remove person.items, (i)-> i.id is item.id
			if person.items.length == 0
				_.remove $scope.order.people, (p)-> p.id is person.id

		orderitem.quantity--

		$scope.calculateTotal()

	$scope.more = (item)->
		person = _.find $scope.order.people, (p)-> p.id is $scope.student.id
		if person is undefined
			person =
				id: $scope.student.id
				name: $scope.student.name
				items: []
			$scope.order.people.push person

		orderitem = _.find person.items, (i)-> i.id is item.id
		if orderitem is undefined
			orderitem =
				id: item.id
				name: item.name
				price: item.price
				quantity: 1
			person.items.push orderitem
		else
			orderitem.quantity++

		$scope.calculateTotal()

	$scope.getQuantity = (item)->
		person = _.find $scope.order.people, (p)-> $scope.student.id is p.id
		return 0 if person is undefined
		item = _.find person.items, (i)-> i.id is item.id
		return 0 if item is undefined
		return item.quantity

	$scope.calculateTotal = ()->
		$scope.order.total = 0
		for person in $scope.order.people
			for item in person.items
				$scope.order.total += item.quantity * item.price

	$scope.save = ()->
		$scope.saved = true
		setTimeout ()->
			$scope.$apply ()->
				$scope.saved = false
		,1000

	$scope.placeOrder = ()->
		handler = StripeCheckout.configure
			key: 'pk_test_6pRNASCoBOKtIshFeQd4XMUh'
			image: 'img/logo.gif'
			token: (token)->

		handler.open
			name: 'Subworx'
			description: "Lunch"
			amount: $scope.order.total*100

]
