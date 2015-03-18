<%@page import="com.sun.org.apache.bcel.internal.generic.DDIV"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Statement st = connjdbc.getDatacn();
	ResultSet rs = null;
	int id = Integer.parseInt(request.getParameter("sales_id"));
	String date = null, invoice = null, shipped_by = null, ordernumber = "", tracking = null, companyname1 = null, address11 = null, address12 = null, city1 = null, state1 = null, zipcode1 = null, country1 = null, atendant_name1 = null, phone1 = null, companyname2 = null, address21 = null, address22 = null, city2 = null, state2 = null, zipcode2 = null, country2 = null, atendant_name2 = null, phone2 = null;
	rs = st.executeQuery("SELECT a.dispatch_date,a.invoice,a.shipped_by,a.tracking,b.company_name,b.address1,b.address2,b.city,b.state,b.zipcode,b.country,b.attendant_name,b.phone1,c.company_name,c.address1,c.address2,c.city,c.state,c.zipcode,c.country,c.attendant_name,c.phone1,a.ordernumber FROM sales_info a INNER JOIN cust_info b ON a.bill_to=b.cust_id INNER JOIN cust_info c ON a.ship_to=c.cust_id where a.sales_id="
			+ id);
	if (rs.next()) {
		date = rs.getString(1);
		invoice = rs.getString(2);
		shipped_by = rs.getString(3);
		tracking = rs.getString(4);
		companyname1 = rs.getString(5);
		address11 = rs.getString(6);
		address12 = rs.getString(7);
		city1 = rs.getString(8);
		state1 = rs.getString(9);
		zipcode1 = rs.getString(10);
		country1 = rs.getString(11);
		atendant_name1 = rs.getString(12);
		phone1 = rs.getString(13);
		companyname2 = rs.getString(14);
		address21 = rs.getString(15);
		address22 = rs.getString(16);
		city2 = rs.getString(17);
		state2 = rs.getString(18);
		zipcode2 = rs.getString(19);
		country2 = rs.getString(20);
		atendant_name2 = rs.getString(21);
		phone2 = rs.getString(22);
		ordernumber = rs.getString(23);
	}
	rs.close();
%>
<html>
<head>
<style type="text/css" media="print">
* {
	margin: 0;
	padding: 0;
}

body {
	font: 14px/1.4 Georgia, serif;
	width: 100%;
	height: 100%;
}

table {
	border-collapse: collapse;
	width: 100%;
}

table td,table th {
	border: 1px solid black;
	padding: 5px;
}

table thead {
	background-color: #cacaca;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print</title>
</head>
<body>
	<div style="height: 130px;">
		<div style="text-align: center;">
			<h1>Glory Chemicals Ltd.</h1>
		</div>
		<br>
		<div>
			<div
				style="float: left; text-align: center; padding-left: 250px; width: 200px;">
				4393 Indian Trail-Fairview Rd. Suite B. Indian Trail NC 28079<br>
				U.S.A
			</div>
			<div style="float: right; text-align: right; width: 150px;">
				(704) 893-0291<br> (704) 893-0296<br> americas@atinks.com
				<br>www.atinks.com
			</div>
		</div>
	</div>
	<div style="height: 80%">
		<br>
		<table border="1">
			<thead>
				<tr style="background-color: #cacaca;">
					<th style="border-right: none; text-align: left;">INVOICE NO:
						<%=invoice%></th>
					<th style="border-left: none; border-right: none;">DATE: <%=date%></th>
					<th style="border-left: none; text-align: right;">ORDER NO: <%=ordernumber%></th>
				</tr>
			</thead>
		</table>

		<table border="1" cellpadding="5px;" cellspacing="0"
			style="table-layout: fixed;">
			<tbody>
				<tr>
					<td colspan="1" width="40%" height="144px"
						style="text-align: left; border-bottom: none;"><div>
							<p>BILL TO:</p>
							<p style="font-weight: bold; text-transform: uppercase;"><%=companyname1%></p>
							<p><%=address11 + (address12.equals(null) ? "" : address12)%></p>
							<p><%=city1 + ", " + state1 + " " + zipcode1%></p>
							<br>
							<p>
								Attn:
								<%=atendant_name1%></p>
							<p><%=phone1%></p>
						</div></td>
					<td width="60%" colspan="3" height="144px"
						style="text-align: left;"><div>
							<p>SHIP TO:</p>
							<p style="font-weight: bold; text-transform: uppercase;"><%=companyname2%></p>
							<p><%=address21 + " " + address12%></p>
							<p><%=city2 + ", " + state2 + " " + zipcode2%></p>
							<br>
							<p>
								Attn:
								<%=atendant_name2%></p>
							<p><%=phone2%></p>
						</div></td>
				</tr>

				<tr bgcolor="#cacaca"
					style="height: 10px; background-color: #cacaca; font-weight: bold; border-right: none;">
					<td
						style="border-top: none; border-bottom: none; background-color: white;"></td>
					<td>DISPATCH DATE</td>
					<td>SHIP BY</td>
					<td>TRACKING#</td>
				</tr>
				<tr style="height: 30px;">
					<td
						style="border-top: none; text-align: center; border-bottom: none;"></td>
					<td><%=date%></td>
					<td><%=shipped_by%></td>
					<td><%=tracking%></td>
				</tr>
				<tr
					style="height: 10px; background-color: #cacaca; font-weight: bold; border-right: none;">
					<td>DESCRIPTION OF GOODS</td>
					<td>PACKING</td>
					<td>QTY</td>
					<td>BATCH NUMBER</td>
				</tr>
				<%
					rs = st.executeQuery("SELECT item_code,packing,quantity,batchno FROM item_sales where order_id="
							+ id);
					int count = 15;
					while (rs.next()) {
						--count;
				%>
				<tr style="height: 30px; text-align: center;">
					<td style="border-bottom: none; border-top: none;"><%=rs.getString(1)%></td>
					<td style="border-bottom: none; border-top: none;"><%=rs.getString(2)%></td>
					<td style="border-bottom: none; border-top: none;"><%=rs.getString(3)%></td>
					<td style="border-bottom: none; border-top: none;"><%=rs.getString(4)%></td>
				</tr>
				<%
					}
				%>

				<%
					for (int i = 0; i < count; i++) {
				%>
				<tr style="height: 30px; text-align: center;">
					<td style="border-bottom: none; border-top: none;"></td>
					<td style="border-bottom: none; border-top: none;"></td>
					<td style="border-bottom: none; border-top: none;"></td>
					<td style="border-bottom: none; border-top: none;"></td>
				</tr>
				<%
					}
				%>


			</tbody>
		</table>
		<script type="text/javascript">
			window.print();
		</script>
	</div>
</body>
</html>