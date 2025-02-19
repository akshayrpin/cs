package csshared.vo;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import alain.core.security.Token;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.utils.RequestMapper;
import csshared.utils.CsConfig;
import csshared.vo.finance.FinanceVO;
import csshared.vo.finance.PaymentVO;
import csshared.vo.finance.StatementVO;

public class RequestVO {

	public String token = "";
	public String entity = "";
	public int entityid = -1;
	public String id = "";
	public String reference = "";
	public String ref = "";
	public int refid = -1;
	public String type = "";
	public int typeid = -1;
	public String group = "";
	public String groupid = "";
	public String grouptype = "";
	public String module = "";
	public String review = "";
	public int reviewgroupid = -1;
	public int reviewid = -1;
	public int reviewrefid = -1;
	public String request = "";
	public String subrequest = "";
	public ObjGroupVO[] data = new ObjGroupVO[0];
	public String ip = "";
	public String username = "";
	public String password = "";
	public String action = "";
	public String search = "";
	public String option = "";
	public String url = "";
	public String app = "";
	public String startdate = "";
	public String enddate = "";
	public boolean viewonly = false;
	public int appttypeid = -1;
	public int apptsubtypeid = -1;
	public int apptstatusid = -1;
	public int start = 0;
	public int end = 1000;
	public HashMap<String, String> extras = new HashMap<String, String>();
	public FinanceVO[] finance = new FinanceVO[0];
	public StatementVO[] statements = new StatementVO[0];
	public PaymentVO payment = new PaymentVO();
	public String processid = "";
	public String source = "";
	
	
	public RequestVO() { }

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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public int getRefid() {
		return refid;
	}

	public void setRefid(int refid) {
		this.refid = refid;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getGroupid() {
		return groupid;
	}

	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}

	public String getGrouptype() {
		return grouptype;
	}

	public void setGrouptype(String grouptype) {
		this.grouptype = grouptype;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getReviewid() {
		return reviewid;
	}

	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}

	public int getReviewrefid() {
		return reviewrefid;
	}

	public void setReviewrefid(int reviewrefid) {
		this.reviewrefid = reviewrefid;
	}

	public int getReviewgroupid() {
		return reviewgroupid;
	}

	public void setReviewgroupid(int reviewgroupid) {
		this.reviewgroupid = reviewgroupid;
	}

	public String getSubgroup() {
		String r = "";
		if (data.length > 0) {
			ObjGroupVO v = data[0];
			r = v.getSubgroup();
		}
		return r;
	}

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}

	public String getSubrequest() {
		return subrequest;
	}

	public void setSubrequest(String subrequest) {
		this.subrequest = subrequest;
	}

	public ObjGroupVO[] getData() {
		return data;
	}

	public void setData(ObjGroupVO[] data) {
		this.data = data;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDomain() {
		return CsConfig.getDomain(getEntity());
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUrl() {
		if (Operator.hasValue(url)) { return url; }
		StringBuilder sb = new StringBuilder();
		String domain = getDomain();

		sb.append(Operator.removeTrailingSlash(domain));
		sb.append("/");
		sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));

		if (getAction().equalsIgnoreCase("login")) {
			sb.append("/auth/login");
		}
		else if (getAction().equalsIgnoreCase("logout")) {
			sb.append("/auth/logout");
		}
		else if (getAction().equalsIgnoreCase("version")) {
			sb.append("/info/version");
		}
		else if (getAction().equalsIgnoreCase("content")) {
			sb.append("/info/content");
		}
		else {
			if(Operator.hasValue(getType())){
				if (Operator.hasValue(getModule())) {
					sb.append("/").append(getModule().toLowerCase());
				}
				else if (!Operator.hasValue(getGrouptype()) || getGrouptype().equalsIgnoreCase("details")) {
					sb.append("/");
					sb.append(getType().toLowerCase());
				}
				else {
					sb.append("/");
					sb.append(getGrouptype().toLowerCase());
				}
				if (Operator.hasValue(getRequest())) {
					sb.append("/");
					sb.append(getRequest().toLowerCase());
					if (Operator.hasValue(getSubrequest())) {
						sb.append("/");
						sb.append(getSubrequest());
					}
				}
				else if (Operator.hasValue(getAction()) && getAction().equalsIgnoreCase("add")) {
					sb.append("/");
					sb.append("fields");
					if (Operator.hasValue(getSubrequest())) {
						sb.append("/");
						sb.append(getSubrequest());
					}
				}
			}
		}

		return sb.toString();
	}

	public String getApp() {
		return app;
	}

	public void setApp(String app) {
		this.app = app;
	}

	public String getToolsUrl() {
		StringBuilder sb = new StringBuilder();
		sb.append(Operator.removeTrailingSlash(getDomain()));
		sb.append("/");
		sb.append(Operator.removeOpeningAndTrailingSlash(CsConfig.getApiPath()));

		if (!Operator.hasValue(getGrouptype()) || getGrouptype().equalsIgnoreCase("details")) {
			sb.append("/");
			sb.append(getType().toLowerCase());
		}
		else {
			sb.append("/");
			sb.append(getGrouptype().toLowerCase());
		}
		if (Operator.hasValue(getRequest())) {
			sb.append("/").append(getRequest());
		}
		else {
			sb.append("/tools");
		}
		return sb.toString();
	}

	public String summaryUrl() {
		StringBuilder sb = new StringBuilder();
		sb.append("summary.jsp?");
		sb.append(RequestMapper.entity).append("=").append(getEntity());
		sb.append("&");
		sb.append(RequestMapper.type).append("=").append(getType());
		sb.append("&");
		sb.append(RequestMapper.id).append("=").append(getTypeid());
		sb.append("&");
		sb.append(RequestMapper.typeid).append("=").append(getTypeid());
		return sb.toString();
	}

	public String actionUrl() {
		StringBuilder sb = new StringBuilder();
		sb.append("summary.jsp?");
		sb.append(RequestMapper.entity).append("=data.entity");
		sb.append("&");
		sb.append(RequestMapper.type).append("=data.type");
		sb.append("&");
		sb.append(RequestMapper.id).append("=").append(getTypeid());
		sb.append("&");
		sb.append(RequestMapper.typeid).append("=data.typeid");
		return sb.toString();
	}

	public String makeString(HashMap<String, String> extras) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			r = mapper.writeValueAsString(this.extras);
		} catch (Exception e) { }
		return r;
	}

	public AvailabilityDateVO makeDateObj(String str) {
		AvailabilityDateVO vo = new AvailabilityDateVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo = mapper.readValue(str, AvailabilityDateVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return vo;
	}

	public RequestVO copy() {
		return duplicate();
	}

	public RequestVO duplicate() {
		RequestVO vo = new RequestVO();
		vo.token = this.token;
		vo.entity = this.entity;
		vo.entityid = this.entityid;
		vo.id = this.id;
		vo.reference = this.reference;
		vo.type = this.type;
		vo.typeid = this.typeid;
		vo.group = this.group;
		vo.groupid = this.groupid;
		vo.grouptype = this.grouptype;
		vo.review = this.review;
		vo.reviewgroupid = this.reviewgroupid;
		vo.reviewid = this.reviewid;
		vo.reviewrefid = this.reviewrefid;

		vo.request = this.request;
		vo.subrequest = this.subrequest;
		vo.ip = this.ip;
		vo.username = this.username;
		vo.password = this.password;
		vo.action = this.action;
		vo.search = this.search;
		vo.option = this.option;
		vo.url = this.url;
		vo.app = this.app;
		vo.startdate = this.startdate;
		vo.enddate = this.enddate;
		vo.viewonly = this.viewonly;
		vo.appttypeid = this.appttypeid;
		vo.apptsubtypeid = this.apptsubtypeid;
		vo.apptstatusid = this.apptstatusid;

		vo.start = this.start;
		vo.end = this.end;

		HashMap<String, String> ex = new HashMap<String, String>();
		for(Map.Entry<String, String> entry : this.extras.entrySet()){
			ex.put(entry.getKey(), entry.getValue());
		}
		vo.extras = ex;

		try {
			ObjectMapper mapper = new ObjectMapper();
			String str = mapper.writeValueAsString(this.data);

			mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo.data = mapper.readValue(str, ObjGroupVO[].class);

		} catch (Exception e) { }

		try {
			ObjectMapper mapper = new ObjectMapper();
			String str = mapper.writeValueAsString(this.finance);

			mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo.finance = mapper.readValue(str, FinanceVO[].class);

		} catch (Exception e) { }

		try {
			ObjectMapper mapper = new ObjectMapper();
			String str = mapper.writeValueAsString(this.statements);

			mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo.statements = mapper.readValue(str, StatementVO[].class);

		} catch (Exception e) { }

		try {
			ObjectMapper mapper = new ObjectMapper();
			String str = mapper.writeValueAsString(this.payment);

			mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo.payment = mapper.readValue(str, PaymentVO.class);

		} catch (Exception e) { }

		return vo;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public boolean isViewonly() {
		return viewonly;
	}

	public void setViewonly(boolean viewonly) {
		this.viewonly = viewonly;
	}

	public int getAppttypeid() {
		return appttypeid;
	}

	public void setAppttypeid(int appttypeid) {
		this.appttypeid = appttypeid;
	}

	public int getApptsubtypeid() {
		return apptsubtypeid;
	}

	public void setApptsubtypeid(int apptsubtypeid) {
		this.apptsubtypeid = apptsubtypeid;
	}

	public int getApptstatusid() {
		return apptstatusid;
	}

	public void setApptstatusid(int apptstatusid) {
		this.apptstatusid = apptstatusid;
	}

	public HashMap<String, String> getExtras() {
		return extras;
	}

	public void setExtras(HashMap<String, String> extras) {
		this.extras = extras;
	}

	public String getExtra(String field) {
		String r = "";
		try {
			r = getExtras().get(field);
		} catch(Exception e) { }
		if (!Operator.hasValue(r)) { r = ""; }
		return r;
	}

	public void addExtra(String field, String value) {
		this.extras.put(field, value);
	}

	public FinanceVO[] getFinance() {
		return finance;
	}

	public void setFinance(FinanceVO[] finance) {
		this.finance = finance;
	}

	public StatementVO[] getStatements() {
		return statements;
	}

	public void setStatements(StatementVO[] statements) {
		this.statements = statements;
	}

	public PaymentVO getPayment() {
		return payment;
	}

	public void setPayment(PaymentVO payment) {
		this.payment = payment;
	}

	public String getProcessid() {
		return processid;
	}

	public void setProcessid(String processid) {
		this.processid = processid;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}





}












