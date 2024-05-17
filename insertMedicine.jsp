<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Medicine</title>
</head>
<body>
<%
    // Get the medicine name from the request
    String medicineName = request.getParameter("medicineName");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/hospital2";
    String username = "root";
    String password = "admin";

    // Initialize connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Prepare SQL statement to insert medicine into the med table
        String sql = "INSERT INTO med (medicine_name) VALUES (?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, medicineName);

        // Execute the query
        pstmt.executeUpdate();

        // Send a success response
        
    } catch (Exception e) {
        // Handle any errors
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>
