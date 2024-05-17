<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String doctorId = request.getParameter("id");
    String status = request.getParameter("status");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
        String updateQuery = "UPDATE doctor SET status = ? WHERE id = ?";
        PreparedStatement updateStatement = con.prepareStatement(updateQuery);
        updateStatement.setString(1, status);
        updateStatement.setString(2, doctorId);
        int rowsAffected = updateStatement.executeUpdate();
        if (rowsAffected > 0) {
            out.println("Status changed successfully.");
        } else {
            out.println("Failed to change status.");
        }
        updateStatement.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while changing status.");
    }
%>
