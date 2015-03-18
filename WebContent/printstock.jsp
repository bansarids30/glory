<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.DDIV"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.Data.connjdbc"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Statement st = connjdbc.getDatacn();
	ResultSet rs = null;
	Date d = new Date();
	DateFormat dateformat = new SimpleDateFormat("yyyy/MM/dd");
	//int id = Integer.parseInt(request.getParameter("sales_id"));
	String item_code = null, batchno = null, packing = null, mdate = null, edate = null;
	String itemid = request.getParameter("item_id");
%>
<html>
<head>
<style type="text/css" media="print">
* {
	margin: 0;
	padding: 0;
}
td{
	padding-bottom: 5px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stocks</title>
</head>
<body>
	<%
		if (itemid == null) {
			rs = st.executeQuery("SELECT * FROM stock_info WHERE quantity>0 ORDER BY item_code");
	%>
	<div style="height: 50px;" align="center">
		<h1>
			Total Stocks as on
			<%=dateformat.format(d)%></h1>
	</div>
	<table>
		<thead>
			<tr
				style="height: 10px; background-color: #cacaca; font-weight: bold;">
				<td>SR NO.</td>
				<td>ITEM CODE</td>
				<td>BATCH NO</td>
				<td>PACKING</td>
				<td>QUANTITY</td>
				<td>EXPIRY DATE</td>
			</tr>
		</thead>
		<tbody>

			<%
				int i = 0;
			String s = "";
			double inksum = 0,totalsum = 0;
					while (rs.next()) {
						String itemcode = rs.getString(2);
			%>
			<%if(!s.equals(itemcode) && i!=0){ %>
			
			<tr style="height: 30px; text-align: left;">
				<td colspan="4"></td>
				<td colspan="2"><%=inksum %></td>
			</tr>
			<%
				inksum = 0;
			} %>
			<tr style="height: 30px; text-align: left;">
				<td><%=++i%></td>
				<td><%if(s.equals(itemcode)){out.println("");}else{%><%=rs.getString(2)%><%}%></td>
				<td><%=rs.getString(3)%></td>
				<td align="center"><%=rs.getString(4)%></td>
				<td><%=rs.getString(5)%></td>
				<td><%=rs.getString(7)%></td>
			</tr>
			<%
			inksum = inksum+(rs.getInt(4)*rs.getInt(5));
			totalsum=totalsum+(rs.getInt(4)*rs.getInt(5));
			s = itemcode;
					}
			%>
			<tr style="height: 30px; text-align: left;">
				<td colspan="4"></td>
				<td colspan="2"><%=inksum %></td>
			</tr>
			<tr style="height: 50px; text-align: left;">
				<td colspan="4">Total quantity</td>
				<td colspan="2"><%=totalsum%></td>
			</tr>
			</tbody>
			</table>
			<%
				} else if (itemid != null) {
					int id = Integer.parseInt(request.getParameter("item_id"));
			%>
			<div style="height: 50px;" align="center">
				<h1>
					Total Stocks as on
					<%=dateformat.format(d)%></h1>
			</div>
			<table>
				<thead>
					<tr
						style="height: 10px; background-color: #cacaca; font-weight: bold;">
						<th>Sr No</th>
						<th>Item Code</th>
						<th>Batch Number</th>
						<th>Expiry Date</th>
						<th>Packing</th>
						<th>Quantity</th>
						<th>Company Name</th>
						<th>Invoice</th>
						<th>Dispatch Date</th>
					</tr>
				</thead>
				<tbody>

					<%
						rs = st.executeQuery("SELECT a.item_code,a.batchno,a.expiry_date,a.packing,a.quantity,c.company_name,b.invoice,b.dispatch_date FROM item_sales a INNER JOIN sales_info b ON a.order_id=b.sales_id INNER JOIN cust_info c ON b.ship_to=c.cust_id WHERE item_id="
									+ id);
							int i = 0;
							String s = "";
							while (rs.next()) {
								String itemcode = rs.getString(1);
					%>
					<tr style="height: 30px; text-align: left;">
						<td><%=++i%></td>
						<td><%=rs.getString(1)%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<td><%=rs.getString(6)%></td>
						<td><%=rs.getString(7)%></td>
						<td><%=rs.getString(8)%></td>						
					</tr>
					<%
						s = item_code;
						}
						}
					%>
				</tbody>
			</table>
			<script type="text/javascript">
				window.print();
			</script>
</body>
</html>