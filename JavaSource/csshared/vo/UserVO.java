 package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;

import alain.core.utils.Operator;


public class UserVO {

	public int id = -1;
	public String username = "";
	public int userid = -1;
	public String firstname = "";
	public String middlename = "";
	public String lastname = "";
	public String email = "";
	public String type = "";
	public HashMap<String, PeopleVO> people = new HashMap<String, PeopleVO>();
	public HashMap<String, StaffVO> staff = new HashMap<String, StaffVO>();

	public UserVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getMiddlename() {
		return middlename;
	}

	public void setMiddlename(String middlename) {
		this.middlename = middlename;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public HashMap<String, PeopleVO> getPeopleMap() {
		return people;
	}

	public ArrayList<PeopleVO> getPeople() {
		try {
			return new ArrayList<PeopleVO>(people.values());
		} catch (Exception e) { return new ArrayList<PeopleVO>(); }
	}

	public void setPeople(HashMap<String, PeopleVO> people) {
		this.people = people;
	}

	public PeopleVO getPeople(int id) {
		return getPeople(Operator.toString(id));
	}

	public PeopleVO getPeople(String id) {
		PeopleVO vo = new PeopleVO();
		try {
			vo = people.get(id);
			if (vo == null) { vo = new PeopleVO(); }
		}
		catch (Exception e) {
			vo = new PeopleVO();
		}
		return vo;
	}

	public void addPeople(PeopleVO p) {
		people.put(Operator.toString(p.getId()), p);
	}

	public HashMap<String, StaffVO> getStaffMap() {
		return staff;
	}

	public ArrayList<StaffVO> getStaff() {
		try {
			return new ArrayList<StaffVO>(staff.values());
		} catch (Exception e) { return new ArrayList<StaffVO>(); }
	}

	public void setStaff(HashMap<String, StaffVO> staff) {
		this.staff = staff;
	}

	public StaffVO getStaff(int id) {
		return getStaff(Operator.toString(id));
	}

	public StaffVO getStaff(String id) {
		StaffVO vo = new StaffVO();
		try {
			vo = staff.get(id);
			if (vo == null) { vo = new StaffVO(); }
		}
		catch (Exception e) {
			vo = new StaffVO();
		}
		return vo;
	}

	public void addStaff(StaffVO s) {
		staff.put(Operator.toString(s.getId()), s);
	}














}






















