 package csshared.vo;

import java.util.LinkedHashMap;
import java.util.Map;

import csshared.vo.lkup.RolesVO;
import alain.core.utils.Operator;

public class ComboReviewVO {

	public int comboid = -1;
	public String combotitle = "";

	public String entity = "";
	public String entityid = "";

	public String type = "";
	public int typeid = -1;
	public String title = "";
	public String subtitle = "";
	public String reference = "";
	
	public String group = "";
	public int groupid = -1;

	public String start = "";
	public String due = "";

	public String expedited = "N";

	public String reviewgrouptitle = "";
	public int reviewgroupid = -1;

	public String project = "";
	public int projectid = -1;
	public String activity = "";
	public int activityid = -1;

	public String projecttype = "";
	public String activitytype = "";

	public String address = "";
	public int lsoid = -1;

	public boolean create = false;
	public boolean read = false;
	public boolean update = false;
	public boolean delete = false;
	public boolean admin = false;

	public LinkedHashMap<Integer, ReviewVO> reviews = new LinkedHashMap<Integer, ReviewVO>();


	public ComboReviewVO() { }


	public int getComboid() {
		return comboid;
	}


	public void setComboid(int comboid) {
		this.comboid = comboid;
	}


	public String getCombotitle() {
		return combotitle;
	}


	public void setCombotitle(String combotitle) {
		this.combotitle = combotitle;
	}


	public String getEntity() {
		return entity;
	}


	public void setEntity(String entity) {
		this.entity = entity;
	}


	public String getEntityid() {
		return entityid;
	}


	public void setEntityid(String entityid) {
		this.entityid = entityid;
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


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getSubtitle() {
		return subtitle;
	}


	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}


	public String getReference() {
		return reference;
	}


	public void setReference(String reference) {
		this.reference = reference;
	}


	public String getGroup() {
		return group;
	}


	public void setGroup(String group) {
		this.group = group;
	}


	public int getGroupid() {
		return groupid;
	}


	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}


	public String getStart() {
		return start;
	}


	public void setStart(String start) {
		this.start = start;
	}


	public String getDue() {
		return due;
	}


	public void setDue(String due) {
		this.due = due;
	}


	public String getExpedited() {
		return expedited;
	}


	public void setExpedited(String expedited) {
		this.expedited = expedited;
	}

	public void expedite(boolean e) {
		if (e) { setExpedited("Y"); }
		else { setExpedited("N"); }
	}

	public boolean isExpedited() {
		return Operator.equalsIgnoreCase(getExpedited(), "Y");
	}


	public String getProject() {
		return project;
	}


	public void setProject(String project) {
		this.project = project;
	}


	public int getProjectid() {
		return projectid;
	}


	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}


	public String getActivity() {
		return activity;
	}


	public void setActivity(String activity) {
		this.activity = activity;
	}


	public int getActivityid() {
		return activityid;
	}


	public void setActivityid(int activityid) {
		this.activityid = activityid;
	}


	public String getProjecttype() {
		return projecttype;
	}


	public void setProjecttype(String projecttype) {
		this.projecttype = projecttype;
	}


	public String getActivitytype() {
		return activitytype;
	}


	public void setActivitytype(String activitytype) {
		this.activitytype = activitytype;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public int getLsoid() {
		return lsoid;
	}


	public void setLsoid(int lsoid) {
		this.lsoid = lsoid;
	}


	public String getReviewgrouptitle() {
		return reviewgrouptitle;
	}


	public void setReviewgrouptitle(String reviewgrouptitle) {
		this.reviewgrouptitle = reviewgrouptitle;
	}


	public int getReviewgroupid() {
		return reviewgroupid;
	}


	public void setReviewgroupid(int reviewgroupid) {
		this.reviewgroupid = reviewgroupid;
	}


	public LinkedHashMap<Integer, ReviewVO> getReviews() {
		return reviews;
	}


	public void setReviews(LinkedHashMap<Integer, ReviewVO> reviews) {
		this.reviews = reviews;
	}


	public void addReview(ReviewVO review) {
		int field = review.getId();
		if (field > 0) {
			this.reviews.put(field, review);
		}
	}


	public ReviewVO getReview(int id) {
		ReviewVO vo = new ReviewVO();
		try {
			vo = getReviews().get(id);
			if (vo == null) { vo = new ReviewVO(); }
		}
		catch (Exception e) {
			vo = new ReviewVO();
		}
		return vo;
	}


	public void addAction(int reviewid, ReviewActionVO action) {
		if (reviewid > 0) {
			ReviewVO vo = getReview(reviewid);
			vo.addAction(action);
			this.reviews.put(reviewid, vo);
		}
	}

	public void addAction(ReviewActionVO action) {
		int rev = action.getReviewrefid();
		addAction(rev, action);
	}

	public void addTeam(int reviewid, ReviewTeamVO team) {
		if (reviewid > 0) {
			ReviewVO vo = getReview(reviewid);
			vo.addTeam(team);
			this.reviews.put(reviewid, vo);
		}
	}

	public void addTeam(ReviewTeamVO team) {
		int rev = team.getReviewrefid();
		addTeam(rev, team);
	}

	public boolean isApproved() {
		LinkedHashMap<Integer, ReviewVO> reviews = getReviews();
		if (reviews.size() < 1) { return false; }
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {
			ReviewVO v = entry.getValue();
			if (!v.isApproved()) { return false; }
			if (v.isUnapproved()) { return false; }
		}
		return true;
	}

	public boolean isUnapproved() {
		LinkedHashMap<Integer, ReviewVO> reviews = getReviews();
		if (reviews.size() < 1) { return false; }
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {
			ReviewVO v = entry.getValue();
			if (v.isUnapproved()) { return true; }
		}
		return false;
	}

	public boolean isFinal() {
		LinkedHashMap<Integer, ReviewVO> reviews = getReviews();
		if (reviews.size() < 1) { return false; }
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {
			ReviewVO v = entry.getValue();
			if (!v.isFinal() && !v.isApproved() && !v.isUnapproved()) { return false; }
		}
		return true;
	}

	public String status() {
		String r = "APPROVED";
		LinkedHashMap<Integer, ReviewVO> reviews = getReviews();
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {
			ReviewVO v = entry.getValue();
			if (v.isUnapproved()) { return "UNAPPROVED"; }
			if (!v.isApproved() || !v.isFinal()) { r = "PENDING"; }
		}
		return r;
	}

	public void addAssigned(ReviewTeamVO vo) {
		int revrefid = vo.getReviewrefid();
		if (revrefid > 0) {
			ReviewVO r = getReview(revrefid);
			r.addAssigned(vo);
			this.reviews.put(revrefid, r);
		}
	}

	public boolean isCreate() {
		if (isAdmin()) { return true; }
		return create;
	}

	public void setCreate(boolean create) {
		this.create = create;
	}

	public boolean isRead() {
		if (isAdmin()) { return true; }
		if (isCreate()) { return true; }
		if (isUpdate()) { return true; }
		if (isDelete()) { return true; }
		return read;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public boolean isUpdate() {
		if (isAdmin()) { return true; }
		return update;
	}

	public void setUpdate(boolean update) {
		this.update = update;
	}

	public boolean isDelete() {
		if (isAdmin()) { return true; }
		return delete;
	}

	public void setDelete(boolean delete) {
		this.delete = delete;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean admin) {
		if (admin) {
			setAdmin(true);
			setCreate(true);
			setRead(true);
			setUpdate(true);
			setDelete(true);
		}
		else {
			setCreate(vo.createAccess(userroles, nonpublicroles));
			setRead(vo.readAccess(userroles, nonpublicroles));
			setUpdate(vo.updateAccess(userroles, nonpublicroles));
			setDelete(vo.deleteAccess(userroles, nonpublicroles));
		}
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean onhold, boolean admin) {
		if (admin) {
			setAdmin(true);
			setCreate(true);
			setRead(true);
			setUpdate(true);
			setDelete(true);
		}
		else {
			setCreate(vo.createAccess(userroles, nonpublicroles));
			setRead(vo.readAccess(userroles, nonpublicroles));
			setUpdate(vo.updateAccess(userroles, nonpublicroles));
			setDelete(vo.deleteAccess(userroles, nonpublicroles));

			if (onhold) {
				setAdmin(false);
				setCreate(false);
				setUpdate(false);
				setDelete(false);
			}
		}
	}


}






















