<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            background:url("img/adminlogin.jpg");
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
/*            /height: 350px;/*/
            padding: 10px;
            width: 30%;
            margin: 45px auto;
            box-shadow: rgb(38, 57, 77) 0px 20px 30px -10px;
        }
        .heading {
            font-size: 35px;
            font-weight: 600;
            margin-top: 1rem;
            text-align: center;
            letter-spacing: 1px;
            text-shadow: 2px 2px 2px rgba(0,0,0,0.6);
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
            display:block;
            text-align: left;
            letter-spacing: 1.5px;
        }
        .inputbox input{
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
        footer {
/*            margin-top: -10px;*/
            padding-top: 7px;
            text-align: center;
            color: white;
            background-color: #5a2f90;
            height: 55px;
            font-family: "Inter",sans-serif;
            bottom: 0;
            width:100%;
/*            position: absorlute;*/
            
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }
        .dropdown-content {
            display: none;
            position: fixed;
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
            <a href="viewDoctor.jsp">Doctors</a>
            <a href="onlinepatientreg.jsp">Book Appointment Online</a>
            <a href="contact.html">Contact Us</a>
        </div>
    </div>
    <div class="container">
        <div class="heading">User and Password Update</div>
        <div class="box">
            <form method="post">
                <div class="inputbox">
                    Enter new username <input type="text" name="newUsername" required=""><br>
                </div>
                <div class="inputbox">
                    Enter new password <input type="password" name="newPassword" required><br>
                </div>
                <div class="inputbox">
                    Enter OTP received on Email <input type="text" name="otp" required><br>
                </div>
                <input class="btn" type="submit" value="UPDATE">
            </form>
        </div>
    </div>
    
    <!-- Java code to insert data into the database -->
    <%
    // Check if the form was submitted
    if (request.getParameter("newUsername") != null && request.getParameter("newPassword") != null && request.getParameter("otp") != null) {
        // Assuming user and pass are variables containing the new username and password
        String user = request.getParameter("newUsername");
        String pass = request.getParameter("newPassword");
        String enteredOtp = request.getParameter("otp");
        String generatedOtp = (String) session.getAttribute("generatedOtp"); // Retrieve OTP from session

        if (enteredOtp != null && enteredOtp.equals(generatedOtp)) {
            String url = "jdbc:mysql://localhost:3306/hospital2";
            String username = "root";
            String password = "admin";

            try {
                // Load the MySQL driver
                Class.forName("com.mysql.jdbc.Driver");

                // Connect to the database
                Connection conn = DriverManager.getConnection(url, username, password);

                // Prepare SQL statement for update
                String sql = "UPDATE administrator SET Password = ? , User = ? WHERE Email= ? ";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, pass); // Set new password
                statement.setString(2, user);
                statement.setString(3, "internaradhya@gmail.com"); // Filter by user

                // Execute the update
                int rowsUpdated = statement.executeUpdate();

                // Close connections
                statement.close();
                conn.close();

                // Display alert using JavaScript
                %>
                <script>
                    alert("User Id and Password updated successfully.");
                    window.location.href = "administrator.html"; // Redirect to another page if needed
                </script>
                <%
            } catch (Exception e) {
                // Print any error that occurs
                out.println("Error updating user: " + e.getMessage());
            }
        } else {
            // Display alert for incorrect OTP
            %>
            <script>
                alert("Incorrect OTP. Please try again.");
            </script>
            <%
        }
    }

    // Generate Random Password Method
    %>
    <%! 
        String generateRandomPassword() {
            String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder sb = new StringBuilder();
            java.util.Random rnd = new java.util.Random();
            while (sb.length() < 10) {
                int index = (int) (rnd.nextFloat() * chars.length());
                sb.append(chars.charAt(index));
            }
            return sb.toString();
        }
    %>
    
    <%
        final String username1 = "jkhospitalx@gmail.com";
        final String password1 = "cbayswcezziyoyzy"; // Consider using a more secure way to store credentials
        String email = "internaradhya@gmail.com";
        String generatedPassword = generateRandomPassword();
        session.setAttribute("generatedOtp", generatedPassword); // Store OTP in session

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
                return new PasswordAuthentication(username1, password1);
            }
        });

        try {
            // Create a default MimeMessage object
            Message message = new MimeMessage(msgsession);

            // Set From: header field
            message.setFrom(new InternetAddress(username1));

            // Set To: header field
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

            // Set Subject: header field
            message.setSubject("OTP Verification");

            // Set email content
            String emailContent = "OTP : " + generatedPassword + "\n";
            message.setText(emailContent);

            // Send message
            Transport.send(message);
        } catch (MessagingException e) {
            // Print any errors
            out.println("Error sending email: " + e.getMessage());
        }
    %>
    <footer>
        <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
    </footer>
</body>
</html>