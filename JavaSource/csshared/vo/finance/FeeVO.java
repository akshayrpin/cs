package csshared.vo.finance;

import alain.core.utils.Operator;




public class FeeVO {

	public int reffeeformulaid = -1;
	public int feeid = -1;
	public String name = "";
	public String description = "";
	public String createdBy = "";
	public String createdDate = "";
	public String startdate = "";
	public String expdate = "";
	public int formulaId = -1;
	public String formula = "";
	public String modifiedformula = "";
	public String account = "";
	
	public double input1 = 0;
	public double input2 = 0;
	public double input3 = 0;
	public double input4 = 0;
	public double input5 = 0;
	public double factor = 0;
	
	public int inputtype1 = 0;
	public int inputtype2 = 0;
	public int inputtype3 = 0;
	public int inputtype4 = 0;
	public int inputtype5 = 0;
	
	public String inputtypedesc1 = "";
	public String inputtypedesc2 = "";
	public String inputtypedesc3 = "";
	public String inputtypedesc4 = "";
	public String inputtypedesc5 = "";
	
	public String inputtypelabel1 = "";
	public String inputtypelabel2 = "";
	public String inputtypelabel3 = "";
	public String inputtypelabel4 = "";
	public String inputtypelabel5 = "";
	
	
	public String inputeditable1 = "";
	public String inputeditable2 = "";
	public String inputeditable3 = "";
	public String inputeditable4 = "";
	public String inputeditable5 = "";
	
	public String required = "N";
	
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	public double inputamount = 0.00;
	
	
	public int groupid = 0;
	public String group = "";
	
	public String feedate = "";
	public String json = "";
	
	public int statementdetailid = 0;
	public int statementid = 0;
	
	public int paymentid = 0;
	public int paymentdetailid = 0;
	
	public int revpaymentid = 0;
	public int revpaymentdetailid = 0;
	
	public String combined="";
	
	public String active="";
	
	public int financemapid = 0;
	public String accountnumber = "";
	public String keycode = "";
	public String budgetunit = "";
	public String fund = "";
	
	public int parentId = 0;
	public String edit = "";
	public double valuation = 0.00;
	
	public FeeVO() {}

	public int getRevpaymentid() {
		return revpaymentid;
	}

	public void setRevpaymentid(int revpaymentid) {
		this.revpaymentid = revpaymentid;
	}

	public int getRevpaymentdetailid() {
		return revpaymentdetailid;
	}

	public void setRevpaymentdetailid(int revpaymentdetailid) {
		this.revpaymentdetailid = revpaymentdetailid;
	}

	public int getFeeid() {
		return feeid;
	}

	public void setFeeid(int feeid) {
		this.feeid = feeid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getExpdate() {
		return expdate;
	}

	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}

	public int getFormulaId() {
		return formulaId;
	}

	public void setFormulaId(int formulaId) {
		this.formulaId = formulaId;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public double getInput1() {
		return input1;
	}

	public void setInput1(double input1) {
		this.input1 = input1;
	}

	public double getInput2() {
		return input2;
	}

	public void setInput2(double input2) {
		this.input2 = input2;
	}

	public double getInput3() {
		return input3;
	}

	public void setInput3(double input3) {
		this.input3 = input3;
	}

	public double getInput4() {
		return input4;
	}

	public void setInput4(double input4) {
		this.input4 = input4;
	}

	public double getInput5() {
		return input5;
	}

	public void setInput5(double input5) {
		this.input5 = input5;
	}
	
	

	public double getFactor() {
		return factor;
	}

	public void setFactor(double factor) {
		this.factor = factor;
	}

	public int getInputtype1() {
		return inputtype1;
	}

	public void setInputtype1(int inputtype1) {
		this.inputtype1 = inputtype1;
	}

	public int getInputtype2() {
		return inputtype2;
	}

	public void setInputtype2(int inputtype2) {
		this.inputtype2 = inputtype2;
	}

	public int getInputtype3() {
		return inputtype3;
	}

	public void setInputtype3(int inputtype3) {
		this.inputtype3 = inputtype3;
	}

	public int getInputtype4() {
		return inputtype4;
	}

	public void setInputtype4(int inputtype4) {
		this.inputtype4 = inputtype4;
	}

	public int getInputtype5() {
		return inputtype5;
	}

	public void setInputtype5(int inputtype5) {
		this.inputtype5 = inputtype5;
	}

	public String getInputtypedesc1() {
		return inputtypedesc1;
	}

	public void setInputtypedesc1(String inputtypedesc1) {
		this.inputtypedesc1 = inputtypedesc1;
	}

	public String getInputtypedesc2() {
		return inputtypedesc2;
	}

	public void setInputtypedesc2(String inputtypedesc2) {
		this.inputtypedesc2 = inputtypedesc2;
	}

	public String getInputtypedesc3() {
		return inputtypedesc3;
	}

	public void setInputtypedesc3(String inputtypedesc3) {
		this.inputtypedesc3 = inputtypedesc3;
	}

	public String getInputtypedesc4() {
		return inputtypedesc4;
	}

	public void setInputtypedesc4(String inputtypedesc4) {
		this.inputtypedesc4 = inputtypedesc4;
	}

	public String getInputtypedesc5() {
		return inputtypedesc5;
	}

	public void setInputtypedesc5(String inputtypedesc5) {
		this.inputtypedesc5 = inputtypedesc5;
	}



	public String getInputtypelabel1() {
		return inputtypelabel1;
	}

	public void setInputtypelabel1(String inputtypelabel1) {
		this.inputtypelabel1 = inputtypelabel1;
	}

	public String getInputtypelabel2() {
		return inputtypelabel2;
	}

	public void setInputtypelabel2(String inputtypelabel2) {
		this.inputtypelabel2 = inputtypelabel2;
	}

	public String getInputtypelabel3() {
		return inputtypelabel3;
	}

	public void setInputtypelabel3(String inputtypelabel3) {
		this.inputtypelabel3 = inputtypelabel3;
	}

	public String getInputtypelabel4() {
		return inputtypelabel4;
	}

	public void setInputtypelabel4(String inputtypelabel4) {
		this.inputtypelabel4 = inputtypelabel4;
	}

	public String getInputtypelabel5() {
		return inputtypelabel5;
	}

	public void setInputtypelabel5(String inputtypelabel5) {
		this.inputtypelabel5 = inputtypelabel5;
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public boolean isRequired() {
		return getRequired().equalsIgnoreCase("Y");
	}

	public String getFormula() {
		return formula;
	}

	public void setFormula(String formula) {
		this.formula = formula;
	}
	
	

	public String getModifiedformula() {
		return modifiedformula;
	}

	public void setModifiedformula(String modifiedformula) {
		this.modifiedformula = modifiedformula;
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

	public String getFeedate() {
		return feedate;
	}

	public void setFeedate(String feedate) {
		this.feedate = feedate;
	}
	
	
	
	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}

	public int getStatementdetailid() {
		return statementdetailid;
	}

	public void setStatementdetailid(int statementdetailid) {
		this.statementdetailid = statementdetailid;
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

	public int getStatementid() {
		return statementid;
	}

	public void setStatementid(int statementid) {
		this.statementid = statementid;
	}

	public int getPaymentid() {
		return paymentid;
	}

	public void setPaymentid(int paymentid) {
		this.paymentid = paymentid;
	}

	public int getPaymentdetailid() {
		return paymentdetailid;
	}

	public void setPaymentdetailid(int paymentdetailid) {
		this.paymentdetailid = paymentdetailid;
	}

	public int getReffeeformulaid() {
		return reffeeformulaid;
	}

	public void setReffeeformulaid(int reffeeformulaid) {
		this.reffeeformulaid = reffeeformulaid;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	public boolean isActive(){
		return Operator.equalsIgnoreCase(getActive(), "Y");
	}

	public int getFinancemapid() {
		return financemapid;
	}

	public void setFinancemapid(int financemapid) {
		this.financemapid = financemapid;
	}

	public String getAccountnumber() {
		return accountnumber;
	}

	public void setAccountnumber(String accountnumber) {
		this.accountnumber = accountnumber;
	}

	public String getKeycode() {
		return keycode;
	}

	public void setKeycode(String keycode) {
		this.keycode = keycode;
	}

	public String getBudgetunit() {
		return budgetunit;
	}

	public void setBudgetunit(String budgetunit) {
		this.budgetunit = budgetunit;
	}

	public String getFund() {
		return fund;
	}

	public void setFund(String fund) {
		this.fund = fund;
	}

	public String getInputeditable1() {
		return inputeditable1;
	}

	public void setInputeditable1(String inputeditable1) {
		this.inputeditable1 = inputeditable1;
	}

	public String getInputeditable2() {
		return inputeditable2;
	}

	public void setInputeditable2(String inputeditable2) {
		this.inputeditable2 = inputeditable2;
	}

	public String getInputeditable3() {
		return inputeditable3;
	}

	public void setInputeditable3(String inputeditable3) {
		this.inputeditable3 = inputeditable3;
	}

	public String getInputeditable4() {
		return inputeditable4;
	}

	public void setInputeditable4(String inputeditable4) {
		this.inputeditable4 = inputeditable4;
	}

	public String getInputeditable5() {
		return inputeditable5;
	}

	public void setInputeditable5(String inputeditable5) {
		this.inputeditable5 = inputeditable5;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getEdit() {
		return edit;
	}

	public void setEdit(String edit) {
		this.edit = edit;
	}

	public double getValuation() {
		return valuation;
	}

	public void setValuation(double valuation) {
		this.valuation = valuation;
	}
	
	
	
}
