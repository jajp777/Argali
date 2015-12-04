angular.module('app', [])
.filter('divideByAwesome', function() {
    return function(input, delimiter) {
      var delimiter = delimiter || 'Aw3s0m3';

      return input.split(delimiter);
    } 
})
.controller('AdminController', RestController);
function RestController ($scope, $http, $interval) {
    $scope.scriptStream = "startAw3s0m3end"
    $scope.loadJson = function () {
    	var requestContent = "module=" + $scope.module + "&codeset=" + $scope.codeset + "&arg1=" + $scope.arg1
	    $http.post('https://<ip>:<port>/api', requestContent).success(function(dataID) {
	    	$scope.elasticID = dataID.elasticID;   
	    });

	    var stopInterval = $interval(function () {
			var requestContent = "module=es&codeset=queryJob&arg1=" + $scope.elasticID
			// var requestContent = "module=es&codeset=queryJob&arg1=AVFiqvCqozhxc4tHqhlk"
			$http.post('https://<ip>:<port>/api', requestContent).success(function(data) {
				$scope.scriptStream = data.output[0];
			});
			if (angular.isDefined($scope.scriptStream.endTime)) {
	            $interval.cancel(stopInterval);
	        }
		}, 10000)
	};
};
