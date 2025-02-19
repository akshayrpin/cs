 package csshared.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class ResolutionVO {

	public int id = -1;
	public String number = "";
	public String title = "";
	public String adopted = "";
	public int createdby = -1;
	public String creator = "";
	public int updatedby = -1;
	public String updater = "";
	public String createddate = "";
	public String updateddate = "";
	public String complied = "Y";
	public String appcomplied = "Y";
	public String tempref = "";
	public boolean partsadopted = true;

	public LinkedHashMap<String, ResolutionDetailVO> details = new LinkedHashMap<String, ResolutionDetailVO>();
	public ResolutionDetailVO detail = new ResolutionDetailVO();

	public ResolutionVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAdopted() {
		if (!partsadopted) { return ""; }
		return adopted;
	}

	public void setAdopted(String adopted) {
		this.adopted = adopted;
	}

	public Timekeeper adoptedDate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getAdopted())) {
			d.setDate(getAdopted());
		}
		return d;
	}

	public boolean isAdopted() {
		if (!partsadopted) { return false; }
		return Operator.hasValue(getAdopted());
	}

	public boolean isPartsAdopted() {
		return partsadopted;
	}

	public void setPartsAdopted(boolean partsadopted) {
		this.partsadopted = partsadopted;
	}

	public String getComplied() {
		return complied;
	}

	public void setComplied(String complied) {
		this.complied = complied;
	}

	public boolean isComplied() {
		return Operator.equalsIgnoreCase(getComplied(), "Y");
	}

	public String getAppcomplied() {
		return appcomplied;
	}

	public void setAppcomplied(String appcomplied) {
		this.appcomplied = appcomplied;
	}

	public boolean isAppcomplied() {
		return Operator.equalsIgnoreCase(getAppcomplied(), "Y");
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

	public String getCreateddate() {
		return createddate;
	}

	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}

	public Timekeeper createdDate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getCreateddate())) {
			d.setDate(getCreateddate());
		}
		return d;
	}

	public String getUpdateddate() {
		return updateddate;
	}

	public void setUpdateddate(String updateddate) {
		this.updateddate = updateddate;
	}

	public Timekeeper updatedDate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getUpdateddate())) {
			d.setDate(getUpdateddate());
		}
		return d;
	}

	public LinkedHashMap<String, ResolutionDetailVO> getDetails() {
		return details;
	}

	public void setDetails(LinkedHashMap<String, ResolutionDetailVO> details) {
		this.details = details;
	}

	public void addDetail(ResolutionDetailVO detail) {
		if (detail.isUnapproved()) {
			setPartsAdopted(false);
		}
		else if (!detail.isFinaled() && !detail.isApproved()) {
			setPartsAdopted(false);
		}
		if (!detail.isComplied()) {
			if (detail.isApproved()) {
				setComplied("N");
			}
		}
		if (!detail.isAppcomplied()) {
			if (detail.isApproved()) {
				setAppcomplied("N");
			}
		}
		this.details.put(Operator.toString(detail.getId()), detail);
	}

	public ResolutionDetailVO getDetail(int id) {
		return details.get(Operator.toString(id));
	}

	public ArrayList<ResolutionDetailVO> array() {
		Collection<ResolutionDetailVO> values = details.values();
		return new ArrayList<ResolutionDetailVO>(values);
	}

	public void addDetail(int id, int resolutionid, int detailid, String part, String name, String description, String date, int statusid, String status, String complieddate, String approved, String finaled, int createdby, String creator, int updatedby, String updater, String createddate, String updateddate) {
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
		vo.setComplieddate(complieddate);
		vo.setApproved(approved);
		vo.setFinaled(finaled);
		vo.setCreatedby(createdby);
		vo.setCreator(creator);
		vo.setUpdatedby(updatedby);
		vo.setUpdater(updater);
		vo.setCreateddate(createddate);
		vo.setUpdateddate(updateddate);
		addDetail(vo);
	}

	public ResolutionDetailVO getDetail() {
		return detail;
	}

	public void setDetail(ResolutionDetailVO detail) {
		this.detail = detail;
	}

}






















