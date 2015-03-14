<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<%
	String s = request.getParameter("q");
	int id = s != null ? Integer.parseInt(s) : 0;
	Statement st = connjdbc.getDatacn();
%>
<div class="table-responsive">
	<div class="panel panel-default">
		<div class="panel-heading">
			Order Detail<a style="float: right;" href="addsalesitem.jsp?salesid=<%=id%>"><button class="btn btn-success">Add
					New item for this sale</button></a>
		</div>
		<div class="panel-body">
			<table class="table table-striped table-bordered table-hover"
				id="dataTables-example1">
				<thead>
					<tr>
						<th>No</th>
						<th>Company Name</th>
						<th>item_code</th>
						<th>Batch Number</th>
						<th>Packing</th>
						<th>Quantity</th>
						<th>Expiry Date</th>
						<th>Edit</th>
					</tr>
				</thead>
				<tbody id="vieworder">
					<%
						ResultSet rs = st
								.executeQuery("SELECT a.id,c.company_name,a.item_code,a.batchno,a.packing,a.quantity,a.order_id,a.expiry_date FROM item_sales a INNER JOIN sales_info b ON b.sales_id=a.order_id INNER JOIN cust_info c ON b.bill_to=c.cust_id WHERE a.order_id="
										+ id);
						int i = 0;
						while (rs.next()) {
					%>
					<tr>
						<td><%=++i%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<td><%=rs.getString(6)%></td>
						<td><%=rs.getString(8)%></td>

						<td>
							<%
								out.println("<a href='addsalesitem.jsp?edit_id="
											+ rs.getInt(1)
											+ " ' > <button class=\"btn btn-primary\"><i class=\"fa fa-edit \"></i> Edit</button></a>");
							%>
						</td>

					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>