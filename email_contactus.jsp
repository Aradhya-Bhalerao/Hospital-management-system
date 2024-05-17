<%-- 
    Document   : email_contactus
    Created on : 24 Apr, 2024, 1:30:37 PM
    Author     : akash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%
    // Sender's email credentials
    final String username = "jkhospitalx@gmail.com";
    final String password = "cbayswcezziyoyzy";

    // Recipient's email address
    String to = "jkhospitalx@gmail.com";

    // Get values from HTML form
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobno = request.getParameter("mobno");
    String city = request.getParameter("city");
    String query = request.getParameter("query");

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
    Session msgsession = Session.getInstance(props,
        new javax.mail.Authenticator() {
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
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

        // Set Subject: header field
        message.setSubject("Contact Form Enquiry");

        // Set email content
        String emailContent = "Name : " + name + "\n";
        emailContent += "Email ID : " + email + "\n";
        emailContent += "Mobile No : " + mobno + "\n";
        emailContent += "City : " + city + "\n";
        emailContent += "Query : " + query;

        message.setText(emailContent);

        // Send message
        Transport.send(message);

        // Print a success message
 response.sendRedirect("contact.html?success=true");
    } catch (MessagingException e) {
        // Print any errors
        out.println("Error sending email: " + e.getMessage());
    }
%>    </body>
</html>