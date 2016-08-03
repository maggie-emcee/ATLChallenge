<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome!</title>
	</head>
	<body>
	
		<div style="margin: auto; width: 75%; border: 2px solid; padding: 10px; text-align: center;">
			<form name="introForm" id="introForm" action="" method="POST">
			<span> 
				Hi! Welcome to the the coding challenge chat room. This is the delivery from candidate, Maggie Cadwising.
				<br/>
				To proceed, please enter a username.
			</span>
			<br/>
			<input type="text" id="username" name="username"/>
			<br/>
			<input type="submit" value="Proceed" id="proceedBtn" name="proceedBtn" onclick="check();"/>
		</form>
		</div>
		
		<script type="text/javascript">
	
			function check(){
				if(!(username.value && username.value.trim())){
					alert("Please provide a username to proceed.")
					username.focus();
				} else{
					var ctx =  window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
					introForm.action = ctx + "/pages/chatroom.jsp";
					introForm.submit();
				}
			}

			
			username.addEventListener("keyup", function(event) {
		    	event.preventDefault();
			    if (event.keyCode == 13) {
			    	proceedBtn.click();
			    }
			});
		</script>
	</body>
</html>