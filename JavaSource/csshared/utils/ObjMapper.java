package csshared.utils;

import java.util.HashMap;

import alain.core.security.RequestToken;
import alain.core.security.Token;
import alain.core.utils.Logger;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.ResponseVO;
import csshared.vo.TypeVO;
import csshared.vo.finance.FinanceVO;

public class ObjMapper {

	public ObjMapper() {}

	public static String toJson(RequestVO vo) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
			r = mapper.writeValueAsString(vo);
		}
		catch (Exception e) {}
		return r;
	}
	
	public static String toJson(RequestToken vo) {
		String r = vo.toString();
		return r;
	}
	
	public static String toJson(Token vo) {
		String r = vo.toString();
		return r;
	}
	
	public static String toJson(ResponseVO vo) {
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

	public static RequestToken toRequestToken(String json) {
		RequestToken evo = new RequestToken();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, RequestToken.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}
	
	public static Token toToken(String json) {
		Token evo = new Token();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, Token.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}
	
	public static RequestVO toRequestObj(String json) {
		RequestVO evo = new RequestVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, RequestVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}
	
	public static TypeVO toTypeObj(String json) {
		TypeVO evo = new TypeVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, TypeVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}

	public static TypeVO convert(RequestVO vo) {
		TypeVO t = new TypeVO();
		t.setEntity(vo.getEntity());
		t.setId(vo.getTypeid());
		t.setType(vo.getType());
		return t;
	}
	
	public static ResponseVO toResponseObj(String json) {
		ResponseVO evo = new ResponseVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, ResponseVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}
	
	public static FinanceVO toRequestFinanceObj(String json) {
		FinanceVO evo = new FinanceVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, FinanceVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}

	public static HashMap<String, ObjVO> getObjMap(TypeVO vo) {
		HashMap<String, ObjVO> map = new HashMap<String, ObjVO>();
		ObjGroupVO[] gs = vo.getGroups();
		if (gs.length > 0) {
			ObjGroupVO g = gs[0];
			ObjVO[] os = g.getObj();
			int l = os.length;
			for (int i=0; i<l; i++) {
				ObjVO o = os[i];
				String fieldid = o.getFieldid();
				map.put(fieldid, o);
			}
		}
		return map;
	}

	public static HashMap<String, String> getFieldValues(TypeVO vo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ObjGroupVO[] gs = vo.getGroups();
		if (gs.length > 0) {
			ObjGroupVO g = gs[0];
			ObjVO[] os = g.getObj();
			int l = os.length;
			for (int i=0; i<l; i++) {
				ObjVO o = os[i];
				String fieldid = o.getFieldid();
				String value = o.getValue();
				map.put(fieldid, value);
			}
		}
		return map;
	}

	public static HashMap<String, String> getFieldText(TypeVO vo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ObjGroupVO[] gs = vo.getGroups();
		if (gs.length > 0) {
			ObjGroupVO g = gs[0];
			ObjVO[] os = g.getObj();
			int l = os.length;
			for (int i=0; i<l; i++) {
				ObjVO o = os[i];
				String fieldid = o.getFieldid();
				String value = o.getText();
				map.put(fieldid, value);
			}
		}
		return map;
	}

	public static String getGroupId(TypeVO vo) {
		String r = "";
		ObjGroupVO[] gs = vo.getGroups();
		if (gs.length > 0) {
			ObjGroupVO g = gs[0];
			r = g.getGroupid();
		}
		return r;
	}

	public static boolean isFinaled(TypeVO vo) {
		boolean r = false;
		ObjGroupVO[] gs = vo.getGroups();
		if (gs.length > 0) {
			ObjGroupVO g = gs[0];
			r = g.isFinaled();
		}
		return r;
	}



/*	public static TypeVO toTypeVoObj(String json) {
		TypeVO evo = new TypeVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			evo = mapper.readValue(json, TypeVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return evo;
	}*/




}
