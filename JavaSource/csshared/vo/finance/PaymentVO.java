package csshared.vo.finance;

import csshared.vo.SubObjVO;




public class PaymentVO {

	public int paymentid = 0;
	public int method = 0;
	public int transactiontype = 0;
	public String paymentdate = "";
	public double amount = 0.00;
	public String number = "";
	public String comment = "";
	
	public int counter = 0;
	
	public int payeeid = 0;
	
	public SubObjVO[] methods = new SubObjVO[0];
	public SubObjVO[] transactiontypes = new SubObjVO[0];
	public SubObjVO[] counters = new SubObjVO[0];
	public SubObjVO[] payees = new SubObjVO[0];
	
	public StatementVO[] statements = new StatementVO[0];
	
	
	public String otherpayeename = "";
	
	public String online = "";
	
	public String onlinetranasactionnumber = "";
	
	public int authorizedby = 0;
	
	public String reversed = "";
	
	
	
	public int revpaymentid = 0;
	public double revamount = 0.00;
	
	public double inputamount = 0.00;
	
	public String combined ="";
	
	public String methodname = "";
	public String transactiontypename = "";
	public String countername = "";
	
	public String auto = "N";
	
	public DepositCreditVO[] depositcredits = new DepositCreditVO[0];

	public int getPaymentid() {
		return paymentid;
	}

	public void setPaymentid(int paymentid) {
		this.paymentid = paymentid;
	}

	public int getMethod() {
		return method;
	}

	public void setMethod(int method) {
		this.method = method;
	}

	public int getTransactiontype() {
		return transactiontype;
	}

	public void setTransactiontype(int transactiontype) {
		this.transactiontype = transactiontype;
	}

	public String getPaymentdate() {
		return paymentdate;
	}

	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getCounter() {
		return counter;
	}

	public void setCounter(int counter) {
		this.counter = counter;
	}

	public SubObjVO[] getMethods() {
		return methods;
	}

	public void setMethods(SubObjVO[] methods) {
		this.methods = methods;
	}

	public SubObjVO[] getTransactiontypes() {
		return transactiontypes;
	}

	public void setTransactiontypes(SubObjVO[] transactiontypes) {
		this.transactiontypes = transactiontypes;
	}

	public SubObjVO[] getCounters() {
		return counters;
	}

	public void setCounters(SubObjVO[] counters) {
		this.counters = counters;
	}

	public StatementVO[] getStatements() {
		return statements;
	}

	public void setStatements(StatementVO[] statements) {
		this.statements = statements;
	}

	public String getOnline() {
		return online;
	}

	public void setOnline(String online) {
		this.online = online;
	}

	public String getOnlinetranasactionnumber() {
		return onlinetranasactionnumber;
	}

	public void setOnlinetranasactionnumber(String onlinetranasactionnumber) {
		this.onlinetranasactionnumber = onlinetranasactionnumber;
	}

	public int getAuthorizedby() {
		return authorizedby;
	}

	public void setAuthorizedby(int authorizedby) {
		this.authorizedby = authorizedby;
	}

	public String getReversed() {
		return reversed;
	}

	public void setReversed(String reversed) {
		this.reversed = reversed;
	}

	public SubObjVO[] getPayees() {
		return payees;
	}

	public void setPayees(SubObjVO[] payees) {
		this.payees = payees;
	}

	public String getOtherpayeename() {
		return otherpayeename;
	}

	public void setOtherpayeename(String otherpayeename) {
		this.otherpayeename = otherpayeename;
	}

	public int getPayeeid() {
		return payeeid;
	}

	public void setPayeeid(int payeeid) {
		this.payeeid = payeeid;
	}

	public String getMethodname() {
		return methodname;
	}

	public void setMethodname(String methodname) {
		this.methodname = methodname;
	}

	public String getTransactiontypename() {
		return transactiontypename;
	}

	public void setTransactiontypename(String transactiontypename) {
		this.transactiontypename = transactiontypename;
	}

	public int getRevpaymentid() {
		return revpaymentid;
	}

	public void setRevpaymentid(int revpaymentid) {
		this.revpaymentid = revpaymentid;
	}

	public String getCombined() {
		return combined;
	}

	public void setCombined(String combined) {
		this.combined = combined;
	}

	public double getRevamount() {
		return revamount;
	}

	public void setRevamount(double revamount) {
		this.revamount = revamount;
	}

	public double getInputamount() {
		return inputamount;
	}

	public void setInputamount(double inputamount) {
		this.inputamount = inputamount;
	}

	public String getCountername() {
		return countername;
	}

	public void setCountername(String countername) {
		this.countername = countername;
	}

	public DepositCreditVO[] getDepositcredits() {
		return depositcredits;
	}

	public void setDepositcredits(DepositCreditVO[] depositcredits) {
		this.depositcredits = depositcredits;
	}

	public String getAuto() {
		return auto;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}
	
	



}
