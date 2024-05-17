<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
        <style>
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
            /* Success message */
.success-message {
    margin:80px;
    text-align: center;
    background-color: #d4edda; /* Greenish background */
    color: #155724; /* Dark green text */
    border: 1px solid #c3e6cb; /* Light green border */
    padding: 15px; /* Padding around the message */
    margin-bottom: 20px; /* Spacing between messages */
    border-radius: 5px; /* Rounded corners */
}

/* Error message */
.error-message {
    text-align: center;
    margin:80px;
    background-color: #f8d7da; /* Reddish background */
    color: #721c24; /* Dark red text */
    border: 1px solid #f5c6cb; /* Light red border */
    padding: 15px; /* Padding around the message */
    margin-bottom: 20px; /* Spacing between messages */
    border-radius: 5px; /* Rounded corners */
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
        <div style="height:65vh;">
            <%
              String status = request.getParameter("status");
              if(status.equals("success")){%>
                  <div class="success-message">
    <p><i class="fas fa-check-circle"></i> Email sent successfully!</p>
    <% response.sendRedirect("doctor-dashboard.jsp");%>
                  </div><%
                      }else{

%>
<div class="error-message">
    <p><i class="fas fa-exclamation-circle"></i> Error sending email: Please try again.</p>
</div>
<%

              }
            %>
        </div>
        
         <footer>
            <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
        </footer>
    </body>
</html>