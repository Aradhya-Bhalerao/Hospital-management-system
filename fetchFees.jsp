<%@ page import="java.sql.*" %>

<%
String doctorName = request.getParameter("doctor");
String visitType = request.getParameter("visitType");

// Your database connection code
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
String sql = "SELECT " + visitType + " FROM doctor WHERE name = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, doctorName);
ResultSet rs = pstmt.executeQuery();

if (rs.next()) {
    out.print(rs.getString(visitType)); // Return the fees for the selected visit type
} else {
    out.print("0");
}

rs.close();
pstmt.close();
con.close();
%>
