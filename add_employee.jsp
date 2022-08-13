<%@page import="addEmployeePackage.GeneratePassword"%>

<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("roles").equals("2"))) {
%>
You need to be logged in as to view this page<br/>
<a href="login.jsp">Please Login</a>
<%
response.sendRedirect("login.jsp");
%>
<%} else {
%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Employee</title>
<!-- Basic CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="css/style.css" rel="stylesheet">
<%String no = GeneratePassword.randomPasswordIs();%>

</head>
<body>

<!-- Navigation Bar -->
<jsp:include page="nav.jsp"></jsp:include>

<div class="container">
<div class="col-md-5">
<h1>Add Employee</h1>
 <form method="post" action="addEmployeeServlet" > 
<label for="emp_ID">Employee ID:</label>
<input type="text" id="emp_ID" name="emp_ID" maxLength="10" minLength="6"  value="<%=no %>" class="form-control" required/>
<br/>
<label for="first_name">First Name:</label>
<input type="text" id="first_name" name="first_name" value="" class="form-control" required />
<br/>
<label for="last_name">Last Name:</label>
<input type="text" id="last_name" name="last_name" value="" class="form-control"  required/>
<br/>
<label for="gender">Gender:</label><br/>

<input type="radio" name="gender" value="male" required> Male <input type="radio" name="gender" value="female" required> Female
<br/><br/>
<label for="dob">Date Of Birth:</label>
<input type="date" id="dob" name="dob" min="1940-12-31" max="1998-12-31"  value="" class="form-control" required />
<br/>
<label for="email">Email Address:</label>
<input type="email" id="email" name="email" value="" class="form-control"  required/>
<br/>

<label for="phone_number">Phone Number:</label>
<input type="number" id="phone_number" name="phone_number" value="" class="form-control"  required/>
<br/>
<label for="address">Home Address:</label>
<textarea type="text" id="address" name="address" value="" class="form-control"  required></textarea>
<br>
<label for="Basic">Basic:</label>
<input type="number" id="basic" name="basic" value="0" class="form-control"  required onblur="incrSal()"/>
<br>
<label for="HRA">HRA:</label>
<input type="number" id="hra" name="hra" value="0" class="form-control"  required onblur="incrSal()"/>
<br>
<label for="Allowance">Allowance:</label>
<input type="number" id="Allowance" name="Allowance" value="0" class="form-control"  required onblur="incrSal()"/>
<br>
<label for="salary">Default Salary In rs(Yearly):</label>
<input type="text" id="salary" name="salary" value="0" class="form-control"  readonly="readonly"/>
<label for="date_joined">Date Joined:</label>
<input type="date" id="date_joined" name="date_joined" value="" class="form-control"  /><br>
<input type="reset" id="reset" name="reset" value="Reset" class="btn btn-warning"  />
<input type="submit" id="submit" name="submit" value="Add" class="btn btn-primary"  />
</form>

</div>



</div>



<script>

function incrSal(){
	
	var hra = document.getElementById("hra").value; 
	var basic = document.getElementById("basic").value; 
	var allowance = document.getElementById("Allowance").value; 
	document.getElementById("salary").value =parseInt(hra)+parseInt(basic)+parseInt(allowance);
	
	
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