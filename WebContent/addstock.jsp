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
		String packing  = null;
		String quantity = null;
		String mdate = null;
		String edate = null;
		int check = 0;
		int editid = 0;
		if(edit!=null){
			editid = Integer.parseInt(edit);
			session.setAttribute("editid",editid);
			rs = st.executeQuery("SELECT * FROM stock_info WHERE item_id="+editid);
			if(rs.next()){
				itemcode = rs.getString(2);
				batchno = rs.getString(3);
				packing = rs.getString(4);
				quantity = rs.getString(5);
				mdate = rs.getString(6);
				edate = rs.getString(7);
			}
			System.out.println("mdate"+mdate);
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
.forform{
margin:10px;
padding:10px;
width:100%;
}
.forform tr{
	margin:10px;
	margin-bottom: 20px;
	padding-bottom:20px;
	width:100%;
}
.forform tr td{
	margin:10px;
	margin-bottom: 20px;
	padding-bottom:20px;
}
</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<script type="text/javascript">
			var d = document.getElementById("addstock");
			d.className = d.className + "active-menu";
		</script>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
					<p><%if(session.getAttribute("add") != null){out.println(session.getAttribute("add"));}session.setAttribute("add", ""); %></p>
						<form action="addstockcode.jsp">
							<table class="forform">
								<tr>
									<td><label>Item Code:</label></td>
									<td><input name="itemcode" value="<%if(check>0){out.println(itemcode);}else{} %>" placeholder="Enter Item Code"></td>
									<td><label>Batch Number:</label></td>
									<td><input name="batch" value="<%if(check>0){out.println(batchno);}else{} %>" placeholder="Enter Batch Number"></td>
								</tr>
								<tr>
									<td><label>Packing:</label></td>
									<td><input name="packing" value="<%if(check>0){out.println(packing);}else{} %>" placeholder="Enter Packing"></td>
									<td><label>Quantity:</label></td>
									<td><input name="quantity" value="<%if(check>0){out.println(quantity);}else{} %>" pattern="^(0|[1-9][0-9]*)$" title="quantity should be in numbers!" placeholder="Enter Quantity"></td>
								</tr>
								<tr>
									<td><label>Manufacture Date:</label></td>
									<td><input id="datepicker" name="manufacture" placeholder="Enter Manufacturing date"  /></td>
									<td><label>Expiry Date:</label></td>
									<td><input id="datepicker1" name="expiry" placeholder="Enter Expiry date"/></td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2"><input type="submit" name="submit" value=<%=check>0?"Update":"Add" %>></td>
									<td></td>
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
					var c = <%=check%>
					
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
					if(c > 0){
						var m = "<%=mdate%>";
						$("#datepicker").datepicker('setDate',m);
					}
					$("#datepicker1").datepicker();
					 $( "#datepicker1" ).datepicker({
					 	  dateFormat: "yy-mm-dd"
					 	});
					 //Getter
					 var dateFormat = $( "#datepicker1" ).datepicker( "option", "dateFormat" );
					 
					// Setter
					$( "#datepicker1" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
					
					if(c > 0){
						var e = "<%=edate%>";
						$("#datepicker1").datepicker('setDate',e);
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
