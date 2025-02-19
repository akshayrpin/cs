package cs.utils;

import java.util.ArrayList;
import java.util.HashMap;

import alain.core.utils.Cartographer;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.common.ApiHandler;
import csshared.utils.CsApi;
import csshared.utils.CsConfig;
import csshared.utils.ObjMapper;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.SubObjGroupVO;
import csshared.vo.TypeVO;
import csshared.vo.finance.PaymentVO;

public class RequestMapper {

	public static String id = CsApi.id;
	public static String entityid =  CsApi.entityid;
	public static String entity = CsApi.entity;
	public static String typeid = CsApi.typeid;
	public static String type = CsApi.type;
	public static String groupid = CsApi.groupid;
	public static String group = CsApi.group;
	public static String grouptype = CsApi.grouptype;
	public static String reference = CsApi.reference;
	public static String ref = CsApi.ref;
	public static String refid = CsApi.refid;

	public static String review = CsApi.review;
	public static String reviewid = CsApi.reviewid;
	public static String reviewrefid = CsApi.reviewrefid;
	public static String reviewgroupid = CsApi.reviewgroupid;

	public static String subgroup = CsApi.subgroup;
	public static String subgroupfields = CsApi.subgroupfields;
	public static String subgroupsize = CsApi.subgroupsize;

	public static String request = CsApi.request;
	public static String action = CsApi.action;
	public static String startdate = CsApi.startdate;
	public static String enddate = CsApi.enddate;
	public static String start = CsApi.start;
	public static String end = CsApi.end;

	public static String appttypeid = CsApi.appttypeid;
	public static String apptsubtypeid = CsApi.apptsubtypeid;
	public static String apptstatusid = CsApi.apptstatusid;
	public static String note = CsApi.note;

	public RequestMapper() {}

	/**
	 * @deprecated Use csshared.utils.CsApi.createRequest(Cartographer map)
	 *
	 */
	public static RequestVO getRequest(Cartographer map) {
		RequestVO nav = new RequestVO();

		nav.setId(map.getString(id));
		nav.setEntityid(map.getInt(entityid));
		nav.setEntity(map.getString(entity));
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setReference(map.getString(reference));
		nav.setRef(map.getString(ref));
		nav.setRefid(map.getInt(refid));

		nav.setReview(map.getString(review));
		nav.setReviewid(map.getInt(reviewid));
		nav.setReviewrefid(map.getInt(reviewrefid));
		nav.setReviewgroupid(map.getInt(reviewgroupid));

		nav.setRequest(map.getString(request));
		nav.setAction(map.getString(action));
		nav.setStartdate(map.getString(startdate));
		nav.setEnddate(map.getString(enddate));
		nav.setStart(map.getInt(start));
		nav.setEnd(map.getInt(end));

		nav.setAppttypeid(map.getInt(appttypeid));
		nav.setApptsubtypeid(map.getInt(apptsubtypeid));
		nav.setApptstatusid(map.getInt(apptstatusid));

		if (map.hasValue(note)) {
			nav.addExtra("note", map.getString(note));
		}

		nav.setUsername(map.username());
		if(Operator.hasValue(map.getString("token"))){
			nav.setToken(map.getString("token"));
		}else {
			nav.setToken(map.token());
		}
		nav.setIp(map.getRemoteIp());
		return nav;
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.submitRequest(Cartographer map)
	 *
	 */
	public static String submit(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setRequest("details");
		nav.setSubrequest("save");
		nav.setData(getGroup(map));
		return ObjMapper.toJson(nav);
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.saveRequest(Cartographer map)
	 *
	 */
	public static RequestVO getSaveRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		if (map.hasValue(RequestMapper.action)) {
			nav.setRequest(map.getString(RequestMapper.action));
		}
		else {
			nav.setRequest("save");
		}
		nav.setData(getGroup(map));
		return nav;
	}

	public static RequestVO getRequest(Cartographer map, String action) {
		RequestVO nav = getRequest(map);
		nav.setRequest(action);
		nav.setData(getGroup(map));
		return nav;
	}

	public static RequestVO getDeleteRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setRequest("delete");
		nav.setData(getGroup(map));
		return nav;
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.group(Cartographer map)
	 *
	 */
	public static ObjGroupVO[] getGroup(Cartographer map) {
		RequestVO n = getRequest(map);
		return getGroup(map,n,false,true);
	}	

	/**
	 * @deprecated Use csshared.utils.CsApi.group(Cartographer map, RequestVO n, boolean subgroups)
	 *
	 */
	public static ObjGroupVO[] getGroup(Cartographer map, RequestVO n, boolean subgroups) {
		return getGroup(map, n, subgroups, false);
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.group(Cartographer map, RequestVO n, boolean subgroups, boolean nonempty)
	 *
	 */
	public static ObjGroupVO[] getGroup(Cartographer map, RequestVO n, boolean subgroups, boolean nonempty) {
		boolean multi = map.equalsIgnoreCase(action, "multiedit");

		ObjGroupVO[] result = new ObjGroupVO[0];
	
		n.setRequest("fields");
//		n.setSubrequest("fields");
		if(Operator.hasValue(n.getType())){
			TypeVO e = ApiHandler.getType(n);
			ObjGroupVO g = new ObjGroupVO();
			g.setGroup(map.getString(group));
			g.setGroupid(map.getString(groupid));
			g.setType(map.getString(grouptype));

			ObjGroupVO[] gs = e.getGroups();
			if (gs.length > 0) {
				result = new ObjGroupVO[1];
				ObjGroupVO s = gs[0];
				ObjVO[] sf = s.getObj();
				ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
				int l = sf.length;
				for (int i=0; i<l; i++) {
					ObjVO f = sf[i];
					String fieldid = f.getFieldid();
					String mfield = f.getMultieditcheck();
					String itype = f.getItype();
					String value = "";
					
					boolean systemgenerated = f.isSystemGenerated();
					boolean m = f.isMultiedit();
					if (!multi) {
						value = map.getString(fieldid);
					}
					
					else if (multi && m) {
						if (!Operator.hasValue(mfield)) {
							value = map.getString(fieldid);
						}
						else {
							String ch = map.getString(mfield);
							if (Operator.equalsIgnoreCase(ch, "Y")) {
								value = map.getString(fieldid);
							}
							else {
								value = CsConfig.SKIPVALUE;
							}
						}
					}
					if (!nonempty || Operator.hasValue(value) || systemgenerated || itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle") || f.hasMultivalueindex()) {
						if (!Operator.hasValue(value)) {
							if (itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle")) {
								value = "N";
							}
						}
						f.setValue(value);
						
						if (f.isQty()) {
							String[] values = paramToArray(value);
							for (int x=0; x<values.length; x++) {
								String v = values[x];
								f.addValue(v, map.getString(v));
							}
						}
						if (f.hasMultivalueindex()) {
							String mf = f.getMultivalueindex();
							String fs = map.getString(mf);
							if (Operator.hasValue(fs)) {
								String param = map.getString(f.getMultivalueindex());
								String[] values = paramToArray(param);
								for (int x=0; x<values.length; x++) {
									String v = values[x];
									StringBuilder sb = new StringBuilder();
									sb.append(fieldid).append("_").append(v);
									String mfld = sb.toString();
									String vl = map.getString(mfld);
									if (Operator.hasValue(vl)) {
										f.addValue(mfld, vl);
									}
								}
							}
						}
						gf.add(f);
					}
				}
				g.setObj(gf.toArray(new ObjVO[gf.size()]));
				if(subgroups){
					g.setCustomsize(map.getInt("customsize",0));
					g.setCustom(getCustom(map, n));
				}
				else if (map.hasValue(subgroup)) {
					g.setSubgroup(map.getString(subgroup));
					g.setCustom(getSubgroup(map, n));
				}
				result[0] = g;
			}
		}
		return result;
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.subgroup(Cartographer map, RequestVO n)
	 *
	 */
	public static SubObjGroupVO[] getSubgroup(Cartographer map, RequestVO n) {

		SubObjGroupVO[] result = new SubObjGroupVO[0];
		if (map.hasValue(subgroup)) {
			int size = map.getInt(subgroupsize, -1);
			RequestVO req = n.duplicate();
			req.setGroup(subgroup);
			req.setGroupid(subgroup);
			req.setGrouptype(map.getString(subgroup));
			req.setRequest("fields");

			TypeVO e = ApiHandler.getType(req);
			ObjGroupVO[] gs = e.getGroups();
			ObjGroupVO s = gs[0];
			ObjVO[] fields = s.getObj();
			if (gs.length > 0) {
				if (size < 0) {
					result = new SubObjGroupVO[1];
					SubObjGroupVO g = new SubObjGroupVO();
					ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
					int l = fields.length;
					for (int i=0; i<l; i++) {
						ObjVO f = fields[i];
						String fieldid = f.getFieldid();
						String value = "";
						value = map.getString(fieldid);
						f.setValue(value);
						gf.add(f);
					}
					g.setObj(gf.toArray(new ObjVO[gf.size()]));
					result[0] = g;
				}
				else {
					SubObjGroupVO[] subarray = new SubObjGroupVO[size];
					for (int i=0; i<size; i++) {
						SubObjGroupVO sub = new SubObjGroupVO();
						int l = fields.length;
						ObjVO[] oa = new ObjVO[l];
						for (int x=0; x<l; x++) {
							ObjVO f = fields[x];
							String fieldid = f.getFieldid()+"_"+i;
							String value = "";
							value = map.getString(fieldid);
							f.setValue(value);
							oa[x] = f;
						}
						sub.setObj(oa);
						SubObjGroupVO dsub = SubObjGroupVO.deserialize(sub);
						subarray[i] = dsub;
					}
					result = subarray;
				}
			}

		}
		return result;
	}



	public static RequestVO getPaymentRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
//		nav.setRequest("details");
		TypeVO t = ObjMapper.toTypeObj(map.getString("_cartsession"));
		nav.setStatements(t.getStatements());
		nav.setPayment(getPayment(map));
		nav.setRequest("pay");
		
		
		nav.setEntityid(map.getInt(entityid));
		nav.setEntity("finance");
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		
		return nav;
	}
	
	public static PaymentVO getPayment(Cartographer map) {
		PaymentVO p = new PaymentVO();
		p.setPaymentid(map.getInt("paymentid"));
		p.setMethod(map.getInt("method"));
		p.setTransactiontype(map.getInt("transactiontype"));
		p.setNumber(map.getString("number"));
		p.setCounter(map.getInt("counter"));
		p.setPayeeid(map.getInt("payeeid"));
		p.setComment(map.getString("comment"));
		p.setOtherpayeename(map.getString("payee"));
		if(Operator.hasValue(p.getOtherpayeename())){
			p.setPayeeid(map.getInt("payee"));
		}
		p.setAmount(map.getDouble("amount"));
		p.setCombined(map.getString("combined"));
		//p.setCountername(map.getString("applydeposit"));
		p.setMethodname(map.getString("applydeposit"));
		return p;
		
	}

	public static RequestVO getFeesRequest(Cartographer map,String action) {
		RequestVO nav = new RequestVO();
		TypeVO t = ObjMapper.toTypeObj(map.getString("feesjson"));
		nav.setStatements(t.getStatements());
		nav.setRequest(action);
		
		nav.setEntityid(t.getEntityid());
		nav.setEntity(t.getEntity());
		nav.setTypeid(t.getTypeid());
		nav.setType(t.getType());
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setToken(map.token());
		nav.setUsername(map.username());
		nav.setIp(map.getRemoteIp());
		return nav;
	}
	
	public static RequestVO getDepositRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		
		nav.setPayment(getPayment(map));
		nav.setRequest("save");
		/*nav.setEntityid(map.getInt(entityid));
		nav.setEntity(map.getString(entity));
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));*/
		
		return nav;
	}

	public static RequestVO getReverseRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setPayment(getPayment(map));
		nav.setRequest("reverse");
		return nav;
	}
	
	public static RequestVO getDepositPayeesRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
//		nav.setRequest("details");
		TypeVO t = ObjMapper.toTypeObj(map.getString("_cartsession"));
		nav.setStatements(t.getStatements());
		//nav.setPayment(getPayment(map));
		nav.setRequest("depositpayees");
		
		
		nav.setEntityid(map.getInt(entityid));
		nav.setEntity("finance");
		nav.setTypeid(map.getInt(typeid));
		nav.setType("finance");
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype("deposit");
		
		return nav;
	}
	
	public static RequestVO getStatementPaymentRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setGroupid(map.getString("STATEMENT_DETAIL_ID"));
		nav.setRequest("showstatementpayment");
		
		return nav;
	}
	
	public static RequestVO getPartialReverseRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setGroupid(map.getString("STATEMENT_DETAIL_ID"));
		nav.setRequest("partialreverse");
		PaymentVO p = new PaymentVO();
		p.setPaymentid(map.getInt("PD_ID"));
		p.setRevpaymentid(map.getInt("P_ID"));
		p.setPayeeid(map.getInt("PAYEE_ID"));
		p.setAmount(map.getDouble("AMOUNT"));
		p.setTransactiontype(5);
		p.setMethod(map.getInt("P_METHOD"));
		p.setComment(map.getString("P_COMMENT"));
		nav.setPayment(p);
		return nav;
	}
	
	public static RequestVO getLedgerPaymentRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setRequest("showledger");
		PaymentVO p = new PaymentVO();
		p.setPaymentid(map.getInt("P_ID"));
		nav.setPayment(p);
		return nav;
	}
	
	public static RequestVO getDepositLedgerRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setRequest("showdepositledger");
		PaymentVO p = new PaymentVO();
		p.setPaymentid(map.getInt("P_ID"));
		nav.setPayment(p);
		return nav;
	}
	
	public static RequestVO getDepositList(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setRequest("depositlist");
	
		return nav;
	}
	
	
	public static RequestVO getParkingRequest(Cartographer map,String action) {
		RequestVO nav = getRequest(map);
		nav.setSearch(map.getString("search"));
		nav.setRequest(action);
		
		HashMap<String,String> s = new HashMap<String, String>();
		s.put("strno", map.getString("strno"));
        s.put("strname", map.getString("strname"));
        s.put("fraction", map.getString("fraction"));
        s.put("unit", map.getString("unit"));
        s.put("accountno", map.getString("accountno"));
        s.put("projectno", map.getString("projectno"));
        s.put("licno", map.getString("licno"));
        s.put("name", map.getString("name"));
        s.put("email", map.getString("email"));
        s.put("permit", map.getString("permit"));
        nav.setExtras(s);
		
		return nav;
	}
	

	public static RequestVO getSaveExemption(Cartographer map) {
		
		RequestVO nav = getRequest(map);
		ObjGroupVO[] g = getGroup(map,nav,true);
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setRequest("saveexemption");
		HashMap<String, String> extras = new HashMap<String, String>();
		extras.put("NO_OF_VEHICLES", map.getString("NO_OF_VEHICLES"));
		nav.setExtras(extras);
		
		nav.setData(g);
		
		
		return nav;
	}
	
	public static RequestVO getSaveParkingPermit(Cartographer map) {
		return getSaveParkingPermit(map,"savepermit");
	}
	public static RequestVO getSaveParkingPermit(Cartographer map, String request) {
		
		RequestVO nav = getRequest(map);
		
		ObjGroupVO[] g = getGroup(map,nav,false);
		
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setRequest(request);
		nav.setEnd(map.getInt("QTY"));
		
		nav.setReference(map.getString(reference));
		
		nav.setData(g);
		
		
		return nav;
	}
	
	/**
	 * @deprecated Use csshared.utils.CsApi.custom(Cartographer map, RequestVO n)
	 *
	 */
	public static SubObjGroupVO[] getCustom(Cartographer map, RequestVO n) {
		
		ArrayList<SubObjGroupVO> r = new ArrayList<SubObjGroupVO>();
		n.setRequest("addlfields");
		if(Operator.hasValue(n.getType())){
			TypeVO e = ApiHandler.getType(n);
			
			if (e.getGroups().length > 0) {
				int count = map.getInt("customsize",0);
				Logger.info(count);
				ObjGroupVO g = e.getGroups()[0];
				ObjVO[] sf = g.getObj();
				for(int i=0;i<count;i++){
					
					SubObjGroupVO s = new SubObjGroupVO();
					s.setGroup(g.getGroup());
					s.setGroupid(g.getGroupid());
				
					ArrayList<ObjVO> gf = new ArrayList<ObjVO>();
					int l = sf.length;
					
					for (int j=0; j<l; j++) {
						ObjVO f = new ObjVO();
						String fieldid = sf[j].getFieldid();
						String value = map.getString(fieldid);
						f.setFieldid(fieldid);
						f.setItype(sf[j].getItype());
						if(!Operator.hasValue(value)){
							value = map.getString(fieldid+"_"+i);
							
						}
						f.setValue(value);
						if (!Operator.hasValue(value)) {
							String itype = f.getItype();
							if (itype.equalsIgnoreCase("boolean") || itype.equalsIgnoreCase("yesno") || itype.equalsIgnoreCase("toggle")) {
								value = "N";
							}
						}
						Logger.info(f.getFieldid()+" :: "+f.getValue());
						gf.add(f);
						
					
					}
					
					s.setObj(gf.toArray(new ObjVO[gf.size()]));
					r.add(s);
				}
				
			}
		}
		
		SubObjGroupVO[] ra = r.toArray(new SubObjGroupVO[r.size()]);
		return ra;
	}

	public static RequestVO getPaymentOnlineRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.setPayment(getPayment(map));
		nav.setRequest("payonline");
		nav.setEntityid(map.getInt(entityid));
		nav.setEntity("finance");
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
	
		return nav;
	}
	
	
	public static RequestVO getEmailRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		nav.addExtra("email_bcc", map.getString("email_bcc"));
		nav.addExtra("email_subject", map.getString("email_subject"));
		nav.addExtra("email_body", map.getString("email_body"));
		return nav;
	}
	
	public static RequestVO getApprovalRequest(Cartographer map) {
		RequestVO nav = getRequest(map);
		HashMap<String,String> s = new HashMap<String, String>();
		s.put("status", map.getString("status"));
        s.put("comment", map.getString("comment"));
        s.put("account", map.getString("account"));
        s.put("APPROVED_SPACE", map.getString("APPROVED_SPACE"));
        s.put("CARS", map.getString("CARS"));
        s.put("REQUIRED_SPACE", map.getString("REQUIRED_SPACE"));
        nav.setExtras(s);
		return nav;
	}

	/**
	 * @deprecated Use csshared.utils.CsApi.parameterToArray(String param)
	 *
	 */
	public static String[] paramToArray(String param) {
		String[] r = new String[0];
		if (Operator.hasValue(param)) {
			if (param.indexOf(",") > -1) {
				r = Operator.split(param, ",");
			}
			else {
				r = Operator.split(param, "|");
			}
		}
		return r;
	}

	
public static RequestVO getReview(Cartographer map, String request) {
		
		RequestVO nav = getRequest(map);
		
		ObjGroupVO[] g = getGroup(map,nav,false);
		
		nav.setGroupid(map.getString(groupid));
		nav.setGroup(map.getString(group));
		nav.setGrouptype(map.getString(grouptype));
		nav.setRequest(request);
		nav.setEntity(request);
		nav.setTypeid(map.getInt(typeid));
		nav.setType(map.getString(type));
		nav.setReference(map.getString(reference));
		
		nav.setData(g);
		
		
		return nav;
	}


}
