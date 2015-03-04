<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<div class="heading"><b><span style="height:100%; padding-bottom:20px;">GLORY CHEMICALS</span> </b></div>
<div class="formdiv">
<div style="background:#4d4d4d; color: white; margin: 10px; width:90%;text-align: center; font-size: x-large; padding-top:20px; "><b>LOGIN</b></div>
<hr/>
<p style="text-align: center; color: white; font-size: large;"><%if(session.getAttribute("loginerror")!=null){out.println(session.getAttribute("loginerror"));} %></p>
<form action="logincode.jsp">
<input name="username" type="text" placeholder="username"><br>
<input type="password" name="password" placeholder="password">
<input type="submit" name="submit">
</form>
</div>
<div class="bottom"></div>
</body>
</html>