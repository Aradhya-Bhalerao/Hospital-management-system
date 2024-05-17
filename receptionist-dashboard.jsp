<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Receptionist Dashboard</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

        <!-- Add any CSS styles here if needed -->
        <style>
            body {
                margin: 0;
                padding: 0;
                background:url("img/adminlogin.jpg");
                background-size: cover;
                background-attachment: fixed;
                font-family:  sans-serif;
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
                height: inherit;
                width: 60%;
                margin: 30px auto;
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
                position: absolute;
                bottom:0;
                /*margin-top: -10px;*/
                width: 100%;
                padding-top: 7px;
                text-align: center;
                color: white;
                background-color: #5a2f90;
                height: 55px;
                font-family: "Inter",sans-serif;
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
            table {
                width: 80%;
                border-collapse: collapse;
                margin: 0 auto;
                background-color: white;
            }
            th, td {
                padding: 8px;
                padding-right:0px !important;
                border-bottom: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .container{
                margin-top:10%; 
                width: max-content;
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
                <a href="onlinepatientreg.jsp">Book Apointment Online</a>
                <a href="contact.html">Contact Us</a>
            </div>
        </div>
        <div class="container">

            <center>

                <h2>Receptionist Dashboard</h2>
            </center>

          

            <%-- Display fetched data in a table --%>
            <div style="display:flex; justify-content: space-between; width:inherit; flex-direction: row; align-items: center; padding: 10px;">
                <a href="PatientReg.jsp" name="print" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa; margin: 4px;">Register Patient Offline</a>
                <a href="onlineRegisterPatientsList.jsp" name="print" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa; margin: 4px;">View Online Registered Patients</a>
            </div>
          
        </div>
        <footer>
            <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
        </footer>
       
    </body>
</html>

