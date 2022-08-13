

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make Payment</title>
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
 <h2>Search Records(Day wise Payment)</h2>

 <form method="post" name="frm" action="SearchPayServlet">
 <div class="col-md-8">

<input class="form-control"  type="text" name="emp_ID" id="emp_ID" placeholder="Search Employee By ID eg. Emp001" required >
</div>

 <br><br><br><div class="col-md-8">
<select class="form-control" name="date_of_payment">
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
</select><input type="hidden" name="source_url" id="source_url" value="/makepayment.jsp" />
<br><br>
<input class="btn"  type="submit" name="search" id="search" value="Search">
</div>



</form>
<hr>
</div>
<%
String emp_id = request.getParameter("emp_ID");
String date_of_payment =request.getParameter("date_of_payment");
String mins =request.getParameter("mins");
Calendar cal = Calendar.getInstance();
int res = cal.getActualMaximum(Calendar.DATE);
System.out.println("Today's Date = " + cal.getTime().getDate());
System.out.println("Last Date of the current month = " + res);



if(emp_id!=null )
{%>
<div class="table-horizontal-container">
    <table class="unfixed-table">
    <tr>
     
      <th>Employee Id</th>
       <th>Date</th>
      <th>Make Payment</th>      
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
	String validateUser = "select count(*) from  attendance where emp_id=? and month=?";
	PreparedStatement preparedStatement;
	try {
		preparedStatement = conn.prepareStatement(validateUser);
		preparedStatement.setString(1, emp_id);
		preparedStatement.setString(2, date_of_payment);
		ResultSet result=preparedStatement.executeQuery();
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
		
		while(result.next())
		{
      %>
		<tr>
		<td><%=emp_id%></td>
       <td><%=formatter.format(date)%></td>
        <td><a href="makepayment.jsp?emp_id=<%=emp_id%>&date_of_payment=<%=date_of_payment%>&mins=<%=result.getString(1)%>">Generate Payslip</a></td>
      </tr>
		<% 
		
		}
	}
	catch (Exception e) {
		e.printStackTrace();
	}
}else if(mins != null)
{
	if(cal.getTime().getDate()!=res)
	{%>
	<script>
	alert("Month is yet to complete!!Cant generate Payslip");
	</script>
	
	<%
		
	/*   }else{  */
	emp_id = request.getParameter("emp_id");
	 date_of_payment =request.getParameter("date_of_payment");
	%>
	<div class="table-horizontal-container">
	    <table class="unfixed-table">
	    <tr>
	      <th>Gross Salary(Month)</th>
	      <th>Salary Per Day</th>   
	      <th>Present Day</th>
	      <th>Deductions</th>
	      <th>Net Salary</th>  
	         
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
		String validateUser = "select salary from  employees_tb where emp_id=?";
		PreparedStatement preparedStatement;
		try {
			preparedStatement = conn.prepareStatement(validateUser);
			preparedStatement.setString(1, emp_id);
			ResultSet result=preparedStatement.executeQuery();%>
			<%=preparedStatement.toString()%><% 
			while(result.next())
			{
				DecimalFormat df = new DecimalFormat("0.00");
				String salary = result.getString(1);
				double isalary = Double.parseDouble(salary);
				double daymins = 365;
				int totalminsinoffice = 0;
				double actualsalarypermins =isalary/daymins;
				/* if(date_of_payment.equals("1")||date_of_payment.equals("3")||date_of_payment.equals("5")||
						date_of_payment.equals("7")||date_of_payment.equals("8")||date_of_payment.equals("10")||date_of_payment.equals("12")
						)
				 totalminsinoffice = 31-Integer.parseInt(mins);
				else if(date_of_payment.equals("2"))
					totalminsinoffice = 28-Integer.parseInt(mins);
				else
					totalminsinoffice = 30-Integer.parseInt(mins); */
				double netsalary = Integer.parseInt(mins)*actualsalarypermins;
				
	      %>
			<tr>
			<td><%=isalary/12%></td>
	       <td><%= df.format(actualsalarypermins)%></td>
	        <td><%=mins %></td>
	        <td><%=df.format(isalary/12 -netsalary )%></td>
	         <td><%=df.format(netsalary)%></td>
	      </tr>
			<% 
			String query1="insert into payslip (emp_id,date_of_payment,gross_salary,allowances,deductions,net_salary) values (?,?,?,?,?,?)";				 
			 PreparedStatement ps1=conn.prepareStatement(query1);				 
			 ps1.setString(1,emp_id);
			 ps1.setString(2, date_of_payment);
			 ps1.setString(3, salary);
			 ps1.setString(4, emp_id+date_of_payment);
			 ps1.setString(5,df.format(isalary -netsalary )+"");
			 ps1.setString(6, df.format(netsalary)+"");
			int i= ps1.executeUpdate();
			if(i==1){
			%>
			
			<script>
			
			
			alert("Payslip Generated")
			</script>
			<%}else{%>
			
		<script>
			
			
			alert("Payslip Already Generated")
			</script>
			<%  
			}}
		}
		catch (Exception e) {
			%>
			
			<script>
				
				
				alert("Payslip Already Generated")
				</script>
				<% 
			e.printStackTrace();
		}
	}	

}

}
%>
</table>



</div>
</div>


