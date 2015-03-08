
<%@page import="com.Data.connjdbc"%>
<%@ page import="java.sql.*"%>

<%
	String orderdate = request.getParameter("odate");
	String billto = request.getParameter("billto");
	int shipto = Integer.parseInt(request.getParameter("shipto"));
	String batchno=null;
	//String edate = null;
	String invoice = request.getParameter("invoice");	
	String shippedby = request.getParameter("shipby");
	String tracking = request.getParameter("tracking");
	
	String submittype = request.getParameter("submit");
	String username= session.getAttribute("username")+"";
	String ordernumber = request.getParameter("ordernumber");
	int custid = Integer.parseInt(billto);
	
	Statement st = connjdbc.getDatacn();
	int defaultquantity = 0;
	
	try {
		if(submittype.equals("Add")){
			int i = 0;			
			/*ResultSet rs = st.executeQuery("SELECT * FROM stock_info WHERE item_id= "+batch);
			
			if(rs.next()){
				batchno = rs.getString(3);
				edate = rs.getString(7);
				defaultquantity = rs.getInt(5);				
			}
			if(defaultquantity < Integer.parseInt(quantity)){
				
				session.setAttribute("quantityerror", "Available quantity is only "+defaultquantity );
				response.sendRedirect("addsales.jsp");*/
				
					
				String str = "INSERT INTO sales_info(dispatch_date,bill_to,ship_to,invoice,ordernumber,shipped_by,tracking,entry_by) VALUES('"
						+ orderdate + "'," + billto + ","+shipto+",'"+invoice+"','"+ordernumber+"','"+shippedby+"','"+tracking+"','"+username+"')";	
				i = st.executeUpdate(str);
				//i+=st.executeUpdate("UPDATE stock_info SET quantity=quantity-'"+quantity+"' WHERE item_id="+itemcode);
				ResultSet rs = st.executeQuery("SELECT sales_id FROM sales_info where tracking='"+tracking+"' AND invoice='"+invoice+"'");
				int id = 0;
				if(rs.next()){
					id = rs.getInt(1);
				}
				if (i > 0) {
					session.setAttribute("add", "Successfully Added!");
					session.setAttribute("salesid", id);
					response.sendRedirect("addsalesitem.jsp");
				} else{
					session.setAttribute("add", "Not Successfully Added!");
					response.sendRedirect("addsales.jsp");
				}
			
		}else if(submittype.equals("Update")){
			int i  = 0;
			String s = session.getAttribute("editid")+"";
			int id = Integer.parseInt(s);
			String str = "UPDATE sales_info SET dispatch_date='"+orderdate+"',bill_to="+billto+",ship_to="+shipto+",invoice='"+invoice+"',shipped_by='"+shippedby+"',tracking='"+tracking+"',ordernumber='"+ordernumber+"' WHERE sales_id="+id;
			i = st.executeUpdate(str);
			if(i > 0){
				session.setAttribute("update", "Successfully Updated!");
				response.sendRedirect("totalsales.jsp");
				
			}else{
				session.setAttribute("update", "Not Successfully Updated!");
				response.sendRedirect("totalsales.jsp");
			}			
		}
		
	} catch (Exception e) {
		System.out.println(e);
	}
%>
