package cs.utils;

import java.io.ByteArrayOutputStream;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import csshared.vo.RequestVO;
import alain.core.utils.Cartographer;
import alain.core.utils.Operator;

public class ViewFile extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		Cartographer map = new Cartographer(request,response);
		RequestVO nav = new RequestVO();
		nav.setEntity(map.getString("_ent","lso"));
		nav.setToken(map.token());
		nav.setType(map.getString("_type","lso"));
		nav.setTypeid(map.getInt("_typeid"));
		nav.setId(map.getString("_id"));
		nav.setReference(map.getString("_reference"));
		if(Operator.hasValue(map.getString("request"))){
			nav.setRequest(map.getString("request"));
		}else {
			nav.setRequest("viewer");	
		}
		nav.setGrouptype("attachments");
		byte[] b = new byte[500];
		ByteArrayOutputStream o = new ByteArrayOutputStream();
		try {
			HttpClient c = new DefaultHttpClient();
			HttpPost p = new HttpPost(nav.getUrl());
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			String json = ow.writeValueAsString(nav);
			
			StringEntity input = new StringEntity(json);
			input.setContentType("application/json");
			p.setEntity(input);

			HttpResponse r = c.execute(p);
			HttpEntity entity = r.getEntity();
			
			response.getOutputStream();			
		
		}
		
		catch (Exception e) { }
	}
	
}
