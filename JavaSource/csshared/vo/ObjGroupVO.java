package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import csshared.utils.CsConfig;
import csshared.vo.lkup.RolesVO;
import alain.core.security.Token;
import alain.core.utils.Logger;
import alain.core.utils.Operator;



public class ObjGroupVO {

	public String groupid = "";
	public String group = "";
	public String label = ""; // USED TO DISPLAY AS TITLE IN THE UI. IF NO VALUE, DEFAULT WILL BE GROUP
	public String updated = "";
	public String contenttype = ""; // DETERMINES THE TYPE IN CONTENT TABLE, WHICH IS USED TO DISPLAY CONTENT IN A "MORE INFORMATION" OR "HELP" PAGE
	public String pub = "N";
	public int cols = -1;
	public String editurl = "";
	public String[] index = new String[0];
	public String[] fields = new String[0];
	public String crosstab = "";
	public ComboReviewList comboreview = new ComboReviewList();
	public AppointmentVO[] appointments = new AppointmentVO[0];
	public ResolutionVO[] resolutions = new ResolutionVO[0];
	public ReviewVO[] reviews = new ReviewVO[0];
	public ObjVO[] obj = new ObjVO[0];
	public ObjMap[] values = new ObjMap[0];
	public String entity = "";
	public String type = "";
	public String display = "";
	public String parent = "";
	public int parentid = -1;
	public String title = ""; // Override default title in the UI to this value
	public String subtitle = ""; // Override the default subtitle in the UI to this value
	public String titlefield = ""; // Database column containing title
	public String subtitlefield = ""; // Database column containing subtitle
	public HashMap<String, String> extras = new HashMap<String, String>();
	public ArrayList<HashMap<String, String>> extraslist = new ArrayList<HashMap<String, String>>();
	public String action = "";
	public ToolVO[] tools = new ToolVO[0];
	public String[] options = new String[0];
	public String descriptionvalue = "";
	public String descriptionlabel = "";
	public int idvalue = -1;
	public String idlabel = "";
	public boolean dodescription = false;
	public boolean doid = false;
	public boolean addable = true;
	public boolean editable = true;
	public boolean multieditable = false;
	public boolean deletable = true;
	public boolean history = false;
	public boolean finaled = false;
	public String disableeditfield = "";
	public String disableeditvalue = "Y";
	public String disabledeletefield = "";
	public String disabledeletevalue = "Y";
	public String subgroup = "";
	public int subgroupsize = -1;
	public SubObjGroupVO[] custom = new SubObjGroupVO[0];
	public int customsize = -1;
	public String messagecode = "";
	public String message = "";
	public boolean displayempty = false;
	public boolean create = false;
	public boolean read = false;
	public boolean update = false;
	public boolean delete = false;
	public boolean admin = false;
	public String modulechanged = "";
	public String modulechangedaction = "";
	public int modulechangedid = -1;
	public Token token = new Token();
	
	/*public FeesGroupVO[] feesgroups = new FeesGroupVO[0];
	
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	public double inputamount = 0.00;
*/
	public ObjGroupVO() {}

	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getLabel() {
		if (!Operator.hasValue(label)) { return getGroup(); }
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getContenttype() {
		return contenttype;
	}

	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}

	public String getUpdated() {
		return updated;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}

	public String getPub() {
		return pub;
	}
	public void setPub(String pub) {
		this.pub = pub;
	}
	public int getCols() {
		return cols;
	}

	public void setCols(int cols) {
		this.cols = cols;
	}

	public String[] getIndex() {
		if (CsConfig.isPublic()) {
			if (values.length > 0) {
				ObjMap value = values[0];
				ArrayList<String> l = new ArrayList<String>();
				for (int i=0; i<index.length; i++) {
					String field = index[i];
					ObjVO o = value.getValues().get(field);
					if (o.isShowpublic()) {
						l.add(field);
					}
				}
				return l.toArray(new String[l.size()]);
			}
		}
		return index;
	}

	public void setIndex(String[] index) {
		this.index = index;
	}

	public String[] getFields() {
		if (CsConfig.isPublic() && !token.isStaff()) {
			if (values.length > 0) {
				ObjMap value = values[0];
				ArrayList<String> l = new ArrayList<String>();
				for (int i=0; i<fields.length; i++) {
					String field = fields[i];
					ObjVO o = value.getValues().get(field);
					if (o.isShowpublic()) {
						l.add(field);
					}
				}
				return l.toArray(new String[l.size()]);
			}
		}
		return fields;
	}

	public void setFields(String[] fields) {
		this.fields = fields;
	}

	public String getCrosstab() {
		return crosstab;
	}

	public void setCrosstab(String crosstab) {
		this.crosstab = crosstab;
	}

	public ComboReviewList getComboreview() {
		return comboreview;
	}

	public void setComboreview(ComboReviewList comboreview) {
		this.comboreview = comboreview;
	}

	public AppointmentVO[] getAppointments() {
		return appointments;
	}
	public AppointmentVO getFirstAppointment() {
		AppointmentVO vo = new AppointmentVO();
		if (Operator.hasValue(getAppointments()) && getAppointments().length > 0) {
			vo = getAppointments()[0];
		}
		return vo;
	}

	public void setAppointments(AppointmentVO[] appointments) {
		this.appointments = appointments;
	}

	public ResolutionVO[] getResolutions() {
		return resolutions;
	}

	public void setResolutions(ResolutionVO[] resolutions) {
		this.resolutions = resolutions;
	}

	public ReviewVO[] getReviews() {
		return reviews;
	}

	public void setReviews(ReviewVO[] reviews) {
		this.reviews = reviews;
	}

	public ObjVO[] getObj() {
		return obj;
	}
	public void setObj(ObjVO[] obj) {
		this.obj = obj;
	}

	public String getEditurl() {
		return editurl;
	}

	public void setEditurl(String editurl) {
		this.editurl = editurl;
	}

	public ObjMap[] getValues() {
		return values;
	}

	public void setValues(ObjMap[] values) {
		this.values = values;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public int getParentid() {
		return parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getTitlefield() {
		return titlefield;
	}

	public void setTitlefield(String titlefield) {
		this.titlefield = titlefield;
	}

	public String getSubtitlefield() {
		return subtitlefield;
	}

	public void setSubtitlefield(String subtitlefield) {
		this.subtitlefield = subtitlefield;
	}

	public HashMap<String, String> getExtras() {
		return extras;
	}

	public void setExtras(HashMap<String, String> extras) {
		this.extras = extras;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}
	
	

	
	


	public ToolVO[] getTools() {
		return tools;
	}

	public void setTools(ToolVO[] tools) {
		this.tools = tools;
	}

	public String[] getOptions() {
		return options;
	}

	public void setOptions(String[] options) {
		this.options = options;
	}

	public String getDescriptionvalue() {
		return descriptionvalue;
	}

	public void setDescriptionvalue(String descriptionvalue) {
		this.descriptionvalue = descriptionvalue;
	}

	public int getIdvalue() {
		return idvalue;
	}

	public void setIdvalue(int idvalue) {
		this.idvalue = idvalue;
	}

	public String getDescriptionlabel() {
		if (!Operator.hasValue(this.descriptionlabel)) { return "DESCRIPTION"; }
		return descriptionlabel;
	}

	public void setDescriptionlabel(String descriptionlabel) {
		this.descriptionlabel = descriptionlabel;
	}

	public String getIdlabel() {
		if (!Operator.hasValue(this.idlabel)) { return "ID"; }
		return idlabel;
	}

	public void setIdlabel(String idlabel) {
		this.idlabel = idlabel;
	}

	public boolean isDodescription() {
		return dodescription;
	}

	public void setDodescription(boolean dodescription) {
		this.dodescription = dodescription;
	}

	public boolean isDoid() {
		return doid;
	}

	public void setDoid(boolean doid) {
		this.doid = doid;
	}

	public boolean isAddable() {
		if (!isCreate()) { return false; }
		return addable;
	}

	public void setAddable(boolean addable) {
		this.addable = addable;
	}

	public boolean isEditable() {
		if (!isUpdate()) { return false; }
		return editable;
	}

	public void setEditable(boolean editable) {
		this.editable = editable;
	}

	public boolean isMultieditable() {
		if (!isUpdate()) { return false; }
		return multieditable;
	}

	public void setMultieditable(boolean multieditable) {
		this.multieditable = multieditable;
	}

	public boolean isDeletable() {
		if (!isDelete()) { return false; }
		return deletable;
	}

	public void setDeletable(boolean deletable) {
		this.deletable = deletable;
	}

	public boolean isHistory() {
		return history;
	}

	public void setHistory(boolean history) {
		this.history = history;
	}

	public boolean isFinaled() {
		return finaled;
	}

	public void setFinaled(boolean finaled) {
		this.finaled = finaled;
	}

	public String getDisableeditfield() {
		return disableeditfield;
	}

	public void setDisableeditfield(String disableeditfield) {
		this.disableeditfield = disableeditfield;
	}

	public String getDisableeditvalue() {
		return disableeditvalue;
	}

	public void setDisableeditvalue(String disableeditvalue) {
		this.disableeditvalue = disableeditvalue;
	}

	public String getDisabledeletefield() {
		return disabledeletefield;
	}

	public void setDisabledeletefield(String disabledeletefield) {
		this.disabledeletefield = disabledeletefield;
	}

	public String getDisabledeletevalue() {
		return disabledeletevalue;
	}

	public void setDisabledeletevalue(String disabledeletevalue) {
		this.disabledeletevalue = disabledeletevalue;
	}

	
	
	public String getSubgroup() {
		return subgroup;
	}

	public void setSubgroup(String subgroup) {
		this.subgroup = subgroup;
	}

	public int getSubgroupsize() {
		return subgroupsize;
	}

	public void setSubgroupsize(int subgroupsize) {
		this.subgroupsize = subgroupsize;
	}

	public SubObjGroupVO[] getCustom() {
		return custom;
	}

	public void setCustom(SubObjGroupVO[] custom) {
		this.custom = custom;
	}
	
	
	

	public int getCustomsize() {
		return customsize;
	}

	public void setCustomsize(int customsize) {
		this.customsize = customsize;
	}

	public String getMessagecode() {
		return messagecode;
	}

	public void setMessagecode(String messagecode) {
		this.messagecode = messagecode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public boolean isDisplayempty() {
		return displayempty;
	}

	public void setDisplayempty(boolean displayempty) {
		this.displayempty = displayempty;
	}

	public HashMap<String, Integer> objIndex() {
		HashMap<String, Integer> r = new HashMap<String, Integer>();
		int l = obj.length;
		for (int i = 0; i < l; i++) {
			try {
				r.put(getObj()[i].getField(), i);
			}
			catch (Exception e) { }
		}
		return r;
	}

	public HashMap<String, String> objValues() {
		HashMap<String, String> r = new HashMap<String, String>();
		int l = obj.length;
		for (int i = 0; i < l; i++) {
			try {
				ObjVO vo = obj[i];
				r.put(getObj()[i].getField(), vo.getValue());
			}
			catch (Exception e) { }
		}
		return r;
	}

	public ArrayList<HashMap<String, String>> getExtraslist() {
		return extraslist;
	}

	public void setExtraslist(ArrayList<HashMap<String, String>> extraslist) {
		this.extraslist = extraslist;
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

	public String getModulechanged() {
		return modulechanged;
	}

	public void setModulechanged(String modulechanged) {
		this.modulechanged = modulechanged;
	}

	public String getModulechangedaction() {
		return modulechangedaction;
	}

	public void setModulechangedaction(String modulechangedaction) {
		this.modulechangedaction = modulechangedaction;
	}

	public int getModulechangedid() {
		return modulechangedid;
	}

	public void setModulechangedid(int modulechangedid) {
		this.modulechangedid = modulechangedid;
	}

	public Token getToken() {
		return token;
	}

	public void setToken(Token token) {
		this.token = token;
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean admin) {
		putRoles(vo, userroles, nonpublicroles, false ,admin);
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean onhold, boolean admin) {
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

			if (onhold) {
				setAdmin(false);
				setCreate(false);
				setUpdate(false);
				setDelete(false);
			}
		}
	}
	
	public ObjGroupVO duplicate() {
		String s = toJson();
		return toObj(s);
	}

	public String toJson() {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			r = mapper.writeValueAsString(this);
		} catch (Exception e) { }
		return r;
	}

	private static ObjGroupVO toObj(String json) {
		ObjGroupVO vo = new ObjGroupVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo = mapper.readValue(json, ObjGroupVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return vo;
	}




	/*
	 * 
	 * 
	 * 
	 * 
	 * public double getAmount() {
		return amount;
	}



	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getPaidamount() {
		return paidamount;
	}

	public void setPaidamount(double paidamount) {
		this.paidamount = paidamount;
	}

	public double getBalancedue() {
		return balancedue;
	}

	public void setBalancedue(double balancedue) {
		this.balancedue = balancedue;
	}

	
	public double getInputamount() {
		return inputamount;
	}


	public void setInputamount(double inputamount) {
		this.inputamount = inputamount;
	}


	public FeesGroupVO[] getFeesgroups() {
		return feesgroups;
	}

	public void setFeesgroups(FeesGroupVO[] feesgroups) {
		this.feesgroups = feesgroups;
	}

	*/




}
