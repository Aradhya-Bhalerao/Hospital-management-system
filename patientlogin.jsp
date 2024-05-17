<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%> 

<%
    // Database connection parameters
    String dbUrl = "jdbc:mysql://localhost:3306/hospital2";
    String dbUsername = "root";
    String dbPassword = "admin";

    // Action parameter to determine the action to perform (login or update)
    String action = request.getParameter("action"); 

    // Authentication logic
    if (action != null) {
        if (action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                try {
                    // Establish a connection to the database
                    Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                    // Prepare the SQL statement to check the username and password
                    String query = "SELECT * FROM patientlogin WHERE User = ? AND Password = ?";
                    PreparedStatement ps = con.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setString(2, password);

                    // Execute the query
                    ResultSet rs = ps.executeQuery();

                    // If the query returns a row, the user is authenticated
                    if (rs.next()) {
                        session.setAttribute("patientlogin", true);
                        response.sendRedirect("patientdashboard.jsp?username=" + username);
                        con.close();
                        return; // Terminate the script after redirection
                    }

                    // Close resources
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("patientlogin.html"); // Redirect if authentication fails
        } else if (action.equals("change")) {
            // Password update logic
            String username = request.getParameter("username");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (username != null && currentPassword != null && newPassword != null && confirmPassword != null &&
                    newPassword.equals(confirmPassword)) {
                try {
                    // Establish a connection to the database
                    Connection con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                    // Prepare the SQL statement to update the password
                    String updateQuery = "UPDATE patientlogin SET Password = ? WHERE User = ? AND Password = ?";
                    PreparedStatement updatePs = con.prepareStatement(updateQuery);
                    updatePs.setString(1, newPassword);
                    updatePs.setString(2, username);
                    updatePs.setString(3, currentPassword);

                    // Execute the update query
                    int rowsAffected = updatePs.executeUpdate();

                    // Close resources
                    updatePs.close();
                    con.close();

                    if (rowsAffected > 0) {
                        out.print("<script>alert('Password changed successfully!');");
                        response.sendRedirect("patientlogin.html"); // Redirect to dashboard after password change
                        return; // Terminate the script after redirection
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("patientlogin.html"); // Redirect if password change fails
        } else {
            response.sendRedirect("patientlogin.html"); // Redirect for invalid action parameter
        }
    } else {
        response.sendRedirect("patientlogin.html"); // Redirect if action parameter is missing
    }
%>
