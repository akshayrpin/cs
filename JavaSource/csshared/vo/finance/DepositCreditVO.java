package csshared.vo.finance;

import csshared.vo.SubObjVO;


public class DepositCreditVO {

	public int id = 0;
	public int type = 0;
	public double amount = 0.00;
	public double currentamount = 0.00;
	public int parentid = 0;
	public int paymentid = 0;
	public String comment = "";
	public String createdby = "";
	public String createddate = "";
	public String updateddate = "";
	public String updatedby = "";
	public String typename = "";
	public String level = "";
	public SubObjVO[] types = new SubObjVO[0];
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getCurrentamount() {
		return currentamount;
	}
	public void setCurrentamount(double currentamount) {
		this.currentamount = currentamount;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public int getPaymentid() {
		return paymentid;
	}
	public void setPaymentid(int paymentid) {
		this.paymentid = paymentid;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
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
	public String getUpdatedby() {
		return updatedby;
	}
	public void setUpdatedby(String updatedby) {
		this.updatedby = updatedby;
	}
	
	
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	
	public SubObjVO[] getTypes() {
		return types;
	}
	public void setTypes(SubObjVO[] types) {
		this.types = types;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	
	
	
	
	
	
	



}
