package csshared.vo;

import alain.core.utils.Operator;



public class HoldsVO {

	public String type = "";
	public int typeid = -1;
	public int holdid = -1;
	public int holdtypeid = -1;
	public String holdtype = "";
	public String typedescription = "";
	public int statusid = -1;
	public String status = "";
	public String statusdescription = "";
	public String title = "";
	public String description = "";
	public String live = "";
	public String released = "";
	public String significant = "";
	public String ispublic = "";
	public int createdby = -1;
	public String createddate = "";

	public HoldsVO() { }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public int getHoldid() {
		return holdid;
	}

	public void setHoldid(int holdid) {
		this.holdid = holdid;
	}

	public int getHoldtypeid() {
		return holdtypeid;
	}

	public void setHoldtypeid(int holdtypeid) {
		this.holdtypeid = holdtypeid;
	}

	public String getHoldtype() {
		return holdtype;
	}

	public void setHoldtype(String holdtype) {
		this.holdtype = holdtype;
	}

	public String getTypedescription() {
		return typedescription;
	}

	public void setTypedescription(String typedescription) {
		this.typedescription = typedescription;
	}

	public int getStatusid() {
		return statusid;
	}

	public void setStatusid(int statusid) {
		this.statusid = statusid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusdescription() {
		return statusdescription;
	}

	public void setStatusdescription(String statusdescription) {
		this.statusdescription = statusdescription;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLive() {
		return live;
	}

	public void setLive(String live) {
		this.live = live;
	}

	public boolean isLive() {
		return Operator.equalsIgnoreCase(getLive(), "Y");
	}

	public String getReleased() {
		return released;
	}

	public void setReleased(String released) {
		this.released = released;
	}

	public boolean isReleased() {
		return Operator.equalsIgnoreCase(getReleased(), "Y");
	}

	public String getSignificant() {
		return significant;
	}

	public void setSignificant(String significant) {
		this.significant = significant;
	}

	public boolean isSignificant() {
		return Operator.equalsIgnoreCase(getSignificant(), "Y");
	}

	public String getIspublic() {
		return ispublic;
	}

	public void setIspublic(String ispublic) {
		this.ispublic = ispublic;
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





}
