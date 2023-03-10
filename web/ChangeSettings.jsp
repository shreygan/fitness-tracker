<%-- 
    CHANGE SETTINGS
--%>

<%@ page import="JavaClasses.User" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Exercise Tracker - Settings</title>
      
        <link rel="icon" href='Images/Icon.png'>
        
        <link href='CSS/ChangeSettings.css' rel='stylesheet' type='text/css'/>
        
    </head>
    <body>
        
        <!--top page switcher--> 
        <div class="topnav">
            <a href="index.jsp">Log Out</a>
            <a href="Settings.jsp">Settings</a>
            <a href="CreateExercises.jsp">Create Exercises</a>
            <a href="Calendar.jsp">Calendar</a>
            <a href="Main.jsp">Main Menu</a>
        </div>
        
        <br/><br/><br/><br/>
        
        <%
            User u = new User();
        %>

        <h1 id="topMessage">Change <% out.println(session.getAttribute("ChangeValue").toString()); %> </h1>  
        
        <form action="ChangeSettings.jsp">
        <%
            // Seeing what column in the database is going to changem, and displaying input options accordingly
            String column = "";
            if (session.getAttribute("ChangeValue").toString() == "Username") {
                column = "Username";
                %> 
                    <div class = "inputBox"> <p  class = "change">Enter New Username</p>  <input type="text" name="Username"/> </div> 
                    <div class = "inputBox"> <p  class = "change">Confirm New Username</p>  <input type="text" name="UsernameConfirm"/> </div>
                <%
            } else if (session.getAttribute("ChangeValue").toString() == "Password") {
                column = "Password";
                %> 
                    <div class = "inputBox"> <p  class = "change">Enter New Password</p>  <input type="password" name="Password"/> </div> 
                    <div class = "inputBox"> <p  class = "change">Confirm New Password</p>  <input type="password" name="PasswordConfirm"/> </div>
                <%
            } else if (session.getAttribute("ChangeValue").toString() == "Email") {
                column = "Email";
                %> 
                    <div class = "inputBox"> <p  class = "change">Enter New Email</p>  <input type="text" name="Email"/> </div> 
                    <div class = "inputBox"> <p  class = "change">Confirm New Email</p>  <input type="text" name="EmailConfirm"/> </div>
                <%
            }
            
            if (request.getParameter("submit") != null) {
                if (!request.getParameter(column).equals(request.getParameter(column + "Confirm"))) {
                    
                    // Printing error if the two inputs don't match when they should
                    %> <div class="error"> <% out.println(column + "'s"); %> Don't Match </div> <%                   
                } else if (column.equals("Email")) {
                    
                    if (!request.getParameter("Email").contains("@") || !request.getParameter("Email").contains(".")) {
                        %> <div class="error"> Please Enter a Valid Email </div> <%  
                    } else {
                        u.updateUser(session.getAttribute("Username").toString(), column, request.getParameter(column));
                    }

                    // Informing the user that the change was successful
                    %> <div class="success"> Change Successful! </div> <%  
                } else if (column.equals("Username")){                 
                    
                    int check = u.checkUser(request.getParameter("Username"));
                    
                    if (check == 1) {
                        // Get error #4 from User, and printing it to show the user
                        %> <div class="error"> <% out.println(u.getError4()); %> </div> <%
                    } else {
                        u.updateUser(session.getAttribute("Username").toString(), column, request.getParameter(column));
                           
                        session.setAttribute("Username", request.getParameter("Username"));
                        
                        // Informing the user that the change was successful
                        %> <div class="success"> Change Successful! </div> <% 
                    }                    
                } else if (column.equals("Password")) {
                    
                }
            }
        %>                    
            <div class="change"> <input type="submit" value="Enter" name = "submit"/> </div>             
        </form>        
        <br/><br/><br/><br/><br/><br/><br/><br/>
        <br/><br/><br/><br/><br/><br/><br/>
    </body>
</html>
