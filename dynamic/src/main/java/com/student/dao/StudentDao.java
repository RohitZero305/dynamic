package com.student.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.student.model.FormField;
import com.student.util.DBConnection; // Assumes your connection class is here

public class StudentDao {

    // 1. Fetch Form Configuration
    public List<FormField> getFormConfiguration() {
        List<FormField> fields = new ArrayList<>();
        String query = "SELECT field_name, field_label, field_type, is_required FROM form_configuration WHERE is_active = 1 ORDER BY display_order ASC";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ptmt = con.prepareStatement(query);
             ResultSet rs = ptmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("field_name");
                String label = rs.getString("field_label");
                // Clean up the string to prevent hidden space issues
                String type = rs.getString("field_type").trim().toLowerCase(); 
                boolean isRequired = rs.getBoolean("is_required");

                FormField field = new FormField(name, label, type, isRequired);

                // Fetch dynamic options if the field is a dropdown
                if ("select".equals(type)) {
                    field.setOptions(getDropdownOptions(name, con));
                }
                fields.add(field);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fields;
    }

    // 2. Fetch Dropdown Options
    private List<String> getDropdownOptions(String fieldName, Connection con) {
        List<String> options = new ArrayList<>();
        String sql = "SELECT option_value FROM Dropdown_Options WHERE field_name = ?";
        
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, fieldName);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    options.add(rs.getString("option_value"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return options;
    }

    // 3. Register Student (Dynamically generates INSERT statement)
    public boolean registerStudent(Map<String, String[]> parameterMap) {
        StringBuilder columns = new StringBuilder();
        StringBuilder values = new StringBuilder();
        List<String> paramValues = new ArrayList<>();

        for (String paramName : parameterMap.keySet()) {
            // 🚨 CRITICAL FIX: Skip the "action" parameter sent by the Servlet 
            // so it doesn't get treated as a database column.
            if ("action".equals(paramName)) {
                continue;
            }

            columns.append(paramName).append(",");
            values.append("?,"); // Protect against SQL Injection
            paramValues.add(parameterMap.get(paramName)[0]);
        }

        // Clean up the trailing commas from the loops
        if (columns.length() > 0) {
            columns.deleteCharAt(columns.length() - 1);
            values.deleteCharAt(values.length() - 1);
        }

        // Construct the final dynamic SQL query
        String sql = "INSERT INTO Student_Information (" + columns.toString() + ") VALUES (" + values.toString() + ")";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            // Inject the actual user data into the '?' placeholders
            for (int i = 0; i < paramValues.size(); i++) {
                pstmt.setString(i + 1, paramValues.get(i));
            }
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            // It's helpful to print the generated SQL to the console if an error happens
            System.err.println("SQL Error while executing: " + sql);
            e.printStackTrace();
            return false;
        }
    }
}