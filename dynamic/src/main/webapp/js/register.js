 var app = angular.module('studentApp', []);
        
        app.controller('FormController', function($scope, $http, $timeout) {
            $scope.fields = [];
            $scope.formData = {};
            $scope.isSubmitting = false;

            // 1. Fetch Dynamic Fields
            $scope.getFormConfiguration = function() {
                $http({
                    method: 'POST',
                    url: 'register', 
                    params: { 
                        "action": "getFormFields" 
                            }
                }).then(function successCallback(response) {
                    var result = response.data;
                    if (result.success) {
                        $scope.fields = result.fields;
                    } else {
                        console.error("Failed to load form configuration from server.");
                    }
                }, function errorCallback(response) {
                    alert("Invalid Request. Please Contact System Administrator!");
                });
            };

            // 2. Submit Form Data
            $scope.submitRegistration = function() {
                $scope.isSubmitting = true;
                $scope.submissionMessage = ""; // Clear previous messages
                
                // Combine the action command with the user's form data
                var payload = { "action": "saveStudent" };
                Object.assign(payload, $scope.formData);
                

                $http({
                    method: 'POST',
                    url: 'register', 
                    params: payload // Using params sends data perfectly for request.getParameterMap()
                }).then(function successCallback(response) {
                    var result = response.data;
                    $scope.isSubmitting = false;
                    
                    if (result.success) {
                        $scope.isSuccess = true;
                        $scope.submissionMessage = "Student Registered Successfully!";
                        
                        // Clear the form after success
                        $scope.formData = {}; 
                        $scope.studentForm.$setPristine();
                        $scope.studentForm.$setUntouched();
                        
                        // Hide the success message after 5 seconds
                        $timeout(function() {
                            $scope.submissionMessage = "";
                        }, 5000);
                        
                    } else {
                        $scope.isSuccess = false;
                        $scope.submissionMessage = "Registration Failed: " + result.message;
                    }
                }, function errorCallback(response) {
                    $scope.isSubmitting = false;
                    $scope.isSuccess = false;
                    $scope.submissionMessage = "Server Error. Please Contact System Administrator!";
                });
            };

            // Fetch dynamic fields when the page loads
            $scope.getFormConfiguration();
        });