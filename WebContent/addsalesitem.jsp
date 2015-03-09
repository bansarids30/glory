<!DOCTYPE html>
<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	try {
		Statement st = connjdbc.getDatacn();
		ResultSet rs = null;
		String edit = request.getParameter("edit_id");
		String itemcode = null;
		String batchno = null;
		String packing = null;
		String quantity = null;
		String mdate = null;
		String edate = null;
		int check = 0;
		int editid = 0;
		if (edit != null) {
			editid = Integer.parseInt(edit);
			session.setAttribute("editid", editid);
			rs = st.executeQuery("SELECT * FROM item_sales WHERE id="
					+ editid);
			if (rs.next()) {
				itemcode = rs.getString(2);
				batchno = rs.getString(3);
				packing = rs.getString(4);
				quantity = rs.getString(5);
				mdate = rs.getString(6);
				edate = rs.getString(7);
			}
			check = 5;
		}
		int scheck = 0;//for sales id
		String salesid = request.getParameter("salesid");
		if (salesid != null) {
			session.setAttribute("salesid", salesid);
			scheck = 5;
		}
%>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add Sales Item</title>
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
<script type="text/javascript">
	function showBatch() {
		var packing = document.getElementById("pack").value;
		var item = document.getElementById("itemcode").value;
		if (packing == "") {
			document.getElementById("batchno").innerHTML = "";
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
				document.getElementById("batchno").innerHTML = xmlhttp.responseText;
				//document.getElementById("destinationcity").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("GET", "getbatchno.jsp?item=" + item + "&packing="
				+ packing, true);
		xmlhttp.send();
	}
	function showPacking() {
		var item = document.getElementById("itemcode").value;
		if (item == "") {
			document.getElementById("showpacking").innerHTML = "";
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
				document.getElementById("showpacking").innerHTML = xmlhttp.responseText;
				//document.getElementById("destinationcity").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("GET", "getpacking.jsp?item=" + item, true);
		xmlhttp.send();
	}
</script>
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
						<p style="font-weight: bold; color: red;"><%if(session.getAttribute("duplicateentry")!=null){
							out.println(session.getAttribute("duplicateentry"));
							session.setAttribute("duplicateentry","");
						} %></p>
						<form action="addsalesitemcode.jsp">
							<table class="forform">

								<tr>
									<td><label>Item Code:</label></td>
									<td><select name="itemcode" id="itemcode"
										onchange="showPacking();">
											<option value="-1">Select ItemCode</option>
											<%
												rs = st.executeQuery("SELECT DISTINCT item_code FROM stock_info ORDER BY item_code");
													while (rs.next()) {
											%>
											<option
												<%if (check > 0) {
						if (itemcode.equals(rs.getString(1)))
							out.println("selected");
					}%>
												value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
											<%
												}
											%>
									</select></td>
									<td><label>Packing:</label></td>
									<td><div id="showpacking">
											<select name="packing" id="pack" onchange="showBatch();">
												<option value="-1">Select Packing</option>
												<%
													if (check > 0) {
															rs = st.executeQuery("SELECT DISTINCT packing from stock_info where item_code='"
																	+ itemcode + "'");
															while (rs.next()) {
												%>
												<option <%=packing.equals(rs.getString(1)) ? "selected"
								: ""%>
													value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
												<%
													}
														}
												%>
											</select>
										</div></td>

								</tr>
								<tr>
									<td><label>Batch Number:</label></td>
									<td><div id="batchno">
											<select name="batchno">
												<option value="-1">Select BatchNo</option>
												<%
													if (check > 0) {
															rs = st.executeQuery("select item_id,batch_no from stock_info where item_code='"
																	+ itemcode + "' and packing='" + packing + "'");
															while (rs.next()) {
												%>
												<option
													<%if (batchno.equals(rs.getString(2))) {
							out.println("selected");
						}%>
													value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
												<%
													}
														}
												%>
											</select>
										</div></td>
									<td><label>Quantity:</label></td>
									<td><input type=text name="quantity"
										value="<%=check > 0 ? quantity : ""%>" placeholder="Enter quantity"></td>
								</tr>
								<tr>
									<td colspan="2" style="color: red;"><div
											id="availablequantity"></div></td>
									<td colspan="2" style="color: red;"><%=session.getAttribute("quantityerror")%>
										<%
											session.setAttribute("quantityerror", "");
										%></td>
								</tr>
								<tr>
									<%
										if (scheck > 0) {
									%>
									<td><input type="submit" class="btn btn-success" value="Add" name = "submit"></td>
									<%
										} else {
									%>
									<%
										if (check > 0) {
									%>
									<td><input class="btn btn-success" type="submit" value="Update" name="submit"></td>
									<%
										} else {
									%>

									<td colspan="1"><input class="btn btn-success" type="submit"
										value="Add & Add more" name="submit"></td>
									<td colspan="1"><input class="btn btn-success" type="submit" value="Add & Exit"
										name="submit"></td>
										<td><a class="btn btn-primary" href="totalsales.jsp">Exit</a></td>
									<%
										}
											}
									%>
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

</body>
<%
	} catch (Exception e) {
		System.out.println(e);
	}
%>
</html>
