package csshared.vo;

import java.util.HashMap;
import java.util.LinkedHashMap;

import alain.core.utils.Operator;



public class HoldsList {

	public HashMap<Integer, HoldsVO> holds = new HashMap<Integer, HoldsVO>();
	public HashMap<String, Integer> holdsidx = new HashMap<String, Integer>();
	public HashMap<Integer, String> holdtypeidx = new HashMap<Integer, String>();

	public HashMap<Integer, String> significantactivityholds = new HashMap<Integer, String>();
	public LinkedHashMap<Integer, String> significantactivityholdlist = new LinkedHashMap<Integer, String>();
	public HashMap<String, Integer> activitiesidx = new HashMap<String, Integer>();

	public String priorityhold = "";
	public HashMap<Integer, Integer> significantholdcount = new HashMap<Integer, Integer>();
	public LinkedHashMap<String, Integer> significantholdlist = new LinkedHashMap<String, Integer>();

	public HoldsList() { }

	public boolean clear() {
		boolean r = true;
		try {
			holds.clear();
			significantholdcount.clear();
			significantactivityholds.clear();
			significantholdlist.clear();
			significantactivityholdlist.clear();
			holdsidx.clear();
			activitiesidx.clear();
			priorityhold = "";
		}
		catch (Exception e) {
			r = false;
		}
		return r;
	}

	// SET A HOLD
	public void set(HoldsVO h) {
		int id = h.getHoldid();
		String t = h.getHoldtype();
		int ht = h.getHoldtypeid();
		holds.put(id, h);
		holdtypeidx.put(ht, t);
		setHoldTypeIndex(t, id);
		if (h.isSignificant() && !h.isReleased()) {
			significantholdlist.put(t, 1);
			addSignificantHoldCount(h.getHoldtypeid());
			setPriorityhold(t);
		}
	}

	// IS THERE AN ACTIVE HOLD OF A SPECIFIC HOLD TYPE?
	public boolean onSignificantHold(int holdstypeid) {
		int r = getSignificantHoldCount(holdstypeid);
		return r > 0;
	}

	// IS THERE AN ACTIVE HOLD OF A SPECIFIC HOLD TYPE?
	public boolean onSignificantHold(String holdtype) {
		int h = getHoldTypeIndex(holdtype);
		return onSignificantHold(h);
	}

	// ASSOCIATE A HOLD TYPE WITH AN ACTIVITY TYPE. NOTE: YOU CAN ASSOCIATE ACTIVE OR INACTIVE HOLD TYPES
	public void setActType(int acttypeid, String acttype, int holdtypeid) {
		String r = getActTypeString(acttypeid);
		StringBuilder sb = new StringBuilder();
		if (Operator.hasValue(r)) {
			sb.append(r);
			if (holdtypeid > 0) {
				sb.append("|");
			}
		}
		if (holdtypeid > 0) {
			sb.append(holdtypeid);
		}
		significantactivityholds.put(acttypeid, sb.toString());
		setActTypeIndex(acttype, acttypeid);
		if (onSignificantHold(holdtypeid)) {
			addSignificantActivityHolds(acttypeid, holdtypeid);
		}
	}

	// GET HOLD TYPES ASSOCIATED WITH AN ACTIVITY TYPE. NOTE: THIS INCLUDES ALL HOLD TYPES ACTIVE OR INACTIVE
	public String[] getActType(int acttypeid) {
		return Operator.split(getActTypeString(acttypeid), "|");
	}

	// GET ACT TYPE ID OF acttype
	public String[] getActType(String acttype) {
		int a = getActTypeIndex(acttype);
		return getActType(a);
	}

	// IS THERE AN ACTIVE HOLD ON ANY ACTIVITY TYPE SET TO THE OBJECT USING setActType()?
	public boolean actOnSignificantHold() {
		boolean r = false;
		for (int key : significantactivityholds.keySet()) {
			if (actOnSignificantHold(key)) {
				r = true;
				return true;
			}
		}
		return r;
	}

	// IS THERE AN ACTIVE HOLD ON THE SPECIFIED ACTIVITY TYPE?
	public boolean actOnSignificantHold(int acttypeid) {
		String[] a = getActType(acttypeid);
		boolean r = false;
		for (int i=0; i<a.length; i++) {
			String hts = a[i];
			if (onSignificantHold(Operator.toInt(hts))) {
				r = true;
			}
		}
		return r;
	}

	// IS THERE AN ACTIVE HOLD ON THE SPECIFIED ACTIVITY TYPE?
	public boolean actOnSignificantHold(String acttype) {
		int a = getActTypeIndex(acttype);
		return actOnSignificantHold(a);
	}

	// GET ARRAY OF ALL ACTIVE HOLDS FOR ALL ACTIVITY TYPES SET TO THE OBJECT USING setActType()
	public String[] significantActivityHolds() {
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		for (int key : significantactivityholdlist.keySet()) {
			if (!empty) { sb.append("|"); }
			sb.append(getSignificantActivityHolds(key));
			empty = false;
		}
		String aah = sb.toString();
		String[] h = Operator.split(aah, "|");
		empty = true;
		sb = new StringBuilder();
		for (int i=0; i<h.length; i++) {
			int hh = Operator.toInt(h[i]);
			if (hh > 0) {
				String ht = getHoldType(hh);
				if (Operator.hasValue(ht)) {
					if (!empty) { sb.append("|"); }
					sb.append(ht);
					empty = false;
				}
			}
		}
		return Operator.split(sb.toString(), "|");
	}


	// GET ARRAY OF ALL ACTIVE HOLD TYPES. THIS INCLUDES ALL HOLDS THAT ARE ACTIVE EVEN IF THE ACTIVITY DOES NOT HONOR THE HOLD.
	public String[] getSignificantHolds() {
		return significantholdlist.keySet().toArray(new String[significantholdlist.size()]);
	}

	// PRIVATE METHODS
	private String getActTypeString(int acttypeid) {
		String r = "";
		try { r = significantactivityholds.get(acttypeid); }
		catch (Exception e) { }
		if (!Operator.hasValue(r)) { r = ""; }
		return r;
	}



	private int addSignificantHoldCount(int holdstypeid) {
		int r = getSignificantHoldCount(holdstypeid);
		r++;
		significantholdcount.put(holdstypeid, r);
		return r;
	}

	private int getSignificantHoldCount(int holdstypeid) {
		int r = 0;
		try { r = significantholdcount.get(holdstypeid); }
		catch (Exception e) { r = 0; }
		return r;
	}

	private void setActTypeIndex(String acttype, int idx) {
		if (Operator.hasValue(acttype) && idx > 0) {
			activitiesidx.put(acttype, idx);
		}
	}

	private int getActTypeIndex(String acttype) {
		int r = -1;
		try {
			r = activitiesidx.get(acttype);
		}
		catch (Exception e) { r = -1; }
		if (r < 1) { r = -1; }
		return r;
	}

	private void setHoldTypeIndex(String holdtype, int idx) {
		if (Operator.hasValue(holdtype) && idx > 0) {
			holdsidx.put(holdtype, idx);
		}
	}

//	private HoldsVO getHold(int holdtypeindex) {
//		HoldsVO vo = new HoldsVO();
//		try {
//			vo = holds.get(holdtypeindex);
//			if (vo == null) { vo = new HoldsVO(); }
//		}
//		catch (Exception e) { vo = new HoldsVO(); }
//		return vo;
//	}

	private int getHoldTypeIndex(String holdtype) {
		int r = -1;
		try {
			r = holdsidx.get(holdtype);
		}
		catch (Exception e) { r = -1; }
		if (r < 1) { r = -1; }
		return r;
	}

	public void setPriorityhold(String p) {
		if (!Operator.hasValue(priorityhold)) {
			this.priorityhold = p;
		}
	}

	public String getPriorityhold() {
		return priorityhold;
	}

	public String getSignificantActivityHolds(int acttypeid) {
		String r = "";
		try {
			r = significantactivityholdlist.get(acttypeid);
		}
		catch (Exception e) { r = ""; }
		if (!Operator.hasValue(r)) { r = ""; }
		return r;
	}

	public void addSignificantActivityHolds(int acttype, int holdtype) {
		String r = getSignificantActivityHolds(acttype);
		StringBuilder sb = new StringBuilder();
		if (Operator.hasValue(r)) {
			sb.append(r);
			sb.append("|");
		}
		sb.append(Operator.toString(holdtype));
		significantactivityholdlist.put(acttype, sb.toString());
	}

	public String getHoldType(int holdtypeid) {
		String r = "";
		try {
			r = holdtypeidx.get(holdtypeid);
		}
		catch (Exception e) { }
		if (!Operator.hasValue(r)) { r = ""; }
		return r;
	}
}



















