 package csshared.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;

import alain.core.utils.Operator;


public class ResolutionsVO {

	public LinkedHashMap<String, ResolutionVO> resolutions = new LinkedHashMap<String, ResolutionVO>();

	public ResolutionsVO() { }

	public LinkedHashMap<String, ResolutionVO> getResolutions() {
		return resolutions;
	}

	public void setResolutions(LinkedHashMap<String, ResolutionVO> resolutions) {
		this.resolutions = resolutions;
	}

	public void addResolution(ResolutionVO vo) {
		this.resolutions.put(Operator.toString(vo.getId()), vo);
	}

	public ResolutionVO getResolution(int id) {
		ResolutionVO r = new ResolutionVO();
		try { r = resolutions.get(Operator.toString(id)); }
		catch (Exception e){ r = new ResolutionVO(); }
		if (r == null) {
			r = new ResolutionVO();
		}
		return r;
	}

	public void addResolutionDetail(int resid, String number, String title, String adopted, int createdby, String creator, int updatedby, String updater, String createddate, String updateddate, ResolutionDetailVO vo) {
		ResolutionVO r = getResolution(resid);
		if (r.getId() < 1) {
			r.setId(resid);
			r.setNumber(number);
			r.setTitle(title);
			r.setAdopted(adopted);
			r.setCreatedby(createdby);
			r.setCreator(creator);
			r.setUpdatedby(updatedby);
			r.setUpdater(updater);
			r.setCreateddate(createddate);
			r.setUpdateddate(updateddate);
		}
		if (vo.getId() > 0) {
			r.addDetail(vo);
		}
		addResolution(r);
	}

	public ArrayList<ResolutionVO> array() {
		Collection<ResolutionVO> values = resolutions.values();
		return new ArrayList<ResolutionVO>(values);
	}

}






















