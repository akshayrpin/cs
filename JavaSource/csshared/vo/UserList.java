 package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;

import alain.core.utils.Operator;


public class UserList {

	public HashMap<String, UserVO> users = new HashMap<String, UserVO>();

	public UserList() { }

	public ArrayList<UserVO> getUsers() {
		try {
			return new ArrayList<UserVO>(users.values());
		}
		catch (Exception e) {
			return new ArrayList<UserVO>();
		}
	}

	public HashMap<String, UserVO> getUsersMap() {
		return users;
	}

	public void setUsers(HashMap<String, UserVO> users) {
		this.users = users;
	}
	
	public UserVO getUser(int id) {
		return getUser(Operator.toString(id));
	}

	public UserVO getUser(String id) {
		UserVO u = new UserVO();
		try {
			u = users.get(id);
			if (u == null) { u = new UserVO(); }
		}
		catch (Exception e) { u = new UserVO(); }
		return u;
	}

	public void addUser(UserVO u) {
		users.put(Operator.toString(u.getId()), u);
	}









}






















