package csshared.vo;

import java.util.HashMap;


public class BrowserHeaderVO {

	public HashMap<String, String> parents = new HashMap<String, String>();
	public BrowserSearchVO search = new BrowserSearchVO();
	public String dataid = "";
	public String follow = "";
	public String[] options = new String[0];
	public String label = "";
	public String menu = "";
	public String entity = "";
	public String type = "";
	public String domain = "";
	public int found = 0;
	public int querytime = 0;
	public int status = 0;
	public String query = "";
	public String message = "";
	public String option = "";

	public BrowserHeaderVO() { }

	public HashMap<String, String> getParents() {
		return parents;
	}

	public void setParents(HashMap<String, String> parents) {
		this.parents = parents;
	}

	public void addParent(String id, String type) {
		this.parents.put(id, type);
	}

	public BrowserSearchVO getSearch() {
		return search;
	}

	public void setSearch(BrowserSearchVO search) {
		this.search = search;
	}

	public String getDataid() {
		return dataid;
	}

	public void setDataid(String dataid) {
		this.dataid = dataid;
	}

	public String getFollow() {
		return follow;
	}

	public void setFollow(String follow) {
		this.follow = follow;
	}

	public String[] getOptions() {
		return options;
	}

	public void setOptions(String[] options) {
		this.options = options;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public int getFound() {
		return found;
	}

	public void setFound(int found) {
		this.found = found;
	}

	public int getQuerytime() {
		return querytime;
	}

	public void setQuerytime(int querytime) {
		this.querytime = querytime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}



}




