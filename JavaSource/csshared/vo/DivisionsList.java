package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import alain.core.utils.Operator;


public class DivisionsList {

	public HashMap<Integer, DivisionsVO> divisions = new HashMap<Integer, DivisionsVO>();
	public LinkedHashMap<String, Integer> index = new LinkedHashMap<String, Integer>();
	public LinkedHashMap<String, ArrayList<String>> groups = new LinkedHashMap<String, ArrayList<String>>();
	public LinkedHashMap<String, ArrayList<String>> publicgroups = new LinkedHashMap<String, ArrayList<String>>();
	public HashMap<String, Integer> lvlindex = new HashMap<String, Integer>();
	public HashMap<Integer, String> typeindex = new HashMap<Integer, String>();
	private Iterator<Map.Entry<String, Integer>> ITER = null;
	private String CURRENT = "";
	public int lsoid = -1;
	public int parentid = -1;
	public int grandparentid = -1;

	public DivisionsList() { }

	public HashMap<Integer, DivisionsVO> getDivisions() {
		return divisions;
	}

	public void setDivisions(HashMap<Integer, DivisionsVO> divisions) {
		this.divisions = divisions;
	}

	public LinkedHashMap<String, Integer> getIndex() {
		return index;
	}

	public void setIndex(LinkedHashMap<String, Integer> index) {
		this.index = index;
	}

	public HashMap<String, Integer> getLvlindex() {
		return lvlindex;
	}

	public void setLvlindex(HashMap<String, Integer> lvlindex) {
		this.lvlindex = lvlindex;
	}

	public void addDivision(DivisionsVO division) {
		int id = division.getId();
		String type = division.getDivisiontype();
		String lso = division.getLsotype();
		String group = division.getGroup();
		int typeid = division.getDivisiontypeid();
		if (Operator.hasValue(type)) {
			this.divisions.put(id, division);
			this.index.put(type.toLowerCase(), id);
			this.typeindex.put(typeid, type.toLowerCase());
			String lvl = type.toLowerCase() + "_" + lso.toLowerCase();
			this.lvlindex.put(lvl, id);
			addGroup(group, type);
		}
	}

	private DivisionsVO getObject(String type) {
		DivisionsVO div = new DivisionsVO();
		if (Operator.hasValue(type)) {
			int i = getIndex(type);
			div = getObject(i);
		}
		return div;
	}

	private DivisionsVO getObject(String type, String lso) {
		DivisionsVO div = new DivisionsVO();
		if (Operator.hasValue(type) && Operator.hasValue(lso)) {
			int i = getIndex(type, lso);
			div = getObject(i);
		}
		return div;
	}

	private DivisionsVO getObject(int id) {
		DivisionsVO div = new DivisionsVO();
		try {
			div = this.divisions.get(id);
			if (div == null) {
				div = new DivisionsVO();
			}
		}
		catch (Exception e) {
			div = new DivisionsVO();
		}
		return div;
	}

	private String getTypeIndex(int typeid) {
		String r = "";
		if (typeid > 0) {
			try {
				r = this.typeindex.get(typeid);
			}
			catch (Exception e) { r = ""; }
		}
		return r;
	}

	private int getIndex(String type) {
		int r = 0;
		if (Operator.hasValue(type)) {
			try {
				r = this.index.get(type.toLowerCase());
			}
			catch (Exception e) { r = 0; }
		}
		return r;
	}

	private int getIndex(String type, String lso) {
		int r = 0;
		if (Operator.hasValue(type) && Operator.hasValue(lso)) {
			try {
				String lvl = type.toLowerCase() + "_" + lso.toLowerCase();
				r = this.lvlindex.get(lvl);
			}
			catch (Exception e) { r = 0; }
		}
		return r;
	}

	public String getValue(int idx) {
		DivisionsVO div = getObject(idx);
		return div.getDivision();
	}

	public String getValue(String type) {
		DivisionsVO div = getObject(type);
		return div.getDivision();
	}

	private void addGroup(String group, String type) {
		if (Operator.hasValue(type)) {
			if (!Operator.hasValue(group)) { group = "Default"; }
			ArrayList<String> g = divisiongroup(group);
			if (!g.contains(type)) {
				g.add(type);
				this.groups.put(group, g);
			}
		}
	}

	public ArrayList<String> divisiongroups() {
		ArrayList<String> keys = new ArrayList<>(groups.keySet());
		return keys;
	}

	public ArrayList<String> divisiongroup(String group) {
		ArrayList<String> g = new ArrayList<String>();
		try {
			g = groups.get(group);
		}
		catch (Exception e) { g = new ArrayList<String>(); }
		if (g ==  null) { g = new ArrayList<String>(); }
		return g;
	}

	public DivisionsList list(String group) {
		DivisionsList l = new DivisionsList();
		ArrayList<String> g = divisiongroup(group);
		for (int i=0; i<g.size(); i++) {
			String gs = g.get(i);
			DivisionsVO d = getObject(gs);
			l.addDivision(d);
		}
		return l;
	}

	public boolean next() {
		if (ITER == null) {
			ITER = index.entrySet().iterator();
		}
		if (ITER.hasNext()) {
			CURRENT = setCurrent();
			return true;
		}
		else {
			ITER = index.entrySet().iterator();
			CURRENT = "";
			return false;
		}
	}

	private String setCurrent() {
		Map.Entry<String, Integer> entry = ITER.next();
		return entry.getKey();
	}

	public DivisionsVO getDivision() {
		return getObject(CURRENT);
	}

	public DivisionsVO getDivision(String type) {
		return getObject(type);
	}

	public DivisionsVO getDivision(int divid) {
		return getObject(divid);
	}

	public DivisionsVO getDivisionType(int typeid) {
		String type = getTypeIndex(typeid);
		return getDivision(type);
	}

	public DivisionsVO getLevel(String lso) {
		return getObject(CURRENT, lso);
	}

	public DivisionsVO getLevel(int lsoid) {
		String level = level(lsoid);
		return getObject(CURRENT, level);
	}

	public DivisionsVO getDivision(String type, String level) {
		return getObject(type, level);
	}

	public DivisionsVO getDivision(String type, int lsoid) {
		String level = level(lsoid);
		return getObject(type, level);
	}

	public int size() {
		return index.size();
	}

	public DivisionsList dot() {
		DivisionsList l = new DivisionsList();
		while (next()) {
			DivisionsVO vo = getDivision();
			if (vo.isDot()) {
				l.addDivision(vo);
			}
		}
		return l;
	}

	public String type() {
		return CURRENT;
	}

	public int getLsoid() {
		return lsoid;
	}

	public void setLsoid(int lsoid) {
		this.lsoid = lsoid;
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

	public String level(int lsoid) {
		if (lsoid == getLsoid()) {
			if (getGrandparentid() > 0) { return "O"; }
			else if (getParentid() > 0) { return "S"; }
			else { return "L"; }
		}
		else if (lsoid == getParentid()) {
			if (getGrandparentid() > 0) { return "S"; }
			else { return "L"; }
		}
		else if (lsoid == getGrandparentid()) {
			return "L";
		}
		return "";
	}

	public String level() {
		if (getGrandparentid() > 0) { return "O"; }
		else if (getParentid() > 0) { return "S"; }
		else { return "L"; }
	}

	public int landId() {
		if (Operator.equalsIgnoreCase(level(), "O")) { return grandparentid; }
		else if (Operator.equalsIgnoreCase(level(), "S")) { return parentid; }
		else if (Operator.equalsIgnoreCase(level(), "L")) { return lsoid; }
		else { return -1; }
	}

	public int structureId() {
		if (Operator.equalsIgnoreCase(level(), "O")) { return parentid; }
		else if (Operator.equalsIgnoreCase(level(), "S")) { return lsoid; }
		else { return -1; }
	}

	public int occupancyId() {
		if (Operator.equalsIgnoreCase(level(), "O")) { return lsoid; }
		else { return -1; }
	}

	public ObjGroupVO group() {
		ObjGroupVO result = new ObjGroupVO();
		result.setGroup("divisions");
		result.setGroupid("divisions");
		result.setType("divisions");

		ObjVO[] os = new ObjVO[size()];
		int count = 0;
		while (next()) {
			DivisionsVO d = getDivision();
			ObjVO vo = new ObjVO();
			vo.setId(d.getId());
			vo.setField(Operator.toString(d.getDivisiontypeid()));
			vo.setFieldid(Operator.toString(d.getDivisiontypeid()));
			vo.setValue(Operator.toString(d.getDivisionid()));
			vo.setLabel(d.getDivisiontype());
			vo.setText(d.getDivision());
			vo.setRequired(d.getRequired());
			vo.setType("String");
			vo.setItype("select");
			os[count] = vo;
			count++;
		} 
		result.setObj(os);

		return result;

	}

	public String typeIds() {
		StringBuilder sb = new StringBuilder();
		boolean empty = true;
		while (next()) {
			DivisionsVO v = getDivision();
			int typeid = v.getDivisiontypeid();
			if (typeid > 0) {
				if (!empty) { sb.append(","); }
				sb.append(typeid);
				empty = false;
			}
		}
		return sb.toString();
	}

	public String divisionIds() {
		StringBuilder sb = new StringBuilder();
		boolean empty = true;
		while (next()) {
			DivisionsVO v = getDivision();
			int divid = v.getDivisionid();
			if (divid > 0) {
				if (!empty) { sb.append(","); }
				sb.append(divid);
				empty = false;
			}
		}
		return sb.toString();
	}



}


















