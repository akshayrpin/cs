 package csshared.vo.finance;



public class FinanceVO {

	public int typeid = -1;
	public String type = "";
	public int groupid = -1;
	public String group = "";
	public String grouptype = "";
	public FeesGroupVO[] groups = new FeesGroupVO[0];
	public String title = "";
	public String subtitle = "";
	public String alert = "";
	public double valuation = 0;
	
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	
	public String token = "";
	public String entity = "";
	public int entityid = -1;
	public String ip = "";
	
	public FinanceVO() {}


	public int getTypeid() {
		return typeid;
	}


	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	


	public int getGroupid() {
		return groupid;
	}


	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}


	public String getGroup() {
		return group;
	}


	public void setGroup(String group) {
		this.group = group;
	}


	


	public String getGrouptype() {
		return grouptype;
	}


	public void setGrouptype(String grouptype) {
		this.grouptype = grouptype;
	}


	public FeesGroupVO[] getGroups() {
		return groups;
	}


	public void setGroups(FeesGroupVO[] groups) {
		this.groups = groups;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getSubtitle() {
		return subtitle;
	}


	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}


	public String getAlert() {
		return alert;
	}


	public void setAlert(String alert) {
		this.alert = alert;
	}


	public double getValuation() {
		return valuation;
	}


	public void setValuation(double valuation) {
		this.valuation = valuation;
	}


	public double getAmount() {
		return amount;
	}


	public void setAmount(double amount) {
		this.amount = amount;
	}


	public double getPaidamount() {
		return paidamount;
	}


	public void setPaidamount(double paidamount) {
		this.paidamount = paidamount;
	}


	public double getBalancedue() {
		return balancedue;
	}


	public void setBalancedue(double balancedue) {
		this.balancedue = balancedue;
	}


	public String getToken() {
		return token;
	}


	public void setToken(String token) {
		this.token = token;
	}


	public String getEntity() {
		return entity;
	}


	public void setEntity(String entity) {
		this.entity = entity;
	}


	public int getEntityid() {
		return entityid;
	}


	public void setEntityid(int entityid) {
		this.entityid = entityid;
	}


	public String getIp() {
		return ip;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}

	
	
}
