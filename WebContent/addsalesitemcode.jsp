
<%@page import="com.Data.connjdbc"%>
<%@ page import="java.sql.*"%>

<%
	Statement st = connjdbc.getDatacn();
	ResultSet rs = null;
	String submittype = request.getParameter("submit");
	String itemcode = request.getParameter("itemcode");
	String packing = request.getParameter("packing");
	String batch = request.getParameter("batchno");
	String quantity = request.getParameter("quantity");	
	String batchno = null;
	
	String edate=null;
	int defaultquantity = 0;
	//try {
		if(submittype.equals("Update")){
			String id = session.getAttribute("editid")+"";
			if(id != null){
				int editid = Integer.parseInt(id),i = 0;
				int originalquantity = 0;
				int originalid = 0;
				rs = st.executeQuery("SELECT * FROM item_sales where id = "+editid);
				if(rs.next()){
					originalid = rs.getInt(8);
					originalquantity = rs.getInt(5);
				}	
								
				System.out.println(originalquantity);
				rs = st.executeQuery("SELECT * FROM stock_info where item_id="+batch);
				while(rs.next()){
					batchno = rs.getString(3);
				}
				
				i = st.executeUpdate("UPDATE stock_info SET quantity=quantity + "+originalquantity+" WHERE item_id="+originalid);
				i = st.executeUpdate("UPDATE item_sales SET quantity='"+quantity+"',item_code='"+itemcode+"',batchno='"+batchno+"',packing='"+packing+"',item_id="+batch+" WHERE id="+editid);				
				i = st.executeUpdate("UPDATE stock_info SET quantity=quantity - "+quantity+" WHERE item_id="+batch);
				if(i >0){
					response.sendRedirect("totalsales.jsp");
				}
			}
		}else{
			String oid = session.getAttribute("salesid")+"";
			int orderid = oid!=null?Integer.parseInt(oid):0;
			
			int i = 0;	
			
			rs = st.executeQuery("SELECT * FROM stock_info WHERE item_id= "+batch);
			if(rs.next()){
				batchno = rs.getString(3);
				edate = rs.getString(7);
				defaultquantity = rs.getInt(5);				
			}
			
			rs = st.executeQuery("SELECT * FROM item_sales WHERE order_id="+oid+" AND item_code='"+itemcode+"' AND batchno='"+batchno+"' AND packing="+packing+"");
			if(rs.next()){
				session.setAttribute("duplicateentry","Duplicate Entry!");
				response.sendRedirect("addsalesitem.jsp?salesid="+oid);	
			}
			else{
				if(defaultquantity < Integer.parseInt(quantity)){				
					session.setAttribute("quantityerror", "Available quantity is only "+defaultquantity );
					response.sendRedirect("addsalesitem.jsp");				
				}else{	
					i = st.executeUpdate("INSERT INTO item_sales(item_code,batchno,packing,quantity,order_id,expiry_date,item_id) VALUES('"+itemcode+"','"+batchno+"','"+packing+"','"+quantity+"',"+oid+",'"+edate+"',"+batch+")");
					if(i>0){
						i += st.executeUpdate("UPDATE stock_info SET quantity=quantity-'"+quantity+"' WHERE item_id="+batch+"");
					}
					if(i > 1){
						if(submittype.equals("Add & Exit")){
							response.sendRedirect("addsales.jsp");
						}else if(submittype.equals("Add & Add more")){
							response.sendRedirect("addsalesitem.jsp");
						}else{
							response.sendRedirect("totalsales.jsp");
						}
					}
				}
			}
		}/*else{
			String orderid = session.getAttribute("salesid")+"";
			int oid = orderid!=null?Integer.parseInt(orderid):0;		
			int i = 0;			
			rs = st.executeQuery("SELECT * FROM stock_info WHERE item_id= "+batch);
			if(rs.next()){
				batchno = rs.getString(3);
				edate = rs.getString(7);
				defaultquantity = rs.getInt(5);				
			}
			if(defaultquantity < Integer.parseInt(quantity)){				
				session.setAttribute("quantityerror", "Available quantity is only "+defaultquantity );
				response.sendRedirect("addsalesitem.jsp");				
			}else{	
				i = st.executeUpdate("INSERT INTO item_sales(item_code,batchno,packing,quantity,order_id,expiry_date,item_id) VALUES('"+itemcode+"','"+batchno+"','"+packing+"','"+quantity+"',"+oid+",'"+edate+"',"+batch+")");
				if(i>0){
					i += st.executeUpdate("UPDATE stock_info SET quantity=quantity-'"+quantity+"' WHERE item_id="+batch+"");
				}
				if(i > 1){
					if(submittype.equals("Add & Exit")){
						response.sendRedirect("addsales.jsp");
					}else if(submittype.equals("Add & Add more")){
						response.sendRedirect("addsalesitem.jsp");
					}
				}
			}
			
		response.sendRedirect("addsalesitem.jsp");
		}*/

	
%>
