<%-- 

    NEW ACCOUNT

--%>

<%@ page import="JavaClasses.User" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Exercise Tracker - New Account</title>
        
        <link rel="icon" href='Images/Icon.png'>
        
        <link href='CSS/NewAccount.css' rel='stylesheet' type='text/css'/>
    </head>
  
    <body>
        
        <!--top page switcher--> 
        <div class="topnav">
        <a href="NewAccount.jsp">Create an Account</a>
        <a href="index.jsp">Login</a>
        </div>   
        
        <div> <img id="image" alt="Logo" src='Images/Logo.png'> </div>

        <br/><br/><br/>
        
        <h1 id="topMessage">Creating an Account</h1>        

        <br/>
        
        <form action="NewAccount.jsp">
            
            
            <div class = "inputBox"> <p class = "input">First Name</p>  <input type="text" name="FName"/> </div>
            <div class = "inputBox"> <p class = "input">Last Name</p>  <input type="text" name="LName"/> </div>
            <div class = "inputBox"> <p class = "input">Email</p>  <input type="text" name="Email"/> </div>
            <div class = "inputBox"> <p class = "input">Username</p>  <input type="text" name="User"/> </div>
            
            <div class = "inputBox"> <p class = "input">Password</p>  <input type="password" name="Pass1"/> </div> 
            <div class = "inputBox"> <p class = "input">Confirm Password</p>  <input type="password" name="Pass2"/> </div>            
            
            <br/><br/>

            <%
                User u = new User();
                                
                // Seeing if the user has pressed submit
                if (request.getParameter("submit") != null) {

                    // Setting the data that the user entered into its respective variables
                    String FName = request.getParameter("FName");
                    String LName = request.getParameter("LName");
                    String Email = request.getParameter("Email");
                    String User = request.getParameter("User");
                    String Pass1 = request.getParameter("Pass1");
                    String Pass2 = request.getParameter("Pass2");
                        
                    // Setting the user's FirstName in a session attribute, for use in later pages
                    session.setAttribute("FName", FName);
                        
                    int check = u.checkNewUser(FName, LName, Email, User, Pass1, Pass2);
                        
                    // If the checkNewUser method returns 0, that means that they entered the correct informatiom
                    if (check == 0) {
                        u.addUser(FName, LName, Email, User, Pass1);
                            
                        // Setting the user's username and First Name in a session attribute, for use in later pages
                        session.setAttribute("FName", FName);
                        session.setAttribute("Username", User);
                        
                        // Stating that this is the first time in this session the user is visiting the main page, for later use 
                        // to make sure that no information is printed twice on the main page
                        session.setAttribute("Iteration", 1);
                            
                        response.sendRedirect("Main.jsp");
                        
                    // If checkNewUser returns a number between 1-5, there is an error    
                    } else if (check == 1) {
                        %> <div class="error"> <% out.println(u.getError1()); %> </div> <%
                    } else if (check == 2) {
                        %> <div class="error"> <% out.println(u.getError2()); %> </div> <%
                    } else if (check == 3) {
                        %> <div class="error"> <% out.println(u.getError3()); %> </div> <%
                    } else if (check == 4) {
                        %> <div class="error"> <% out.println(u.getError4()); %> </div> <%
                    } else if (check == 5) {
                        %> <div class="error"> <% out.println(u.getError5()); %> </div> <%
                    }
                } else {
                    %> <br/><br/> <%
                }
            %>
            
            <div id="inputButton"> <input type="submit" value="Enter" name = "submit"/> </div>     
            
        </form>
            <br/><br/>
            <br/><br/>
            <br/>
            
    </body>
</html>