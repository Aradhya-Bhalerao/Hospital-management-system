<%@ page import="java.sql.*, java.io.*, javax.servlet.annotation.MultipartConfig" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Doctor</title>
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
        input[type="file"],
        input[type="password"]{
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
    .message{
        margin-bottom: 20px;
    }
    .form-group1 input{
        width: 30%;
        font-weight: 600;
    }
    input[type="number"] {
    -moz-appearance: textfield; /* Firefox */
}

input[type="number"]::-webkit-inner-spin-button, 
input[type="number"]::-webkit-outer-spin-button { /* WebKit */
    -webkit-appearance: none;
    margin: 0; /* Removes the default margin */
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
<div class="tabs">
  <a href="adminlogin.jsp?tab=doctors" class="tab-link active" onclick="openTab(event, 'doctors')">Doctors</a>
<a href="adminlogin.jsp?tab=receptionists" class="tab-link" onclick="openTab(event, 'receptionists')">Receptionists</a>
<a href="adminlogin.jsp?tab=patients" class="tab-link" onclick="openTab(event, 'patients')">Patients</a>

</div>
<div class="container">
    <h1>Add New Doctor</h1>
    <form action="AddNewDoctorServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="photo">Photo:</label>
            <input type="file" id="photo" name="photo" accept="image/*" required>
        </div>
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <label for="regno">Registration Number:</label>
        <input type="text" name="regno" id="regno" required>
        <div class="form-group">
            <label for="education">Education:</label>
            <input type="text" id="education" name="education" required>
        </div>
        <div class="form-group">
            <label for="experience">Experience:</label>
            <input type="number" id="experience" name="experience" required>
        </div>
        <div class="form-group1">
            <label for="fees">Doctor's Charges:</label>
            <label for="visit1">1st Visit:</label>
            <input type="number" id="visit1" name="visit1" required>
            <label for="visit2">2nd Visit:</label>
            <input type="number" id="visit2" name="visit2" required>
            <label for="visit3">3rd Visit:</label>
            <input type="number" id="visit3" name="visit3" required>
        </div>
        <div class="form-group">
            <label for="username">Username :</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password :</label>
            <input type="password" id="password" name="password" required>
        </div>
        
        <button type="submit">Add Doctor</button>
    </form>
</div>
     <%
            String message = request.getParameter("message");
            if (message != null && !message.isEmpty()) {
        %>
            <div class="message">
                <center>
                    
                <%= message %>
                </center>
            </div>
        <% 
            }
        %>
    
      <footer>
            <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
        </footer>

</body>
</html>