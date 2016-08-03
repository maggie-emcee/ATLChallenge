<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title> Allied Telesis Coding Challenge</title>
	</head>
	<body>
	
		<div style="margin: auto; width: 75%; padding: 10px; text-align: center;">
			<textarea rows="20" cols="80" readonly="readonly" id="messageArea"></textarea>
			<br/>
			<input type="text" id="msgTxt" name="msgTxt" size="96"/>
			<input type="button" value="Send" onclick="sendMsg();" id="sendBtn" name="sendBtn"/>
		</div>

	
		<script type="text/javascript">
			var ctx =  window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
			var url = "ws://" + window.location.host + "" + ctx + "/ChatServerEndpoint" 
			var socketEndpnt = new WebSocket(url);

			socketEndpnt.onopen = function(){
				var username = "<%=request.getParameter("username")%>";
				socketEndpnt.send(username);
			}
			
			socketEndpnt.onmessage = function(message){
				if(message){
					var jsonData = JSON.parse(message.data)
					
					
					
					if(jsonData.message != null){
						if(jsonData.message.includes("null username")){
	 						socketEndpnt.close();
							alert("You have not provided a username. Redirecting to 'login' page once you click OK.");

							var indexUrl =  window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
							window.location.pathname = indexUrl;
						}
						else
							messageArea.value += jsonData.message + "\n";
					}
				}
					
			}

			function sendMsg(){
				socketEndpnt.send(msgTxt.value);
				msgTxt.value = "";
			}

			msgTxt.addEventListener("keyup", function(event) {
		    	event.preventDefault();
			    if (event.keyCode == 13) {
			    	sendBtn.click();
			    }
			});
		
		</script>
	</body>
</html>