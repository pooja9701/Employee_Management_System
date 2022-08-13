
<%@page import="java.sql.*"%>
<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("roles").equals("1"))) {
%>
You need to be logged in as to view this page<br/>
<a href="login.jsp">Please Login</a>
<%
response.sendRedirect("login.jsp");
%>
<%} else {
%>
<%@ page import="java.util.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Employee</title>
<!-- Basic CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="css/style.css" rel="stylesheet">


<style>
/* default styling. Nothing to do with freexing first row and column */
main {display: flex;}
main > * {border: 1px solid;}
table {border-collapse: collapse; font-family: helvetica}
td, th {border:  1px solid;
      padding: 10px;
      min-width: 200px;
      background: white;
      box-sizing: border-box;
      text-align: left;
}
.table-container {
  position: relative;
  max-height:  300px;
  width: 500px;
  overflow: scroll;
}

thead th {
  position: -webkit-sticky;
  position: sticky;
  top: 0;
  z-index: 2;
  background: hsl(20, 50%, 70%);
}

thead th:first-child {
  left: 0;
  z-index: 3;
}

tfoot {
  position: -webkit-sticky;
  bottom: 0;
  z-index: 2;
}

tfoot td {
  position: sticky;
  bottom: 0;
  z-index: 2;
  background: hsl(20, 50%, 70%);
}

tfoot td:first-child {
  z-index: 3;
}

tbody {
  overflow: scroll;
  height: 200px;
}

/* MAKE LEFT COLUMN FIXEZ */
tr > :first-child {
  position: -webkit-sticky;
  position: sticky; 
  background: hsl(180, 50%, 70%);
  left: 0; 
}
/* don't do this */
tr > :first-child {
  box-shadow: inset 0px 1px black;
}




</style>
</head>
<body>

<!-- Navigation Bar -->
<jsp:include page="nav.jsp"></jsp:include>

<div class="container">
<div class="row">
 <h2>View Attendance</h2>

 <form method="post" name="frm" action="viewemployeeattendance.jsp">
  <div class="col-md-8">
<select class="form-control" name="month">
<option value="01">January</option>

<option value="02">Feburary </option>

<option value="03">March</option>

<option value="04">April</option>

<option value="05">May</option>

<option value="06">June</option>

<option value="07">July</option>

<option value="08">August</option>

<option value="09">September</option>

<option value="10">October</option>

<option value="11">November</option>

<option value="12">December</option>
</select>
</div>


 <div class="col-md-4">
<input type="hidden" name="source_url" id="source_url" value="/viewattendance.jsp" />
<input class="btn"  type="submit" name="search" id="search" value="Search">
</div>



</form>
<hr>
</div>
<br>
<br>
<div class="row">
<div class="col-md-5">


<%
int c=0;
String emp_id = (String)session.getAttribute("empid");
String month = (String)request.getParameter("month");
if(month!=null)
{%>
<div class="table-horizontal-container">
    <table class="unfixed-table">
    <tr>
      <th>Present Date(yyyy-mm-dd)</th>
    </tr>
<% 
Connection conn=null;
try{String username="root";
String password="rootpassword1";
String DB_URL = "jdbc:mysql://localhost/payroll";
	      //STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");

	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,username,password);
	      System.out.println("Connecting to database.done..");
	   }
	   catch (Exception e) {
		// TODO: handle exception
		   System.out.println("Unable to connect Database");
	}

	String validateUser = "select * from  attendance where emp_id=? and month=?";
	PreparedStatement preparedStatement;
	try {
		preparedStatement = conn.prepareStatement(validateUser);
		preparedStatement.setString(1, emp_id);
		preparedStatement.setString(2, request.getParameter("month"));
		ResultSet result=preparedStatement.executeQuery();
		while(result.next())
		{c++;
			String abc = "https://www.google.com/maps/dir/"+result.getString(4)+","+result.getString(3);
      %>
		<tr>
		<td><%=result.getString(2)%></td>
      </tr>
		<% 
			
		}
		%><tr>
		<td style="background-color: white">Total Present day <%=c%></td>
      </tr><% 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
}
%>

</table>
</div>
</div>


</div>



<script>

function ChangeSalary(){
	
	var desg = document.getElementById("desig").value; 

	

	
	
	switch(desg) {
    case "Receptionist":
    	document.getElementById("salary").value =1500;
    	
        break;
    case "Cleaner":
    	
    	document.getElementById("salary").value =600;
        break;
        
    case "Developer":
    	document.getElementById("salary").value =6000;
        break;
    case "Project_Manager":
    	document.getElementById("salary").value =15000;
        break;
    case "Accountant":
    	document.getElementById("salary").value =3000;;
        break;
    default:
        salary =0;
}
	
}
</script>

 <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>
</html>

<%

}

%>