<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.fasterxml.jackson.databind.ObjectWriter"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.utils.Cart"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.common.ApiHandler"%><%@page import="csshared.vo.RequestVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><%

	String resp = "";
	Cartographer map = new Cartographer(request, response, true);

	if (!map.hasValue("request")) {
		resp = "Request is a required field.";
	}else if (!map.hasValue("token")) {
		resp = "Token is a required field.";
	}
	else if (!map.hasValue("ip")) {
		resp = "IP is a required field";
	}else if(map.equalsIgnoreCase("_ent", "review")){

		
		RequestVO vo = RequestMapper.getRequest(map);
		vo.setRequest(map.getString("request"));
		if (map.equalsIgnoreCase("action", "url")) {
			resp = vo.getUrl();
		}
		
		else {
			vo.setIp(map.getString("ip"));
			vo.setToken(map.getString("token"));
			if (!Operator.hasValue(vo.getType())) {
				vo.setType(vo.getGrouptype());
			}
			if (map.equalsIgnoreCase("action", "request")) {
				
				if(map.equalsIgnoreCase("request", "create") ){
					vo = RequestMapper.getReview(map,"create");					
				}
				if( map.equalsIgnoreCase("request", "update")){
					vo = RequestMapper.getReview(map,"update");
				}
				if( map.equalsIgnoreCase("request", "add")){
					vo = RequestMapper.getReview(map,"add");
				}
				if( map.equalsIgnoreCase("request", "saveteam")){
					vo = RequestMapper.getReview(map,"saveteam");
				}
				resp = ObjMapper.toJson(vo);
				//resp = vo.simpleJson();
			}
			else if (map.equalsIgnoreCase("action", "response")) {
				
				if(map.equalsIgnoreCase("request", "create")){
					vo = RequestMapper.getReview(map,"create");					
				}
				if( map.equalsIgnoreCase("request", "update")){
					vo = RequestMapper.getReview(map,"update");
				}
				if( map.equalsIgnoreCase("request", "add")){
					vo = RequestMapper.getReview(map,"add");
				}
				if( map.equalsIgnoreCase("request", "saveteam")){
					vo = RequestMapper.getReview(map,"saveteam");
				}
				resp = ApiHandler.post(vo);
			}
		}
	
		
		
	
	}
	else if(map.equalsIgnoreCase("_ent", "parking")){
		
		RequestVO vo = RequestMapper.getRequest(map);
		vo.setRequest(map.getString("request"));
		if (map.equalsIgnoreCase("action", "url")) {
			resp = vo.getUrl();
		}
		
		else {
			vo.setIp(map.getString("ip"));
			vo.setToken(map.getString("token"));
			if (!Operator.hasValue(vo.getType())) {
				vo.setType(vo.getGrouptype());
			}
			if (map.equalsIgnoreCase("action", "request")) {
				
				if(map.equalsIgnoreCase("request", "saveexemption")){
					vo = RequestMapper.getSaveExemption(map);
					
				}
				
				if(map.equalsIgnoreCase("request", "savepermit")){
					vo = RequestMapper.getSaveParkingPermit(map);
					
				}
				
				resp = ObjMapper.toJson(vo);
				//resp = vo.simpleJson();
			}
			else if (map.equalsIgnoreCase("action", "response")) {
				
				if(map.equalsIgnoreCase("request", "saveexemption")){
					vo = RequestMapper.getSaveExemption(map);
					
				}
				
				if(map.equalsIgnoreCase("request", "savepermit")){
					vo = RequestMapper.getSaveParkingPermit(map);
					
				}
				
				resp = ApiHandler.post(vo);
			}
		}
	
		
		
	}else if(map.equalsIgnoreCase("_ent", "finance")){
		
		RequestVO vo = RequestMapper.getRequest(map);
		vo.setRequest(map.getString("request"));
		if (map.equalsIgnoreCase("action", "url")) {
			resp = vo.getUrl();
		}
		
		else {
			vo.setIp(map.getString("ip"));
			vo.setToken(map.getString("token"));
			if (!Operator.hasValue(vo.getType())) {
				vo.setType(vo.getGrouptype());
			}
			if (map.equalsIgnoreCase("action", "request")) {
				
			 	if(map.equalsIgnoreCase("request", "payonline")){
					vo = RequestMapper.getPaymentOnlineRequest(map);
					
				}
				
				
				resp = ObjMapper.toJson(vo);
				//resp = vo.simpleJson();
			}
			else if (map.equalsIgnoreCase("action", "response")) {
				
				
				if(map.equalsIgnoreCase("request", "payonline")){
					vo = RequestMapper.getPaymentOnlineRequest(map);
					
				}
				/* if(map.equalsIgnoreCase("request", "saveexemption")){
					vo = RequestMapper.getSaveExemption(map);
					
				}
				
				if(map.equalsIgnoreCase("request", "savepermit")){
					vo = RequestMapper.getSaveParkingPermit(map);
					
				} */
				
				resp = ApiHandler.post(vo);
			}
		}
	
		
		
	}
	else {
		RequestVO vo = RequestMapper.getRequest(map);
		vo.setRequest(map.getString("request"));
		if (map.equalsIgnoreCase("action", "url")) {
			resp = vo.getUrl();
		}
		
		else {
			vo.setIp(map.getString("ip"));
			vo.setToken(map.getString("token"));
			if (!Operator.hasValue(vo.getType())) {
				vo.setType(vo.getGrouptype());
			}
			if (map.equalsIgnoreCase("action", "request")) {
				if (map.equalsIgnoreCase("request", "save")) {
					vo = RequestMapper.getSaveRequest(map);
					resp = ObjMapper.toJson(vo);
				}
				else if (map.equalsIgnoreCase("request", "delete")) {
					vo = RequestMapper.getDeleteRequest(map);
					resp = ObjMapper.toJson(vo);
				}
				else {
					resp = ObjMapper.toJson(vo);
				}
//				resp = vo.simpleJson();
			}
			else if (map.equalsIgnoreCase("action", "response")) {
				if (map.equalsIgnoreCase("request", "save")) {
					vo = RequestMapper.getSaveRequest(map);
					resp = ApiHandler.post(vo);
				}
				else if (map.equalsIgnoreCase("request", "delete")) {
					vo = RequestMapper.getDeleteRequest(map);
					resp = ApiHandler.post(vo);
				}
				else {
					resp = ApiHandler.post(vo);
				}
			}
		}
	}
	out.print(resp);


%>
