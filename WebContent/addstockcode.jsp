
<%@page import="com.Data.connjdbc"%>
<%@ page import="java.sql.*"%>

<%
	String item_code = request.getParameter("itemcode");
	String batch = request.getParameter("batch");
	String packing = request.getParameter("packing");
	String quantity = request.getParameter("quantity");
	String mdate = request.getParameter("manufacture");
	String edate = request.getParameter("expiry");
	String submittype = request.getParameter("submit"); 
	Statement st = connjdbc.getDatacn();
	
	
	try {
		if(submittype.equals("Add")){
			int i = 0;
			String str = "INSERT INTO stock_info(item_code,batch_no,packing,quantity,date_of_manufacture,date_of_expiry) VALUES('"
					+ item_code + "','" + batch + "','"+packing+"','"+quantity+"','"+mdate+"','"+edate+"')";
	
			System.out.println(str);
			i = st.executeUpdate(str);
			out.println("successfully added");
			if (i > 0) {
				session.setAttribute("add", "Successfully Added!");
				response.sendRedirect("addstock.jsp");
			} else{
				session.setAttribute("add", "Not Successfully Added!");
				response.sendRedirect("addstock.jsp");
			}
		}else if(submittype.equals("Update")){
			int i  = 0;
			String s = session.getAttribute("editid")+"";
			int id = Integer.parseInt(s);
			String str = "UPDATE stock_info SET item_code='"+item_code+"',batch_no='"+batch+"',packing='"+packing+"',quantity='"+quantity+"',date_of_manufacture='"+mdate+"',date_of_expiry='"+edate+"' WHERE item_id="+id;
			i = st.executeUpdate(str);
			if(i > 0){
				session.setAttribute("update", "Successfully Updated!");
				response.sendRedirect("currentstock.jsp");
				
			}else{
				session.setAttribute("update", "Not Successfully Updated!");
				response.sendRedirect("currentstock.jsp");
			}			
		}
		
	} catch (Exception e) {
		System.out.println(e);
	}
%>
