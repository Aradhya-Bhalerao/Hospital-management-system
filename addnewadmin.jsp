<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Update</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
              rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                background: url("img/adminlogin.jpg");
                background-size: cover;
                background-attachment: fixed;
                font-family: "Noto Sans", sans-serif;
                height: 100vh;
            }

            .navbar {
                overflow: hidden;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
                height: 75px;
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
                text-shadow: 1.5px 1px 2px rgba(255, 255, 255, 1);

            }

            .navitem a:hover {
                background-color: #5a2f90;
                color: white;
                border-radius: 30px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
                text-shadow: none;

            }

            .navitem {
                margin-left: auto;
                padding: 10px;
            }

            .container {
                display: flex;
                flex-direction: column;
                border: 2px solid black;
                border-style: outset;
                border-radius: 20px;
                height: 550px;
                width: 80%;

                margin: 40px auto;
                box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
            }

            .heading {
                font-size: 35px;
                font-weight: 600;
                margin-top: 1rem;
                text-align: center;
                letter-spacing: 1px;

                text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.6);

            }

            .box {
                margin-top: 2rem;
            }


            .inputbox {
                border-bottom: 2px solid #000000;
                margin: 10px 75px 25px 40px;
            }

            .inputbox label {
                font-size: 20px;
                font-weight: 500;
                display: block;
                text-align: left;
                letter-spacing: 1.5px;

            }

            .inputbox input {
                font-size: 20px;
                outline: none;
                border: none;
                background: transparent;
                margin-top: 10px;
                width: 100%;
                letter-spacing: 1.5px;
                font-weight: 600;
            }

            .btn {
                color: black;
                background: transparent;
                margin-left: 35%;
                border: 2px solid black;
                width: 30%;
                height: 35px;
                border-radius: 30px;
                font-size: 1rem;
                letter-spacing: 2px;

            }

            .btn:hover {
                background-color: black;
                letter-spacing: 4px;
                color: #ffffff;
            }

            .btn:active {
                transform: scale(0.8);
            }

            .footer {
                background-color: #f2f2f2;
                padding: 20px;
                text-align: center;
                position: fixed;
                left: 0;
                bottom: 0;
                width: 100%;
            }

            .message-container {
                margin: 10px auto;
                width: 30%;
                text-align: center;
                background-color: #f2f2f2;
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: fixed;
                /* Change to fixed */
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
                width: 100%;
                
                position: absolute;
                bottom: -225px;
                left: 0;
              
                /* Added to clear float */
            }

            footer p {
                color: white;

            }

            .tab {
                display: none;
            }

            .tab.active {
                display: block;
            }

            .tab-content {
                padding: 20px;
                padding-top: 10px !important;

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

            ul {
                list-style: none;
                padding: 0;
            }

            ul li {
                margin-bottom: 10px;
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
                        <a href="administrator.html">Receptionist's Login</a>
                        <a href="doctorlogin.html">Doctor's Login</a>
                        <a href="patientlogin.html">Patient's Login</a>
                        <!-- Add more login options as needed -->
                    </div>
                </div>
                <a href="Aboutus.html">About Us</a>
                <a href="viewDoctor.jsp">Doctors</a>
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>
        <%
//  Integer reclogin = (Integer) session.getAttribute("reclogin");
//
//
//            if (reclogin == null) {
//    int recloginValue = reclogin.intValue();
            // Use recloginValue here
        %>
        <div class="tabs">
            <a href="administrator.jsp?tab=admin" class="tab-link active" onclick="openTab(event, 'admin')">Admin</a>
            <a href="administrator.jsp?tab=doctors" class="tab-link active" onclick="openTab(event, 'doctors')">Doctors</a>
            <a href="administrator.jsp?tab=receptionists" class="tab-link" onclick="openTab(event, 'receptionists')">Receptionists</a>
            <a href="administrator.jsp?tab=patients" class="tab-link" onclick="openTab(event, 'patients')">Patients</a>

        </div>
        <% //}
        %>
        <div class="container">
            <div style="display:flex; flex-direction: row;">
                <div>

                    <form action="addnewadmin.jsp?action=update" method="post">
                        <div class="heading">User and Password Update</div>
                        <div class="box">

                            <div class="inputbox">

                                Enter current username <input type="text" name="currentUsername"><br>
                            </div>
                            <div class="inputbox">
                                Enter current password <input type="password" name="currentPassword"><br>
                            </div>
                            <div class="inputbox">
                                Enter new username <input type="text" name="newUsername"><br>
                            </div>
                            <div class="inputbox">
                                Enter new password <input type="password" name="newPassword"><br>
                            </div>
                            <input class="btn" type="submit" value="UPDATE">

                        </div>
                    </form>
                </div>
                <div>

                    <form action="addnewadmin.jsp?action=add" method="post">
                        <div class="heading">Add New Admin</div>
                        <div class="box">

                            <div class="inputbox">

                                Enter username <input type="text" name="username"><br>
                            </div>
                            <div class="inputbox">
                                Enter password <input type="password" name="password"><br>
                            </div>

                            <input class="btn" type="submit" value="ADD">


                        </div>
                    </form>
                </div>
            </div>
            <!-- Message container -->
            <div class="message-container">
                <%-- Java logic for updating username and password --%>
                <%
                    String message = null;

                    // Check if form is submitted
                    if (request.getMethod().equalsIgnoreCase("post")) {
                        String action = request.getParameter("action");
                        if (action != null && action.equals("update")) {
                            // Retrieve form parameters
                            String currentUsername = request.getParameter("currentUsername");
                            String currentPassword = request.getParameter("currentPassword");
                            String newUsername = request.getParameter("newUsername");
                            String newPassword = request.getParameter("newPassword");

                            // Perform database update
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");

                                String selectQuery = "SELECT * FROM adminlogin WHERE User=? AND Password=?";
                                stmt = conn.prepareStatement(selectQuery);
                                stmt.setString(1, currentUsername);
                                stmt.setString(2, currentPassword);

                                ResultSet rs = stmt.executeQuery();
                                if (rs.next()) {
                                    String updateQuery = "UPDATE adminlogin SET User=?, Password=? WHERE User=?";
                                    PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                                    updateStmt.setString(1, newUsername);
                                    updateStmt.setString(2, newPassword);
                                    updateStmt.setString(3, currentUsername);
                                    updateStmt.executeUpdate();
                                    message = "Username and Password updated successfully.";
                                } else {
                                    message = "Invalid current username or password.";
                                }
                            } catch (Exception e) {
                                message = "Error: " + e.getMessage();
                            } finally {
                                try {
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (SQLException e) {
                                    message = "Error in closing resources: " + e.getMessage();
                                }
                            }
                        } else if (action != null && action.equals("add")) {
                            // Retrieve form parameters for adding admin
                            String newUsername = request.getParameter("username");
                            String newPassword = request.getParameter("password");

                            // Perform database insertion
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");

                                String insertQuery = "INSERT INTO adminlogin (User, Password) VALUES (?, ?)";
                                stmt = conn.prepareStatement(insertQuery);
                                stmt.setString(1, newUsername);
                                stmt.setString(2, newPassword);
                                int rowsAffected = stmt.executeUpdate();
                                if (rowsAffected > 0) {
                                    message = "Admin added successfully.";
                                } else {
                                    message = "Failed to add admin.";
                                }
                            } catch (Exception e) {
                                message = "Error: " + e.getMessage();
                            } finally {
                                try {
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (SQLException e) {
                                    message = "Error in closing resources: " + e.getMessage();
                                }
                            }
                        }
                    }
                %>
                <%-- Display message if it's not null --%>
                <% if (message != null) {%>
                <p><%= message%></p>
                <% }%>
            </div>

            <footer>
                <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
            </footer>



    </body>

</html>