<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="alain.core.utils.Cartographer"%>
<%@include file="search/gsfacet.jsp"%>

<%

	Cartographer map = new Cartographer(request,response);
	//map.setString("_facet",URLEncoder.encode(facets, "UTF-8"));
	//System.out.println(map.getString("method")+"###############");
	if(Operator.equalsIgnoreCase(map.getString("method"), "csv")){
		
		String outputFile = "export_search.csv";
		
		
		  //String encoding =  CsConfig.getString("search.credentials.login_username")+":"+ CsConfig.getString("search.credentials.login_pass"); 
		 // byte[] encodedBytes = Base64.encodeBase64(encoding.getBytes());
		  //response.setHeader("Authorization", "Basic " + new String(encodedBytes));
		if( map.getInt("bookmarkid", 0) > 0) {
			GlobalSearch.saveExportFields(map);
		}
		
		response.setHeader("Content-type","text/csv");
		response.setHeader("Content-disposition","attachment; filename="+outputFile);
		String s = GlobalSearch.search(map);
		//System.out.println(s);
		java.io.PrintWriter op = response.getWriter();
		op.write(s);
		op.close();
	}
	else if(Operator.equalsIgnoreCase(map.getString("method"), "spell")){
		
		String resp = GlobalSearch.spell(map);
		
		
		
		out.print(resp);
	}
	else if(Operator.equalsIgnoreCase(map.getString("method"), "stats")){
		
		String resp = GlobalSearch.search(map,false,true);
		
		
		
		out.print(resp);
	}
	else if(Operator.equalsIgnoreCase(map.getString("method"), "trends")){
		
		String resp = GlobalSearch.search(map,true,false);
		
		
		
		out.print(resp);
	}
	else if(Operator.equalsIgnoreCase(map.getString("method"), "viewbookmark")){
		int bookmarkId = map.getInt("bookmarkId");
		//System.out.println("bookmark id "+bookmarkId);
		String resp = GlobalSearch.viewBookmark(bookmarkId).toString();
		out.print(resp);
	}
	
	
	else {
		String resp = GlobalSearch.search(map);
		//System.out.println(resp);
		out.print(resp);
	}
%>
