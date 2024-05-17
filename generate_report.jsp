<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generated Report</title>
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
        

        </style>
    </head>
    <body>
      

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
                <th>Mobile</th>
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
                <a href="sendEmail.jsp?prescription_id=<%=prescriptionId%>&pemail=<%=patientEmail%>" name="print" onclick="printCurrentPage()" style="text-decoration: none; color: #007bff; font-weight: bold; border: 1px solid #007bff; padding: 8px 16px; border-radius: 4px; background-color: #f8f9fa;">Print</a>
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
     <script>
            function printCurrentPage() {
                window.print();
            }
        </script>
</body>
</html>
