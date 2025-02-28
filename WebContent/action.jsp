<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONObject"%>

<%@page import="csshared.utils.CsApi"%><%@page import="csshared.vo.TypeVO"%><%@page import="org.json.JSONArray"%><%@page import="csshared.vo.ResponseVO"%><%@page import="alain.core.utils.Logger"%><%@page import="alain.core.utils.Operator"%><%@page import="csshared.utils.CsConfig"%><%@page import="cs.utils.Cart"%><%@page import="alain.core.utils.Config"%><%@page import="csshared.vo.RequestVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><%

	Cartographer map = new Cartographer(request,response);
	if (!Operator.hasValue(map.token()) || !Operator.hasValue(map.username())) {
		map.logout();
	}
	else {
		StringBuilder sb = new StringBuilder();
		sb.append("summary.jsp?_ent=").append(map.getString("_ent")).append("&_type=").append(map.getString("_type")).append("&_id=").append(map.getString("_typeid")).append("&grp=").append(map.getString("_grp")).append("&_typeid=").append(map.getString("_typeid"));
		String redirect = sb.toString();
		if (map.equalsIgnoreCase("_action", "cancel")) {
			map.redirect(redirect);
		}
		
		else if(map.equalsIgnoreCase("_action", "showselector")){
			
			/* int groupid = map.getInt("ID");
			System.out.println(groupid);
			if(groupid>0){
				
				JSONArray o = AddressTest.getJsonList(AddressTest.getCustomFields(groupid));
				//o.put(1,);
				System.out.println(o.toString()+"###############");
				out.write(o.toString());
			} */
		}
		else if (map.equalsIgnoreCase("_action", "feecalculate")) {
			RequestVO vo = RequestMapper.getFeesRequest(map,"calculate");
			String resp = CsApi.post(vo);
			System.out.println("calc response "+resp);
			out.print(resp);
		}else if (map.equalsIgnoreCase("_action", "feesave")) {
			RequestVO vo = RequestMapper.getFeesRequest(map,"save");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "addtocart")) {
			String resp = Cart.processCart(map);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "scantocart")) {
			String resp = Cart.scanPermitCart(map);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "addcartpermit")) {
			String resp = Cart.processPermitCart(map);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "deletecart")) {
			String resp = Cart.deleteCart(map);
			out.print(resp);
		}else if (map.equalsIgnoreCase("_action", "clearcart")) {
			String resp = Cart.clearCart(map);
			out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "ordercart")) {
			String resp = Cart.orderCart(map);
			out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "highlightcart")) {
			String resp = Cart.highlightCart(map);
			out.print(resp);
		}else if (map.equalsIgnoreCase("_action", "payment")) {
			RequestVO vo = RequestMapper.getPaymentRequest(map);
			 String resp = CsApi.post(vo);
			if(Operator.hasValue(resp)){
				map.setSession("_transactionresponse",resp);
				map.redirect("transaction.jsp?mode=payment");
			}else {
				map.redirect("payment.jsp?_ent=finance&_type=finance&message=Problem while processing payment");
			} 
			//out.print(resp);
			//out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "depositpayees")) {
			RequestVO vo = RequestMapper.getDepositPayeesRequest(map);
			String resp = CsApi.post(vo);
			//map.setSession("_transactionresponse",resp);
			//map.redirect("transaction.jsp?mode=deposit");
			//out.print(resp);
			out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "deposit")) {
			RequestVO vo = RequestMapper.getDepositRequest(map);
			String resp = CsApi.post(vo);
			map.setSession("_transactionresponse",resp);
			map.redirect("transaction.jsp?mode=deposit");
			//out.print(resp);
			//out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "reverse")) {
			RequestVO vo = RequestMapper.getReverseRequest(map);
			
			String resp = CsApi.post(vo);
			System.out.println("DONE REVERSE __>"+resp);
			map.setSession("_transactionresponse",resp);
			System.out.println("REDIRECT REVERSE __>");
			map.redirect("transaction.jsp?mode=reverse");
			System.out.println("DONE  REVERSE >");
			
		}else if (map.equalsIgnoreCase("_action", "showstatementpayment")) {
			RequestVO vo = RequestMapper.getStatementPaymentRequest(map);
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "partialreverse")) {
			RequestVO vo = RequestMapper.getPartialReverseRequest(map);
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}else if (map.equalsIgnoreCase("_action", "showledger")) {
			RequestVO vo = RequestMapper.getLedgerPaymentRequest(map);
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}
		else if (map.equalsIgnoreCase("_action", "deletefee")) {
			RequestVO vo = RequestMapper.getRequest(map);
			vo.setRequest("deletefee");
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}
		else if (map.equalsIgnoreCase("_action", "showdepositledger")) {
			RequestVO vo = RequestMapper.getDepositLedgerRequest(map);
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}
		else if (map.equalsIgnoreCase("_action", "depositlist")) {
			
			RequestVO vo = RequestMapper.getDepositList(map);
			String resp = CsApi.post(vo);
			//out.print(resp);
			out.print(resp);
			
		}
		else if (map.equalsIgnoreCase(RequestMapper.subgroup, "REFUSER")) {

			RequestVO vo = RequestMapper.getRequest(map);
			HashMap<String, String> extras = new HashMap<String, String>();
			extras.put("LKUP_ACTPEOPLETYPE_ID", map.getString("LKUP_ACTPEOPLETYPE_ID"));
			extras.put("NAME", map.getString("NAME"));
			vo.setExtras(extras);
			vo.setRequest("updateactuser");
			String resp = CsApi.post(vo);
			System.out.println(resp);
			out.print(resp); 
		}
		else if (map.equalsIgnoreCase(RequestMapper.action, "delete")) {
			RequestVO vo = RequestMapper.getDeleteRequest(map);
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase(RequestMapper.action, "deletelockbox")) {
			
			RequestVO vo = RequestMapper.getRequest(map);
			vo.setRequest("delete");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase(RequestMapper.action, "reroute")) {
			RequestVO vo = RequestMapper.getRequest(map);
			vo.setRequest("reroute");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase(RequestMapper.action, "email")) {
			RequestVO vo = RequestMapper.getEmailRequest(map);
			vo.setRequest("send");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		
		else if (map.equalsIgnoreCase(RequestMapper.action, "updateStatusIssued")) {
			RequestVO vo = RequestMapper.getRequest(map);
			vo.setRequest("statusdefaultissued");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		
		else if (map.equalsIgnoreCase(RequestMapper.action, "getupdatedates")) {
			RequestVO vo = RequestMapper.getRequest(map);
			vo.setRequest("getupdatedates");
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase(RequestMapper.group, "attachments")) {
			RequestVO vo = RequestMapper.getSaveRequest(map);
			//String resp = ApiHandler.post(vo);
			ResponseVO r = CsApi.getResponse(vo);
			StringBuilder u = new StringBuilder();
			
			if(r.getMessagecode().equals("cs200")){
				u.append("summary.jsp?_id=").append(vo.getTypeid()).append("&_entid=0&_ent=").append(vo.getEntity()).append("&_typeid=").append(vo.getTypeid()).append("&_type=").append(vo.getType()).append("");
				map.redirect(u.toString());	
			}else {
				u.append("attachments.jsp?_id=").append(vo.getId()).append("&_entid=0&_ent=").append(vo.getEntity()).append("&_typeid=").append(vo.getTypeid()).append("&_type=").append(vo.getType()).append("&_grpid=attachments&_grp=attachments&_grptype=attachments");
				if(Operator.toInt(vo.getId())<=0){
					u.append("&act=add");
				}
				map.redirect(u.toString());
			}
			
		}
		
		else if (map.equalsIgnoreCase(RequestMapper.action, "import")) {
			RequestVO vo = RequestMapper.getSaveRequest(map);
			ResponseVO r = CsApi.getResponse(vo);
			StringBuilder u = new StringBuilder();
			if(r.getMessagecode().equals("cs200")){
				u.append("summary.jsp?_id=").append(vo.getTypeid()).append("&_entid=0&_ent=").append(vo.getEntity()).append("&_typeid=").append(vo.getTypeid()).append("&_type=").append(vo.getType()).append("");
				map.redirect(u.toString());	
			}
			else {
				u.append("importresolution.jsp?_id=").append(vo.getId()).append("&_entid=0&_ent=").append(vo.getEntity()).append("&_typeid=").append(vo.getTypeid()).append("&_type=").append(vo.getType()).append("&_grpid=resolution&_grp=resolution&_grptype=resolution");
				map.redirect(u.toString());
			}
		}
		else if (map.equalsIgnoreCase("_action", "onlineapproval")) {
			RequestVO vo = RequestMapper.getApprovalRequest(map);
			vo.setAction(map.getString("_request"));
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "pollstatus")) {
			RequestVO vo = RequestMapper.getRequest(map);
	/* 		System.out.println(map.getString("_act"));
			System.out.println(map.getString("_request"));
			System.out.println(map.getString("_grpid")); */
			vo.setAction(map.getString("_request"));
			String resp = CsApi.post(vo);
			out.print(resp);
		}
		else if (map.equalsIgnoreCase("_action", "save and add to cart")) {
			RequestVO vo = RequestMapper.getSaveRequest(map);
			String resp = CsApi.post(vo);
			ResponseVO r = CsApi.toResponseVO(resp);
			TypeVO t = r.getType();
			String actids = t.data("activities");
			out.print(resp);
		}
		else {
			RequestVO vo = RequestMapper.getSaveRequest(map);
			String resp = CsApi.post(vo);
			System.out.println(resp);
			out.print(resp); 
		}
	}


%>
