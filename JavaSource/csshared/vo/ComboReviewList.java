 package csshared.vo;

import java.util.ArrayList;
import java.util.LinkedHashMap;

public class ComboReviewList {

	public LinkedHashMap<Integer, ComboReviewVO> comboreviews = new LinkedHashMap<Integer, ComboReviewVO>();
	public String title = "";
	public int groupid = -1;

	public ComboReviewList() {}

	public ComboReviewVO getComboreview(int comboid) {
		ComboReviewVO r = new ComboReviewVO();
		try {
			r = comboreviews.get(comboid);
			if (r == null) { r = new ComboReviewVO(); }
		}
		catch (Exception e) { r = new ComboReviewVO(); }
		return r;
	}

	public ComboReviewVO getComboreview(int comboid, String title, String start, String due, boolean expedite, String type, int typeid, String project, int projectid, String projecttype, String activity, int activityid, String activitytype, String address, int lsoid, String revgrouptitle, int revgroupid) {
		ComboReviewVO r = getComboreview(comboid);

		if (r.getComboid() < 1) {
			r.setComboid(comboid);
			r.setCombotitle(title);
			r.setStart(start);
			r.setDue(due);
			r.expedite(expedite);
			r.setProject(project);
			r.setReviewgrouptitle(revgrouptitle);
			r.setReviewgroupid(revgroupid);
			r.setProject(project);
			r.setProjectid(projectid);
			r.setActivity(activity);
			r.setActivityid(activityid);
			r.setAddress(address);
			r.setLsoid(lsoid);
			r.setType(type);
			r.setTypeid(typeid);
		}

		return r;
	}

	public LinkedHashMap<Integer, ComboReviewVO> getComboreviews() {
		return comboreviews;
	}

	public void setComboreviews(LinkedHashMap<Integer, ComboReviewVO> comboreviews) {
		this.comboreviews = comboreviews;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getGroupid() {
		return groupid;
	}

	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}

	public void addComboReview(ComboReviewVO vo) {
		if (vo.getComboid() > 0) {
			comboreviews.put(vo.getComboid(), vo);
		}
	}

	public void addComboReview(int comboid, String title, String start, String due, boolean expedite, String type, int typeid, String project, int projectid, String projecttype, String activity, int activityid, String activitytype, String address, int lsoid, String revgrouptitle, int revgroupid) {
		ComboReviewVO c = getComboreview(comboid, title, start, due, expedite, type, typeid, project, projectid, projecttype, activity, activityid, activitytype, address, lsoid, revgrouptitle, revgroupid);
		comboreviews.put(comboid, c);
	}

	public void addReview(int comboid, String title, String start, String due, boolean expedite, String type, int typeid, String project, int projectid, String projecttype, String activity, int activityid, String activitytype, String address, int lsoid, String revgrouptitle, int revgroupid, ReviewVO review) {
		if (comboid > 0) {
			ComboReviewVO c = getComboreview(comboid, title, start, due, expedite, type, typeid, project, projectid, projecttype, activity, activityid, activitytype, address, lsoid, revgrouptitle, revgroupid);
			c.addReview(review);
			comboreviews.put(comboid, c);
		}
	}

	public void addAction(int comboid, String title, String start, String due, boolean expedite, String type, int typeid, String project, int projectid, String projecttype, String activity, int activityid, String activitytype, String address, int lsoid, String revgrouptitle, int revgroupid, ReviewVO review, ReviewActionVO action) {
		if (comboid > 0) {
			ComboReviewVO c = getComboreview(comboid, title, start, due, expedite, type, typeid, project, projectid, projecttype, activity, activityid, activitytype, address, lsoid, revgrouptitle, revgroupid);
			ReviewVO r = c.getReview(review.getId());
			if (r.getId() < 1) {
				c.addReview(review);
			}
			c.addAction(action);
			comboreviews.put(comboid, c);
		}
	}

	public void addTeam(int comboid, int reviewid, ReviewTeamVO team) {
		if (comboid > 0) {
			ComboReviewVO c = getComboreview(comboid);
			c.addTeam(reviewid, team);
			comboreviews.put(comboid, c);
		}
	}

	public ArrayList<ComboReviewVO> toArrayList() {
		return new ArrayList<ComboReviewVO>(comboreviews.values());
	}

	public int size() {
		return comboreviews.size();
	}




}






















