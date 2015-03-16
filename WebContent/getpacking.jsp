<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<%
	Statement st = connjdbc.getDatacn();
	String sn = request.getParameter("item");
	ResultSet rs = st
			.executeQuery("select DISTINCT packing from stock_info where item_code='"
					+ sn + "'");%>
	
	<select name="packing" onchange="showBatch();" id = "pack">
	<option value="-1">Select Packing</option>											
	
	<%while (rs.next()) {
		out.println("<option value=" + rs.getString(1) + ">"
				+ rs.getString(1) + "</option>");
	}

%>
</select>
<%
%>
