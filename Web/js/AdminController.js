angular.module('app', [])
.controller('AdminController', RestController);
function RestController ($scope, $http) {
    $scope.loadJson = function () {
    	var requestContent = "module=" + $scope.module + "&codeset=" + $scope.codeset + "&arg1=" + $scope.arg1
	    $http.post('https://192.168.1.245/api', requestContent).
	    success(function(dataID) {
	        $scope.esID = dataID.esID;
	    });

	    var httpPost = 'http://es.pixelrebirth.local:9200/argali/POSHtest/'
	    var httpPostEsID = httpPost.concat($scope.esID)

	    var boolCont = true
	    while (boolCont){
	    	setTimeout(function(){ 
		    	$http.post(httpPostEsID, requestContent).
		        success(function(data) {
			        $scope.scriptStream = data;
		    	});
		    }, 500)
		    if ($scope.scriptStream.match("endTime")){
		    	var boolCount = false
		    }
	    };


	}
};
