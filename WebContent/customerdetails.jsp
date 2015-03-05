<!DOCTYPE html>
<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	try {
		Statement st = connjdbc.getDatacn();
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
<script type="text/javascript">
	function del(id) {
		// alert(id);

		if (confirm("Are you sure you want to delete?") == true) {
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			xmlhttp.onreadystatechange = function() {

				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				}
			};
			xmlhttp.open("GET", "delcustomer.jsp?delete_id=" + id, true);

			xmlhttp.send();
		}
	}
</script>
</head>
<body>
	<%
		ResultSet rs = null;
			String editid = request.getParameter("edit_id");
			int check = 0;
			String name = null, address1 = null, phone1 = null, address2 = null, attendant = null,phone2 = null, city = null, state = null, company = null, zipcode = null, country = null, email = null;

			if (editid != null) {
				int id = Integer.parseInt(editid);
				rs = st.executeQuery("SELECT * FROM cust_info WHERE cust_id="
						+ id);
				if (rs.next()) {
					company = rs.getString(2);
					address1 = rs.getString(3);
					address2 = rs.getString(4);
					city = rs.getString(5);
					state = rs.getString(6);
					zipcode = rs.getString(7);
					country = rs.getString(8);
					attendant = rs.getString(9);
					phone1 = rs.getString(10);
					phone2 = rs.getString(11);
					email = rs.getString(12);
				}
				session.setAttribute("editid", id);
				check = 5;
			}
	%>
	<div id="wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<script type="text/javascript">
			var d = document.getElementById("custdetail");
			d.className = d.className + "active-menu";
		</script>

		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<p>
							<b>Customer Information</b>
						</p>
						<p>
							<%
								if (session.getAttribute("custadd") != null) {
										out.println(session.getAttribute("custadd"));
										session.setAttribute("custadd", "");
									}
									if (session.getAttribute("custupdate") != null) {
										out.println(session.getAttribute("custupdate"));
										session.setAttribute("custupdate", "");
									}
							%>
						</p>
						<form action="customerdetailsinfo.jsp">
							<table class="forform">
								<tr>
									<td><label>Company Name:</label></td>
									<td><input name="company"
										value="<%=check > 0 ? company : ""%>"
										placeholder="Enter Customer Name"></td>
								</tr>
								<tr>
									<td><label>Address Line 1:</label></td>
									<td><input name="address1"
										value="<%=check > 0 ? address1 : ""%>"
										placeholder="Address Line 1"></td>
								</tr>
								<tr>
									<td><label>Address Line 2:</label></td>
									<td><input name="address2"
										value="<%=check > 0 ? address2 : ""%>"
										placeholder="Address Line 2"></td>
								</tr>
								<tr>
									<td><label>City:</label></td>
									<td><input name="city" value="<%=check > 0 ? city : ""%>"
										placeholder="Enter City Name"></td>
								</tr>
								<tr>
									<td><label>State:</label></td>
									<td><input name="state"
										value="<%=check > 0 ? state : ""%>"
										placeholder="Enter State Name"></td>
								</tr>
								<tr>
									<td><label>Zipcode:</label></td>
									<td><input name="zipcode"
										value="<%=check > 0 ? zipcode : ""%>"
										placeholder="Enter Zipcode"></td>
								</tr>
								<tr>
									<td><label>Country:</label></td>
									<td><input name="country"
										value="<%=check > 0 ? country : ""%>"
										placeholder="Enter Country"></td>
								</tr>
								<tr>
									<td><label>Attendant Name:</label></td>
									<td><input name="attendant"
										value="<%=check > 0 ? attendant : ""%>"
										placeholder="Enter Attendant"></td>
								</tr>
								<tr>
									<td><label>Phone Number</label></td>
									<td><input name="phone1" pattern="^(0|[1-9][0-9]*)$"
										maxlength="12" value="<%=check > 0 ? phone1 : ""%>"
										placeholder="Enter Phone"></td>
								</tr>
								<tr>
									<td><label>Alternate Number:</label></td>
									<td><input name="phone2" pattern="^(0|[1-9][0-9]*)$"
										maxlength="12" value="<%=check > 0 ? phone2 : ""%>"
										placeholder="Enter Phone"></td>
								</tr>
								<tr>
									<td><label>Email:</label></td>
									<td><input name="email"
										value="<%=check > 0 ? email : ""%>" placeholder="Enter Email" /></td>
								</tr>
								<tr>
									<td><input type="submit" class="btn btn-success"
										value="<%=check > 0 ? "Update" : "Add"%>" name="submit"></td>
									<td><a class="btn btn-primary" href="customerdetails.jsp">Exit</a></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />

				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Current Stocks</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>Sr No</th>
												<th>Company Name</th>
												<th>Address Line 1</th>
												<th>Address Line 2</th>
												<th>City</th>
												<th>State</th>
												<th>Zipcode</th>
												<th>Country</th>
												<th>Attendant Name</th>
												<th>Phone</th>
												<th>Alternate Phone</th>
												<th>Email</th>
												<th>Edit</th>
											</tr>
										</thead>

										<tbody>
											<%
												int i = 0;
													rs = st.executeQuery("SELECT * FROM cust_info");
													while (rs.next()) {
											%>
											<tr>
												<td><%=++i%></td>
												<td><%=rs.getString(2)%></td>
												<td><%=rs.getString(3)%></td>
												<td><%=rs.getString(4)%></td>
												<td><%=rs.getString(5)%></td>
												<td><%=rs.getString(6)%></td>
												<td><%=rs.getString(7)%></td>
												<td><%=rs.getString(8)%></td>
												<td><%=rs.getString(9)%></td>
												<td><%=rs.getString(10)%></td>
												<td><%=rs.getString(11)%></td>
												<td><%=rs.getString(12)%></td>
												<td>
													<%
														out.println("<a href='customerdetails.jsp?edit_id="
																		+ rs.getInt(1)
																		+ " ' > <button class=\"btn btn-primary\"><i class=\"fa fa-edit \"></i> Edit</button></a>");
													%> <%
 	//out.println("<a href='' onclick='javascript:return del("
 			//+ rs.getInt(1)
 			//				+ ");' > <button class=\"btn btn-danger\">Delete</button></a>");
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
						<!--End Advanced Tables -->
					</div>
				</div>



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
	<!-- DATA TABLE SCRIPTS -->
	<script src="js/dataTables/jquery.dataTables.js"></script>
	<script src="js/dataTables/dataTables.bootstrap.js"></script>
	<script>
		$(document).ready(function() {
			$('#dataTables-example').dataTable();
		});
	</script>
	<!-- CUSTOM SCRIPTS -->
	<script src="js/custom.js"></script>


</body>
<%
	} catch (Exception e) {
		System.out.println(e);
	}
%>
</html>
