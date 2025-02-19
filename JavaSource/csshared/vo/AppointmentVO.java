package csshared.vo;

import java.util.ArrayList;



public class AppointmentVO {

	public int id = -1;
	public int appttypeid = -1;
	public String appttype = "";
	public int comboreviewid = -1;
	public int refreviewid = -1;
	public int reviewid = -1;
	public String review = "";
	public String subject = "";
	public String cstype = "";
	public String createdby = "";
	public int createduser = -1;
	public String updatedby = "";
	public int updateduser = -1;

	public int collaboratorsize = 0;
	public int teamsize = 0;

	public ArrayList<AppointmentScheduleVO> schedule = new ArrayList<AppointmentScheduleVO>();
	public ArrayList<UserVO> team = new ArrayList<UserVO>();
	public ArrayList<UserVO> collaborators = new ArrayList<UserVO>();

	public AppointmentVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAppttypeid() {
		return appttypeid;
	}

	public void setAppttypeid(int appttypeid) {
		this.appttypeid = appttypeid;
	}

	public String getAppttype() {
		return appttype;
	}

	public void setAppttype(String appttype) {
		this.appttype = appttype;
	}

	public int getComboreviewid() {
		return comboreviewid;
	}

	public void setComboreviewid(int comboreviewid) {
		this.comboreviewid = comboreviewid;
	}

	public int getRefreviewid() {
		return refreviewid;
	}

	public void setRefreviewid(int refreviewid) {
		this.refreviewid = refreviewid;
	}

	public int getReviewid() {
		return reviewid;
	}

	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getCstype() {
		return cstype;
	}

	public void setCstype(String cstype) {
		this.cstype = cstype;
	}

	public String getCreatedby() {
		return createdby;
	}

	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}

	public int getCreateduser() {
		return createduser;
	}

	public void setCreateduser(int createduser) {
		this.createduser = createduser;
	}

	public String getUpdatedby() {
		return updatedby;
	}

	public void setUpdatedby(String updatedby) {
		this.updatedby = updatedby;
	}

	public int getUpdateduser() {
		return updateduser;
	}

	public void setUpdateduser(int updateduser) {
		this.updateduser = updateduser;
	}

	public ArrayList<AppointmentScheduleVO> getSchedule() {
		return schedule;
	}

	public void setSchedule(ArrayList<AppointmentScheduleVO> schedule) {
		this.schedule = schedule;
	}

	public AppointmentScheduleVO getFirstSchedule() {
		AppointmentScheduleVO vo = new AppointmentScheduleVO();
		try {
			if (getSchedule().size() > 0) {
				vo = getSchedule().get(0);
			}
		}
		catch (Exception e) {
			vo = new AppointmentScheduleVO();
		}
		return vo;
	}

	public void addSchedule(AppointmentScheduleVO vo) {
		schedule.add(vo);
	}

	public ArrayList<UserVO> getTeam() {
		return team;
	}

	public void setTeam(ArrayList<UserVO> team) {
		this.team = team;
	}

	public void addTeam(UserVO team) {
		this.team.add(team);
	}

	public boolean inTeam(String username) {
		int l = getTeam().size();
		for (int i=0; i<l; i++) {
			UserVO v = getTeam().get(i);
			if (v.getUsername().equalsIgnoreCase(username)) { return true; }
		}
		return false;
	}

	public String team() {
		ArrayList<UserVO> t = getTeam();
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<t.size(); i++) {
			UserVO vo = t.get(i);
			if (i > 0) { sb.append(", "); }
			sb.append(vo.getUsername());
		}
		return sb.toString();
	}

	public ArrayList<UserVO> getCollaborators() {
		return collaborators;
	}

	public void setCollaborators(ArrayList<UserVO> collaborators) {
		this.collaborators = collaborators;
	}

	public void addCollaborator(UserVO collaborator) {
		this.collaborators.add(collaborator);
	}

	public boolean isCollaborator(String username) {
		int l = getCollaborators().size();
		for (int i=0; i<l; i++) {
			UserVO v = getCollaborators().get(i);
			if (v.getUsername().equalsIgnoreCase(username)) { return true; }
		}
		return false;
	}

	public String collaborators() {
		ArrayList<UserVO> t = getCollaborators();
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<t.size(); i++) {
			UserVO vo = t.get(i);
			if (i > 0) { sb.append(", "); }
			sb.append(vo.getUsername());
		}
		return sb.toString();
	}

	public int getCollaboratorsize() {
		if (collaborators.size() > 0) { return collaborators.size(); }
		return collaboratorsize;
	}

	public void setCollaboratorsize(int collaboratorsize) {
		this.collaboratorsize = collaboratorsize;
	}

	public int getTeamsize() {
		if (team.size() > 0) { return team.size(); }
		return teamsize;
	}

	public void setTeamsize(int teamsize) {
		this.teamsize = teamsize;
	}

}




