<%@page import="com.Data.connjdbc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
        <%
        	Statement st = connjdbc.getDatacn();   
        	String delete_Fid = request.getParameter("delete_id");
        	int FId = Integer.parseInt(delete_Fid);

        	try {
        		int i = 0;
        		i = st.executeUpdate("Delete from cust_info where cust_id ="
        				+ FId + "");
        		if (i > 0) {
        			response.sendRedirect("customerdetails.jsp");
        		}
        	} catch (Exception e) {
        		System.out.print("Delete" + e);
        	}
        %>