 package csshared.vo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;

public class ReviewVO {

	public int id = -1;
	public int comboid = -1;
	public int reviewid = -1;
	public String title = "";
	public String startdate = "";
	public String duedate = "";
	public int daystilldue = -1;
	public int availabilityid = -1;
	public int maxactiveappt = 0;
	public String review = "";
	public LinkedHashMap<Integer, ReviewActionVO> actions = new LinkedHashMap<Integer, ReviewActionVO>();
	public ArrayList<ReviewTeamVO> team = new ArrayList<ReviewTeamVO>(); 
	public ObjVO[] obj = new ObjVO[0];

	public ReviewVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getComboid() {
		return comboid;
	}

	public void setComboid(int comboid) {
		this.comboid = comboid;
	}

	public int getReviewid() {
		return reviewid;
	}

	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public Timekeeper startdate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getStartdate())) {
			d.setDate(getStartdate());
		}
		return d;
	}

	public String getDuedate() {
		if (Operator.hasValue(duedate)) {
			return duedate;
		}
		else if (Operator.hasValue(getStartdate()) && daystilldue > 0) {
			Timekeeper s = startdate().copy();
			s.addDay(daystilldue);
			return s.getString("YYYY-MM-DD");
		}
		else { return ""; }
	}

	public void setDuedate(String duedate) {
		this.duedate = duedate;
	}

	public Timekeeper duedate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getDuedate())) {
			d.setDate(getDuedate());
		}
		return d;
	}

	public int getDaystilldue() {
		return daystilldue;
	}

	public void setDaystilldue(int daystilldue) {
		this.daystilldue = daystilldue;
	}

	public int getAvailabilityid() {
		return availabilityid;
	}

	public void setAvailabilityid(int availabilityid) {
		this.availabilityid = availabilityid;
	}

	public int getMaxactiveappt() {
		return maxactiveappt;
	}

	public void setMaxactiveappt(int maxactiveappt) {
		this.maxactiveappt = maxactiveappt;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public LinkedHashMap<Integer, ReviewActionVO> getActions() {
		return actions;
	}

	public void setActions(LinkedHashMap<Integer, ReviewActionVO> actions) {
		this.actions = actions;
	}

	public void addAction(ReviewActionVO action) {
		int field = action.getId();
		this.actions.put(field, action);
	}

	public ReviewActionVO getAction(int id) {
		ReviewActionVO vo = new ReviewActionVO();
		try {
			vo = getActions().get(id);
			if (vo == null) { vo = new ReviewActionVO(); }
		}
		catch (Exception e) {
			vo = new ReviewActionVO();
		}
		return vo;
	}

	public ArrayList<ReviewTeamVO> getTeam() {
		return team;
	}

	public void setTeam(ArrayList<ReviewTeamVO> team) {
		this.team = team;
	}

	public void addTeam(ReviewTeamVO vo) {
		this.team.add(vo);
	}

	public boolean inTeam(String username) {
		int l = getTeam().size();
		for (int i=0; i<l; i++) {
			ReviewTeamVO v = getTeam().get(i);
			if (v.getUsername().equalsIgnoreCase(username)) { return true; }
		}
		return false;
	}

	public boolean inTeam(int refteamid) {
		int l = getTeam().size();
		for (int i=0; i<l; i++) {
			ReviewTeamVO v = getTeam().get(i);
			if (v.getRefteamid() == refteamid) { return true; }
		}
		return false;
	}

	public String teamMembers() {
		ArrayList<ReviewTeamVO> t = getTeam();
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<t.size(); i++) {
			ReviewTeamVO vo = t.get(i);
			if (i > 0) { sb.append(", "); }
			sb.append(vo.getUsername());
		}
		return sb.toString();
	}

	public String teamMembers(int actionid) {
		boolean empty = true;
		ArrayList<ReviewTeamVO> t = getTeam();
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<t.size(); i++) {
			ReviewTeamVO vo = t.get(i);
			if (vo.getActionid() == actionid) {
				if (!empty) { sb.append(", "); }
				sb.append(vo.getUsername());
				empty = false;
			}
		}
		return sb.toString();
	}

	public ObjVO[] getObj() {
		return obj;
	}

	public void setObj(ObjVO[] obj) {
		this.obj = obj;
	}

	public ReviewActionVO getCurrent() {
		ReviewActionVO r = new ReviewActionVO();
		try {
		    Map.Entry<Integer, ReviewActionVO> action = getActions().entrySet().iterator().next();
		    r = action.getValue();
		    if (r == null) { r = new ReviewActionVO(); }
		}
		catch (Exception e) { r = new ReviewActionVO(); }
		return r;
	}

	public boolean isApproved() {
		return getCurrent().isApproved();
	}

	public boolean isFinal() {
		return getCurrent().isFinal();
	}

	public boolean isUnapproved() {
		return getCurrent().isUnapproved();
	}

	public boolean isInspection() {
		return getCurrent().isInspection();
	}

	public void addAssigned(int actionid, ReviewTeamVO vo) {
		ReviewActionVO avo = getAction(actionid);
		avo.addAssigned(vo);
		this.actions.put(actionid, avo);
	}

	public void addAssigned(ReviewTeamVO vo) {
		addAssigned(vo.getActionid(), vo);
	}


	public String getStatus() {
		return getCurrent().getStatus();
	}



}






















