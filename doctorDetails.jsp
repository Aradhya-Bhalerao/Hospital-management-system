<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
         .container2 {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
          
            /*background-color: #fff;*/
            border-radius: 8px;
            border: 1px solid black;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .doctor-info {
            display: flex;
            align-items: center;
        }
        .doctor-img {
            max-width: 100px;
            max-height: 100px;
            margin-right: 20px;
        }
        .doctor-details {
            flex: 1;
        }
        .doctor-details p {
            margin: 5px 0;
        }
        .doctor-details strong {
            font-weight: bold;
            color: #333;
        }
        .error-message {
            color: red;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container2">
        <%
            String doctorId = request.getParameter("id");
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");

                String sql = "SELECT id, name,regno, education, experience, photo_path FROM doctor WHERE id=?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setString(1, doctorId);
                ResultSet rs = statement.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String regno = rs.getString("regno");
                    String education = rs.getString("education");
                    int experience = rs.getInt("experience");
                    String photoPath = rs.getString("photo_path");
        %>
                    <div class="doctor-info">
                        
                        <img src="<%= photoPath %>" alt="Doctor Photo" style="border: 1px solid black;
            border-radius:10px;" class="doctor-img">
                        
                        <div class="doctor-details">
                            <p><strong>Name:</strong> <%= name %></p>
                            <p><strong>Registration No. :</strong> <%= regno %> </p>
                            <p><strong>Education:</strong> <%= education %></p>
                            <p><strong>Experience:</strong> <%= experience %> years</p>
                        </div>
                    </div>
        <%
                } else {
        %>
                    <p class="error-message">No details found for this doctor.</p>
        <%
                }

                rs.close();
                statement.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <p class="error-message">Error fetching doctor details.</p>
        <%
            }
        %>
    </div>
</body>
</html>
