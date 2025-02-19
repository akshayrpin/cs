package csshared.vo;

import alain.core.utils.Operator;




public class AddressVO {

	public int lsoid = 0;
	public String lsoidfield = "";

	public int strno = 0;
	public String strnofield = "";

	public String strmod = "";
	public String strmodfield = "";

	public String predir = "";
	public String predirfield = "";

	public String strname = "";
	public String strnamefield = "";

	public String strtype = "";
	public String strtypefield = "";

	public String unit = "";
	public String unitfield = "";

	public String city = "";
	public String cityfield = "";

	public String state = "";
	public String statefield = "";

	public String zip = "";
	public String zipfield = "";

	public AddressVO() { }

	public int getLsoid() {
		return lsoid;
	}

	public void setLsoid(int lsoid) {
		this.lsoid = lsoid;
	}

	public String getLsoidfield() {
		return lsoidfield;
	}

	public void setLsoidfield(String lsoidfield) {
		this.lsoidfield = lsoidfield;
	}

	public int getStrno() {
		return strno;
	}

	public void setStrno(int strno) {
		this.strno = strno;
	}

	public String getStrnofield() {
		return strnofield;
	}

	public void setStrnofield(String strnofield) {
		this.strnofield = strnofield;
	}

	public String getStrmod() {
		return strmod;
	}

	public void setStrmod(String strmod) {
		this.strmod = strmod;
	}

	public String getStrmodfield() {
		return strmodfield;
	}

	public void setStrmodfield(String strmodfield) {
		this.strmodfield = strmodfield;
	}

	public String getPredir() {
		return predir;
	}

	public void setPredir(String predir) {
		this.predir = predir;
	}

	public String getPredirfield() {
		return predirfield;
	}

	public void setPredirfield(String predirfield) {
		this.predirfield = predirfield;
	}

	public String getStrname() {
		return strname;
	}

	public void setStrname(String strname) {
		this.strname = strname;
	}

	public String getStrnamefield() {
		return strnamefield;
	}

	public void setStrnamefield(String strnamefield) {
		this.strnamefield = strnamefield;
	}

	public String getStrtype() {
		return strtype;
	}

	public void setStrtype(String strtype) {
		this.strtype = strtype;
	}

	public String getStrtypefield() {
		return strtypefield;
	}

	public void setStrtypefield(String strtypefield) {
		this.strtypefield = strtypefield;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getUnitfield() {
		return unitfield;
	}

	public void setUnitfield(String unitfield) {
		this.unitfield = unitfield;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCityfield() {
		return cityfield;
	}

	public void setCityfield(String cityfield) {
		this.cityfield = cityfield;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getStatefield() {
		return statefield;
	}

	public void setStatefield(String statefield) {
		this.statefield = statefield;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getZipfield() {
		return zipfield;
	}

	public void setZipfield(String zipfield) {
		this.zipfield = zipfield;
	}

	public String address() {
		StringBuilder sb = new StringBuilder();
		if (getStrno() > 0) {
			sb.append(getStrno());
			if (Operator.hasValue(getStrmod())) {
				sb.append(" ").append(getStrmod());
			}
			if (Operator.hasValue(getPredir())) {
				sb.append(" ").append(getPredir());
			}
			sb.append(" ").append(getStrname());
			if (Operator.hasValue(getStrtype())) {
				sb.append(" ").append(getStrtype());
			}
			if (Operator.hasValue(getUnit())) {
				sb.append(" ").append(getUnit());
			}
		}
		return sb.toString();
	}

	




}
