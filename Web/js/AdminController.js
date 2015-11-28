angular.module('app', [])
.controller('AdminController', RestController);
function RestController ($scope, $http, $interval) {
    $scope.loadJson = function () {
    	var requestContent = "module=" + $scope.module + "&codeset=" + $scope.codeset + "&arg1=" + $scope.arg1
	    $http.post('https://192.168.1.245/api', requestContent).success(function(dataID) {
	    	$scope.esID = dataID.esID;   
	    });

	    var stopInterval = $interval(function () {
			var requestContent = "module=es&codeset=queryJob&arg1=" + $scope.esID
			$http.post('https://192.168.1.245/api', requestContent).success(function(data) {
				$scope.scriptStream = data;
			});
			if (angular.isDefined($scope.scriptStream.endTime)) {
	            $interval.cancel(stopInterval);
	        }
		}, 300)
	};
};
