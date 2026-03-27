package com.student.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.student.dao.StudentDao;
import com.student.model.FormField;

@WebServlet("/register")
public class StudentRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDao studentDao = new StudentDao();
    private final Gson gson = new Gson(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just forward the user to the JSP page. AngularJS will take over from there.
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Set response headers for JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 1. Handle AngularJS Request: Get Form Fields
        if ("getFormFields".equals(action)) {
            List<FormField> fields = studentDao.getFormConfiguration();
            
            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("success", fields != null);
            jsonResponse.put("fields", fields);
            
            response.getWriter().write(gson.toJson(jsonResponse));
            return;
        }

        // 2. Handle AngularJS Request: Save Student Data
        if ("saveStudent".equals(action)) {
            // Because we used 'params' in AngularJS, getParameterMap() will easily read the inputs
            boolean isSuccess = studentDao.registerStudent(request.getParameterMap());

            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("success", isSuccess);
            jsonResponse.put("message", isSuccess ? "Success" : "Database error occurred.");

            response.getWriter().write(gson.toJson(jsonResponse));
            return;
        }
        
        // 3. Fallback for unknown actions
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", "Invalid action command.");
        response.getWriter().write(gson.toJson(errorResponse));
    }
}