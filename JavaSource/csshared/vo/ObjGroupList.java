package csshared.vo;

import java.util.HashMap;
import java.util.LinkedHashMap;



public class ObjGroupList {

	public LinkedHashMap<String, ObjGroupVO> groups = new LinkedHashMap<String, ObjGroupVO>();

	public ObjGroupList() {}

	public ObjGroupVO getGroup(String groupname) {
		ObjGroupVO r = new ObjGroupVO();
		try {
			r = groups.get(groupname);
			if (r == null) { r = new ObjGroupVO(); }
		}
		catch (Exception e) {
			r =  new ObjGroupVO();
		}
		return r;
	}

	public void setGroup(ObjGroupVO group) {
		String field = group.getGroup();
		groups.put(field, group);
	}

	public void setIndex(String groupname, String[] idx) {
		ObjGroupVO r = getGroup(groupname);
		r.setIndex(idx);
		setGroup(r);
	}

	public void setValues(String groupname, ObjMap[] values) {
		ObjGroupVO r = getGroup(groupname);
		r.setValues(values);
		setGroup(r);
	}

	public void setValues(String groupname, ObjVO[] values) {
		ObjGroupVO r = getGroup(groupname);
		r.setObj(values);
		setGroup(r);
	}




}

