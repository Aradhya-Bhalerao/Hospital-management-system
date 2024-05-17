<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    // Check if the delete parameter is set and process the deletion
    if (request.getParameter("action") != null && request.getParameter("action").equals("delete")) {
        String adminIdToDelete = request.getParameter("id");

        // Perform deletion logic here
        // For example, you can execute a DELETE SQL statement
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
            String deleteQuery = "DELETE FROM adminlogin WHERE User = ?";
            PreparedStatement deleteStatement = con.prepareStatement(deleteQuery);
            deleteStatement.setString(1, adminIdToDelete);
            int rowsAffected = deleteStatement.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<script>alert('Admin deleted successfully.');</script>");
            } else {
                out.println("<script>alert('Failed to delete Admin.');</script>");
            }
            deleteStatement.close();
            con.close();
        } catch (Exception e) {
            out.println("<script>alert('An error occurred during deletion.');</script>");
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Doctors</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background:url("img/adminlogin.jpg");
                background-size: cover;
                background-attachment: fixed;
                font-family: "Noto Sans", sans-serif;
            }
            /* Navbar styles */
            .navbar {
                background-color: white;
                overflow: hidden;
                display: flex;
                align-items: center; /* Center vertically */
                height: 70px;
            }

            #navimg {
                height: 70px;
                width: 90px;
            }

            .navbar a {
                color: black;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            .navitem a:hover {
                background-color: #5a2f90;
                color: white;
                border-radius: 30px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4); 
            }

            .navitem {
                margin-left: auto;
                padding: 10px;
                position: relative;
                z-index: 2;
            }

            /* Slideshow container */
            .slideshow-container {
                max-width: 92%; /* Changed to % */
                height: 510px;
                margin: auto;
                margin-top: 10px;
                display: flex;
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
                position: relative;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.9); 
            }

            /* Slides */
            .mySlides {
                display: none;
                width: 100%;
                height: 100%;
                opacity: 0; /* Initially hidden */
                transition: opacity 1s ease; /* Fade animation */
            }

            /* Adjusting image size */
            .mySlides img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Ensures the image covers the entire container */
            }
            #aboutUsContent{
                margin-top: 20px;
            }

            /* Dropdown styles */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: fixed; /* Change to fixed */
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                z-index: 2;
                margin-top: 15px;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {
                background-color: #5a2f90;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            /* Footer styles */
            footer {
                background-color: #5a2f90;
                color: white;
                text-align: center;
                padding: 10px;

                clear: both; /* Added to clear float */
            }

            footer p {
                color: white;

            }



            .container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                margin-top: 20px; 
                margin-bottom: 20px; 
                height:100vh;
                background-color: #fff;
                border-radius: 8px;
                border: 1px solid black;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .container2 {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background-color: white;
                background-color: #fff;
                border-radius: 8px;
                border: 1px solid black;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }


            h1 {
                text-align: center;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="number"],
            input[type="file"] {
                width: 90%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                display: block;
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
            .doctor-img {
                max-width: 100px;
                max-height: 100px;
            }
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.0); /* Black w/ opacity */
                padding-top: 60px;

            }

            .modal-content {
                background-color: skyblue;
                margin: 5% auto; /* 15% from the top and centered */
                padding: 20px;
                border: 1px solid #888;
                width: 50%; /* Could be more or less, depending on screen size */
                border: 1px solid black;
                border-radius:10px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            .tab {
                display: none;
            }
            .tab.active {
                display: block;
            }

            .modal {
                /* display: none; / / Removed this line */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.0); /* Black w/ opacity */
                padding-top: 60px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                display: block; /* Add this line to always display the close button */
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }



            .tab-content {
                padding: 20px;
                padding-top:10px !important;

                border: 1px solid #ccc;
                border-top: none;
                text-align: center;
                align-items: center;

            }
            .tabs {
                overflow: hidden;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
            }
            .tab-link {
                float: left;
                border-right: 1px solid #ccc;
                background-color: inherit;
                padding: 10px 20px;
                text-decoration: none;
                color: black;
            }
            .tab-link:last-child {
                border-right: none;
            }
            .tab-link:hover {
                background-color: #ddd;
            }
            .tab-link.active {
                background-color: white;
                border-bottom: 1px solid white;
            }

        </style>
    </head>
    <body>
        <!-- Navbar -->
        <div class="navbar">
            <a href="index.html"><img id="navimg" src="img/newlogo.png"></a>
            <div class="navitem">
                <a href="index.html">Home</a>
                <div class="dropdown">
                    <a href="#about" id="login-drop">Login</a>
                    <div class="dropdown-content">
                        <a href="administrator.html">Administrator Login</a>
                        <a href="adminlogin.html">Admin Login</a>
                        <a href="receptionistlogin.html">Receptionist's Login</a>
                        <a href="doctorlogin.html">Doctor's Login</a>
                        <a href="patientlogin.html">Patient's Login</a>
                        <!-- Add more login options as needed -->
                    </div>
                </div>
                
                <a href="Aboutus.html">About Us</a>
                <a href="adminviewdoctor.jsp">Doctors</a>
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>
        <div class="tabs">
            <a href="administrator.jsp?tab=admin" class="tab-link active" onclick="openTab(event, 'admin')">Admin</a>
            <a href="administrator.jsp?tab=doctors" class="tab-link active" onclick="openTab(event, 'doctors')">Doctors</a>
            <a href="administrator.jsp?tab=receptionists" class="tab-link" onclick="openTab(event, 'receptionists')">Receptionists</a>
            <a href="administrator.jsp?tab=patients" class="tab-link" onclick="openTab(event, 'patients')">Patients</a>

        </div>
        <div class="container">
            <center>

                <h2>View Admin</h2>
            </center>
            <table id="doctorTable">
                <div style="display:flex; justify-content: space-between; width:inherit; flex-direction: row; align-items: center; padding: 10px;">
                <a href="addnewadmin.jsp" name="add" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa; margin: 4px;">Add New Admin</a>
                </div>
                <tr>
                    <th>Name</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");

                        String sql = "SELECT * FROM adminlogin";
                        PreparedStatement statement = con.prepareStatement(sql);
                        ResultSet rs = statement.executeQuery();

                        while (rs.next()) {
                            String user = rs.getString("User");
                            String pass = rs.getString("Password");
//                            String status = rs.getString("status");
                %>
                <tr>
                    <td class="doctor-name" data-id="<%= user%>"><%= user%></td>
                    <td class="doctor-name" data-id="<%= pass%>"><%= pass%></td>
                    <td class="doctor-name" data-id="<%= user%>"><div style="display:flex; justify-content: space-between; width:30%; flex-direction: row; align-items: center; padding: 10px;">
                <a href="addnewadmin.jsp?user=<%= user%>" name="add" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa; margin: 4px;">Update</a>
                <a href="administratorviewadmin.jsp?id=<%= user%>&action=delete" name="delete" style="text-decoration: none; color: black; font-weight: bold; border: 1px solid black; padding: 8px 16px; border-radius: 4px; background-color:red; margin: 4px;">Delete</a>
            </div></td>
                </tr>
                <%
                        }
                        rs.close();
                        statement.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
        <footer>
            <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
       </footer>

    </body>
</html>