package csshared.vo.finance;




public class StatementVO {

	public int projectid = 0;
	public int activityid = 0;
	public String projectnumber = "";
	public String activitynumber = "";
	public String projectname = "";
	public String activitytype = "";
	public String activitystatus = "";
	public String address = "";
	
	
	
	public int statementid = 0;
	public String statementnumber = "";
	public String status = "";
	public String comment = "";
	public String expdate = "";
	
	public String createdby = "";
	public String updatedy = "";
	public String createddate = "";
	public String updateddate = "";
	
	public FeesGroupVO[] groups = new FeesGroupVO[0];
	
	public double reviewAmount = 0.00;
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	public double inputamount = 0.00;
	



	public String online = "";
	public String active = "";
	
	public String combined = "";
	
	public int groupslength = 0;
	
	public String searched = "";
	
	public String highlight = "";
	
	public String type = "";
	
	public int groupslengthwithbalancedue = 0;
	public int order = 0;
	
	public StatementVO() {}



	public int getProjectid() {
		return projectid;
	}



	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}



	public int getActivityid() {
		return activityid;
	}



	public void setActivityid(int activityid) {
		this.activityid = activityid;
	}



	public String getProjectnumber() {
		return projectnumber;
	}



	public void setProjectnumber(String projectnumber) {
		this.projectnumber = projectnumber;
	}



	public String getActivitynumber() {
		return activitynumber;
	}



	public void setActivitynumber(String activitynumber) {
		this.activitynumber = activitynumber;
	}



	public String getProjectname() {
		return projectname;
	}



	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}



	public String getActivitytype() {
		return activitytype;
	}



	public void setActivitytype(String activitytype) {
		this.activitytype = activitytype;
	}



	public String getActivitystatus() {
		return activitystatus;
	}



	public void setActivitystatus(String activitystatus) {
		this.activitystatus = activitystatus;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public int getStatementid() {
		return statementid;
	}



	public void setStatementid(int statementid) {
		this.statementid = statementid;
	}



	public String getStatementnumber() {
		return statementnumber;
	}



	public void setStatementnumber(String statementnumber) {
		this.statementnumber = statementnumber;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}



	public String getExpdate() {
		return expdate;
	}



	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}



	public String getCreatedby() {
		return createdby;
	}



	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}



	public String getUpdatedy() {
		return updatedy;
	}



	public void setUpdatedy(String updatedy) {
		this.updatedy = updatedy;
	}



	public String getCreateddate() {
		return createddate;
	}



	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}



	public String getUpdateddate() {
		return updateddate;
	}



	public void setUpdateddate(String updateddate) {
		this.updateddate = updateddate;
	}



	public FeesGroupVO[] getGroups() {
		return groups;
	}



	public void setGroups(FeesGroupVO[] groups) {
		this.groups = groups;
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

	public double getInputamount() {
		return inputamount;
	}



	public void setInputamount(double inputamount) {
		this.inputamount = inputamount;
	}


	public String getOnline() {
		return online;
	}



	public void setOnline(String online) {
		this.online = online;
	}



	public String getActive() {
		return active;
	}



	public void setActive(String active) {
		this.active = active;
	}



	public String getCombined() {
		return combined;
	}



	public void setCombined(String combined) {
		this.combined = combined;
	}



	public int getGroupslength() {
		return groupslength;
	}



	public void setGroupslength(int groupslength) {
		this.groupslength = groupslength;
	}



	public String getSearched() {
		return searched;
	}



	public void setSearched(String searched) {
		this.searched = searched;
	}



	public String getHighlight() {
		return highlight;
	}



	public void setHighlight(String highlight) {
		this.highlight = highlight;
	}



	public int getGroupslengthwithbalancedue() {
		return groupslengthwithbalancedue;
	}



	public void setGroupslengthwithbalancedue(int groupslengthwithbalancedue) {
		this.groupslengthwithbalancedue = groupslengthwithbalancedue;
	}



	public int getOrder() {
		return order;
	}



	public void setOrder(int order) {
		this.order = order;
	}



	public String getType() {
		return type;
	}



	public void setType(String type) {
		this.type = type;
	}



	public double getReviewAmount() {
		return reviewAmount;
	}



	public void setReviewAmount(double reviewAmount) {
		this.reviewAmount = reviewAmount;
	}



	
	
	

	
	

	




}
