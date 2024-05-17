<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.Properties"%>
<%@page import="org.xhtmlrenderer.pdf.ITextRenderer"%>
<%@page import="java.time.LocalDateTime"%>

<%
    // Fetch prescription ID from request parameter
    int prescriptionId = Integer.parseInt(request.getParameter("prescription_id"));
    String pemail = (String)request.getParameter("pemail");

    // Initialize database connection
    Connection con = null;
    ResultSet rsPrescription = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hospital2";
        String user = "root";
        String pass = "admin";
        con = DriverManager.getConnection(url, user, pass);

        // Fetch data from prescription table
        String sqlPrescription = "SELECT * FROM prescription WHERE prescription_id = ?";
        PreparedStatement pstmtPrescription = con.prepareStatement(sqlPrescription);
        pstmtPrescription.setInt(1, prescriptionId);
        rsPrescription = pstmtPrescription.executeQuery();

        // Create HTML content for the email
        StringBuilder emailContent = new StringBuilder();
        emailContent.append("<!DOCTYPE html>");
        emailContent.append("<html>");
        emailContent.append("<head>");
//        emailContent.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
        emailContent.append("<title>Generated Report</title>");
        emailContent.append("<style>"); // Add your CSS styles here
        emailContent.append("table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }");
        emailContent.append("th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }");
        emailContent.append("th { background-color: #f2f2f2; }");
        emailContent.append(".logo{float:left; margin-right: 20px; margin-top: 10px;} .header {overflow: hidden; background-color: #f2f2f2; padding: 20px 10px;text-align: center;}");
        
        // Add more CSS styles as needed
        emailContent.append("</style>");
        emailContent.append("</head>");
        emailContent.append("<body><center><div class='header'><img src='img/newlogo.png' width='65' height='60' class='logo'/><h1 class='title'>JK Multi-Specialist Hospital</h1></div><hr/><h3>Prescription</h3></center>");
        // Add content from the fetched data
        emailContent.append("<table>");
        // Add table headers
        emailContent.append("<thead><tr><th>Prescription ID</th><th>Patient Name</th><th>Age</th><th>Weight</th><th>Visit Date</th><th>Prescription</th><th>Patient ID</th><th>Doctor Name</th></tr></thead>");
        emailContent.append("<tbody>");
        while (rsPrescription.next()) {
            // Add table rows with data
            emailContent.append("<tr>");
            emailContent.append("<td>").append(rsPrescription.getInt("prescription_id")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getString("patient_name")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getInt("age")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getInt("weight")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getString("visit_date")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getString("prescription")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getString("patient_id")).append("</td>");
            emailContent.append("<td>").append(rsPrescription.getString("doctor_name")).append("</td>");
            emailContent.append("</tr>");
            // Fetch data from meal_timing table for each prescription

            String sqlMealTiming = "SELECT * FROM meal_timing WHERE prescription_id = ?";
            PreparedStatement pstmtMealTiming = con.prepareStatement(sqlMealTiming);
            pstmtMealTiming.setInt(1, prescriptionId);
            ResultSet rsMealTiming = pstmtMealTiming.executeQuery();
            emailContent.append("<tr>");
            emailContent.append("<td colspan=\"8\">");
            emailContent.append("<center>");
            emailContent.append("<h3>Medicine Details</h3>");
            emailContent.append("</center>");
            emailContent.append("<table>");
            emailContent.append("<thead><tr><th>Medicine</th><th>Dose</th><th>Meal Timing</th><th>Timing</th><th>No of Days</th></tr></thead>");
            emailContent.append("<tbody>");
            while (rsMealTiming.next()) {
                emailContent.append("<tr>");
                emailContent.append("<td>").append(rsMealTiming.getString("medicine")).append("</td>");
                emailContent.append("<td>").append(rsMealTiming.getInt("dose")).append("</td>");
                emailContent.append("<td>").append(rsMealTiming.getString("meal_timing")).append("</td>");
                String timing = rsMealTiming.getString("timing").replace("#", ", ");
                emailContent.append("<td>").append(timing).append("</td>");
                emailContent.append("<td>").append(rsMealTiming.getInt("no_of_days")).append("</td>");
                emailContent.append("</tr>");
            }
            emailContent.append("</tbody>");
            emailContent.append("</table>");
            emailContent.append("</td></tr>");
                       rsMealTiming.close();
            pstmtMealTiming.close();
        }
        emailContent.append("</tbody>");
        emailContent.append("</table><hr/>");
         emailContent.append(" <footer><center><p>Address: Besides Hotel Neelam, Opp. Empire Mall,Badnera Road, Amravati-444605 Maharashtra, India. <br/>Contact: 0721-4575688</p></center></footer>");

        emailContent.append("</body>");
        emailContent.append("</html>");

      
         

        // Generate PDF from HTML content
       String outputPath = "C:/Users/LENOVO/Documents/NetBeansProjects/Hospital/web/reports/" + prescriptionId + "file.pdf";
       // Change this path to your desired location
//     // Change this path to your desired location
//        String outputPath = "reports/"; // Change this path to your desired location
        OutputStream outputStream = new FileOutputStream(outputPath);
        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocumentFromString(emailContent.toString());
        renderer.layout();
        renderer.createPDF(outputStream);
        outputStream.close();

        // Send email with the PDF attachment
        final String username = "jkhospitalx@gmail.com";
        final String password = "cbayswcezziyoyzy";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session msgsession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(msgsession);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(pemail));
//        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(patientEmail));
        message.setSubject("Prescription Report");
        message.setText("Please find the attached prescription report.");

        // Attach PDF file to the email
        MimeBodyPart attachPart = new MimeBodyPart();
        attachPart.attachFile(new File(outputPath));

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(attachPart);
        message.setContent(multipart);

        Transport.send(message);

        response.sendRedirect("mail-sent.jsp?status=success");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("mail-sent.jsp?status=success");
//        out.println("<center><h4>Error sending email: " + e.getMessage() + "</h4></center>");
    } finally {
        // Close resources
        if (rsPrescription != null) {
            try {
                rsPrescription.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
