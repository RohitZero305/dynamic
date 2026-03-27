<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="studentApp">
<head>
    <meta charset="UTF-8">
    <title>Dynamic Student Registration</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        input, select { padding: 10px; width: 100%; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        .required-star { color: red; margin-left: 3px; }
        .btn { padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; margin-top: 10px; }
        .btn:hover { background-color: #218838; }
        .btn:disabled { background-color: #a5d8b0; cursor: not-allowed; }
        .error-msg { color: red; font-size: 12px; margin-top: 5px; display: block; }
        .status-msg { font-weight: bold; margin-bottom: 15px; text-align: center; padding: 10px; border-radius: 4px; }
        .status-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .status-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body ng-controller="FormController">

    <div class="container">
        <h2>Student Registration</h2>
        
        <div ng-if="submissionMessage" class="status-msg" ng-class="{'status-success': isSuccess, 'status-error': !isSuccess}">
            {{submissionMessage}}
        </div>
        
        <form name="studentForm" ng-submit="submitRegistration()" novalidate>
            
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
            
            <button type="submit" class="btn" ng-disabled="studentForm.$invalid || isSubmitting">
                {{ isSubmitting ? 'Saving...' : 'Submit Registration' }}
            </button>
        </form>
    </div>
 <script src="js/register.js"></script>
</body>
</html>