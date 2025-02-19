 package csshared.vo;

import java.util.LinkedHashMap;

import alain.core.utils.Operator;

public class ComboReviewGroup {

	public LinkedHashMap<String, ComboReviewList> list = new LinkedHashMap<String, ComboReviewList>();

	public ComboReviewGroup() {}

	public LinkedHashMap<String, ComboReviewList> getList() {
		return list;
	}

	public void setList(LinkedHashMap<String, ComboReviewList> list) {
		this.list = list;
	}

	public int size() {
		return list.size();
	}

	public ComboReviewList getList(String title, int revgroupid) {
		ComboReviewList r = new ComboReviewList();
		try {
			r = list.get(title);
			if (r == null) { r = new ComboReviewList(); }
		}
		catch (Exception e) { r = new ComboReviewList(); }
		if (!Operator.hasValue(r.getTitle())) {
			r.setTitle(title);
			r.setGroupid(revgroupid);
		}
		return r;
	}

	public void addComboreview(ComboReviewVO vo) {
		if (Operator.hasValue(vo.getReviewgrouptitle())) {
			ComboReviewList r = getList(vo.getReviewgrouptitle(), vo.getReviewgroupid());
			r.addComboReview(vo);
			list.put(vo.getReviewgrouptitle(), r);
		}
	}

	public void addAction(String revgrouptitle, int revgroupid, int comboid, String combotitle, String start, String due, boolean expedite, String type, int typeid, String project, int projectid, String projecttype, String activity, int activityid, String activitytype, String address, int lsoid, ReviewVO review, ReviewActionVO action) {
		ComboReviewList r = getList(revgrouptitle, revgroupid);
		r.addAction(comboid, combotitle, start, due, expedite, type, typeid, project, projectid, projecttype, activity, activityid, activitytype, address, lsoid, revgrouptitle, revgroupid, review, action);
		list.put(revgrouptitle, r);
	}


}






















