<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="studentApp">
<head>
    <meta charset="UTF-8">
    <title>Dynamic Student Registration</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 500px; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input, select { padding: 10px; width: 100%; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        .required-star { color: red; margin-left: 3px; }
        .btn { padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; }
        .btn:hover { background-color: #218838; }
        .btn:disabled { background-color: #a5d8b0; cursor: not-allowed; }
        .error-msg { color: red; font-size: 12px; margin-top: 5px; display: block; }
    </style>
</head>
<body ng-controller="FormController">

    <div class="container">
        <h2>Student Registration</h2>
        
        <form name="studentForm" action="register" method="POST" novalidate>
            
            <div class="form-group" ng-repeat="field in fields">
                <label for="{{field.name}}">
                    {{field.label}} 
                    <span class="required-star" ng-if="field.isRequired">*</span>
                </label>
                
                <input ng-if="field.type !== 'select'" 
                       type="{{field.type}}" 
                       id="{{field.name}}" 
                       name="{{field.name}}" 
                       ng-model="formData[field.name]" 
                       ng-required="field.isRequired">
                       
                <select ng-if="field.type === 'select'" 
                        id="{{field.name}}" 
                        name="{{field.name}}" 
                        ng-model="formData[field.name]" 
                        ng-required="field.isRequired">
                    <option value="">-- Select {{field.label}} --</option>
                    <option ng-repeat="opt in field.options" value="{{opt}}">{{opt}}</option>
                </select>
                
                <span class="error-msg" ng-show="studentForm[field.name].$touched && studentForm[field.name].$invalid">
                    This field is required.
                </span>
            </div>

            <div ng-if="fields.length === 0" style="color:red; margin-bottom: 15px;">
                <p>Loading form configuration...</p>
            </div>
            
            <button type="submit" class="btn" ng-disabled="studentForm.$invalid">Submit Registration</button>
        </form>
    </div>

    <script>
        var app = angular.module('studentApp', []);
        
        app.controller('FormController', function($scope, $http) {
            $scope.fields = [];
            $scope.formData = {};

            $scope.getFormConfiguration = function() {
                $http({
                    method: 'post',
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
                    alert("Invalid Request Please Contact System Administrator!");
                });
            };

            // Fetch dynamic fields on load
            $scope.getFormConfiguration();
        });
    </script>
</body>
</html>