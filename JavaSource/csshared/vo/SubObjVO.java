package csshared.vo;

import java.util.HashMap;

import csshared.vo.lkup.RolesVO;
import alain.core.utils.Numeral;
import alain.core.utils.Operator;

public class SubObjVO {

	public int id = -1;
	public String type = "";
	public String itype = "";
	public String value = "";
	public String text = "";
	public String html = "";
	public String description = "";
	public int integer = -1;
	public String date = "";
	public String link = "";
	public String target = "";
	public String placeholder = "";
	public String selected = "";
	public int maxchar = 10000;
	public String entity = "";
	public HashMap<String, String> addldata = new HashMap<String, String>();
	public boolean create = false;
	public boolean read = false;
	public boolean update = false;
	public boolean delete = false;
	public boolean admin = false;

	public SubObjVO() {}

	public ObjVO toObj() {
		ObjVO vo = new ObjVO();
		vo.setId(id);
		vo.setType(type);
		vo.setMaxchar(maxchar);
		vo.setValue(value);
		vo.setText(text);
		vo.setInteger(integer);
		vo.setDate(date);
		vo.setLink(link);
		return vo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getItype() {
		if (!Operator.hasValue(itype)) { return getType(); }
		return itype;
	}

	public void setItype(String itype) {
		this.itype = itype;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getText() {
		String t = text;
		if (!Operator.hasValue(t)) {
			t = getValue();
		}
		if (getItype().equalsIgnoreCase("currency")) {
			double d = Operator.toDouble(t);
			t = Numeral.currency(d);
		}
		return t;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getInteger() {
		return integer;
	}

	public void setInteger(int integer) {
		this.integer = integer;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getPlaceholder() {
		return placeholder;
	}

	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public boolean isSelected() {
		return getSelected().equalsIgnoreCase("Y");
	}

	public int getMaxchar() {
		return maxchar;
	}

	public void setMaxchar(int maxchar) {
		this.maxchar = maxchar;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public HashMap<String, String> getAddldata() {
		return addldata;
	}

	public void setAddldata(HashMap<String, String> addldata) {
		this.addldata = addldata;
	}

	public String getData(String field) {
		String r = addldata.get(field);
		if (!Operator.hasValue(r)) { r = ""; }
		return r;
	}

	public void setData(String field, String value) {
		addldata.put(field, value);
	}

	public boolean isCreate() {
		if (isAdmin()) { return true; }
		return create;
	}

	public void setCreate(boolean create) {
		this.create = create;
	}

	public boolean isRead() {
		if (isAdmin()) { return true; }
		if (isCreate()) { return true; }
		if (isUpdate()) { return true; }
		if (isDelete()) { return true; }
		return read;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public boolean isUpdate() {
		if (isAdmin()) { return true; }
		return update;
	}

	public void setUpdate(boolean update) {
		this.update = update;
	}

	public boolean isDelete() {
		if (isAdmin()) { return true; }
		return delete;
	}

	public void setDelete(boolean delete) {
		this.delete = delete;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean admin) {
		if (admin) {
			setAdmin(true);
			setCreate(true);
			setRead(true);
			setUpdate(true);
			setDelete(true);
		}
		else {
			setCreate(vo.createAccess(userroles, nonpublicroles));
			setRead(vo.readAccess(userroles, nonpublicroles));
			setUpdate(vo.updateAccess(userroles, nonpublicroles));
			setDelete(vo.deleteAccess(userroles, nonpublicroles));
		}
	}
	



}









