<%@page import="alain.core.security.AuthenticateAgent"%>
<%@page import="alain.core.security.RequestToken"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="cs.utils.Cart"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.common.ApiHandler"%><%@page import="csshared.vo.RequestVO"%><%@page import="cs.utils.RequestMapper"%><%@page import="alain.core.utils.Cartographer"%><%

	String resp = "";
	Cartographer map = new Cartographer(request, response, true);
	String entity = map.getString(RequestMapper.entity);

	if (map.equals(RequestMapper.action, "login")) {
		if (map.equalsIgnoreCase("action", "url")) {
			StringBuilder sb = new StringBuilder();
			sb.append(Operator.removeTrailingSlash(CsConfig.getDomain(entity)));
			sb.append("/");
			sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));
			sb.append("/auth/login");
			resp = sb.toString();
		}
		else {
			if (!map.hasValue("username")) {
				resp = "Username is a required field.";
			}
			else if (!map.hasValue("password")) {
				resp = "Password is a required field.";
			}
			else if (!map.hasValue("requestor")) {
				resp = "Requestor is a required field.";
			}
			else if (!map.hasValue("ip")) {
				resp = "IP is a required field";
			}
			else {
				RequestToken r = new RequestToken();
				r.setUsername(map.getString("username"));
				String password = map.getString("password");
//				String encpass = AuthenticateAgent.encryptPassword(map.getString("requestor"), password);
//				r.setPassword(encpass);
				r.setPassword(password);
				r.setRequestor(map.getString("requestor"));
				r.setIp(map.getString("ip"));
				r.setAction(map.getString(RequestMapper.action));
				if (map.equalsIgnoreCase("action", "request")) {
					resp = r.toString();
				}
				else if (map.equalsIgnoreCase("action", "response")) {
					resp = ApiHandler.post(entity, r);
				}
			}
		}
	}
	else if (map.equals(RequestMapper.action, "token")) {
		if (map.equalsIgnoreCase("action", "url")) {
			StringBuilder sb = new StringBuilder();
			sb.append(Operator.removeTrailingSlash(CsConfig.getDomain(entity)));
			sb.append("/");
			sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));
			sb.append("/auth/token");
			resp = sb.toString();
		}
		else {
			if (!map.hasValue("token")) {
				resp = "Token is a required field.";
			}
			else if (!map.hasValue("ip")) {
				resp = "IP is a required field";
			}
			else if (!map.hasValue("requestor")) {
				resp = "Requestor is a required field.";
			}
			else {
				RequestToken r = new RequestToken();
				r.setToken(map.getString("token"));
				r.setRequestor(map.getString("requestor"));
				r.setIp(map.getString("ip"));
				r.setAction(map.getString(RequestMapper.action));
				if (map.equalsIgnoreCase("action", "request")) {
					resp = r.toString();
				}
				else if (map.equalsIgnoreCase("action", "response")) {
					resp = ApiHandler.post(entity, r);
				}
			}
		}
	}

	out.print(resp);


%>
