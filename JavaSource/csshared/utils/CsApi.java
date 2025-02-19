package csshared.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import alain.core.email.ExchangeMessenger;
import alain.core.security.RequestToken;
import alain.core.security.Token;
import alain.core.utils.Cartographer;
import alain.core.utils.Logger;
import alain.core.utils.Operator;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import csshared.vo.AvailabilityVO;
import csshared.vo.DivisionsList;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.ResponseVO;
import csshared.vo.SubObjGroupVO;
import csshared.vo.SubObjVO;
import csshared.vo.TypeVO;


public class CsApi {

	public static String id = "_id";
	public static String entityid = "_entid";
	public static String entity = "_ent";
	public static String typeid = "_typeid";
	public static String type = "_type";
	public static String groupid = "_grpid";
	public static String group = "_grp";
	public static String grouptype = "_grptype";
	public static String reference = "_reference";
	public static String ref = "_ref";
	public static String refid = "_refid";

	public static String review = "_review";
	public static String reviewid = "_reviewid";
	public static String reviewrefid = "_revrefid";
	public static String reviewgroupid = "_revgroupid";

	public static String subgroup = "_subgrp";
	public static String subgroupfields = "_subgrpflds";
	public static String subgroupsize = "_subgrpsize";

	public static String request = "_request";
	public static String action = "_act";
	public static String startdate = "_startdate";
	public static String enddate = "_enddate";
	public static String start = "_start";
	public static String end = "_end";

	public static String appttypeid = "_appttypeid";
	public static String apptsubtypeid = "_apptsubtypeid";
	public static String apptstatusid = "_apptstatusid";
	public static String note = "_note";
	public static String option = "_end";

	public static String toJson(RequestVO vo) {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(vo);
		}
		catch (Exception e) {}
		return r;
	}

	public static String toJson(TypeVO vo) {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(vo);
		}
		catch (Exception e) {}
		return r;
	}

	public static String toJson(ObjGroupVO[] vo) {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(vo);
		}
		catch (Exception e) {}
		return r;
	}

	public static String toJson(SubObjVO[] vo) {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(vo);
		}
		catch (Exception e) {}
		return r;
	}

	public static ResponseVO toResponseVO(String json) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		ResponseVO evo = new ResponseVO();
		try {
			evo = mapper.readValue(json, ResponseVO.class);
		}
		catch (Exception e) {
			evo = new ResponseVO();
			evo.setMessagecode("cs500");
			evo.addError(e.getMessage());
			Logger.error(e);
		}
		return evo;
	}

	public static String post(RequestVO vo) {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(vo);
			r = post(vo.getUrl(), r);
		}
		catch (Exception e) { }
		return r;
	}

	public static String post(String url, String json) {
		Logger.info("POST URL", url);
		StringBuilder sb = new StringBuilder();

		try {
			HttpClient c = new DefaultHttpClient();
			HttpPost p = new HttpPost(url);
			StringEntity input = new StringEntity(json);
			input.setContentType("application/json");
			p.setEntity(input);

			HttpResponse r = c.execute(p);
			HttpEntity entity = r.getEntity();

			if (entity != null) {
				InputStream is = entity.getContent();

				BufferedReader br = new BufferedReader(new InputStreamReader(is));
				String l = System.getProperty("line.separator");
				String line;
				
				while ((line = br.readLine()) != null) {
					sb.append(line);
					sb.append(l);
				}
				is.close();
			}
		}
		catch (Exception e) { Logger.error(e); }
		return sb.toString();
	}

	public static String post(String action, RequestToken vo) {
		String r = "";
		try {
			StringBuilder sb = new StringBuilder();
			sb.append(Operator.removeTrailingSlash(CsConfig.getString("tokendomain")));
			sb.append("/");
			sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));
			sb.append("/auth/").append(action);
			String url = sb.toString();
			sb = new StringBuilder();
			sb = null;
			r = post(url, vo.toString());
		}
		catch (Exception e) {}
		return r;
	}

	public static ResponseVO getResponse(RequestVO vo) {
		String json = post(vo);
		return toResponseVO(json);
	}
	
	 public static TypeVO getType(RequestVO vo) {
		String json = post(vo);
		
		Logger.info("GET TYPEEEEEEEEEEEEEEEEEEEEEEE");
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		TypeVO evo = new TypeVO();
		try {
			Logger.info(json);
			evo = mapper.readValue(json, TypeVO.class);
		}
		catch (Exception e) { e.printStackTrace(); Logger.error(e); }
		return evo;
	}

	public static TypeVO getType(String url) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		TypeVO u = new TypeVO();
		try {
			u = mapper.readValue(new URL(url), TypeVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return u;
	}

	public static ObjGroupVO getGroup(RequestVO vo) {
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		ObjGroupVO evo = new ObjGroupVO();
		try {
			evo = mapper.readValue(json, ObjGroupVO.class);
		}
		catch (Exception e) { e.printStackTrace(); Logger.error(e); }
		return evo;
	}
	
	public static ObjGroupVO[] getGroups(RequestVO vo) {
		ObjGroupVO[] evo = new ObjGroupVO[0];
		try {
			evo = getGroupsOrErrorOnce(vo);
		}
		catch (Exception e) {
			Logger.error(e);
		}
		return evo;
	}

	public static ObjGroupVO[] getGroupsOrErrorTwice(RequestVO vo) throws Exception {
		ObjGroupVO[] evo = new ObjGroupVO[0];
		try {
			evo = getGroupsOrErrorOnce(vo);
		}
		catch (Exception e) {
			try {
				Thread.sleep(2000);
				vo.setAction("refresh");
				evo = getGroupsOrErrorOnce(vo);
			}
			catch (Exception e1) {
				Logger.error(e1);
				throw new Exception();
			}
		}
		return evo;
	}

	public static ObjGroupVO[] getGroupsOrErrorOnce(RequestVO vo) throws Exception {
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		ObjGroupVO[] evo = new ObjGroupVO[0];
		evo = mapper.readValue(json, ObjGroupVO[].class);
		return evo;
	}
	
	public static DivisionsList getDivisions(RequestVO vo) {
		vo.setModule("divisions");
		vo.setRequest("divisions");
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		DivisionsList evo = new DivisionsList();
		try {
			evo = mapper.readValue(json, DivisionsList.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}

	public static DivisionsList getPublicDivisions(RequestVO vo) {
		vo.setModule("divisions");
		vo.setRequest("publicdivisions");
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		DivisionsList evo = new DivisionsList();
		try {
			evo = mapper.readValue(json, DivisionsList.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}

	public static SubObjVO[] getChoices(String choicetype, String entity, String type, int typeid) {
		RequestVO vo = new RequestVO();
		vo.setEntity(entity);
		vo.setGrouptype(choicetype);
		vo.setType(type);
		vo.setTypeid(typeid);
		return getChoices(vo);
	}

	public static SubObjVO[] getChoices(RequestVO vo) {
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		SubObjVO[] evo = new SubObjVO[0];
		try {
			evo = mapper.readValue(json, SubObjVO[].class);
		}
		catch (Exception e) {
			try {
				ObjVO ovo = mapper.readValue(json, ObjVO.class);
				evo = ovo.getChoices();
			}
			catch (Exception e1) { Logger.error(e); }
		}
		return evo;
	}

	public static ObjVO psearch(String entity, String type, String query, int page, int max, String token, String ip) {
		if (page < 1) { page = 1; }
		if (max < 1) { max = 25; }
		RequestVO vo = new RequestVO();
		vo.setToken(token);
		vo.setIp(ip);
		vo.setEntity(entity);
		vo.setType(type);
		vo.setGrouptype(type);
		vo.setSearch(query);
		vo.setRequest("psearch");
		vo.addExtra("PAGE", Operator.toString(page));
		vo.addExtra("MAX", Operator.toString(max));
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		ObjVO evo = new ObjVO();
		try { evo = mapper.readValue(json, ObjVO.class); }
		catch (Exception e) { }
		return evo;
	}

	public static AvailabilityVO getAvailability(RequestVO vo) {
		String json = post(vo);
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		AvailabilityVO evo = new AvailabilityVO();
		try {
			evo = mapper.readValue(json, AvailabilityVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}

	public static Token getToken(String token, String ip) {
		RequestToken r = new RequestToken();
		r.setToken(token);
		r.setIp(ip);
		String s  = post("token", r);
		Token t = new Token();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			t = mapper.readValue(s, Token.class);
		}
		catch (Exception e) { Logger.error(e); }
		return t;
	 }

	public static String token(String token, String ip) {
		RequestToken r = new RequestToken();
		r.setToken(token);
		r.setIp(ip);
		String s  = post("token", r);
		return s;
	 }

	public static Token login(String username, String password, String ip) {
		RequestToken r = new RequestToken();
		r.setUsername(username);
		r.setPassword(password);
		r.setIp(ip);
		String s  = post("token", r);
		Token t = new Token();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			t = mapper.readValue(s, Token.class);
		}
		catch (Exception e) { Logger.error(e); }
		return t;
	}

	public static String info(String entity, String token, String ip) {
		if (!Operator.hasValue(token)) { return ""; }
		RequestVO req = new RequestVO();
		req.setToken(token);
		req.setIp(ip);
		req.setEntity(entity);
		req.setType(entity);
		req.setAction("version");
		String json = post(req);
		return json;
	 }

	public static String content(String contenttype, String token, String ip) {
		RequestVO req = new RequestVO();
		req.setToken(token);
		req.setIp(ip);
		req.setReference(contenttype);
		req.setAction("content");
		String json = post(req);
		return json;
	 }

	public static SubObjVO[] getLkupObj(String choicetype, String entity, String type, int selectedid) {
		RequestVO vo = new RequestVO();
		vo.setEntity(entity);
		vo.setRequest(choicetype);
		vo.setType(type);
		vo.setId(Operator.toString(selectedid));
		vo.setGrouptype(type);
		vo.setModule("lkup");
		String json = post(vo);

		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		SubObjVO[] evo = new SubObjVO[0];
		try {
			evo = mapper.readValue(json, SubObjVO[].class);
		}
		catch (Exception e) {
			try {
				ObjVO ovo = mapper.readValue(json, ObjVO.class);
				evo = ovo.getChoices();
			}
			catch (Exception e1) { Logger.error(e); }
		}
		return evo;
	}

	public static SubObjVO[] getStreets() {
		return getStreets(-1);
	}

	public static SubObjVO[] getStreets(int selectedid) {
		return getLkupObj("streets","lso","profile", selectedid);
	}

	public static boolean notifyAdministrators(String method,String problem) {
		boolean result = true;
		String email = "aromero@beverlyhills.org,sunvoyage@gmail.com,svijay@edgesoftinc.com;jdeanda@beverlyhills.org";
		StringBuffer sb = new StringBuffer();
		sb.append(" Problem in the method have a look into the script.");
		sb.append(method);
		sb.append("<BR><BR><BR>");
		sb.append(problem);
		String message = sb.toString();
		ExchangeMessenger m = new ExchangeMessenger();
		m.setRecipient(email);
		m.setSubject("CITY SMART");
		m.setContent(message);
		result = m.deliver();
		Logger.info(message);
		return result;
	}
























	public static RequestVO createRequest(Cartographer map) {
		return createRequest(map, map.getString(action));
	}

	public static RequestVO createRequest(Cartographer map, String action) {
		RequestVO nav = new RequestVO();

		nav.setId(map.getString(id));
		nav.setEntityid(map.getInt(entityid));
		nav.setEntity(map.getString(entity));
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setReference(map.getString(reference));
		nav.setRef(map.getString(ref));
		nav.setRefid(map.getInt(refid));
		nav.setOption(map.getString(option));

		nav.setReview(map.getString(review));
		nav.setReviewid(map.getInt(reviewid));
		nav.setReviewrefid(map.getInt(reviewrefid));
		nav.setReviewgroupid(map.getInt(reviewgroupid));

		nav.setRequest(map.getString(request));
		nav.setAction(action);
		nav.setStartdate(map.getString(startdate));
		nav.setEnddate(map.getString(enddate));
		nav.setStart(map.getInt(start));
		nav.setEnd(map.getInt(end));

		nav.setAppttypeid(map.getInt(appttypeid));
		nav.setApptsubtypeid(map.getInt(apptsubtypeid));
		nav.setApptstatusid(map.getInt(apptstatusid));

		if (map.hasValue(note)) {
			nav.addExtra("note", map.getString(note));
		}

		nav.setUsername(map.username());
		if(Operator.hasValue(map.getString("token"))){
			nav.setToken(map.getString("token"));
		}else {
			nav.setToken(map.token());
		}
		nav.setIp(map.getRemoteIp());
		return nav;
	}

	public static ObjGroupVO[] group(Cartographer map) {
		RequestVO n = createRequest(map);
		return group(map,n,false,true);
	}	

	public static ObjGroupVO[] group(Cartographer map, TypeVO type) {
		ObjGroupVO[] result = new ObjGroupVO[0];
		ObjGroupVO[] gs = type.getGroups();
		if (gs.length > 0) {
			ObjGroupVO grp = gs[0];
			result = group(map, grp);
		}
		return result;
	}	

	public static ObjGroupVO[] group(Cartographer map, ObjGroupVO grp) {
		RequestVO n = createRequest(map);
		return group(map,n,grp,false,true);
	}	

	public static ObjGroupVO[] group(Cartographer map, RequestVO n, boolean subgroups) {
		return group(map, n, subgroups, false);
	}

	public static ObjGroupVO[] group(Cartographer map, RequestVO n, boolean subgroups, boolean nonempty) {
		ObjGroupVO[] result = new ObjGroupVO[0];
		if(Operator.hasValue(n.getType())){
			n.setRequest("fields");
			TypeVO e = getType(n);
			ObjGroupVO[] gs = e.getGroups();
			if (gs.length > 0) {
				ObjGroupVO grp = gs[0];
				result = group(map, n, grp, subgroups, nonempty);
			}
		}
		return result;
	}

	public static ObjGroupVO[] group(Cartographer map, RequestVO n, ObjGroupVO grp, boolean subgroups, boolean nonempty) {
		boolean multi = map.equalsIgnoreCase(action, "multiedit");

		ObjGroupVO[] result = new ObjGroupVO[0];
	
		if(Operator.hasValue(n.getType())){
			ObjGroupVO g = new ObjGroupVO();
			g.setGroup(map.getString(group));
			g.setGroupid(map.getString(groupid));
			g.setType(map.getString(grouptype));

			result = new ObjGroupVO[1];
			ObjVO[] sf = grp.getObj();
			ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
			int l = sf.length;
			for (int i=0; i<l; i++) {
				ObjVO f = sf[i];
				String fieldid = f.getFieldid();
				String mfield = f.getMultieditcheck();
				String itype = f.getItype();
				String value = "";
				
				boolean systemgenerated = f.isSystemGenerated();
				boolean m = f.isMultiedit();
				if (!multi) {
					value = map.getString(fieldid);
				}
				
				else if (multi && m) {
					if (!Operator.hasValue(mfield)) {
						value = map.getString(fieldid);
					}
					else {
						String ch = map.getString(mfield);
						if (Operator.equalsIgnoreCase(ch, "Y")) {
							value = map.getString(fieldid);
						}
						else {
							value = CsConfig.SKIPVALUE;
						}
					}
				}
				if (!nonempty || Operator.hasValue(value) || systemgenerated || itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle") || f.hasMultivalueindex()) {
					if (!Operator.hasValue(value)) {
						if (itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle")) {
							value = "N";
						}
					}
					f.setValue(value);
					
					if (f.isQty()) {
						String[] values = parameterToArray(value);
						for (int x=0; x<values.length; x++) {
							String v = values[x];
							f.addValue(v, map.getString(v));
						}
					}
					if (f.hasMultivalueindex()) {
						String mf = f.getMultivalueindex();
						String fs = map.getString(mf);
						if (Operator.hasValue(fs)) {
							String param = map.getString(f.getMultivalueindex());
							String[] values = parameterToArray(param);
							for (int x=0; x<values.length; x++) {
								String v = values[x];
								StringBuilder sb = new StringBuilder();
								sb.append(fieldid).append("_").append(v);
								String mfld = sb.toString();
								String vl = map.getString(mfld);
								if (Operator.hasValue(vl)) {
									f.addValue(mfld, vl);
								}
							}
						}
					}
					gf.add(f);
				}
			}
			g.setObj(gf.toArray(new ObjVO[gf.size()]));
			if(subgroups){
				g.setCustomsize(map.getInt("customsize",0));
				g.setCustom(custom(map, n));
			}
			else if (map.hasValue(subgroup)) {
				g.setSubgroup(map.getString(subgroup));
				g.setCustom(subgroup(map, n));
			}
			result[0] = g;
		}
		return result;
	}

	public static SubObjGroupVO[] custom(Cartographer map, RequestVO n) {
		
		ArrayList<SubObjGroupVO> r = new ArrayList<SubObjGroupVO>();
		n.setRequest("addlfields");
		if(Operator.hasValue(n.getType())){
			TypeVO e = getType(n);
			
			if (e.getGroups().length > 0) {
				int count = map.getInt("customsize",0);
				Logger.info(count);
				ObjGroupVO g = e.getGroups()[0];
				ObjVO[] sf = g.getObj();
				for(int i=0;i<count;i++){
					
					SubObjGroupVO s = new SubObjGroupVO();
					s.setGroup(g.getGroup());
					s.setGroupid(g.getGroupid());
				
					ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
					int l = sf.length;
					
					for (int j=0; j<l; j++) {
						ObjVO f = new ObjVO();
						String fieldid = sf[j].getFieldid();
						String value = map.getString(fieldid);
						f.setFieldid(fieldid);
						f.setItype(sf[j].getItype());
						if(!Operator.hasValue(value)){
							value = map.getString(fieldid+"_"+i);
							
						}
						f.setValue(value);
						if (!Operator.hasValue(value)) {
							String itype = f.getItype();
							if (itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle")) {
								value = "N";
							}
						}
						Logger.info(f.getFieldid()+" :: "+f.getValue());
						gf.add(f);
						
					
					}
					
					s.setObj(gf.toArray(new ObjVO[gf.size()]));
					r.add(s);
				}
				
			}
		}
		
		SubObjGroupVO[] ra = r.toArray(new SubObjGroupVO[r.size()]);
		return ra;
	}

	public static SubObjGroupVO[] subgroup(Cartographer map, RequestVO n) {

		SubObjGroupVO[] result = new SubObjGroupVO[0];
		if (map.hasValue(subgroup)) {
			int size = map.getInt(subgroupsize, -1);
			RequestVO req = n.duplicate();
			req.setGroup(subgroup);
			req.setGroupid(subgroup);
			req.setGrouptype(map.getString(subgroup));
			req.setRequest("fields");

			TypeVO e = getType(req);
			ObjGroupVO[] gs = e.getGroups();
			ObjGroupVO s = gs[0];
			ObjVO[] fields = s.getObj();
			if (gs.length > 0) {
				if (size < 0) {
					result = new SubObjGroupVO[1];
					SubObjGroupVO g = new SubObjGroupVO();
					ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
					int l = fields.length;
					for (int i=0; i<l; i++) {
						ObjVO f = fields[i];
						String fieldid = f.getFieldid();
						String value = "";
						value = map.getString(fieldid);
						f.setValue(value);
						gf.add(f);
					}
					g.setObj(gf.toArray(new ObjVO[gf.size()]));
					result[0] = g;
				}
				else {
					SubObjGroupVO[] subarray = new SubObjGroupVO[size];
					for (int i=0; i<size; i++) {
						SubObjGroupVO sub = new SubObjGroupVO();
						int l = fields.length;
						ObjVO[] oa = new ObjVO[l];
						for (int x=0; x<l; x++) {
							ObjVO f = fields[x];
							String fieldid = f.getFieldid()+"_"+i;
							String value = "";
							value = map.getString(fieldid);
							f.setValue(value);
							oa[x] = f;
						}
						sub.setObj(oa);
						SubObjGroupVO dsub = SubObjGroupVO.deserialize(sub);
						subarray[i] = dsub;
					}
					result = subarray;
				}
			}

		}
		return result;
	}

	public static String[] parameterToArray(String param) {
		String[] r = new String[0];
		if (Operator.hasValue(param)) {
			if (param.indexOf(",") > -1) {
				r = Operator.split(param, ",");
			}
			else {
				r = Operator.split(param, "|");
			}
		}
		return r;
	}

	public static String submitRequest(Cartographer map) {
		RequestVO nav = createRequest(map);
		nav.setRequest("details");
		nav.setSubrequest("save");
		nav.setData(group(map));
		return ObjMapper.toJson(nav);
	}

	public static RequestVO saveRequest(Cartographer map) {
		RequestVO nav = createRequest(map);
		if (map.hasValue(action)) {
			nav.setRequest(map.getString(action));
		}
		else {
			nav.setRequest("save");
		}
		nav.setData(group(map));
		return nav;
	}

	public static TypeVO fields(String entity, String type, String token, String ip) {
		TypeVO r = new TypeVO();
		Cartographer map = new Cartographer();
		RequestVO req = createRequest(map);
		req.setIp(ip);
		req.setEntity(entity);
		req.setToken(token);
		req.setType(type);
		req.setRequest("fields");
		r = getType(req);
		return r;
	}

	public static TypeVO details(String entity, String type, String token, String ip) {
		TypeVO r = new TypeVO();
		Cartographer map = new Cartographer();
		RequestVO req = createRequest(map);
		req.setIp(ip);
		req.setEntity(entity);
		req.setToken(token);
		req.setType(type);
		req.setRequest("details");
		r = getType(req);
		return r;
	}

	public static TypeVO requestType(int id, String entity, String type, String request, String token, String ip) {
		return requestType(id, entity, type, -1, "", request, token, ip);
	}

	public static TypeVO requestType(String entity, String type, String request, String token, String ip) {
		return requestType(entity, type, -1, "", request, token, ip);
	}

	public static TypeVO requestType(String entity, String type, int typeid, String grouptype, String request, String token, String ip) {
		return requestType(-1, entity, type, typeid, grouptype, request, token, ip);
	}

	public static TypeVO requestType(int id, String entity, String type, int typeid, String grouptype, String request, String token, String ip) {
		TypeVO r = new TypeVO();
		Cartographer map = new Cartographer();
		RequestVO req = createRequest(map);
		req.setId(Operator.toString(id));
		req.setIp(ip);
		req.setEntity(entity);
		req.setToken(token);
		req.setType(type);
		req.setTypeid(typeid);
		req.setGrouptype(grouptype);
		req.setRequest(request);
		r = getType(req);
		return r;
	}


}
















