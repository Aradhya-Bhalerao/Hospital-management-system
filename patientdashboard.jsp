<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Patient Dashboard</title>
        <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your external CSS file -->
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .navbar {
                background-color: #343a40;
                color: #ffffff;
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .navbar a {
                color: #ffffff;
                text-decoration: none;
                margin-right: 20px;
                font-size: 18px;
            }
            .main-content {
                padding: 20px;
                margin-top: 20px;
            }
            h2 {
                margin-top: 0;
                color: #343a40;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border-bottom: 1px solid #dee2e6;
                text-align: left;
            }
            th {
                background-color: #343a40;
                color: #ffffff;
            }
            tr:hover {
                background-color: #f2f2f2;
            }
            body{
                margin: 0;
                padding:0;
                font-family: sans-serif;
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
                position: absolute;
                bottom: 0;
                width: 100%;
                clear: both; /* Added to clear float */
            }

            footer p {
                color: white;

            }

        </style>
    </head>
    <body>
        <!-- Navbar -->
        <!-- Navbar -->
        <div class="navbar">
            <a href="index.html"><img id="navimg" src="img/newlogo.png"></a>
            <div class="navitem">
                <a href="index.html">Home</a>
                    <a href="index.html" id="login-drop">Logout</a>
                <div class="dropdown">
                    <a href="#" id="login-drop">Login</a>
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
                <a href="viewDoctor.jsp">Doctors</a>
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>



        <!-- Main content -->
        <div class="main-content">
            <h2>Your Appointments</h2>
            <table>
                <tr>
                    <th>Appointment Number</th>
                    <th>Doctor Name</th>
                    <th>Time</th>
                    <th></th>
                </tr>
                <%
                    String username = request.getParameter("username");
                    try {
                        // Establish a connection to the database
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");

                        // Prepare the SQL statement to retrieve appointments for the logged-in patient
                        String query = "SELECT * FROM prescription WHERE patient_id = ?";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, username);

                        // Execute the query
                        ResultSet rs = ps.executeQuery();

                        // Display appointment details in the table
                            int i = 1;
                        while (rs.next()) {
                            String appointmentNumber = rs.getString("prescription_id");
                            String doctorName = rs.getString("doctor_name");
                            String time = rs.getString("timestamp");
                %>
                <tr>
                    <td><%= i%></td>
                    <td><%= doctorName%></td>
                    <td><%= time%></td>
                     <td><a href="viewAppointmentDetails.jsp?prescription_id=<%= rs.getString("prescription_id") %>" class="btn" style="text-decoration:none; background-color: hotpink; border: 1px solid black; border-radius:10px; padding: 5px; color:black;">View Details</a></td>
                </tr>
                <%
                            i++;
                        }
                        // Close resources
                        rs.close();
                        ps.close();
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
