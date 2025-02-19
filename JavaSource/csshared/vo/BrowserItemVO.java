 package csshared.vo;

import java.util.ArrayList;

import alain.core.utils.Operator;


public class BrowserItemVO {

	public String dataid = "";
	public String id = "";
	public String title = "";
	public String description = "";
	public int children = 0;
	public String child = "";
	public String sub = "";
	public String link = "";
	public String entity = "";
	public String type = "";
	public String domain = "";
	public boolean expired = false;
	public ArrayList<String> alerts = new ArrayList<String>(); 

	public BrowserItemVO() { }

	public String getDataid() {
		return dataid;
	}

	public void setDataid(String dataid) {
		this.dataid = dataid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getChildren() {
		return children;
	}

	public void setChildren(int children) {
		this.children = children;
	}

	public String getChild() {
		return child;
	}

	public void setChild(String child) {
		this.child = child;
	}

	public String getSub() {
		return sub;
	}

	public void setSub(String sub) {
		this.sub = sub;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
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

	public boolean isExpired() {
		return expired;
	}

	public void setExpired(boolean expired) {
		this.expired = expired;
	}

	public ArrayList<String> getAlerts() {
		return alerts;
	}

	public void setAlerts(ArrayList<String> alerts) {
		this.alerts = alerts;
	}

	public void addAlert(String alert) {
		this.alerts.add(alert);
	}

	public String joinAlerts(String prefix) {
		return joinAlerts(prefix, " ");
	}

	public String joinAlerts(String prefix, String delimiter) {
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		int size = getAlerts().size();
		for (int i=0; i<size; i++) {
			if (!empty) {
				sb.append(delimiter);
			}
			if (Operator.hasValue(prefix)) {
				sb.append(prefix);
			}
			sb.append(getAlerts().get(i));
		}
		return sb.toString();
	}





}




