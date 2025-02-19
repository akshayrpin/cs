 package csshared.vo;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class PeopleVO {

	public int id = -1;
	public int userid = -1;
	public String address = "";
	public String city = "";
	public String state = "";
	public String zip = "";
	public String zip4 = "";
	public String workphone = "";
	public String cell = "";
	public String comments = "";
	public String license = "";
	public String licensetype = "";
	public int licensetypeid = -1;
	public String licenseexpiration = "";

	public PeopleVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getZip4() {
		return zip4;
	}

	public void setZip4(String zip4) {
		this.zip4 = zip4;
	}

	public String getWorkphone() {
		return workphone;
	}

	public void setWorkphone(String workphone) {
		this.workphone = workphone;
	}

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getLicensetype() {
		return licensetype;
	}

	public void setLicensetype(String licensetype) {
		this.licensetype = licensetype;
	}

	public int getLicensetypeid() {
		return licensetypeid;
	}

	public void setLicensetypeid(int licensetypeid) {
		this.licensetypeid = licensetypeid;
	}

	public String getLicenseexpiration() {
		return licenseexpiration;
	}

	public Timekeeper getLicenseExpirationDate() {
		Timekeeper d = new Timekeeper();
		if (Operator.hasValue(getLicenseexpiration())) {
			d.setDate(getLicenseexpiration());
		}
		return d;
	}

	public void setLicenseexpiration(String licenseexpiration) {
		this.licenseexpiration = licenseexpiration;
	}











}






















