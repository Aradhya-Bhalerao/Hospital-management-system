<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

<%@page import="java.util.*,java.sql.*" %>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.util.Random" %>

<%
//  Integer reclogin = (Integer) session.getAttribute("reclogin");
    int id;
    if (request.getParameter("id") == null || request.getParameter("id").isEmpty()) {
        String rloginStatus = "No"; // Default value is "No"

        //        rloginStatus = "Yes"; // Set rloginStatus to "Yes" if id is provided
        //    int id = Integer.parseInt(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Patient Reg</title>
        <style>

            body{
                margin: 0;
                padding: 0;
                background-image: url('img/doctorlogin.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                /*                    height: 100vh;*/

                font-family: sans-serif;

            }
                    
            .navbar {
                background-color: white;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
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
                padding: 15px;
                /* position: relative;*/
                z-index: 2;
            }
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
            input[type="number"] {
                -moz-appearance: textfield; /* Firefox */
            }

            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button { /* WebKit */
                -webkit-appearance: none;
                margin: 0; /* Removes the default margin */
            }

            .container {
                width: 40%;
                margin: 50px auto;

                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background: none;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            table {
                width: 80%;
                border-collapse: collapse;
            }

            table td {
                padding: 10px;
                border-bottom: 1px solid #ccc;
            }

            table td:first-child {
                width: 30%;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: calc(100% - 20px);
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 50%;
                padding: 10px;
                background-color: #5a2f90;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 10px;
                margin-left:30%;
            }

            input[type="submit"]:hover {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.9);
            }

            .radio-group {
                display: flex;
                align-items: center;
            }

            .radio-group input[type="radio"] {
                margin-right: 5px;
            }

            .subscript {
                vertical-align: super;
                font-size: 80%;
            }
            footer {
                background-color: #5a2f90;
                color: white;
                text-align: center;
                padding: 10px;
                margin-bottom: -18px;
                clear: both;  /*Added to clear float */
            }

            footer p {
                color: white;
            }
            select {
                width: calc(100% - 20px);
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .tab {
                display: none;
            }
            .tab.active {
                display: block;
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
            ul {
                list-style: none;
                padding: 0;
            }
            ul li {
                margin-bottom: 10px;
            }
        </style>
        <!-- Your head content goes here -->
    </head>
    <body>

        <div class="navbar" style="display:flex; flex-direction: row; justify-content: space-between;">
            <div> <a href="index.html"><img id="navimg" src="img/newlogo.png"></a></div>
            <div class="navitem"> <a href="index.html">Home</a>
                <div class="dropdown">
                    <a href="#about" id="login-drop">Login</a>
                    <div class="dropdown-content">
                        <a href="administrator.html">Administrator Login</a>
                        <a href="adminlogin.html">Admin Login</a>
                        <a href="receptionistlogin.html">Receptionist's Login</a>
                        <a href="doctorlogin.jsp">Doctor's Login</a>
                        <a href="patientlogin.jsp">Patient's Login</a>
                        <!-- Add more login options as needed -->
                    </div>
                </div>
                <a href="Aboutus.html">About Us</a>
                <a href="viewDoctor.jsp">Doctors</a>
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>
        <div class="container">
            <h1>Online Patient Registration</h1>
            <form name="PatientReg" action="" method="POST" onsubmit="return validation()">
                <table>
                    <tbody>
                        <tr>
                            <td>Patient Name:</td>
                            <td><input type="text" name="pname" required/></td>
                        </tr>
                        <tr>
                            <td>Doctor:</td>
                            <td><select name="doctor" onchange="updateFees()">

                                    <option>Active Doctor</option>
                                    <%                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");

                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
                                            String sql1 = "select * from doctor where status='active'";
                                            Statement st1 = con.createStatement();
                                            ResultSet rs1 = st1.executeQuery(sql1);
                                            while (rs1.next()) {
                                                out.print(rs1.getString("name"));
                                    %>
                                    <option value='<%=rs1.getString("name")%>'>
                                        <% out.print(rs1.getString("name") + " (" + rs1.getString("education") + ")"); %>
                                    </option>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.print(e);

                                        }
                                    %>
                                </select></td>
                        </tr>

                        <tr>

                            <!-- Gender field -->
                        <tr>
                            <td>Gender:</td>
                            <td class="radio-group">
                                <input type="radio" name="gender" value="Male" />Male 
                                <input type="radio" name="gender" value="Female" />Female
                            </td>
                        </tr>
                        <tr>
                            <td>Mobile No:</td>
                            <td><input type="number" name="mobile" id="mobile" /></td>
                        </tr>
                        <tr>
                            <td>Email Id:</td>
                            <td><input type="text" name="email" required/></td>
                        </tr>

                        <tr>
                            <td>Age:</td>
                            <td><input type="number" name="age" required /></td>
                        </tr>
                        <tr>
                            <td>Weight:</td>
                            <td><input type="number" name="weight" required /></td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td><textarea rows="5" name="address" required></textarea></td>
                        </tr>
                        <tr>
                            <td>Hospital Visit:</td>
                            <td>
                                <input type="radio" name="visit" value="1st" id="visit1" checked />1st
                                <input type="radio" name="visit" value="2nd" id="visit2" />2nd
                                <input type="radio" name="visit" value="3rd" id="visit3" />3rd
                            </td>
                        </tr>
                        <tr>



                        <tr>
                            <td colspan="2"><input type="submit" value="Submit" /></td>
                        </tr>
                    </tbody>
                </table>
                <input type="hidden" name="fees" id="fees" value=""/>
            </form>
        </div>
    </body>
</html>



<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
            String userPassword = null;
            // Check if the user already exists in patientlogin table
            String sqlCheckUser = "SELECT * FROM patientlogin WHERE User = ?";
            PreparedStatement pstmtCheckUser = con.prepareStatement(sqlCheckUser);
            pstmtCheckUser.setString(1, mobile);
            ResultSet rsCheckUser = pstmtCheckUser.executeQuery();

            String n = request.getParameter("pname");
            String doc = request.getParameter("doctor");
            String g = request.getParameter("gender");
            String m = mobile;
            String a = request.getParameter("age");
            String w = request.getParameter("weight");
            String ad = request.getParameter("address");
            String h = request.getParameter("visit");
            String f = (String)request.getParameter("fees").trim();
            String s = "Online";

            if (!rsCheckUser.next()) {
                // User does not exist, proceed with insertion
                userPassword = generateRandomPassword();
                // Insert patient data into patientreg table
                String sqlInsertPatientReg = "INSERT INTO patientreg (Name, Doctor, Gender, MobileNo, Email, Age, Weight, Address, Visit, Fees) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmtInsertPatientReg = con.prepareStatement(sqlInsertPatientReg);
                pstmtInsertPatientReg.setString(1, n);
                pstmtInsertPatientReg.setString(2, doc);
                pstmtInsertPatientReg.setString(3, g);
                pstmtInsertPatientReg.setString(4, m);
                pstmtInsertPatientReg.setString(5, email);
                pstmtInsertPatientReg.setString(6, a);
                pstmtInsertPatientReg.setString(7, w);
                pstmtInsertPatientReg.setString(8, ad);
                pstmtInsertPatientReg.setString(9, h);
                pstmtInsertPatientReg.setString(10, f);
                pstmtInsertPatientReg.executeUpdate();
                pstmtInsertPatientReg.close();

                // Insert patient data into patientlogin table
                String sqlInsertPatientLogin = "INSERT INTO patientlogin (User, Password) VALUES (?, ?)";
                PreparedStatement pstmtInsertPatientLogin = con.prepareStatement(sqlInsertPatientLogin);
                pstmtInsertPatientLogin.setString(1, mobile);
                pstmtInsertPatientLogin.setString(2, userPassword);
                pstmtInsertPatientLogin.executeUpdate();
                pstmtInsertPatientLogin.close();

            } else {
                // User already exists, proceed with insertion without sending user and password

                // Insert patient data into patientreg table
                String sqlInsertPatientReg = "INSERT INTO patientreg (Name, Doctor, Gender, MobileNo, Email, Age, Weight, Address, Visit, Fees,status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
                PreparedStatement pstmtInsertPatientReg = con.prepareStatement(sqlInsertPatientReg);
                pstmtInsertPatientReg.setString(1, n);
                pstmtInsertPatientReg.setString(2, doc);
                pstmtInsertPatientReg.setString(3, g);
                pstmtInsertPatientReg.setString(4, m);
                pstmtInsertPatientReg.setString(5, email);
                pstmtInsertPatientReg.setString(6, a);
                pstmtInsertPatientReg.setString(7, w);
                pstmtInsertPatientReg.setString(8, ad);
                pstmtInsertPatientReg.setString(9, h);
                pstmtInsertPatientReg.setString(10, f);
                pstmtInsertPatientReg.setString(11, s);
                pstmtInsertPatientReg.executeUpdate();
                pstmtInsertPatientReg.close();
            }

            final String username = "jkhospitalx@gmail.com";
            final String password = "cbayswcezziyoyzy"; // Consider using a more secure way to store credentials

            // SMTP server properties
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP server address
            props.put("mail.smtp.port", "587"); // Port for SMTP server

            // Set connection timeout and socket timeout
            props.put("mail.smtp.connectiontimeout", "5000"); // 5 seconds
            props.put("mail.smtp.timeout", "5000"); // 5 seconds

            // Get the Session object
            Session msgsession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            try {
                // Create a default MimeMessage object
                Message message = new MimeMessage(msgsession);

                // Set From: header field
                message.setFrom(new InternetAddress(username));

                // Set To: header field
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

                // Set Subject: header field
                message.setSubject("Appointment Receipt");

                // Set email content
                String emailContent = "Name : " + n + "\n";
                emailContent += "Doctor Name : " + doc + "\n";
                emailContent += "Gender : " + g + "\n";
                emailContent += "Mobile No : " + m + "\n";
                emailContent += "Email Id : " + email + "\n";
                emailContent += "Age : " + a + "\n";
                emailContent += "Weight : " + w + "\n";
                emailContent += "Visit : " + h + "\n";
                emailContent += "Doctor fees to be paid at hospital: " + f + "\n";
                if (userPassword != null) {
                    // Include password if it's not null
                    emailContent += "Your Login Id is your mobile number. \nPassword : " + userPassword + "\n";
                }
                message.setText(emailContent);

                // Send message
                Transport.send(message);
                out.print("<center><h4>Patient Registered Successfully!</h4></center>");
            } catch (MessagingException e) {
                // Print any errors
                out.println("Error sending email: " + e.getMessage());
            }
            rsCheckUser.close();
            pstmtCheckUser.close();
            con.close();
        } catch (Exception e) {
            out.print(e);
        }
    }
%>


<%!
    // Generate Random Password Method
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        java.util.Random rnd = new java.util.Random();
        while (sb.length() < 10) {
            int index = (int) (rnd.nextFloat() * chars.length());
            sb.append(chars.charAt(index));
        }
        String password = sb.toString();
        return password;
    }
%>



<script>
    function validation() {
        var m = document.PatientReg.mobile.value;
        if (isNaN(m)) {
            alert("Mobile Number should be numeric");
            return false;
        } else if (m.length !== 10) {
            alert("Mobile Number should be 10 digit");
            return false;
        } else {
            return true;
        }
    }

    var radioButtons = document.querySelectorAll('input[name="visit"]');
    radioButtons.forEach(function (radioButton) {

        radioButton.addEventListener('click', updateFees);
    });

    // Initial update of fees on page load
//        updateFees();

    function updateFees() {
        console.log("Fees update function called");
        var feesInput = document.getElementById('fees');
        var visit1 = document.getElementById('visit1');
        var visit2 = document.getElementById('visit2');
        var visit3 = document.getElementById('visit3');

        var doctorName = document.querySelector('select[name="doctor"]').value; // Get selected doctor name

        var visitType;
        if (visit1.checked) {
            visitType = "visit1";
        } else if (visit2.checked) {
            visitType = "visit2";
        } else if (visit3.checked) {
            visitType = "visit3";
        }
//feesInput.value=1;
        // Ajax call to fetch fees from the database based on doctor name and visit type
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                feesInput.value = xhr.responseText; // Update fees input field with fetched value
//                console.log(xhr.responseText);
            }
        };
        xhr.open("GET", "fetchFees.jsp?doctor=" + doctorName + "&visitType=" + visitType, true);
        xhr.send();
    }


</script>
</body>
    </html>
<%
} else {
    id = Integer.parseInt(request.getParameter("id"));

    String url = "jdbc:mysql://localhost:3306/hospital2";
    String us = "root";
    String pas = "admin";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "admin");
        String query = "SELECT * FROM patientreg where id=?";
        PreparedStatement ps = con.prepareStatement(query);
//        String doctorName = (String) session.getAttribute("doctor_name");

        ps.setInt(1, id);

        // Execute the query
        ResultSet rs = ps.executeQuery();

        // If the query returns a row, the user is authenticated
        if (rs.next()) {
%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Patient Reg</title>
        <style>

            body{
                margin: 0;
                padding: 0;
                background-image: url('img/doctorlogin.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                /*                    height: 100vh;*/

                font-family: sans-serif;

            }
                    
            .navbar {
                background-color: white;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
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
                padding: 15px;
                /* position: relative;*/
                z-index: 2;
            }
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
            input[type="number"] {
                -moz-appearance: textfield; /* Firefox */
            }

            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button { /* WebKit */
                -webkit-appearance: none;
                margin: 0; /* Removes the default margin */
            }

            .container {
                width: 40%;
                margin: 50px auto;

                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background: none;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            table {
                width: 80%;
                border-collapse: collapse;
            }

            table td {
                padding: 10px;
                border-bottom: 1px solid #ccc;
            }

            table td:first-child {
                width: 30%;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: calc(100% - 20px);
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 50%;
                padding: 10px;
                background-color: #5a2f90;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 10px;
                margin-left:30%;
            }

            input[type="submit"]:hover {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.9);
            }

            .radio-group {
                display: flex;
                align-items: center;
            }

            .radio-group input[type="radio"] {
                margin-right: 5px;
            }

            .subscript {
                vertical-align: super;
                font-size: 80%;
            }
            footer {
                background-color: #5a2f90;
                color: white;
                text-align: center;
                padding: 10px;
                margin-bottom: -18px;
                clear: both;  /*Added to clear float */
            }

            footer p {
                color: white;
            }
            select {
                width: calc(100% - 20px);
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .tab {
                display: none;
            }
            .tab.active {
                display: block;
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


        <div class="navbar" style="display:flex; flex-direction: row; justify-content: space-between;">
            <div> <a href="index.html"><img id="navimg" src="img/newlogo.png"></a></div>
            <div class="navitem"> <a href="index.html">Home</a>
                <div class="dropdown">
                    <a href="#about" id="login-drop">Login</a>
                    <div class="dropdown-content">
                        <a href="adminlogin.html">Admin Login</a>
                        <a href="receptionistlogin.html">Receptionist's Login</a>
                        <a href="doctorlogin.jsp">Doctor's Login</a>
                        <a href="patientlogin.jsp">Patient's Login</a>
                        <!-- Add more login options as needed -->
                    </div>
                </div>
                <a href="Aboutus.html">About Us</a>
                <a href="viewDoctor.jsp">Doctors</a>
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>


    <center>

        <div class="container">
  <div style="display:flex; justify-content: flex-end; width: 85%; flex-direction: row; ">
                <a href="receptionist-dashboard.jsp" name="print" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa;">Go Back To Dashboard</a>
                
            </div>
            <h1> Online Patient Registration </h1>
            <form name="PatientReg" action=""  method="POST" onsubmit="return validation()">

                <table>
                    <tbody>
                        <tr>
                            <td>Patient Name:</td>
                            <td><input type="text" name="pname" value='<%=rs.getString("Name")%>' required/></td>
                        </tr>
                      

                        <tr>
                            <td>Doctor:</td>
                            <td><select name="doctor">

                                    <option>select Doctor</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");

                                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital2", "root", "admin");
                                            String sql1 = "select * from doctor where status='active'";
                                            Statement st1 = con.createStatement();
                                            ResultSet rs1 = st1.executeQuery(sql1);
                                            while (rs1.next()) {
                                                out.print(rs1.getString("name"));
                                    %>
                            <option value='<%=rs1.getString("name")%>' <% if (rs1.getString("name").equals(rs.getString("Doctor"))) {
    out.print("selected");
}%>>
    <% out.print(rs1.getString("name") + " (" + rs1.getString("education") + ")"); %>
</option>

                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.print(e);

                                        }
                                    %>
                                </select></td>
                        </tr>
                       
                        <tr>
                            <td>Gender:</td>
                            <td class="radio-group">
                                <input type="radio" name="gender" value="Male" <%= rs.getString("Gender").equals("Male") ? "checked" : ""%> />Male 

                                <input type="radio" name="gender" value="Female" <%= rs.getString("Gender").equals("Female") ? "checked" : ""%> />Female
                            </td>
                        </tr>
                        <tr>
                            <td>Mobile No:</td>
                            <td><input type="number" name="mobile" id="mobile" value='<%=rs.getString("MobileNo")%>' /></td>
                        </tr>
                        <tr>
                            <td>Email Id:</td>
                            <td><input type="text" name="email" value='<%=rs.getString("Email")%>' required/></td>
                        </tr>
                        <tr>
                            <td>Age:</td>
                            <td><input type="number" name="age" value='<%=rs.getString("Age")%>' required /></td>
                        </tr>
                        <tr>
                            <td>Weight:</td>
                            <td><input type="number" name="weight" value='<%=rs.getString("Weight")%>' required /></td>
                        </tr>

                        <tr>
                            <td>Address:</td>
                            <td><textarea rows="5" name="address"  required><%=rs.getString("Address")%></textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Hospital Visit:</td>
                            <td>
                                <input type="radio" name="visit" value="1st" id="visit1" <%if (rs.getString("Visit").equals("1st")) {out.print("checked");}%> />1st
                                <input type="radio" name="visit" value="2nd" id="visit2" <%if (rs.getString("Visit").equals("2nd")) {out.print("checked");}%>/>2nd
                                <input type="radio" name="visit" value="3rd" id="visit3" <%if (rs.getString("Visit").equals("3rd")) {out.print("checked");}%>/>3rd
                            </td>
                        </tr>
                        <tr>
                            <td>Hospital Fees:</td>
                            <td><input type="text" name="fees"  id="fees" value="<%=rs.getString("Fees")%>"></td>
                        </tr>
                      

                        <tr>

                            <td colspan="2"><input type="submit" value="Submit" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </center>



    <%
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        try {
                            String mobile = request.getParameter("mobile");
                            String email = request.getParameter("email");
                            Class.forName("com.mysql.jdbc.Driver");
//                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "");
                            String userPassword = null;
                            // Check if the user already exists in patientlogin table
                            String sqlCheckUser = "SELECT * FROM patientlogin WHERE User = ?";
                            PreparedStatement pstmtCheckUser = con.prepareStatement(sqlCheckUser);
                            pstmtCheckUser.setString(1, mobile);
                            ResultSet rsCheckUser = pstmtCheckUser.executeQuery();

                            
                            String n = request.getParameter("pname");
                String doc = request.getParameter("doctor");
                String g = request.getParameter("gender");
                String m = mobile;
                String a = request.getParameter("age");
                String w = request.getParameter("weight");
                String ad = request.getParameter("address");
                String h = request.getParameter("visit");
                String f = request.getParameter("fees");
                String s = "Offline";
                         

                            if (rsCheckUser.next()) {
                                // User does not exist, proceed with insertion
                                userPassword = generateRandomPassword();
                                // Insert patient data into patientreg table
                                String sqlUpdatePatientReg = "UPDATE patientreg SET Name=?, Doctor=?, Gender=?, Email=?, Age=?, Weight=?, Address=?, Visit=?, Fees=?,status=? WHERE MobileNo=?";
                                PreparedStatement pstmtUpdatePatientReg = con.prepareStatement(sqlUpdatePatientReg);
                                pstmtUpdatePatientReg.setString(1, n);
                                pstmtUpdatePatientReg.setString(2, doc);
                                pstmtUpdatePatientReg.setString(3, g);
                                pstmtUpdatePatientReg.setString(4, email);
                                pstmtUpdatePatientReg.setString(5, a);
                                pstmtUpdatePatientReg.setString(6, w);
                                pstmtUpdatePatientReg.setString(7, ad);
                                pstmtUpdatePatientReg.setString(8, h);
                                pstmtUpdatePatientReg.setString(9, f);
                                pstmtUpdatePatientReg.setString(10, s);
                                pstmtUpdatePatientReg.setString(11, m); // MobileNo used in WHERE clause
                                pstmtUpdatePatientReg.executeUpdate();
                                pstmtUpdatePatientReg.close();

//                                // Insert patient data into patientlogin table
//                                String sqlInsertPatientLogin = "INSERT INTO patientlogin (User, Password) VALUES (?, ?)";
//                                PreparedStatement pstmtInsertPatientLogin = con.prepareStatement(sqlInsertPatientLogin);
//                                pstmtInsertPatientLogin.setString(1, mobile);
//                                pstmtInsertPatientLogin.setString(2, userPassword);
//                                pstmtInsertPatientLogin.executeUpdate();
//                                pstmtInsertPatientLogin.close();

                            } 
//                            else {
//                                // User already exists, proceed with insertion without sending user and password
//
//                                // Insert patient data into patientreg table
//                                String sqlInsertonlinepatientreg = "INSERT INTO onlinepatientreg (Name, Doctor, Gender, MobileNo, Email, Age,Weight, Address) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
//                                PreparedStatement pstmtInsertonlinepatientreg = con.prepareStatement(sqlInsertonlinepatientreg);
//                                pstmtInsertonlinepatientreg.setString(1, n);
//                                pstmtInsertonlinepatientreg.setString(2, doc);
//                                pstmtInsertonlinepatientreg.setString(3, g);
//                                pstmtInsertonlinepatientreg.setString(4, m);
//                                pstmtInsertonlinepatientreg.setString(5, email);
//                                pstmtInsertonlinepatientreg.setString(6, a);
//                                pstmtInsertonlinepatientreg.setString(7, w);
//
//                                pstmtInsertonlinepatientreg.setString(8, ad);
//
//                                pstmtInsertonlinepatientreg.executeUpdate();
//                                pstmtInsertonlinepatientreg.close();
//                            }

                            final String username = "jkhospitalx@gmail.com";
                            final String password = "cbayswcezziyoyzy"; // Consider using a more secure way to store credentials

                            // SMTP server properties
                            Properties props = new Properties();
                            props.put("mail.smtp.auth", "true");
                            props.put("mail.smtp.starttls.enable", "true");
                            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP server address
                            props.put("mail.smtp.port", "587"); // Port for SMTP server

                            // Set connection timeout and socket timeout
                            props.put("mail.smtp.connectiontimeout", "5000"); // 5 seconds
                            props.put("mail.smtp.timeout", "5000"); // 5 seconds

                            // Get the Session object
                            Session msgsession = Session.getInstance(props, new javax.mail.Authenticator() {
                                protected PasswordAuthentication getPasswordAuthentication() {
                                    return new PasswordAuthentication(username, password);
                                }
                            });

                            try {
                                // Create a default MimeMessage object
                                Message message = new MimeMessage(msgsession);

                                // Set From: header field
                                message.setFrom(new InternetAddress(username));

                                // Set To: header field
                                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

                                // Set Subject: header field
                                message.setSubject("Appointment Receipt");

                                // Set email content
                                String emailContent = "Name : " + n + "\n";
                                emailContent += "Doctor Name : " + doc + "\n";
                                emailContent += "Gender : " + g + "\n";
                                emailContent += "Mobile No : " + m + "\n";
                                emailContent += "Email Id : " + email + "\n";
                                emailContent += "Age : " + a + "\n";
                                emailContent += "Weight : " + w + "\n";
                                emailContent += "Payment Status : " + "Paid - ₹"+f + " \n";

                                if (userPassword != null) {
                                    // Include password if it's not null
                                    emailContent += "Your Login Id is your mobile number. \nPassword : " + userPassword + "\n";
                                }
                                message.setText(emailContent);

                                // Send message
                                Transport.send(message);
                                out.print("<center><h4>Patient Registered Successfully!</h4></center>");
                            } catch (MessagingException e) {
                                // Print any errors
                                out.println("Error sending email: " + e.getMessage());
                            }
                            rsCheckUser.close();
                            pstmtCheckUser.close();
                            con.close();
                        } catch (Exception e) {
                            out.print(e);
                        }
                    }
                }
            } catch (Exception e) {
                out.print(e);
            }
        }
    %>


    <!-- Footer -->
    <footer>
        <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
    </footer>

    <script>
        function validation() {
            var m = document.PatientReg.mobile.value;
            if (isNaN(m)) {
                alert("Mobile Number should be numeric");
                return false;
            } else if (m.length !== 10) {
                alert("Mobile Number should be 10 digit");
                return false;
            } else {
                return true;
            }
        }

  var radioButtons = document.querySelectorAll('input[name="visit"]');
    radioButtons.forEach(function (radioButton) {

        radioButton.addEventListener('click', updateFees);
    });

    // Initial update of fees on page load
//        updateFees();

    function updateFees() {
        console.log("Fees update function called");
        var feesInput = document.getElementById('fees');
        var visit1 = document.getElementById('visit1');
        var visit2 = document.getElementById('visit2');
        var visit3 = document.getElementById('visit3');

        var doctorName = document.querySelector('select[name="doctor"]').value; // Get selected doctor name

        var visitType;
        if (visit1.checked) {
            visitType = "visit1";
        } else if (visit2.checked) {
            visitType = "visit2";
        } else if (visit3.checked) {
            visitType = "visit3";
        }
//feesInput.value=1;
        // Ajax call to fetch fees from the database based on doctor name and visit type
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                feesInput.value = xhr.responseText; // Update fees input field with fetched value
//                console.log(xhr.responseText);
            }
        };
        xhr.open("GET", "fetchFees.jsp?doctor=" + doctorName + "&visitType=" + visitType, true);
        xhr.send();
    }


    </script>
</body>
    </html>