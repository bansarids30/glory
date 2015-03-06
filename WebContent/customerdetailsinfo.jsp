
<%@page import="com.Data.connjdbc"%>
<%@ page import="java.sql.*"%>

<%
	String name = request.getParameter("name");
	String company = request.getParameter("company");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String country = request.getParameter("country");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String email = request.getParameter("email");
	String submittype = request.getParameter("submit"); 
	Statement st = connjdbc.getDatacn();
	session.setAttribute("custadd","");
	session.setAttribute("custupdate", "");
	
	try {
		if(submittype.equals("Add")){
			int i = 0;
			String str = "INSERT INTO cust_info(company_name,address1,address2,city,state,zipcode,country,phone1,phone2,email) VALUES('"
					+ company + "','"+address1+"','"+address2+"','"+city+"','"+state+"','"+zipcode+"','"+country+"','"+phone1+"','"+phone2+"','"+email+"')";	
			i = st.executeUpdate(str);
			if (i > 0) {
				session.setAttribute("custadd", "Successfully Added!");
				response.sendRedirect("customerdetails.jsp");
			} else{
				session.setAttribute("custadd", "Not Successfully Added!");
				response.sendRedirect("customerdetails.jsp");
			}
		}else if(submittype.equals("Update")){
			int i  = 0;
			String s = session.getAttribute("editid")+"";
			int id = Integer.parseInt(s);
			String str = "UPDATE cust_info SET company_name='"+company+"',address1='"+address1+"',address2='"+address2+"',city='"+city+"',state='"+state+"',zipcode='"+zipcode+"',country='"+country+"',phone1='"+phone1+"',phone2='"+phone2+"',email='"+email+"' WHERE cust_id="+id;
			i = st.executeUpdate(str);
			if(i > 0){
				session.setAttribute("custupdate", "Successfully Updated!");
				response.sendRedirect("customerdetails.jsp");
				
			}else{
				session.setAttribute("custupdate", "Not Successfully Updated!");
				response.sendRedirect("customerdetails.jsp");
			}			
		}
		
	} catch (Exception e) {
		System.out.println(e);
	}
%>
