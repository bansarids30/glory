
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link href="css/csslogin/style.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
</script>
<!--webfonts-->
<link
	href='http://fonts.googleapis.com/css?family=Cabin:400,500,600,700,400italic,500italic,600italic,700italic'
	rel='stylesheet' type='text/css'>
<!--//webfonts-->
</head>
<body>

	<!--/start-login-one-->
	<div class="login-01">
		<div class="one-login  hvr-float-shadow">
			<div class="one-login-head">
				<h1>LOGIN</h1>
				<div>
					<%
						if (session.getAttribute("loginerror") != null) {
							out.println(session.getAttribute("loginerror"));
							session.setAttribute("loginerror", "");
						}
					%>
				</div>
			</div>
			<form action="logincode.jsp">
				<li><input name="username" type="text" class="text"
					value="Username" onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Username';}"><a
					href="#" class=" icon user"></a></li>
				<li><input name="password" type="password" value="Password"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Password';}"><a
					href="#" class=" icon lock"></a></li>
				<div class="p-container">

					<h6>
						<a href="#">Forgot Password ?</a>
					</h6>
				</div>
				<div class="submit">
					<input type="submit" value="SIGN IN">
				</div>

			</form>
		</div>
	</div>


</body>
</html>