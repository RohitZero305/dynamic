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
        // Just forward to the JSP page. AngularJS will fetch the data via POST.
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // 1. Handle AngularJS $http AJAX Request to get form fields
        if ("getFormFields".equals(action)) {
            List<FormField> fields = studentDao.getFormConfiguration();
            
            // Structure the response as a Map to match { success: true, fields: [...] }
            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("success", fields != null);
            jsonResponse.put("fields", fields);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(jsonResponse));
            return; // Stop execution here so it doesn't process registration
        }

        // 2. Handle normal Form Submission (when user clicks "Submit Registration")
        boolean isSuccess = studentDao.registerStudent(request.getParameterMap());

        response.setContentType("text/html");
        if (isSuccess) {
            response.getWriter().println("<h3 style='color:green;'>Student Registered Successfully!</h3>");
        } else {
            response.getWriter().println("<h3 style='color:red;'>Registration Failed or Database Error.</h3>");
        }
        response.getWriter().println("<br><a href='register'>Register Another Student</a>");
    }
}