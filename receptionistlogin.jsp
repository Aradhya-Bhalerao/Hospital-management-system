<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receptionist Login</title>
    </head>
    <body>
        <%
             try
        { 
            String user=request.getParameter("username");
            String pass=request.getParameter("password");
           
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2","root","admin");
        Statement st= con.createStatement();
        String sql="Select * From receptionistlogin";
        ResultSet rs=st.executeQuery(sql);
         while(rs.next())
                {
              String userid=rs.getString("User");
                               String passid=rs.getString("Password");
        if(user.equals(userid)&& pass.equals(passid))
            {
            session.setAttribute("reclogin",1);
            session.setAttribute("receptionistlogin", true);
            session.setAttribute("rlogin", "Yes");
//                response.sendRedirect("PatientReg.jsp");
                response.sendRedirect("receptionist-dashboard.jsp");
            }
            else
            {
              response.sendRedirect("receptionistlogin.html?login=failed");
            }
            
        } con.close();
                    }
                    catch(Exception e)
                    {
                    out.print(e);
                        }
           %>
    </body>
    
</html>