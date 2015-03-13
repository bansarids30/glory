<%@page import="com.Data.connjdbc"%>
<%@page import="java.sql.*"%>
<%
	Statement st = connjdbc.getDatacn();
	String item = request.getParameter("item");
	String packing = request.getParameter("packing");
	try{
	ResultSet rs = st
			.executeQuery("select item_id,batch_no,quantity from stock_info where item_code='"
					+ item + "' and packing='"+packing+"' and quantity>0");%>
	
	<select name="batchno">
	<option value="-1">Select BatchNo</option>											
	
	<%while (rs.next()) {
		out.println("<option value=" + rs.getInt(1) + ">"
				+ rs.getString(2) + " has quantity "+rs.getString(3)+"</option>");
	}
	}catch(Exception e){
		System.err.println(e);
	}

%>
</select>
<%
%>
