app = angular.module 'PublicApp', [
	'ngRoute'
	'oc.modal'
	# 'ui.bootstrap'
	# 'uiGmapgoogle-maps'
	# 'angularModalService'
	'ngMap'
	'google.places'
	'angularFileUpload'
	'monospaced.elastic'
	'ngAnimate'
	'ngDialog'
	'720kb.tooltips'
	# 'ng-sanitize'
]

mod = require 'web-app-modules/gen/client'

app.controller 'IndexController', require './index-controller'
app.controller 'LocationConfigController', require './location-config/location-config'
# app.controller 'CalendarController', require './widgets/calendar/calendar'
# app.controller 'OrderProductController', require './order-product/order-product'
# app.controller 'PlaceOrderController', require './place-order/place-order'
# app.controller 'CustomerSigninController', require './customer-signin/customer-signin'
# app.controller 'OrderReviewController', require './order-review/order-review'

# app.factory 'LoginInterceptor', mod.auth.loginInterceptor
# app.config ['uiGmapGoogleMapApiProvider', (uiGmapGoogleMapApiProvider) ->
# 	mapsConfig =
# 		key: 'AIzaSyB83ol3E5p9fUSQPapia3TbwhAPVzLt2t8',
# 		v: '3.17',
# 		libraries: 'places,geometry,visualization'
#
# 	uiGmapGoogleMapApiProvider.configure (mapsConfig)
# ]

app.directive "xtable", require './widgets/table/table'
app.directive "upimage", require './widgets/up-image/up-image'
# app.directive "cropimage", require './widgets/crop-image/crop-image'

app.config ['$httpProvider','$routeProvider', ($httpProvider,$routeProvider) ->
	# $httpProvider.interceptors.push 'LoginInterceptor'

	userPromise =
		xxx: ($q, $http, $rootScope)->
			return if $rootScope.user
			i = $q.defer()
			$http.get 'module/auth/getLogin'
			.success (data)->
				$rootScope.user = data.user
				i.resolve()
			.error ()->
				delete $rootScope.user
				i.reject()
			i.promise

	$routeProvider.when '/',
		controller : require './home/home'
		templateUrl : 'home/home.html'
		# resolve: userPromise
	.when '/home',
		controller : require './home/home'
		templateUrl : 'home/home.html'
	.when '/contact',
		controller : require './contact/contact'
		templateUrl : '/contact/contact.html'
		# resolve: userPromise
	.when '/features',
		controller : require './features/features'
		templateUrl : '/features/features.html'
		# resolve: userPromise
	.when '/build-menu',
		controller : require './build-menu/build-menu'
		templateUrl : '/build-menu/build-menu.html'
		# resolve: userPromise
	.when '/build-zones',
		controller : require './zone-builder-screen/zone-builder-screen'
		templateUrl : '/zone-builder-screen/zone-builder-screen.html'
		# resolve: userPromise


	# .when '/change-password',
	# 		controller : mod.auth.change-password
	# 		templateUrl : '/mod/auth/change-password.html'
	.otherwise
		redirectTo : '/'
]

module.exports = app
