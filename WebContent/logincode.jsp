<%@page import="com.Data.connjdbc"%>
<%@ page pageEncoding="ISO-8859-1"  %>

<%@ page import = "java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
  	Statement st=connjdbc.getDatacn();
  	session.setAttribute("loginerror","");
  	try
    {
        int i=0;
        String str = "SELECT * from login_info WHERE username = '"+username+"'";
        ResultSet rs  = st.executeQuery(str);
        if(rs.next()){
        	
        	if(rs.getString(3).equals(password)){
        		session.setAttribute("username", username);
        		response.sendRedirect("totalsales.jsp");
        	}else{
        		session.setAttribute("loginerror","Wrong Username & Password!");
            	response.sendRedirect("login.jsp");
        	}
        }else{
        	session.setAttribute("loginerror","Wrong Username & Password!");
        	response.sendRedirect("login.jsp");
        }
   }catch(Exception e){
        System.out.println(e);
    }
%>

