<%@ page  import="java.sql.*"  %>

<%
   String name = request.getParameter("name");
   String city = request.getParameter("city");
   String phone = request.getParameter("phone");
   /* Create string of connection url within specified 
   format with machine name, 
    port number and database name. Here machine name id 
    localhost and database name is student. */
    String connectionURL = "jdbc:mysql://localhost:3306/stu_info" ;
          // declare a connection by using Connection interface 
    Connection connection = null;
        // declare object of Statement interface that uses for 
    
     PreparedStatement pstatement = null;
         // Load JBBC driver "com.mysql.jdbc.Driver"
     Class.forName("com.mysql.jdbc.Driver").newInstance();
          int updateQuery = 0;
     
         // check if the text box is empty
         if(name!=null && city!=null && phone!=null){
                         // check if the text box having only blank spaces
             if(name!="" && city!="" && phone!="") {
                         try {
              /* Create a connection by using getConnection()
              method that takes parameters of string type 
              connection url, user name and password to connect 
                to database. */
              connection = DriverManager.getConnection
              (connectionURL, "root", "root");
                            // sql query to insert values in the secified table.
              String queryString = "INSERT INTO stu_info(Name, Address,Phone) VALUES (?, ?, ?) " ;
                      /* createStatement() is used for create statement
              object that is used for 
                sending sql statements to the specified database. */
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, name);
                          pstatement.setString(2, city);
                          pstatement.setString(3, phone);
              updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
                   <br>
                   <TABLE style="background-color: #E3E4FA;" 
                   WIDTH="30%" border="1">
                      <tr><th>Data is inserted successfully 
                    in database.</th></tr>
                   </table>
              <%
              }
            } 
            catch (Exception ex) {
            out.println("Unable to connect to batabase.");
   
               }
           
          }
        }
%>