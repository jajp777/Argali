angular.module('app', [])
.controller('AdminController', RestController);
function RestController ($scope, $http) {
    $scope.loadJson = function () {
    	var requestContent = "module=" + $scope.module + "&codeset=" + $scope.codeset + "&arg1=" + $scope.arg1
	    $http.post('https://192.168.1.245:9000/api', requestContent).
	    // $http.post('/sample.json').
	    success(function(data) {
	        $scope.json = data;
	    }, function(dataError){
	    	$scope.test = dataError
	    });
	}
};