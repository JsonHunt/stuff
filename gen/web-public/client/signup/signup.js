// Generated by CoffeeScript 1.9.1
(function() {
  this.SignupController = function($scope, $ocModal, $http) {
    setTimeout(function() {
      return $('#username').focus();
    }, 100);
    $scope.signup = function() {
      return $http.post("/rest/signup", {
        user: $scope.user
      }).error(function(data, status, headers, config) {
        return $scope.error = data;
      }).success(function(data, status, headers, config) {
        if (data.error) {
          return $scope.error = data.error;
        } else {
          return $scope.sent = true;
        }
      });
    };
    return $scope.close = function() {
      return $ocModal.close();
    };
  };

  this.SignupController.$inject = ['$scope', '$ocModal', '$http'];

}).call(this);
