package csshared.vo;

import java.util.HashMap;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class ObjMap {

	public int id = -1;
	public String field = "";
	public String alert = "";
	public String ref = "";
	public int refid = -1;
	public HashMap<String, ObjVO> values = new HashMap<String, ObjVO>();
	public String entity = "";
	public boolean finaled = false;
	public String expires = "";
	public boolean showpublic = false;

	public ObjMap() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getAlert() {
		return alert;
	}

	public void setAlert(String alert) {
		this.alert = alert;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public int getRefid() {
		return refid;
	}

	public void setRefid(int refid) {
		this.refid = refid;
	}

	public HashMap<String, ObjVO> getValues() {
		return values;
	}

	public void setValues(HashMap<String, ObjVO> values) {
		this.values = values;
	}

	public ObjVO value(String field) {
		ObjVO vo = new ObjVO();
		try {
			vo = values.get(field);
			if (vo == null) { vo = new ObjVO(); }
		}
		catch (Exception e) {vo = new ObjVO(); }
		return vo;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public boolean isFinaled() {
		return finaled;
	}

	public void setFinaled(boolean finaled) {
		this.finaled = finaled;
	}

	public String getExpires() {
		return expires;
	}

	public void setExpires(String expires) {
		this.expires = expires;
	}

	public boolean hasExpiration() {
		return Operator.hasValue(getExpires());
	}

	public Timekeeper expiresDate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getExpires())) {
			d.setDate(getExpires());
		}
		else {
			d.addDay(1);
		}
		return d;
	}

	public boolean hasExpired() {
		if (!hasExpiration()) { return false; }
		Timekeeper e = expiresDate();
		return e.past();
	}

	public boolean isShowpublic() {
		return showpublic;
	}

	public void setShowpublic(boolean showpublic) {
		this.showpublic = showpublic;
	}




}
