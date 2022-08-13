

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;

import addEmployeePackage.addEmployeeServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
/**
 * Servlet implementation class Savepic
 * Servlet implementation class Savepic2
 */

@WebServlet("/MarkAttendance")
public class MarkAttendance extends HttpServlet {
	String folderpath="C:\\project\\exam";
	String folderattendance=folderpath+"\\markattendance\\";
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarkAttendance() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action = request.getParameter("action");
		String nextPath = "";

		String empid = request.getParameter("empid");
		HttpSession session = request.getSession(true);
		System.out.println(action);
		
		if(action==null)
		{
		//System.out.println("----"+request.getParameter("image"));	
		String base64String = request.getParameter("snapURL");
		
		String[] base64Array = base64String.split(",");
        String type = base64Array[0].split("/")[1].split(";")[0];
        String base64Image = base64Array[1];
        saveThisFile(base64Image, type ,"test");
        String empid1 = ComparingImagewithFolderImages.compareImage(folderpath, folderpath+"test.png");
        String message ="";
        try {
        	empid1 = empid1.replaceAll("\\.png","");
        	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
        	SimpleDateFormat formatter1 = new SimpleDateFormat("MM");  
            
        	Date date = new Date();  
            System.out.println(formatter.format(date));
           	// 1. Get a connection to database
           	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
           	Connection conn = DriverManager.getConnection(
   					"jdbc:mysql://localhost:3306/Payroll", "root", "rootpassword1");
           	String sql = "INSERT INTO attendance (emp_ID, day,primarykey,month) "
               		+ "values (? ,?,?,?)";
               PreparedStatement statement = conn.prepareStatement(sql);
               statement.setString(1, empid1);
               java.util.Date date1=new java.util.Date();
               java.sql.Date sqlDate=new java.sql.Date(date.getTime());
               statement.setDate(2,  sqlDate);
               statement.setString(3, empid1+formatter.format(date));
               statement.setString(4, formatter1.format(date));
               int row = statement.executeUpdate();          
        }catch(Exception e)
        {
        	e.printStackTrace();
        	message = "Employee Attendance already Marked " +empid1;
        }
        if(message.length()==0)
        message = "Employee Attendance Data Saved in the Database " +empid1;
        // sets the message in request scope
        request.setAttribute("Message", message);
         
        // forwards to the message page
        getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
        
		}
		
	}
		private void saveThisFile(String base64Image, String type, String empid) throws IOException {
			// TODO Auto-generated method stub
			
			
		      byte[] decoded = Base64.decodeBase64(base64Image);
		       

		        String extension = "png";
		        String newFilePath;
		       
		        String newFileName=empid+"."+extension;
		        newFilePath = folderpath+newFileName;
		        InputStream is = new ByteArrayInputStream(decoded);
		        FileOutputStream fos = new FileOutputStream(newFilePath);
		        BufferedOutputStream bos = new BufferedOutputStream(fos);
		        BufferedInputStream bis=new BufferedInputStream(is);
		        
		        int data;
		        int i=0;
		        while ((data = bis.read()) != -1) {
		        bos.write(data);
		        i++;
		        }
		        bis.close();
		        bos.close();
		        fos.close();
		}}
