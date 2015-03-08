<!DOCTYPE html>
<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	try {
		Statement st = connjdbc.getDatacn();
		ResultSet rs = null;
		String edit = request.getParameter("edit_id");
		String dispatchdate = null, companyname = null, billto = null, shipto = null, invoice = null, shipped_by = null, tracking = null;
		int sales_id = 0;
		int check = 0;
		int editid = 0;
		if (edit != null) {
			editid = Integer.parseInt(edit);
			session.setAttribute("editid", editid);
			rs = st.executeQuery("SELECT a.sales_id,a.dispatch_date,b.company_name,c.company_name,a.ship_to,a.invoice,a.shipped_by,a.tracking FROM sales_info a INNER JOIN cust_info b ON a.bill_to = b.cust_id INNER JOIN cust_info c ON a.ship_to = c.cust_id where a.sales_id="
					+ editid);
			if (rs.next()) {
				sales_id = rs.getInt(1);
				dispatchdate = rs.getString(2);
				billto = rs.getString(3);
				shipto = rs.getString(4);
				invoice = rs.getString(6);
				shipped_by = rs.getString(7);
				tracking = rs.getString(8);
			}
			check = 5;
		}
%>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Current Stocks</title>
<!-- BOOTSTRAP STYLES-->
<link href="css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="css/font-awesome.css" rel="stylesheet" />
<!-- MORRIS CHART STYLES-->

<!-- CUSTOM STYLES-->
<link href="css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<!-- TABLE STYLES-->
<link href="js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
<link href="css/cssdate/jquery-ui.css" rel="stylesheet" type="text/css" />
<style>
.forform {
	margin: 10px;
	padding: 10px;
	width: 100%;
}

.forform tr {
	margin: 10px;
	margin-bottom: 20px;
	padding-bottom: 20px;
	width: 100%;
}

.forform tr td {
	margin: 10px;
	margin-bottom: 20px;
	padding-bottom: 20px;
}
</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<script type="text/javascript">
			var d = document.getElementById("addsales");
			d.className = d.className + "active-menu";
		</script>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<p></p>
						<form action="addsalescode.jsp">
							<table class="forform">
								<tr>
									<td><label>Dispatch Date:</label></td>
									<td><input id="datepicker" name="odate"
										placeholder="Enter Dispatch date" /></td>
									<td><label>Tracking#:</label></td>
									<td><input name="tracking"
										value="<%=check > 0 ? tracking : ""%>"
										placeholder="Enter Tracking number" /></td>

								</tr>
								<tr>
									<td><label>Bill To:</label></td>
									<td><select name="billto">
											<option value="-1">Select Company Name</option>
											<%
												rs = st.executeQuery("SELECT * FROM cust_info ");
													while (rs.next()) {
											%>
											<option <% if(check > 0){if(rs.getString(2).equals(billto))out.println("selected");}%> value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
											<%
												}
											%>
									</select></td>
									<td><label>Ship To:</label></td>									
									<td><select name="shipto">
											<option value="-1">Select Company Name</option>
											<%
												rs = st.executeQuery("SELECT * FROM cust_info ");
													while (rs.next()) {
											%>
											<option <% if(check > 0){if(rs.getString(2).equals(shipto))out.println("selected");}%> value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
									<td><label>Invoice#:</label></td>
									<td><input name="invoice" value="<%=check > 0 ? invoice : ""%>"
										placeholder="Enter Invoice" /></td>
									<td><label>Shipped By:</label></td>
									<td><input name="shipby"
										value="<%=check > 0 ? shipped_by : ""%>"
										placeholder="Enter shipping company" /></td>
								</tr>
								<tr>

									<td colspan="2"></td>
								</tr>
								<tr>
									<td colspan="2"><input class="btn btn-success"
										style="width: 100px;" type="submit"
										value=<%=check > 0 ? "Update" : "Add"%> name="submit"></td>
									<td colspan="2"><a class="btn btn-primary"
										style="width: 100px;" href="totalsales.jsp">Exit</a></td>
								</tr>
							</table>
						</form>

					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
			</div>

		</div>
		<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="js/jquery.metisMenu.js"></script>


	<!-- CUSTOM SCRIPTS -->
	<script src="js/custom.js"></script>
	<script type="text/javascript" src="js/jsdate/jquery.min.js"></script>
	<script src="js/jsdate/jquery-ui.min.js"></script>

	<script>
		$(document).ready(
				function() {
					var c = <%=check%>;
					$("#datepicker").datepicker();
					$("#datepicker").datepicker({
						dateFormat : "yy-mm-dd"
					});
					//Getter
					var dateFormat = $("#datepicker").datepicker("option",
							"dateFormat");

					// Setter
					$("#datepicker").datepicker("option", "dateFormat",
							"yy-mm-dd");
					if (c > 0) {
						var e = "<%=dispatchdate%>";
						$("#datepicker").datepicker('setDate', e);
					}

				});
	</script>

</body>
<%
	} catch (Exception e) {
		System.out.println(e);
	}
%>
</html>
