  <%-- 
    Document   : doctor
    Created on : Apr 24, 2024, 9:46:08 AM
    Author     : vaish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Doctor's</title>
    <style>
 
      /* Footer styles */
footer {
    background-color: #5a2f90; /* Dark purple */
    color: white; /* White text */
    text-align: center;
    height: 55px;
    font-family: "Inter", sans-serif;
    padding: 10px;
    width: 100%; /* Full width */
}

footer p {
    color: white; /* White text */
    margin: 0; /* Remove default margin */
}

body {
    font-family: sans-serif;
    margin: 0;
    padding: 0;
    background-image: url('img/doctorlogin.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    display: flex; /* Use flexbox */
    flex-direction: column; /* Arrange children in a column */
    min-height: 100vh; /* Ensure the body fills the viewport */
}

/* Ensure the main content area grows to fill the remaining space */
form {
    flex-grow: 1;
}


        /* Navbar styles */
.navbar {
    /*background-color: white;*/
    overflow: hidden;
    display: flex;
    align-items: center; /* Center vertically */
    box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
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
    background-color: #5a2f90; /* Dark purple on hover */
    color: white; /* White text */
}

.dropdown:hover .dropdown-content {
    display: block;
}



       /* Form styles */
form {
    /*background-color: #f9f9f9;*/
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 700px;
    margin: 2px 150px ;
    
}

h1 {
    text-align: center;
    color: #5a2f90;
    margin-top:0px;
    margin-bottom:10px;
}

label {
    font-weight: bold;
    color: #5a2f90;
}

input[type="text"],
input[type="number"],
input[type="date"],
select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #5a2f90;
    border-radius: 5px;
    box-sizing: border-box;
}

input[type="submit"] {
    width: 50%;
    background-color: #ea345c;
    color: white;
    padding: 14px 20px;
    margin-top: 10px;
    margin-left: 25%;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.btn-add{
    width: 30%;
    background-color: #ea345c;
    color: white;
    padding: 15px;
    margin-top: 10px;
    margin-left: 45%;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.btn-add{
     box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}

input[type="submit"]:hover {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
}
.plusimg{
    height: 30px;
    width: 30px;
    
}
input[type="number"] {
    -moz-appearance: textfield; /* Firefox */
}

input[type="number"]::-webkit-inner-spin-button, 
input[type="number"]::-webkit-outer-spin-button { /* WebKit */
    -webkit-appearance: none;
    margin: 0; /* Removes the default margin */
}

 @media print {
    /* Hide the navbar during printing */
    .navbar {
        display: none;
    }

    /* Hide the footer during printing */
    footer {
        display: none;
    }
    
    /* Hide buttons during printing */
    input[type="submit"], button {
        display: none;
    }
}
    </style>
</head>
<body>
    <%
    String user_id = request.getParameter("patient_id");
    String url = "jdbc:mysql://localhost:3306/hospital2";
    String username = "root";
    String password = "admin";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, username, password);
        
        // Prepare SQL statement to fetch data from patientreg table
        String sql = "SELECT Name, Doctor, Gender, MobileNo, Email, Age, Weight, Address, Visit, Fees " +
                     "FROM patientreg " +
                     "WHERE MobileNo = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, user_id);
        
        // Execute the query
        ResultSet rs = pstmt.executeQuery();
        
        // Display the fetched data
        if (rs.next()) {
            String name = rs.getString("Name");
            String doctor = rs.getString("Doctor");
            String gender = rs.getString("Gender");
            String mobileNo = rs.getString("MobileNo");
            String email = rs.getString("Email");
            int age = rs.getInt("Age");
            int weight = rs.getInt("Weight");
            String address = rs.getString("Address");
            String visit = rs.getString("Visit");
            double fees = rs.getDouble("Fees");
%>
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
        <a href="contact.html">Contact</a>
    </div>
</div>
<form action="Give" method="post">
    <h1>Patient Diagnosis</h1>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="pname" style="width: 150px;">Patient's Name</label>
        <input type="text" name="pname" value="<%=name%>" style="flex: 1;" required/>
       
    </div>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="age" style="width: 150px;">Age</label>
        <input type="number" name="age" value="<%=age%>" style="flex: 1;" required/>
    </div>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="weight" style="width: 150px;">Weight</label>
        <input type="number" name="weight" value="<%=weight%>" style="flex: 1;" required/>
    </div>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="medicine" style="width: 150px;">Medicine</label>
       <select class="medicine-dropdown" id="medicine" name="medicine" style="flex: 1;">
           <option value="new">New</option>
                <!-- Code to populate dropdown options from medicine table -->
                <% 
                Statement stmt = con.createStatement();
                ResultSet medicineResultSet = stmt.executeQuery("SELECT * FROM med");
                while (medicineResultSet.next()) { 
                %>
                <option value="<%=medicineResultSet.getString("medicine_name")%>"><%=medicineResultSet.getString("medicine_name")%></option>
                <% 
                }
                medicineResultSet.close();
                stmt.close();
                %>
            </select>
            
        
    </div>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="newMedicine" style="width: 150px;">Add New Medicine</label>
       
        <input type="text" name="newMedicine" id="newMedicine" placeholder="Add New Medicine" class="medicine-input" style="flex: 1;"/>
      <a href=""><img class="plusimg" src="img/plus.png"  onclick="addNewMed()"/></a>
    </div>
          
    <div style="display: flex; margin-bottom: 15px;">
        <label for="dose" style="width: 150px;">Dose</label>
        <input type="text" name="dose"  id="dose" value="" style="flex: 1;" />
       
    </div>
            <!-- Add a timing label and radio buttons for meal timing -->
<div style="display: flex; margin-bottom: 15px;">
    <label for="doseTime" style="width: 150px;">Timing</label>
    <div>
        <select name="mealTiming">
            <option value="Before Meal">Before Meal</option>
            <option value="After Meal">After Meal</option>
        </select>
      
    </div>
</div>

<!-- Add checkboxes for morning, afternoon, and night -->
<div style="display: flex; margin-bottom: 15px;">
    <label for="timing" style="width: 150px;"></label>
    <div>
        <select  name="timing">
            <option value="Morning">Morning</option>
            <option value="Afternoon">Afternoon</option>
            <option value="Night">Night</option>
            <option value="Morning-Afternoon">Morning,Afternoon</option>
            <option value="Afternoon-Night">Afternoon,Night</option>
            <option value="Morning-Night">Morning,Night</option>
            <option value="Morning-Afternoon-Night">Morning,Afternoon,Night</option>

        </select>
      
    </div>
</div>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="noofday" style="width: 150px;">No of days</label>
        <input type="number" name="noofday" id="noofday" value="" style="flex: 1;" required/>
       
    </div>
            <button type="button" onclick="addMedicine()" class="btn-add">Add Medicine & Dose</button>
            <!-- Table to display added medicines -->
            <center>
                
                <table id="medicineTable" border="1" style="background-color:white; border: 1px solid black; border-radius: 10px; margin-top: 10px; margin-bottom: 10px;">
            <thead>
                <tr>
                    <th>Medicine</th>
                    <th>Dose</th>
                    <th>No of Days</th>
                    <th>Timing</th>
                    <th>After/Before Meal</th>
                </tr>
            </thead>
            <tbody id="medicineBody"> 
                <!-- Medicine rows will be dynamically added here -->
            </tbody>
        </table>
            </center>
    <div style="display: flex; margin-bottom: 15px;">
        <label for="visitdate" style="width: 150px;">Next visit</label>
        <input type="date" name="visitdate" value="" style="flex: 1;" required/>
    </div>
    <div style="display: flex; align-items: center; margin-bottom: 15px;">
        <label for="visitdate" style="width: 150px;">Prescription</label>
        <textarea name="prescription" rows="5" cols="70"></textarea>
    </div>
            <input type="hidden" name="patient_id" value="<%=user_id%>"/>
    <input type="hidden" name="medicineData" id="medicineData" value=""/>
    <input type="submit" value="Submit"  style="width: 50%; margin-left: 25%; margin-top: 15px;" />
</form>
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
    


<%
        }
        
        // Close resources
        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


<footer>
    <p>© 2024 JK Multispecialist Hospital Amravati. All Rights Reserved.</p>
</footer>
<script>

function addMedicine() {
    var medicineSelect = document.getElementById("medicine");
    var medicine = "";
    var dose = document.getElementById("dose").value;
    var noOfDays = document.getElementById("noofday").value;
//    var mealTiming = document.querySelector('input[name="mealTiming"]:checked') ? document.querySelector('input[name="mealTiming"]:checked').value : "";
    var mealTimingDropdown = document.querySelector('select[name="mealTiming"]');
    var mealTiming = mealTimingDropdown.options[mealTimingDropdown.selectedIndex].value;
//    var timingCheckboxes = document.querySelectorAll('input[name="timing"]:checked');
//    var timing = [];
 var timingDropdown = document.querySelector('select[name="timing"]');
    var timing = timingDropdown.options[timingDropdown.selectedIndex].value;

    // Check if "new" is selected in the dropdown
    if (medicineSelect.value === "new") {
        // Get the value from the newMedicine input field
        medicine = document.getElementById("newMedicine").value.trim();
    } else {
        // Get the selected value from the dropdown
        medicine = medicineSelect.value;
    }

    // Create a new row with medicine, dose, no of days, timing, and meal timing
    var row = "<tr><td>" + medicine + "</td><td>" + dose + "</td><td>" + noOfDays + "</td><td>";
    
    // Add timing checkboxes if any selected
//    timingCheckboxes.forEach(function(checkbox) {
//        timing.push(checkbox.value);
//    });
//    row += timing.join(", ");
    row += timing;
    
    // Close timing table cell and add meal timing
    row += "</td><td>" + mealTiming + "</td></tr>";

    // Append the row to the table body
    document.getElementById("medicineBody").innerHTML += row;

    // Update the hidden input with added medicine data
    var medicineData = document.getElementById("medicineData").value;
    medicineData += medicine + "," + dose + "," + noOfDays + "," + timing + "," + mealTiming + ";";
    document.getElementById("medicineData").value = medicineData;
}


  function addNewMed() {
            // Get the value entered in the "New Medicine" input field
            var newMedicine = document.getElementById("newMedicine").value.trim();
            
            // Create a new AJAX request
            var xhr = new XMLHttpRequest();
            
            // Configure the request
            xhr.open("POST", "insertMedicine.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            
            // Define the callback function
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // The request was successful, do something if needed
                        console.log("Medicine inserted successfully!");
                    } else {
                        // There was an error with the request
                        console.error("Error inserting medicine:", xhr.statusText);
                    }
                }
            };
            
            // Send the request with the medicine name as a parameter
            xhr.send("medicineName=" + encodeURIComponent(newMedicine));
        }
</script>

</body>

</html>