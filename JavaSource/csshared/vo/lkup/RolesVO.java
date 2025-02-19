package csshared.vo.lkup;

import java.util.ArrayList;
import java.util.HashMap;

import alain.core.utils.Operator;

public class RolesVO {

	public ArrayList<String> create = new ArrayList<String>();
	public ArrayList<String> read = new ArrayList<String>();
	public ArrayList<String> update = new ArrayList<String>();
	public ArrayList<String> delete = new ArrayList<String>();
	public HashMap<String, String> requirepublic = new HashMap<String, String>();
	public boolean empty = true;
	public boolean createempty = true;
	public boolean readempty = true;
	public boolean updateempty = true;
	public boolean deleteempty = true;
	public boolean pubcreate = false;
	public boolean pubread = false;
	public boolean pubupdate = false;
	public boolean pubdelete = false;
	public boolean pubcreatepublic = true;
	public boolean pubreadpublic = true;
	public boolean pubupdatepublic = true;
	public boolean pubdeletepublic = true;

	public RolesVO() { }

	public ArrayList<String> getCreate() {
		return create;
	}

	public void setCreate(ArrayList<String> create) {
		this.create = create;
	}

	public void addCreate(String create) {
		this.create.add(create);
	}

	public ArrayList<String> getRead() {
		return read;
	}

	public void setRead(ArrayList<String> read) {
		this.read = read;
	}

	public void addRead(String read) {
		this.read.add(read);
	}

	public ArrayList<String> getUpdate() {
		return update;
	}

	public void setUpdate(ArrayList<String> update) {
		this.update = update;
	}

	public void addUpdate(String update) {
		this.update.add(update);
	}

	public ArrayList<String> getDelete() {
		return delete;
	}

	public void setDelete(ArrayList<String> delete) {
		this.delete = delete;
	}

	public void addDelete(String delete) {
		this.delete.add(delete);
	}

	public boolean createAccess(String roles, String nonpublicroles) {
		return createAccess(Operator.split(roles, ","), Operator.split(nonpublicroles, ","));
	}

	public boolean createAccess(String[] roles, String[] nonpublicroles) {
		return createAccess(roles, nonpublicroles, true);
	}

	public boolean createAccess(String[] roles, String[] nonpublicroles, boolean pblc) {
		if (isPubcreate()) {
			if (!pblc && isPubcreatepublic()) {
				return false;
			}
			else {
				return true;
			}
		}
		if (roles.length < 1) { return false; }
		if (isCreateempty() && isReadempty() && isUpdateempty() && isDeleteempty() && isEmpty() && nonpublicroles.length > 0) { return true; }
		if (create.size() < 1) { return false; }
		for (int c=0; c<create.size(); c++) {
			String crole = create.get(c);
			for (int r=0; r<roles.length; r++) {
				String role = roles[r];
				if (role.equalsIgnoreCase("ADMIN")) { return true; }
				if (Operator.equalsIgnoreCase(crole, role)) {
					if (!pblc && isRequirePublic(role)) {
						return false;
					}
					else {
						return true;
					}
				}
			}
		}
		return false;
	}

	public boolean readAccess(String roles, String nonpublicroles) {
		return readAccess(Operator.split(roles, ","), Operator.split(nonpublicroles, ","));
	}

	public boolean readAccess(String[] roles, String[] nonpublicroles) {
		return readAccess(roles, nonpublicroles, true);
	}

	public boolean readAccess(String[] roles, String[] nonpublicroles, boolean pblc) {
		if (isPubread()) {
			if (!pblc && isPubreadpublic()) {
				return false;
			}
			else {
				return true;
			}
		}
		if (roles.length < 1) { return false; }
		if (isCreateempty() && isReadempty() && isUpdateempty() && isDeleteempty() && isEmpty() && nonpublicroles.length > 0) { return true; }
		if (read.size() < 1) { return false; }
		for (int c=0; c<read.size(); c++) {
			String crole = read.get(c);
			for (int r=0; r<roles.length; r++) {
				String role = roles[r];
				if (role.equalsIgnoreCase("ADMIN")) { return true; }
				if (Operator.equalsIgnoreCase(crole, role)) {
					if (!pblc && isRequirePublic(role)) {
						return false;
					}
					else {
						return true;
					}
				}
			}
		}
		return false;
	}

	public boolean updateAccess(String roles, String nonpublicroles) {
		return updateAccess(Operator.split(roles, ","), Operator.split(nonpublicroles, ","));
	}

	public boolean updateAccess(String[] roles, String[] nonpublicroles) {
		return updateAccess(roles, nonpublicroles, true);
	}

	public boolean updateAccess(String[] roles, String[] nonpublicroles, boolean pblc) {
		if (isPubupdate()) {
			if (!pblc && isPubupdatepublic()) {
				return false;
			}
			else {
				return true;
			}
		}
		if (roles.length < 1) { return false; }
		if (isCreateempty() && isReadempty() && isUpdateempty() && isDeleteempty() && isEmpty() && nonpublicroles.length > 0) { return true; }
		if (update.size() < 1) { return false; }
		for (int c=0; c<update.size(); c++) {
			String crole = update.get(c);
			for (int r=0; r<roles.length; r++) {
				String role = roles[r];
				if (role.equalsIgnoreCase("ADMIN")) { return true; }
				if (Operator.equalsIgnoreCase(crole, role)) {
					if (!pblc && isRequirePublic(role)) {
						return false;
					}
					else {
						return true;
					}
				}
			}
		}
		return false;
	}

	public boolean deleteAccess(String roles, String nonpublicroles) {
		return deleteAccess(Operator.split(roles, ","), Operator.split(nonpublicroles, ","));
	}

	public boolean deleteAccess(String[] roles, String[] nonpublicroles) {
		return deleteAccess(roles, nonpublicroles, true);
	}

	public boolean deleteAccess(String[] roles, String[] nonpublicroles, boolean pblc) {
		if (isPubdelete()) {
			if (!pblc && isPubdeletepublic()) {
				return false;
			}
			else {
				return true;
			}
		}
		if (roles.length < 1) { return false; }
		if (isCreateempty() && isReadempty() && isUpdateempty() && isDeleteempty() && isEmpty() && nonpublicroles.length > 0) { return true; }
		if (delete.size() < 1) { return false; }
		for (int c=0; c<delete.size(); c++) {
			String crole = delete.get(c);
			for (int r=0; r<roles.length; r++) {
				String role = roles[r];
				if (role.equalsIgnoreCase("ADMIN")) { return true; }
				if (Operator.equalsIgnoreCase(crole, role)) {
					if (!pblc && isRequirePublic(role)) {
						return false;
					}
					else {
						return true;
					}
				}
			}
		}
		return false;
	}

	public HashMap<String, String> getRequirepublic() {
		return requirepublic;
	}

	public void setRequirepublic(HashMap<String, String> requirepublic) {
		this.requirepublic = requirepublic;
	}

	public void requirePublic(String role) {
		this.requirepublic.put(role, "Y");
	}

	public boolean isRequirePublic(String role) {
		String r = this.requirepublic.get(role);
		return Operator.equalsIgnoreCase(r, "Y");
	}

	public boolean isEmpty() {
		return empty;
	}

	public void setEmpty(boolean empty) {
		this.empty = empty;
	}

	public boolean isCreateempty() {
		return createempty;
	}

	public void setCreateempty(boolean createempty) {
		this.createempty = createempty;
	}

	public boolean isReadempty() {
		return readempty;
	}

	public void setReadempty(boolean readempty) {
		this.readempty = readempty;
	}

	public boolean isUpdateempty() {
		return updateempty;
	}

	public void setUpdateempty(boolean updateempty) {
		this.updateempty = updateempty;
	}

	public boolean isDeleteempty() {
		return deleteempty;
	}

	public void setDeleteempty(boolean deleteempty) {
		this.deleteempty = deleteempty;
	}

	public boolean isPubcreate() {
		return pubcreate;
	}

	public void setPubcreate(boolean pubcreate) {
		this.pubcreate = pubcreate;
	}

	public boolean isPubread() {
		if (isPubcreate()) { return true; }
		if (isPubupdate()) { return true; }
		if (isPubdelete()) { return true; }
		return pubread;
	}

	public void setPubread(boolean pubread) {
		this.pubread = pubread;
	}

	public boolean isPubupdate() {
		return pubupdate;
	}

	public void setPubupdate(boolean pubupdate) {
		this.pubupdate = pubupdate;
	}

	public boolean isPubdelete() {
		return pubdelete;
	}

	public void setPubdelete(boolean pubdelete) {
		this.pubdelete = pubdelete;
	}

	public boolean isPubcreatepublic() {
		return pubcreatepublic;
	}

	public void setPubcreatepublic(boolean pubcreatepublic) {
		this.pubcreatepublic = pubcreatepublic;
	}

	public boolean isPubreadpublic() {
		return pubreadpublic;
	}

	public void setPubreadpublic(boolean pubreadpublic) {
		this.pubreadpublic = pubreadpublic;
	}

	public boolean isPubupdatepublic() {
		return pubupdatepublic;
	}

	public void setPubupdatepublic(boolean pubupdatepublic) {
		this.pubupdatepublic = pubupdatepublic;
	}

	public boolean isPubdeletepublic() {
		return pubdeletepublic;
	}

	public void setPubdeletepublic(boolean pubdeletepublic) {
		this.pubdeletepublic = pubdeletepublic;
	}






}
