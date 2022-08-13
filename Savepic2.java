

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

/**
 * Servlet implementation class Savepic
 * Servlet implementation class Savepic2
 */

@WebServlet("/Savepic2")
public class Savepic2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Savepic2() {
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
        saveThisFile(base64Image, type ,addEmployeeServlet.emp_ID);
       String message = "Employee Data Saved in the Database";
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
		        newFilePath = "C:\\project\\exam\\"+newFileName;
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
