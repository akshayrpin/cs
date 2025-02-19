package csshared.vo;

import java.util.HashMap;

import alain.core.utils.Operator;

public class ObjVO {

	public int id = -1;
	public String fieldid = "";
	public String field = "";
	public String label = "";
	public String type = "";
	public String ref = "";
	public int refid = -1;
	public String itype = "";
	public String value = "";
	public String text = "";
	public String textfield = "";		// database sql column containing the full text value
	public String editablefield = "";   // database sql column which determines whether this field is editable
	public String rel = "";
	public String relfield = "";
	public String rel2 = "";
	public String rel2field = "";
	public int integer = -1;
	public String date = "";
	public String required = "N";
	public String addresstype = "";		// determines if the field is an address type. Values include "strno", "strmod", "predir", "strname", "strtype", "unit", "city", "state", "zip"
	public String qty = "N";			// may have quantities. ex: you can add multiple quantities of an activity type. LKUP_ACT_TYPE_ID = 215 then the form may have 215 = 3
	public String multivalueindex = "";	// the index used to identify multiple values. ex: if multiple activity types are chosen each one may have a different expiration date. In this case, on the expiration date object... place the value "LKUP_ACT_TYPE_ID" in this variable.
	public String alert = "";

	public String summarytype = "";		// in conjuction with summaryid... turns on link for redirecting to a summary page containing information about type(activity, project, lso...).
	public int summaryid = -1;			// typeid of summarytype

	public String linktype = "";		// in conjuction with linkid... turns on link for redirecting to a full page containing information about type(activity, project, lso...).
	public int linkid = -1;				// typeid of linktype

	public String adminlink = "";		// url address of webpage containing admin screeen
	public String link = "";			// url address of webpage containing additional information
	public String linkfield = ""; 		// database sql column containing url of link
	public String target = ""; 			// target of links
	public String editable = "Y"; 		// determines if field will be added to an update statement
	public String addable = "Y"; 		// determines if the field will be added to an insert statement
	public String emptyonedit = "N";    // determines if the field will be emptied on the edit form. emptying ensures that a new value is entered.
	public String defaultvalue = "";    // set a default value if empty
	public String multiedit = "N"; 		// determines if this field will be multieditable (used in inspections)
	public String multieditcheck = "";
	public String placeholder = "";
	public String json = "";
	public String lkup = "";
	public boolean finaleditable = false;
	public boolean finaled = false;
	public String datatype = "";		// Used on divisions when field/value pair is in an external level
	public String display = "Y";
	public int order = -1;
	public int maxchar = 10000;
	public HashMap<String, SubObjVO> values = new HashMap<String, SubObjVO>();
	public SubObjVO[] choices = new SubObjVO[0];
	public int numresults = 0;
	public String entity = "";


	public boolean requirestaff = false;	// Determines if data must be shown only to staff
	public boolean showpublic = true;	// Determines if data can be shown to public
	public String updatevalues = "N"; // Determines whether a change in value of this field will require updates of other fields in the form
	public String updateonchangeof = ""; // Change options of select drop down when the value of the specified field is changed.
	public String updateIfValuePresent = "Y";
	public String updateSameTable = "Y";
	public String systemGenerated = "N";
	
	
	public HashMap<String, String>  condtions = new HashMap<String, String>();
	

	public ObjVO() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFieldid() {
		if (!Operator.hasValue(fieldid)) { return getField(); }
		return fieldid;
	}

	public void setFieldid(String fieldid) {
		this.fieldid = fieldid;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getLabel() {
		if (!Operator.hasValue(label)) { return getField(); }
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
		return t;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTextfield() {
		if (!Operator.hasValue(textfield)) { return field; }
		return textfield;
	}

	public void setTextfield(String textfield) {
		this.textfield = textfield;
	}

	public String getEditablefield() {
		return editablefield;
	}

	public void setEditablefield(String editablefield) {
		this.editablefield = editablefield;
	}

	public String getRel() {
		return rel;
	}

	public void setRel(String rel) {
		this.rel = rel;
	}

	public String getRel2() {
		return rel2;
	}

	public void setRel2(String rel2) {
		this.rel2 = rel2;
	}

	public String getRel2field() {
		return rel2field;
	}

	public void setRel2field(String rel2field) {
		this.rel2field = rel2field;
	}

	public String getRelfield() {
		return relfield;
	}

	public void setRelfield(String relfield) {
		this.relfield = relfield;
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

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public boolean isRequired() {
		return getRequired().equalsIgnoreCase("Y");
	}

	public String getAddresstype() {
		String r = addresstype;
		r = Operator.replace(r, "_", "");
		try { r = r.toLowerCase(); } catch(Exception e) { }
		return r;
	}

	public void setAddresstype(String addresstype) {
		this.addresstype = addresstype;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public boolean isQty() {
		return getQty().equalsIgnoreCase("Y");
	}

	public String getMultivalueindex() {
		return multivalueindex;
	}

	public void setMultivalueindex(String multivalueindex) {
		this.multivalueindex = multivalueindex;
	}

	public boolean hasMultivalueindex() {
		return Operator.hasValue(multivalueindex);
	}

	public String getAlert() {
		return alert;
	}

	public void setAlert(String alert) {
		this.alert = alert;
	}

	public String getAdminlink() {
		return adminlink;
	}

	public void setAdminlink(String adminlink) {
		this.adminlink = adminlink;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getLinkfield() {
		return linkfield;
	}

	public void setLinkfield(String linkfield) {
		this.linkfield = linkfield;
	}

	public String getSummarytype() {
		return summarytype;
	}

	public void setSummarytype(String summarytype) {
		this.summarytype = summarytype;
	}

	public int getSummaryid() {
		return summaryid;
	}

	public void setSummaryid(int summaryid) {
		this.summaryid = summaryid;
	}

	public String getLinktype() {
		return linktype;
	}

	public void setLinktype(String linktype) {
		this.linktype = linktype;
	}

	public int getLinkid() {
		return linkid;
	}

	public void setLinkid(int linkid) {
		this.linkid = linkid;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getEditable() {
		return editable;
	}

	public void setEditable(String editable) {
		this.editable = editable;
	}

	public boolean isEditable() {
		return getEditable().equalsIgnoreCase("Y");
	}

	public String getAddable() {
		return addable;
	}

	public void setAddable(String addable) {
		this.addable = addable;
	}

	public boolean isAddable() {
		return getAddable().equalsIgnoreCase("Y");
	}

	public String getEmptyonedit() {
		return emptyonedit;
	}

	public void setEmptyonedit(String emptyonedit) {
		this.emptyonedit = emptyonedit;
	}

	public boolean isEmptyonedit() {
		return getEmptyonedit().equalsIgnoreCase("Y");
	}

	public String getDefaultvalue() {
		return defaultvalue;
	}

	public void setDefaultvalue(String defaultvalue) {
		this.defaultvalue = defaultvalue;
	}

	public String getMultiedit() {
		return multiedit;
	}

	public void setMultiedit(String multiedit) {
		this.multiedit = multiedit;
	}

	public boolean isMultiedit() {
		return getMultiedit().equalsIgnoreCase("Y");
	}

	public String getMultieditcheck() {
		return multieditcheck;
	}

	public void setMultieditcheck(String multieditcheck) {
		this.multieditcheck = multieditcheck;
	}

	public String getPlaceholder() {
		return placeholder;
	}

	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}

	/**
	 * @deprecated - Use Lkup
	 */
	public String getJson() {
		return json;
	}

	/**
	 * @deprecated - Use Lkup
	 */
	public void setJson(String json) {
		this.json = json;
	}

	public String getLkup() {
		return lkup;
	}

	public void setLkup(String lkup) {
		this.lkup = lkup;
	}

	public boolean isFinaleditable() {
		return finaleditable;
	}

	public void setFinaleditable(boolean finaleditable) {
		this.finaleditable = finaleditable;
	}

	public boolean isFinaled() {
		return finaled;
	}

	public void setFinaled(boolean finaled) {
		this.finaled = finaled;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public boolean isDisplay() {
		return getDisplay().equalsIgnoreCase("Y");
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public int getMaxchar() {
		return maxchar;
	}

	public void setMaxchar(int maxchar) {
		this.maxchar = maxchar;
	}

	public HashMap<String, SubObjVO> getValues() {
		return values;
	}

	public void setValues(HashMap<String, SubObjVO> values) {
		this.values = values;
	}

	public SubObjVO[] getChoices() {
		return choices;
	}

	public void setChoices(SubObjVO[] choices) {
		this.choices = choices;
	}

	public int getNumresults() {
		return numresults;
	}

	public void setNumresults(int numresults) {
		this.numresults = numresults;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getUpdatevalues() {
		return updatevalues;
	}

	public void setUpdatevalues(String updatevalues) {
		this.updatevalues = updatevalues;
	}

	public boolean isUpdatevalues() {
		return Operator.equalsIgnoreCase(getUpdatevalues(), "Y");
	}

	public String getUpdateonchangeof() {
		return updateonchangeof;
	}

	public void setUpdateonchangeof(String updateonchangeof) {
		this.updateonchangeof = updateonchangeof;
	}

	public void addValue(String field, String value) {
		SubObjVO v = new SubObjVO();
		v.setValue(value);
		values.put(field, v);
	}

	
	public boolean updateIfValuePresent() {
		return getUpdateIfValuePresent().equalsIgnoreCase("Y");
	}
	
	public boolean updateSameTable() {
		return getUpdateSameTable().equalsIgnoreCase("Y");
	}
	
	public String getUpdateIfValuePresent() {
		return updateIfValuePresent;
	}

	public void setUpdateIfValuePresent(String updateIfValuePresent) {
		this.updateIfValuePresent = updateIfValuePresent;
	}

	public String getUpdateSameTable() {
		return updateSameTable;
	}

	public void setUpdateSameTable(String updateSameTable) {
		this.updateSameTable = updateSameTable;
	}
	
	public boolean isSystemGenerated() {
		return getSystemGenerated().equalsIgnoreCase("Y");
	}
	

	public String getSystemGenerated() {
		return systemGenerated;
	}

	public void setSystemGenerated(String systemGenerated) {
		this.systemGenerated = systemGenerated;
	}

	public HashMap<String, String> getCondtions() {
		return condtions;
	}

	public void setCondtions(HashMap<String, String> condtions) {
		this.condtions = condtions;
	}

	public boolean isRequirestaff() {
		return requirestaff;
	}

	public void setRequirestaff(boolean requirestaff) {
		this.requirestaff = requirestaff;
	}

	public boolean isShowpublic() {
		return showpublic;
	}

	public void setShowpublic(boolean showpublic) {
		this.showpublic = showpublic;
	}

	public ObjVO duplicate() {
		ObjVO vo = new ObjVO();
		vo.id = this.id;
		vo.fieldid = this.fieldid;
		vo.field = this.field;
		vo.label = this.label;
		vo.type = this.type;
		vo.itype = this.itype;
		vo.value = this.value;
		vo.text = this.text;
		vo.textfield = this.textfield;
		vo.rel = this.rel;
		vo.relfield = this.relfield;
		vo.rel2 = this.rel2;
		vo.rel2field = this.rel2field;
		vo.integer = this.integer;
		vo.date = this.date;
		vo.required = this.required;
		vo.alert = this.alert;

		vo.summarytype = this.summarytype;
		vo.summaryid = this.summaryid;

		vo.linktype = this.linktype;
		vo.linkid = this.linkid;

		vo.link = this.link;
		vo.linkfield = this.linkfield;
		vo.target = this.target;
		vo.editable = this.editable;
		vo.addable = this.addable;
		vo.multiedit = this.multiedit;
		vo.multieditcheck = this.multieditcheck;
		vo.placeholder = this.placeholder;
		vo.json = this.json;
		vo.lkup = this.lkup;
		vo.finaleditable = this.finaleditable;
		vo.finaled = this.finaled;
		vo.display = this.display;
		vo.order = this.order;
		vo.maxchar = this.maxchar;
		vo.values = this.values;
		vo.choices = this.choices;
		vo.entity = this.entity;

		vo.requirestaff = this.requirestaff;
		vo.showpublic = this.showpublic;
		vo.updatevalues = this.updatevalues;
		vo.updateonchangeof = this.updateonchangeof;
		vo.updateIfValuePresent = this.updateIfValuePresent;
		vo.updateSameTable = this.updateSameTable;
		vo.systemGenerated = this.systemGenerated;
		return vo;
	}



}
