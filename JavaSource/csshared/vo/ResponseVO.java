package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import alain.core.utils.Operator;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;


public class ResponseVO {

	public int id = -1;
	public String messagecode = "";
	public ArrayList<String> messages = new ArrayList<String>();
	public ArrayList<MessageVO> errors = new ArrayList<MessageVO>();
	public HashMap<String, String> info = new HashMap<String, String>();
	public ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
	public HashMap<String, HashMap<String, String>> map = new HashMap<String, HashMap<String, String>>();
	public LinkedHashMap<String, HashMap<String, String>> orderedmap = new LinkedHashMap<String, HashMap<String, String>>();
	public boolean valid = true;
	public boolean redirect = false;
	
	public TypeVO type = new TypeVO();
	public String reference = "";
	
	public String processid = "";
	public String processtitle = "";
	public String processmessage = "";
	public int percentcomplete = 100;
	
	public FileVO file = new FileVO();
	public ResponseVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMessagecode() {
		if (Operator.equalsIgnoreCase(messagecode, "cs200") && !isValid()) { return "cs500"; }
		if (!Operator.hasValue(messagecode)) {
			if (isValid()) { return "cs200"; }
			else {
				return "cs500";
			}
		}
		return messagecode;
	}

	public void setMessagecode(String messagecode) {
		this.messagecode = messagecode;
	}

	public ArrayList<String> getMessages() {
		return messages;
	}

	public void setMessages(ArrayList<String> messages) {
		this.messages = messages;
	}

	public void addMessage(String message) {
		this.messages.add(message);
	}

	public ArrayList<MessageVO> getErrors() {
		return errors;
	}

	public void setErrors(ArrayList<MessageVO> errors) {
		this.errors = errors;
	}

	public void addError(String message) {
		addError(-1, "", message);
	}

	public void addError(int id, String field, String message) {
		MessageVO vo = new MessageVO();
		vo.setId(id);
		vo.setField(field);
		vo.setMessage(message);
		this.errors.add(vo);
	}

	public HashMap<String, String> getInfo() {
		return info;
	}

	public void setInfo(HashMap<String, String> info) {
		this.info = info;
	}

	public void addInfo(String field, String value) {
		this.info.put(field, value);
	}

	public String getInfo(String field) {
		return getInfo().get(field);
	}

	public ArrayList<HashMap<String, String>> getList() {
		return list;
	}

	public void setList(ArrayList<HashMap<String, String>> list) {
		this.list = list;
	}

	public void addList(HashMap<String, String> m) {
		this.list.add(m);
	}

	public HashMap<String, HashMap<String, String>> getMap() {
		return map;
	}

	public void setMap(HashMap<String, HashMap<String, String>> map) {
		this.map = map;
	}

	public HashMap<String, String> map(String field) {
		HashMap<String, String> r = new HashMap<String, String>();
		try {
			r = map.get(field);
			if (r == null) { r = new HashMap<String, String>(); }
		}
		catch (Exception e) {
			r = new HashMap<String, String>();
		}
		return r;
	}

	public String map(String field, String subfield) {
		String r = "";
		HashMap<String, String> m = map(field);
		try {
			r = m.get(subfield);
			if (!Operator.hasValue(r)) { r = ""; }
		}
		catch (Exception e) {
			r = "";
		}
		return r;
	}

	public void addMap(String field, HashMap<String, String> m) {
		map.put(field, m);
	}

	public void addMap(String field, String subfield, String value) {
		HashMap<String, String> m = map(field);
		m.put(subfield, value);
		addMap(field, m);
	}

	public LinkedHashMap<String, HashMap<String, String>> getOrderedmap() {
		return orderedmap;
	}

	public void setOrderedmap(LinkedHashMap<String, HashMap<String, String>> orderedmap) {
		this.orderedmap = orderedmap;
	}

	public HashMap<String, String> orderedmap(String field) {
		HashMap<String, String> r = new HashMap<String, String>();
		try {
			r = orderedmap.get(field);
			if (r == null) { r = new HashMap<String, String>(); }
		}
		catch (Exception e) {
			r = new HashMap<String, String>();
		}
		return r;
	}

	public String orderedmap(String field, String subfield) {
		String r = "";
		HashMap<String, String> m = orderedmap(field);
		try {
			r = m.get(subfield);
			if (!Operator.hasValue(r)) { r = ""; }
		}
		catch (Exception e) {
			r = "";
		}
		return r;
	}

	public void addOrderedmap(String field, HashMap<String, String> m) {
		orderedmap.put(field, m);
	}

	public void addOrderedmap(String field, String subfield, String value) {
		HashMap<String, String> m = map(field);
		m.put(subfield, value);
		addOrderedmap(field, m);
	}

	public boolean isValid() {
		if (getErrors().size() > 0) { return false; }
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public boolean isRedirect() {
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	public TypeVO getType() {
		return type;
	}

	public void setType(TypeVO type) {
		this.type = type;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String toJson() {
		return toJson(false);
	}

	public String toJson(boolean nonempty) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			if (nonempty) {
				mapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
			}
			r = mapper.writeValueAsString(this);
		} catch(Exception e) { }
		return r;
	}

	public String getProcessid() {
		return processid;
	}

	public void setProcessid(String processid) {
		this.processid = processid;
	}

	public String getProcesstitle() {
		return processtitle;
	}

	public void setProcesstitle(String processtitle) {
		this.processtitle = processtitle;
	}

	public String getProcessmessage() {
		return processmessage;
	}

	public void setProcessmessage(String processmessage) {
		this.processmessage = processmessage;
	}

	public int getPercentcomplete() {
		return percentcomplete;
	}

	public void setPercentcomplete(int percentcomplete) {
		this.percentcomplete = percentcomplete;
	}

	public FileVO getFile() {
		return file;
	}

	public void setFile(FileVO file) {
		this.file = file;
	}

	
	
	


}












