package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import alain.core.utils.Operator;

public class DataVO {

	public int id = -1;
	public String entity = "";
	public String type = "";
	public int typeid = -1;
	public String group = "";
	public boolean history = false;
	public HashMap<String, String> data = new HashMap<String, String>();
	public HashMap<String, String> text = new HashMap<String, String>();

	public DataVO() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public boolean isHistory() {
		return history;
	}

	public void setHistory(boolean history) {
		this.history = history;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public void put(String field, String value) {
		data.put(field, value);
	}

	public void put(String field, String value, String txt) {
		data.put(field, value);
		text.put(field, txt);
	}

	public String get(String field) {
		String r = data.get(field);
		if (!Operator.hasValue(r)) { return ""; }
		return r;
	}

	public String getString(String field) {
		return get(field);
	}

	public int getInt(String field) {
		return Operator.toInt(get(field));
	}

	public boolean is(String field) {
		String v = get(field);
		return Operator.equalsIgnoreCase(v, "Y") || Operator.equalsIgnoreCase(v, "1") || Operator.equalsIgnoreCase(v, "YES") || Operator.equalsIgnoreCase(v, "TRUE");
	}

	public String getText(String field) {
		String r = text.get(field);
		if (!Operator.hasValue(r)) { return ""; }
		return r;
	}

	public static DataVO toDataVO(RequestVO vo) {
		DataVO m = new DataVO();
		m.setEntity(vo.getEntity());
		m.setType(vo.getType());
		m.setTypeid(vo.getTypeid());
		m.setGroup(vo.getGroup());
		m.setId(Operator.toInt(vo.getGroupid()));
		ObjGroupVO[] g = vo.getData();
		if (g.length > 0) {
			ObjVO[] os = g[0].getObj();
			int l = os.length;
			for (int i=0; i<l; i++) {
				ObjVO o = os[i];
				String f = o.getFieldid();
				String v = o.getValue();
				String t = o.getText();
				m.put(f, v, t);
				if (o.isQty() || o.hasMultivalueindex()) {
					HashMap<String, SubObjVO> vm = o.getValues();
					for (Map.Entry<String, SubObjVO> entry : vm.entrySet()) {
						String sfld = entry.getKey();
						SubObjVO sval = entry.getValue();
						String val = sval.getValue();
						m.put(sfld, val);
					}
				}
//				if (o.isQty()) {
//					HashMap<String, SubObjVO> vm = o.getValues();
//					String[] values = Operator.split(v, "|");
//					for (int x=0; x<values.length; x++) {
//						String vx = values[x];
//						SubObjVO sox = vm.get(vx);
//						try {
//							String sv = sox.getValue();
//							m.put(vx, sv);
//						}
//						catch (Exception e) { }
//					}
//				}
			}
		}
		return m;
	}

	public static DataVO[] getSubData(RequestVO vo) {
		DataVO[] m = new DataVO[0];
		ObjGroupVO[] g = vo.getData();
		if (g.length > 0) {
			ObjGroupVO og = g[0];
			SubObjGroupVO[] sg = og.getCustom();
			m = DataVO.toDataVO(sg);
		}
		return m;
	}

	public static DataVO toDataVO(SubObjGroupVO vo) {
		DataVO m = new DataVO();
		m.setEntity(vo.getEntity());
		m.setType(vo.getType());
		ObjVO[] g = vo.getObj();
		int l = g.length;
		for (int i=0; i<l; i++) {
			ObjVO o = g[i];
			String f = o.getFieldid();
			String v = o.getValue();
			String t = o.getText();
			m.put(f, v, t);
			if (o.isQty() || o.hasMultivalueindex()) {
				HashMap<String, SubObjVO> vm = o.getValues();
				for (Map.Entry<String, SubObjVO> entry : vm.entrySet()) {
					String sfld = entry.getKey();
					SubObjVO sval = entry.getValue();
					String val = sval.getValue();
					m.put(sfld, val);
				}
			}
//			if (o.isQty()) {
//				HashMap<String, SubObjVO> vm = o.getValues();
//				String[] values = Operator.split(v, "|");
//				for (int x=0; x<values.length; x++) {
//					String vx = values[x];
//					SubObjVO sox = vm.get(vx);
//					try {
//						String sv = sox.getValue();
//						m.put(vx, sv);
//					}
//					catch (Exception e) { }
//				}
//			}
		}
		return m;
	}

	public static DataVO[] toDataVO(SubObjGroupVO[] vo) {
		ArrayList<DataVO> m = new ArrayList<DataVO>();
		for (int i=0; i<vo.length; i++) {
			SubObjGroupVO g = vo[i];
			DataVO d = toDataVO(g);
			m.add(d);
		}
		return m.toArray(new DataVO[m.size()]);
	}

	public static DataVO toDataVO(TypeVO vo) {
		DataVO m = new DataVO();
		m.setEntity(vo.getEntity());
		m.setType(vo.getType());
		m.setTypeid(vo.getTypeid());
		ObjGroupVO[] g = vo.getGroups();
		if (g.length > 0) {
			ObjGroupVO gr = g[0];
			m.setHistory(gr.isHistory());
			m.setGroup(gr.getGroup());
			m.setId(Operator.toInt(gr.getGroupid()));
			ObjVO[] os = gr.getObj();
			int l = os.length;
			for (int i=0; i<l; i++) {
				ObjVO o = os[i];
				String f = o.getFieldid();
				String v = o.getValue();
				String t = o.getText();
				m.put(f, v, t);
//				if (o.isQty()) {
//					HashMap<String, SubObjVO> vm = o.getValues();
//					String[] values = paramToArray(v);
//					for (int x=0; x<values.length; x++) {
//						String vx = values[x];
//						SubObjVO sox = vm.get(vx);
//						try {
//							String sv = sox.getValue();
//							m.put(vx, sv);
//						}
//						catch (Exception e) { }
//					}
//				}
				if (o.isQty() || o.hasMultivalueindex()) {
					HashMap<String, SubObjVO> vm = o.getValues();
					for (Map.Entry<String, SubObjVO> entry : vm.entrySet()) {
						String sfld = entry.getKey();
						SubObjVO sval = entry.getValue();
						String val = sval.getValue();
						m.put(sfld, val);
					}
				}
			}
		}
		return m;
	}

	public static String[] paramToArray(String param) {
		String[] r = new String[0];
		if (Operator.hasValue(param)) {
			if (param.indexOf(",") > -1) {
				r = Operator.split(param, ",");
			}
			else {
				r = Operator.split(param, "|");
			}
		}
		return r;
	}






}
