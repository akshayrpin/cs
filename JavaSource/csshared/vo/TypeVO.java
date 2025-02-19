 package csshared.vo;

import java.util.HashMap;

import csshared.vo.finance.DepositCreditVO;
import csshared.vo.finance.PaymentVO;
import csshared.vo.finance.StatementVO;
import csshared.vo.lkup.RolesVO;
import alain.core.utils.Operator;


public class TypeVO {

	public int typeid = -1;
	public String type = "";
	public String title = "";
	public String subtitle = "";
	public String hold = "";
	public String status = "";
	public String entity = "";
	public int entityid = -1;
	public HashMap<String, String[]> modules = new HashMap<String, String[]>();
	public HashMap<String, String> data = new HashMap<String, String>();
	public ObjGroupVO[] groups = new ObjGroupVO[0];
	public ToolsVO tools = new ToolsVO();
	public StatementVO[] statements = new StatementVO[0];
	public double amount = 0.00;
	public double paidamount = 0.00;
	public double balancedue = 0.00;
	public double inputamount = 0.00;
	public PaymentVO[] payment = new PaymentVO[0];
	public DepositCreditVO[] depositcredits = new DepositCreditVO[0];
	public String messagecode = "";
	public String message = "";

	public TypeInfo typeinfo = new TypeInfo();

	public String createddate = "";
	public String updateddate = "";

	public boolean create = false;
	public boolean read = true;
	public boolean update = false;
	public boolean delete = false;
	public boolean admin = false;

	public int cartId = -1;
	
	public TypeVO() {}

	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public void setId(int typeid) {
		this.typeid = typeid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
		String r = "";
		if (Operator.hasValue(getHold())) { r = "hold"; }
		else { r = getStatus(); }
		if (Operator.hasValue(r)) {
			r = r.toLowerCase();
		}
		return r;
	}
	public String getHold() {
		return hold;
	}

	public void setHold(String hold) {
		this.hold = hold;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public HashMap<String, String[]> getModules() {
		return modules;
	}

	public String[] getModule(String modulename) {
		return getModules().get(modulename);
	}

	public void setModules(HashMap<String, String[]> modules) {
		this.modules = modules;
	}

	public void setModule(String modulename, String[] modulearray) {
		this.modules.put(modulename, modulearray);
	}

	public HashMap<String, String> getData() {
		return data;
	}

	public String data(String field) {
		return data.get(field);
	}

	public void setData(HashMap<String, String> data) {
		this.data = data;
	}

	public void addData(String field, String value) {
		this.data.put(field, value);
	}

	public ObjGroupVO[] getGroups() {
		return groups;
	}
	public ObjGroupVO getFirstGroup() {
		ObjGroupVO vo = new ObjGroupVO();
		if (Operator.hasValue(getGroups()) && getGroups().length > 0) {
			vo = getGroups()[0];
		}
		return vo;
	}
	public void setGroups(ObjGroupVO[] groups) {
		this.groups = groups;
	}

	public ToolsVO getTools() {
		return tools;
	}

	public void setTools(ToolsVO tools) {
		this.tools = tools;
	}
	

	public StatementVO[] getStatements() {
		return statements;
	}

	public void setStatements(StatementVO[] statements) {
		this.statements = statements;
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

	public PaymentVO[] getPayment() {
		return payment;
	}

	public void setPayment(PaymentVO[] payment) {
		this.payment = payment;
	}

	public DepositCreditVO[] getDepositcredits() {
		return depositcredits;
	}

	public void setDepositcredits(DepositCreditVO[] depositcredits) {
		this.depositcredits = depositcredits;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getMessagecode() {
		return messagecode;
	}

	public void setMessagecode(String messagecode) {
		this.messagecode = messagecode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public TypeInfo getTypeinfo() {
		return typeinfo;
	}

	public void setTypeinfo(TypeInfo typeinfo) {
		this.typeinfo = typeinfo;
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

	public boolean isCreate() {
		if (isAdmin()) { return true; }
		return create;
	}

	public void setCreate(boolean create) {
		this.create = create;
	}

	public boolean isRead() {
		if (isAdmin()) { return true; }
		if (isCreate()) { return true; }
		if (isUpdate()) { return true; }
		if (isDelete()) { return true; }
		return read;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public boolean isUpdate() {
		if (isAdmin()) { return true; }
		return update;
	}

	public void setUpdate(boolean update) {
		this.update = update;
	}

	public boolean isDelete() {
		if (isAdmin()) { return true; }
		return delete;
	}

	public void setDelete(boolean delete) {
		this.delete = delete;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean admin) {
		if (admin) {
			setAdmin(true);
			setCreate(true);
			setRead(true);
			setUpdate(true);
			setDelete(true);
		}
		else {
			setCreate(vo.createAccess(userroles, nonpublicroles));
			setRead(vo.readAccess(userroles, nonpublicroles));
			setUpdate(vo.updateAccess(userroles, nonpublicroles));
			setDelete(vo.deleteAccess(userroles, nonpublicroles));
		}
	}
	
	public void putRoles(RolesVO vo, String[] userroles, String[] nonpublicroles, boolean admin, boolean issued) {
		if (admin) {
			setAdmin(true);
			setCreate(true);
			setRead(true);
			setUpdate(true);
			setDelete(true);
		}
		else {
			setCreate(vo.createAccess(userroles, nonpublicroles, issued));
			setRead(vo.readAccess(userroles, nonpublicroles, issued));
			setUpdate(vo.updateAccess(userroles, nonpublicroles, issued));
			setDelete(vo.deleteAccess(userroles, nonpublicroles, issued));
		}
	}
	
	
	


}
