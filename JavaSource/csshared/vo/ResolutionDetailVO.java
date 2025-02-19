 package csshared.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class ResolutionDetailVO {

	public int id = -1;
	public int resolutionid = -1;
	public int detailid = -1;
	public String ref = "";
	public int refid = -1;
	public String refnum = "";
	public String part = "";
	public String name = "";
	public String description = "";
	public String date = "";
	public String expdate = "";
	public int statusid = -1;
	public String status = "";
	public String approved = "";
	public String unapproved = "";
	public String finaled = "";
	public String deflt = "";
	public int createdby = -1;
	public String creator = "";
	public int updatedby = -1;
	public String updater = "";
	public String complieddate = "";
	public String appcomplieddate = "";
	public String createddate = "";
	public String updateddate = "";

	public LinkedHashMap<String, ResolutionDetailVO> history = new LinkedHashMap<String, ResolutionDetailVO>();

	public ResolutionDetailVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getResolutionid() {
		return resolutionid;
	}

	public void setResolutionid(int resolutionid) {
		this.resolutionid = resolutionid;
	}

	public int getDetailid() {
		return detailid;
	}

	public void setDetailid(int detailid) {
		this.detailid = detailid;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public int getRefid() {
		return refid;
	}

	public void setRefid(int refid) {
		this.refid = refid;
	}

	public String getRefnum() {
		return refnum;
	}

	public void setRefnum(String refnum) {
		this.refnum = refnum;
	}

	public boolean isPermanent() {
		return !Operator.equalsIgnoreCase(getRef(), "project") && !Operator.equalsIgnoreCase(getRef(), "activity");
	}

	public String getType() {
		if (isPermanent()) { return "permanent"; }
		else { return "temporary"; }
	}

	public String getPart() {
		return part;
	}

	public void setPart(String part) {
		this.part = part;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Timekeeper date() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getDate())) {
			d.setDate(getDate());
		}
		return d;
	}

	public String getExpdate() {
		return expdate;
	}

	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}

	public Timekeeper expiration() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getExpdate())) {
			d.setDate(getExpdate());
		}
		return d;
	}

	public boolean expires() {
		return Operator.hasValue(getExpdate());
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

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public boolean isApproved() {
		return Operator.equalsIgnoreCase(getApproved(), "Y");
	}

	public String getUnapproved() {
		return unapproved;
	}

	public void setUnapproved(String unapproved) {
		this.unapproved = unapproved;
	}

	public boolean isUnapproved() {
		if (isApproved()) { return false; }
		return Operator.equalsIgnoreCase(getUnapproved(), "Y");
	}

	public String getDefault() {
		return deflt;
	}

	public void setDefault(String deflt) {
		this.deflt = deflt;
	}

	public boolean isDefault() {
		return Operator.equalsIgnoreCase(getDefault(), "Y");
	}

	public String getFinaled() {
		return finaled;
	}

	public void setFinaled(String finaled) {
		this.finaled = finaled;
	}

	public boolean isFinaled() {
		return Operator.equalsIgnoreCase(getFinaled(), "Y");
	}

	public int getCreatedby() {
		return createdby;
	}

	public void setCreatedby(int createdby) {
		this.createdby = createdby;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public int getUpdatedby() {
		return updatedby;
	}

	public void setUpdatedby(int updatedby) {
		this.updatedby = updatedby;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getComplieddate() {
		return complieddate;
	}

	public void setComplieddate(String complieddate) {
		this.complieddate = complieddate;
	}

	public boolean isComplied() {
		return Operator.hasValue(getComplieddate());
	}

	public String getAppcomplieddate() {
		return appcomplieddate;
	}

	public void setAppcomplieddate(String appcomplieddate) {
		this.appcomplieddate = appcomplieddate;
	}

	public boolean isAppcomplied() {
		return Operator.hasValue(getAppcomplieddate());
	}

	public boolean compliable() {
		if (isApproved()) { return true; }
		return false;
	}

	public String getCreateddate() {
		return createddate;
	}

	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}

	public String getUpdateddate() {
		return updateddate;
	}

	public void setUpdateddate(String updateddate) {
		this.updateddate = updateddate;
	}

	public LinkedHashMap<String, ResolutionDetailVO> getHistory() {
		return history;
	}

	public void setHistory(LinkedHashMap<String, ResolutionDetailVO> history) {
		this.history = history;
	}

	public void addHistory(ResolutionDetailVO hist) {
		this.history.put(Operator.toString(hist.getId()), hist);
	}

	public ResolutionDetailVO getHistory(int id) {
		return history.get(Operator.toString(id));
	}

	public ArrayList<ResolutionDetailVO> array() {
		Collection<ResolutionDetailVO> values = history.values();
		return new ArrayList<ResolutionDetailVO>(values);
	}

	public void addHistory(int id, int resolutionid, int detailid, String part, String name, String description, String date, int statusid, String status, String approved, String finaled, int createdby, String creator, int updatedby, String updater, String createddate, String updateddate) {
		ResolutionDetailVO vo = new ResolutionDetailVO();
		vo.setId(id);
		vo.setResolutionid(resolutionid);
		vo.setDetailid(detailid);
		vo.setPart(part);
		vo.setName(name);
		vo.setDescription(description);
		vo.setDate(date);
		vo.setStatusid(statusid);
		vo.setStatus(status);
		vo.setApproved(approved);
		vo.setFinaled(finaled);
		vo.setCreatedby(createdby);
		vo.setCreator(creator);
		vo.setUpdatedby(updatedby);
		vo.setUpdater(updater);
		vo.setCreateddate(createddate);
		vo.setUpdateddate(updateddate);
		addHistory(vo);
	}

	public boolean hasValue() {
		return getId() > 0;
	}

	public ResolutionDetailVO duplicate() {
		ResolutionDetailVO vo = new ResolutionDetailVO();
		vo.id = this.id;
		vo.resolutionid = this.resolutionid;
		vo.detailid = this.detailid;
		vo.ref = this.ref;
		vo.refid = this.refid;
		vo.refnum = this.refnum;
		vo.part = this.part;
		vo.name = this.name;
		vo.description = this.description;
		vo.date = this.date;
		vo.expdate = this.expdate;
		vo.statusid = this.statusid;
		vo.status = this.status;
		vo.approved = this.unapproved;
		vo.unapproved = this.approved;
		vo.deflt = this.deflt;
		vo.finaled = this.finaled;
		vo.createdby = this.createdby;
		vo.creator = this.creator;
		vo.updatedby = this.updatedby;
		vo.updater = this.updater;
		vo.complieddate = this.complieddate;
		vo.createddate = this.createddate;
		vo.updateddate = this.updateddate;
		return vo;
	}




}






















