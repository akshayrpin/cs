package csshared.vo.finance;




public class FeesGroupVO {

	public int groupid = 0;
	public String group = "";
	public FeeVO[] fees = new FeeVO[0];
	
	
	public double reviewAmount = 0.00;
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	public double inputamount = 0.00;
	
	public int statementid = 0;
	
	public String combined="";
	
	public String highlight = "";
	public int feeslengthwithbalancedue = 0;
	
	
	public String start = "";
	public String expired = "";
	
	
	public FeesGroupVO() {}

	
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

	public FeeVO[] getFees() {
		return fees;
	}

	public void setFees(FeeVO[] fees) {
		this.fees = fees;
	}
	
	public double getReviewAmount() {
		return reviewAmount;
	}

	public void setReviewAmount(double reviewAmount) {
		this.reviewAmount = reviewAmount;
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

	
	
	public int getStatementid() {
		return statementid;
	}



	public void setStatementid(int statementid) {
		this.statementid = statementid;
	}


	public double getInputamount() {
		return inputamount;
	}


	public void setInputamount(double inputamount) {
		this.inputamount = inputamount;
	}


	public String getCombined() {
		return combined;
	}


	public void setCombined(String combined) {
		this.combined = combined;
	}


	public String getStart() {
		return start;
	}


	public void setStart(String start) {
		this.start = start;
	}


	public String getExpired() {
		return expired;
	}


	public void setExpired(String expired) {
		this.expired = expired;
	}


	




}
