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
<script type="text/javascript">
	
</script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<script type="text/javascript">
			var d = document.getElementById("currentstock");
			d.className = d.className + "active-menu";
		</script>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<p>View current stock details here</p>
						<p>
							<%
								if (session.getAttribute("update") != null) {
										out.println(session.getAttribute("update"));

									}
									session.setAttribute("update", "");
							%>
						</p>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />

				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Current Stocks<a style="float: right;" href="addstock.jsp"><button class="btn btn-success"><i class=" fa fa-refresh "></i> Add New Stock</button></a></div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>Sr No</th>
												<th>Item Code</th>
												<th>Batch Number</th>
												<th>Packing</th>
												<th>Quantity</th>
												<th>Manufactured Date</th>
												<th>Expire Date</th>
												<th>Edit/Delete</th>
											</tr>
										</thead>

										<tbody>
											<%
												ResultSet rs = st.executeQuery("SELECT * FROM stock_info");
													int i = 0;
													while (rs.next()) {
											%>
											<tr>
												<td><%=++i%></td>
												<td><%=rs.getString(2)%></td>
												<td><%=rs.getString(3)%></td>
												<td><%=rs.getString(4)%></td>
												<td><%=rs.getString(5)%></td>
												<td><%=rs.getDate(6)%></td>
												<td><%=rs.getDate(7)%></td>
												<td>
													<%
														out.println("<a href='addstock.jsp?edit_id="
																		+ rs.getInt(1)
																		+ " ' > <button class=\"btn btn-primary\"><i class=\"fa fa-edit \"></i> Edit</button></a>");
													%> <%
 	out.println("<a href='' onclick='javascript:return del("
 					+ rs.getInt(1)
 					+ ");' > <button class=\"btn btn-danger\"><i class=\"fa fa-pencil\"></i> Delete</button>");
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
