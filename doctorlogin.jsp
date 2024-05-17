<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>

<%
    try {
        String action = request.getParameter("action");

        if (action != null && action.equals("change")) {
            String username = request.getParameter("username");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (username != null && currentPassword != null && newPassword != null && confirmPassword != null &&
                    newPassword.equals(confirmPassword)) {

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
                PreparedStatement pstmt = con.prepareStatement("UPDATE doctor SET Password = ? WHERE User=? AND Password=?");
                pstmt.setString(1, newPassword);
                pstmt.setString(2, username);
                pstmt.setString(3, currentPassword);
                
                int rowsAffected = pstmt.executeUpdate();
                pstmt.close();
                con.close();

                if (rowsAffected > 0) {
                    out.print("<script>alert('Password Changed successfully')</script>");
response.sendRedirect("updatedoctorpassword.jsp?mesg=Done");
                }
            } else {
                response.sendRedirect("updatedoctorpassword.jsp?msg=Error"); // Redirect if password change fails
                return; // Terminate the script after redirection
            }
        }

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM doctor WHERE User=? AND Password=?");
        pstmt.setString(1, user);
        pstmt.setString(2, pass);
        ResultSet rs = pstmt.executeQuery();
        boolean check = false;
        while (rs.next()) {
            String userid = rs.getString("User");
            String passid = rs.getString("Password");
            session.setAttribute("doctor_id", rs.getInt("id"));
            session.setAttribute("doctorlogin", true);
            session.setAttribute("doctor_name", rs.getString("name"));

            if (user.equals(userid) && pass.equals(passid)) {
                response.sendRedirect("doctor-dashboard.jsp");
                check = true;
            }
        }
        if (!check) {
            response.sendRedirect("doctorlogin.html");
        }
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.print(e);
    }
%>

