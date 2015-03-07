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
<title>Total Sales</title>
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
	
</script>
<script type="text/javascript">
	function orderdetail(id) {		
		if (id == "") {
			document.getElementById("vieworder").innerHTML = "";
			return;
		}
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("vieworder").innerHTML = xmlhttp.responseText;
				
			}
		};
		xmlhttp.open("GET", "getorderdetail.jsp?q=" + id, true);
		xmlhttp.send();
	}
</script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<script type="text/javascript">
			var d = document.getElementById("totalsales");
			d.className = d.className + "active-menu";
		</script>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<p>View sales details here</p>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />

				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div id="vieworder"></div>
						<div class="panel panel-default">
							<div class="panel-heading">
								Total Sales<a style="float: right;" href="addsales.jsp"><button
										class="btn btn-success">Add New Sales</button></a>
							</div>
							<div class="panel-body">

								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>No</th>
												<th>Dispatch Date</th>
												<th>Bill to</th>
												<th>Ship To</th>
												<th>Invoice#</th>
												<th>Shipped_by</th>
												<th>Tracking#</th>
												<th>View Details</th>
												<th>Edit</th>
												<th>Print</th>
											</tr>
										</thead>

										<tbody>
											<%
												ResultSet rs = st
															.executeQuery("SELECT a.sales_id,a.dispatch_date,b.company_name,c.company_name,a.invoice,a.shipped_by,a.tracking FROM sales_info a INNER JOIN cust_info b ON a.bill_to = b.cust_id INNER JOIN cust_info c ON a.ship_to = c.cust_id");
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
												<td><%=rs.getString(7)%></td>
												<td><button onClick="orderdetail(<%=rs.getInt(1)%>);"
														class="btn btn-info">Order Details</button></td>
												<td>
													<%
														out.println("<a href='addsales.jsp?edit_id="
																		+ rs.getInt(1)
																		+ " ' > <button class=\"btn btn-primary\"><i class=\"fa fa-edit \"></i> Edit</button></a>");
													%> <%
 	//	out.println("<a href='' onclick='javascript:return del("
 			//				+ rs.getInt(1)
 			//			+ ");' > <button class=\"btn btn-danger\">Delete</button></a>");
 %>
												</td>
												<td><a href="print.jsp?sales_id=<%=rs.getInt(1)%>">
														<button class="btn btn-info">Print</button>
												</a></td>

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
		$(document).ready(function() {
			$('#dataTables-example1').dataTable();
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
