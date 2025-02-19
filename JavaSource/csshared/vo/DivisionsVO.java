package csshared.vo;

import alain.core.utils.Operator;



public class DivisionsVO {

	public int id = -1;
	public int lsoid = -1;
	public int groupid = -1;
	public String group = "";
	public int divisiontypeid = -1;
	public String divisiontype = "";
	public int divisionid = -1;
	public String division = "";
	public String info = "";
	public String url = "";
	public String lsotype = "";
	public String source = "";
	public int sourceid = -1;
	public String description = "";
	public String dot = "";
	public String required = "";
	public String deflt = "";
	public boolean showpublic = false;
	public int createdby = -1;
	public String createddate = "";
	public int updatedby = -1;
	public String updateddate = "";
	public SubObjVO[] choices = new SubObjVO[0];

	public DivisionsVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGroupid() {
		return groupid;
	}

	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public int getLsoid() {
		return lsoid;
	}

	public void setLsoid(int lsoid) {
		this.lsoid = lsoid;
	}

	public int getDivisiontypeid() {
		return divisiontypeid;
	}

	public void setDivisiontypeid(int divisiontypeid) {
		this.divisiontypeid = divisiontypeid;
	}

	public String getDivisiontype() {
		return divisiontype;
	}

	public void setDivisiontype(String divisiontype) {
		this.divisiontype = divisiontype;
	}

	public int getDivisionid() {
		return divisionid;
	}

	public void setDivisionid(int divisionid) {
		this.divisionid = divisionid;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLsotype() {
		return lsotype;
	}

	public void setLsotype(String lsotype) {
		this.lsotype = lsotype;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getSourceid() {
		return sourceid;
	}

	public void setSourceid(int sourceid) {
		this.sourceid = sourceid;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDot() {
		return dot;
	}

	public void setDot(String dot) {
		this.dot = dot;
	}

	public boolean isDot() {
		return Operator.equalsIgnoreCase(dot, "Y");
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public boolean isRequired() {
		return Operator.equalsIgnoreCase(required, "Y");
	}

	public String getDefault() {
		return deflt;
	}

	public void setDefault(String deflt) {
		this.deflt = deflt;
	}

	public boolean isDefault() {
		return Operator.equalsIgnoreCase(deflt, "Y");
	}

	public boolean isShowpublic() {
		return showpublic;
	}

	public void setShowpublic(boolean showpublic) {
		this.showpublic = showpublic;
	}

	public int getCreatedby() {
		return createdby;
	}

	public void setCreatedby(int createdby) {
		this.createdby = createdby;
	}

	public String getCreateddate() {
		return createddate;
	}

	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}

	public int getUpdatedby() {
		return updatedby;
	}

	public void setUpdatedby(int updatedby) {
		this.updatedby = updatedby;
	}

	public String getUpdateddate() {
		return updateddate;
	}

	public void setUpdateddate(String updateddate) {
		this.updateddate = updateddate;
	}

	public SubObjVO[] getChoices() {
		return choices;
	}

	public void setChoices(SubObjVO[] choices) {
		this.choices = choices;
	}

	public String templateName() {
		StringBuilder sb = new StringBuilder();
		sb.append("division_").append(getDivisiontypeid());
		return sb.toString();
	}




}
