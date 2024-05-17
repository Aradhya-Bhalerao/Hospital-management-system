<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prescription Details</title>
        <style>
            /* Add your CSS styles here */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
            
            .center-div{
                display :flex; 
                flex-direction: row; 
                width: 100%; 
                align-items: center; 
                justify-content: center;
            }
            
                    .logo {
            float: left;
            margin-right: 20px;
            margin-top: 10px;
        }

       
        .header {
            overflow: hidden;
            background-color: #f2f2f2;
            padding: 20px 10px;
            text-align: center;
        }
        
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
                height: 40px;
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

        </style>
    </head>
    <body>
      
 
        <!-- Navbar -->
        <div class="navbar">
            <a href="index.html"><img id="navimg" src="img/newlogo.png"></a>
            <div class="navitem">
                <a href="index.html">Home</a>
                <div class="dropdown">
                    <a href="#">Profile</a>
                    <a href="index.html" id="login-drop">Logout</a>
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

        <%-- Fetch data from the database --%>
        <%
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/hospital2";
                String username = "root";
                String password = "admin";
                con = DriverManager.getConnection(url, username, password);
                int prescriptionId = Integer.parseInt(request.getParameter("prescription_id"));

                // Fetch data from prescription table
                String sqlPrescription = "SELECT * FROM prescription WHERE prescription_id = ?";
                PreparedStatement pstmtPrescription = con.prepareStatement(sqlPrescription);
                String doctorName = (String) session.getAttribute("doctor_name");
                pstmtPrescription.setInt(1, prescriptionId);
                ResultSet rsPrescription = pstmtPrescription.executeQuery();
                
                  String patientEmail = "";
     
                // Display prescription data in a table
        %>
    <center>
       <div class="header">
    <img src="img/newlogo.png" width="65" height="60" alt="alt" class="logo">
    <h1 class="title">JK Multi-Specialist Hospital</h1>
   
</div>
        <hr>
          <h3>Prescription</h3>
    </center>
    <table>
        <thead>
            <tr>
                <th>Prescription ID</th>
                <th>Patient Name</th>
                <th>Age</th>
                <th>Weight</th>
                <th>Visit Date</th>
                <th>Prescription</th>
                <th>Patient ID</th>
                <th>Doctor Name</th>
            </tr>
        </thead>
        <tbody>
            <% while (rsPrescription.next()) {
               String patientId = rsPrescription.getString("patient_id");
            String sqlPatientEmail = "SELECT Email FROM patientreg WHERE MobileNo = ?";
            PreparedStatement pstmtPatientEmail = con.prepareStatement(sqlPatientEmail);
            pstmtPatientEmail.setString(1, patientId);
            ResultSet rsPatientEmail = pstmtPatientEmail.executeQuery();
            if (rsPatientEmail.next()) {
                patientEmail = rsPatientEmail.getString("Email");
//                out.print("<script>alert('patient email'+"+patientEmail+")");
            }
            %>
            <tr>
                <td><%= rsPrescription.getInt("prescription_id")%></td>
                <td><%= rsPrescription.getString("patient_name")%></td>
                <td><%= rsPrescription.getInt("age")%></td>
                <td><%= rsPrescription.getInt("weight")%></td>
                <td><%= rsPrescription.getString("visit_date")%></td>
                <td><%= rsPrescription.getString("prescription")%></td>
                <td><%= rsPrescription.getString("patient_id")%></td>
                <td><%= rsPrescription.getString("doctor_name")%></td>
            </tr>
            <%
                // Fetch data from meal_timing table for each prescription
//                int prescriptionId = rsPrescription.getInt("prescription_id");
                String sqlMealTiming = "SELECT * FROM meal_timing WHERE prescription_id = ?";
                PreparedStatement pstmtMealTiming = con.prepareStatement(sqlMealTiming);
                pstmtMealTiming.setInt(1, prescriptionId);
                ResultSet rsMealTiming = pstmtMealTiming.executeQuery();
            %>
            <tr>
                <td colspan="8">
        <center>
                    <h3>Medicine Details</h3>
        </center>
                    <table>
                        <thead>
                            <tr>
                                <th>Medicine</th>
                                <th>Dose</th>
                                <th>Meal Timing</th>
                                <th>Timing</th>
                                <th>No of Days</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while (rsMealTiming.next()) {%>
                            <tr>
                                <td><%= rsMealTiming.getString("medicine")%></td>
                                <td><%= rsMealTiming.getInt("dose")%></td>
                                <td><%=rsMealTiming.getString("meal_timing")%></td>
                                <td><% String timing = rsMealTiming.getString("timing").replace("#", ", ");
                                    out.print(timing);%></td>
                                <td><%= rsMealTiming.getInt("no_of_days")%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </td>
            </tr>
            <%
                    // Close resources
                    rsMealTiming.close();
                    pstmtMealTiming.close();
                } // End of while loop for prescription data
            %>
        </tbody>
    </table>
    <hr>
    <footer>
        <center>
        <p>Address: Besides Hotel Neelam, Opp. Empire Mall,Badnera Road, Amravati-444605 Maharashtra, India. <br>Contact: 0721-4575688</p>
        </center>
          </footer>
    <%-- Close resources --%>
    <% rsPrescription.close();
        pstmtPrescription.close(); %>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
