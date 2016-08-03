package com.maggie.chat.endpoint;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

@ServerEndpoint("/ChatServerEndpoint")
public class ChatServerEndpoint {
	
	//variable to contain user sessions since no storage of any kind will be used
	static Set<Session> users = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session session, EndpointConfig endpointConfig) {
		users.add(session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws IOException{
		String username = (String) session.getUserProperties().get("username");

		System.out.println("username: " + username);
		System.out.println("message: " + message);
		if(username == null){
			System.out.println("null user?");
			String iMsg = "";
			if(message != null && !message.equalsIgnoreCase("null")){
				session.getUserProperties().put("username", message);
				iMsg = "You are now connected as " + message;
			}else{
				System.out.println("null msg?");
				iMsg = "null username";
			}
			session.getBasicRemote().sendText(formatJson(iMsg, "Hi!"));
		}else{
			Iterator<Session> iterator = users.iterator();
			while(iterator.hasNext()){
				iterator.next().getBasicRemote().sendText(formatJson(message, username));
			}
		}
	}
	
	
	@OnClose
	public void onClose(Session session, CloseReason closeReason) {
		users.remove(session);
	}
	
	private String formatJson(String msg, String uname){
		JSONObject jObj = new JSONObject();
		jObj.put("message", uname + ": " + msg);
		return jObj.toString();
	}
	
	

}
