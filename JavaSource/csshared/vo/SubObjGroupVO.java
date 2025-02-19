package csshared.vo;

import alain.core.utils.Logger;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;




public class SubObjGroupVO {

	public String groupid = "";
	public String group = "";
	public String pub = "N";
	public int cols = -1;
	public String editurl = "";
	public String crosstab = "";
	public ObjVO[] obj = new ObjVO[0];
	public String entity = "";
	public String type = "";
	public String parent = "";
	public int parentid = -1;
	public String action = "";
	
	
	
	public SubObjGroupVO() {}



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



	public String getEditurl() {
		return editurl;
	}



	public void setEditurl(String editurl) {
		this.editurl = editurl;
	}



	public String getCrosstab() {
		return crosstab;
	}



	public void setCrosstab(String crosstab) {
		this.crosstab = crosstab;
	}



	public ObjVO[] getObj() {
		return obj;
	}



	public void setObj(ObjVO[] obj) {
		this.obj = obj;
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



	public String getAction() {
		return action;
	}



	public void setAction(String action) {
		this.action = action;
	}

	public static SubObjGroupVO makeObj(String str) {
		SubObjGroupVO vo = new SubObjGroupVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo = mapper.readValue(str, SubObjGroupVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return vo;
	}

	public static String makeString(SubObjGroupVO vo) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			r = mapper.writeValueAsString(vo);
		} catch (Exception e) { }
		return r;
	}

	public static SubObjGroupVO deserialize(SubObjGroupVO vo) {
		String s = makeString(vo);
		return makeObj(s);
	}





}
