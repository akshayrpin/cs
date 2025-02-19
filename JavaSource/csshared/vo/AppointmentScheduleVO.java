package csshared.vo;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;



public class AppointmentScheduleVO {

	public int id = -1;
	public int apptid = -1;
	public String start = "";
	public String end = "";
	public int statusid = -1;
	public String status = "";
	public int refactionid = -1;
	public int parentid = -1;
	public String source = "";
	public String createdby = "";
	public int createduser = -1;
	public String updatedby = "";
	public int updateduser = -1;

	public String scheduled = "N";
	public String complete = "N";
	public String defaultcomplete = "N";
	public String defaultbegin = "N";

	public AppointmentScheduleVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getApptid() {
		return apptid;
	}

	public void setApptid(int apptid) {
		this.apptid = apptid;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String startDate(String format) {
		if (!Operator.hasValue(getStart())) { return ""; }
		Timekeeper d = new Timekeeper();
		d.setDate(getStart());
		return d.getString(format);
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String endDate(String format) {
		if (!Operator.hasValue(getEnd())) { return ""; }
		Timekeeper d = new Timekeeper();
		d.setDate(getEnd());
		return d.getString(format);
	}

	public int getStatusid() {
		return statusid;
	}

	public void setStatusid(int statusid) {
		this.statusid = statusid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getRefactionid() {
		return refactionid;
	}

	public void setRefactionid(int refactionid) {
		this.refactionid = refactionid;
	}

	public int getParentid() {
		return parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
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

	public String getScheduled() {
		return scheduled;
	}

	public void setScheduled(String scheduled) {
		this.scheduled = scheduled;
	}

	public boolean isScheduled() {
		return Operator.equalsIgnoreCase(getScheduled(), "Y");
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public boolean isComplete() {
		return Operator.equalsIgnoreCase(getComplete(), "Y");
	}

	public String getDefaultcomplete() {
		return defaultcomplete;
	}

	public void setDefaultcomplete(String defaultcomplete) {
		this.defaultcomplete = defaultcomplete;
	}

	public boolean isDefaultcomplete() {
		return Operator.equalsIgnoreCase(getDefaultcomplete(), "Y");
	}

	public String getDefaultbegin() {
		return defaultbegin;
	}

	public void setDefaultbegin(String defaultbegin) {
		this.defaultbegin = defaultbegin;
	}

	public boolean isDefaultbegin() {
		return Operator.equalsIgnoreCase(getDefaultbegin(), "Y");
	}

	public String asText() {
		if (!Operator.hasValue(getStart())) { return ""; }
		StringBuilder sb = new StringBuilder();
		sb.append(startDate("MM/DD/YYYY"));
		String stime = startDate("HOUR_OF_DAY") + startDate("MINUTE");
		if (!stime.equalsIgnoreCase("0000")) {
			sb.append(" @ ").append(startDate("MILITARYTIME"));
		}
		if (!startDate("MM/DD/YYYY").equalsIgnoreCase(endDate("MM/DD/YYYY"))) {
			sb.append(" - ");
			sb.append(endDate("MM/DD/YYYY"));
			if (!endDate("MILITARYTIME").equalsIgnoreCase("23:59")) {
				sb.append(" @ ").append(endDate("MILITARYTIME"));
			}
		}
		else if (!startDate("MILITARYTIME").equalsIgnoreCase(endDate("MILITARYTIME"))) {
			if (!endDate("MILITARYTIME").equalsIgnoreCase("23:59")) {
				sb.append(" - ");
				sb.append(endDate("MILITARYTIME"));
			}
		}
		return sb.toString();
	}




}




