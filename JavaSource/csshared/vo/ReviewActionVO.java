package csshared.vo;

import java.util.ArrayList;

public class ReviewActionVO {

	public int id = -1;
	public int reviewrefid = -1;
	public int statusid = -1;
	public int librarygroupid = -1;
	public int notifications = -1;
	public String date = "";
	public String comments = "";
	public String status = "";
	public String approved = "";
	public String unapproved = "";
	public String fnal = "";
	public String scheduled = "";
	public String cancel = "";
	public String inspection = "";
	public String inspectioncancel = "";
	public String expired = "";
	public String assign = "";
	public String createdby = "";
	public ReviewAttachmentVO attachment = new ReviewAttachmentVO(); 
	public ArrayList<ReviewTeamVO> assigned = new ArrayList<ReviewTeamVO>();
	public AppointmentVO appointment = new AppointmentVO();
	

	public ReviewActionVO() { }


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getReviewrefid() {
		return reviewrefid;
	}


	public void setReviewrefid(int reviewrefid) {
		this.reviewrefid = reviewrefid;
	}


	public int getStatusid() {
		return statusid;
	}


	public void setStatusid(int statusid) {
		this.statusid = statusid;
	}


	public int getLibrarygroupid() {
		return librarygroupid;
	}


	public void setLibrarygroupid(int librarygroupid) {
		this.librarygroupid = librarygroupid;
	}


	public int getNotifications() {
		return notifications;
	}


	public void setNotifications(int notifications) {
		this.notifications = notifications;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getComments() {
		return comments;
	}


	public void setComments(String comments) {
		this.comments = comments;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getApproved() {
		return approved;
	}


	public void setApproved(String approved) {
		this.approved = approved;
	}


	public boolean isApproved() {
		return getApproved().equalsIgnoreCase("Y");
	}

	public String getUnapproved() {
		return unapproved;
	}


	public void setUnapproved(String unapproved) {
		this.unapproved = unapproved;
	}

	public boolean isUnapproved() {
		return getUnapproved().equalsIgnoreCase("Y");
	}

	public String getFnal() {
		return fnal;
	}


	public void setFnal(String fnal) {
		this.fnal = fnal;
	}


	public boolean isFinal() {
		return getFnal().equalsIgnoreCase("Y");
	}

	public String getScheduled() {
		return scheduled;
	}


	public void setScheduled(String scheduled) {
		this.scheduled = scheduled;
	}


	public String getCancel() {
		return cancel;
	}


	public void setCancel(String cancel) {
		this.cancel = cancel;
	}


	public String getInspection() {
		return inspection;
	}


	public void setInspection(String inspection) {
		this.inspection = inspection;
	}

	public boolean isInspection() {
		return getInspection().equalsIgnoreCase("Y");
	}

	public String getInspectioncancel() {
		return inspectioncancel;
	}

	public void setInspectioncancel(String inspectioncancel) {
		this.inspectioncancel = inspectioncancel;
	}


	public String getExpired() {
		return expired;
	}


	public void setExpired(String expired) {
		this.expired = expired;
	}


	public boolean isExpired() {
		return getExpired().equalsIgnoreCase("Y");
	}


	public String getAssign() {
		return assign;
	}


	public void setAssign(String assign) {
		this.assign = assign;
	}


	public String getCreatedby() {
		return createdby;
	}


	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}


	public ReviewAttachmentVO getAttachment() {
		return attachment;
	}


	public void setAttachment(ReviewAttachmentVO attachment) {
		this.attachment = attachment;
	}


	public ArrayList<ReviewTeamVO> getAssigned() {
		return assigned;
	}


	public void setAssigned(ArrayList<ReviewTeamVO> assigned) {
		this.assigned = assigned;
	}

	public void addAssigned(ReviewTeamVO assigned) {
		this.assigned.add(assigned);
	}

	public String assigned() {
		ArrayList<ReviewTeamVO> t = getAssigned();
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<t.size(); i++) {
			ReviewTeamVO vo = t.get(i);
			if (i > 0) { sb.append(", "); }
			sb.append(vo.getUsername());
		}
		return sb.toString();
	}


	public AppointmentVO getAppointment() {
		return appointment;
	}


	public void setAppointment(AppointmentVO appointment) {
		this.appointment = appointment;
	}

}






















