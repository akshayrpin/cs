package csshared.vo;

import java.util.ArrayList;

import alain.core.utils.Operator;


public class TypeInfo {

	public String entity = "";
	public String entitydescription = "";
	public int entityid = -1;
	public int parentid = -1;
	public int grandparentid = -1;
	public ArrayList<Integer> childid = new ArrayList<Integer>();
	public ArrayList<Integer> grandchildid = new ArrayList<Integer>();
	public String projectnumber = "";
	public int projectid = -1;
	public String activitynumber = "";
	public int activityid = -1;
	public String type = "";
	public int typeid = -1;
	public boolean ispublic = true;

	public TypeInfo() { }

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getEntitydescription() {
		return entitydescription;
	}

	public void setEntitydescription(String entitydescription) {
		this.entitydescription = entitydescription;
	}

	public int getEntityid() {
		return entityid;
	}

	public void setEntityid(int entityid) {
		this.entityid = entityid;
	}

	public int getParentid() {
		return parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public int getGrandparentid() {
		return grandparentid;
	}

	public void setGrandparentid(int grandparentid) {
		this.grandparentid = grandparentid;
	}

	public ArrayList<Integer> getChildid() {
		return childid;
	}

	public void setChildid(ArrayList<Integer> childid) {
		this.childid = childid;
	}

	public void addChildid(int cid) {
		this.childid.add(cid);
	}

	public ArrayList<Integer> getGrandchildid() {
		return grandchildid;
	}

	public void setGrandchildid(ArrayList<Integer> grandchildid) {
		this.grandchildid = grandchildid;
	}

	public void addGrandchildid(int gchildid) {
		this.grandchildid.add(gchildid);
	}

	public String getProjectnumber() {
		return projectnumber;
	}

	public void setProjectnumber(String projectnumber) {
		this.projectnumber = projectnumber;
	}

	public int getProjectid() {
		return projectid;
	}

	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}

	public String getActivitynumber() {
		return activitynumber;
	}

	public void setActivitynumber(String activitynumber) {
		this.activitynumber = activitynumber;
	}

	public int getActivityid() {
		return activityid;
	}

	public void setActivityid(int activityid) {
		this.activityid = activityid;
	}

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

	public boolean isIspublic() {
		return ispublic;
	}

	public void setIspublic(boolean ispublic) {
		this.ispublic = ispublic;
	}

	public int getLowestEntity() {
		if (getGrandparentid() > 0) { return getGrandparentid(); }
		else if (getParentid() > 0) { return getParentid(); }
		else { return getEntityid(); }
	}

	public int getLSOOccupancyId() {
		if (!Operator.equalsIgnoreCase(getEntity(), "lso")) { return -1; }
		if (getGrandparentid() < 1) { return -1; }
		else if (getParentid() < 1) { return -1; }
		else { return getEntityid(); }
	}

	public int getLSOStructureId() {
		if (!Operator.equalsIgnoreCase(getEntity(), "lso")) { return -1; }
		if (getGrandparentid() > 0) { return getParentid(); }
		else if (getParentid() > 0) { return getEntityid(); }
		else { return -1; }
	}

	public int getLSOLandId() {
		if (!Operator.equalsIgnoreCase(getEntity(), "lso")) { return -1; }
		return getLowestEntity();
	}




}
