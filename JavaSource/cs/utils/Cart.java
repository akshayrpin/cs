package cs.utils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import alain.core.utils.Cartographer;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.common.ApiHandler;
import csshared.utils.ObjMapper;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjMap;
import csshared.vo.RequestVO;
import csshared.vo.ResponseVO;
import csshared.vo.TypeVO;
import csshared.vo.finance.DepositCreditVO;
import csshared.vo.finance.FeeVO;
import csshared.vo.finance.StatementVO;

/**
 * @author svijay
 *
 */
public class Cart {

	

	public Cart() {}

	public static final String highlightred ="#AF4747";
	public static final String highlightgreen ="#9CDF7F";
	public static final String highlightyellow ="#D7D737";

	public static String processCart(Cartographer map) {
		String s ="";
		try{
			boolean cart = false;
			TypeVO cartsession = new TypeVO();
			String sessionjson = map.getString("_cartsession");
			String currentjson = map.getString("cartjson");
			if(Operator.hasValue(sessionjson)){
				cart = true;
				cartsession = ObjMapper.toTypeObj(sessionjson);
			}
			if(!cart){
				map.setSession("_cartsession", currentjson);
				return currentjson;
			}else {
				if(!Operator.hasValue(cartsession.getStatements())){
					cartsession.setStatements(new StatementVO[0]);
				}
				TypeVO cartcurrent = ObjMapper.toTypeObj(currentjson);
				Logger.info("cartsession.getStatements()"+cartsession.getStatements().length);
				Logger.info("cartcurrent.getStatements()"+cartcurrent.getStatements().length);
				int clen = cartsession.getStatements().length;
				int cclen = cartcurrent.getStatements().length;
				int tlen = clen+cclen;
				StatementVO[] sv =  new StatementVO[tlen];// (ArrayUtils.addAll(cartcurrent.getStatements(), cartsession.getStatements()));
				
				int c =0;
				for(int i=0;i<cartcurrent.getStatements().length;i++){
					sv[i] = cartcurrent.getStatements()[i];
					Logger.highlight(cartcurrent.getStatements()[i].getActivitynumber()+"current");
					c=i;
				}
				c = c+1;
				for(int i=0;i<cartsession.getStatements().length;i++){
					sv[c] = cartsession.getStatements()[i];
					Logger.highlight(cartsession.getStatements()[i].getActivitynumber()+"session");
					c++;
				}
				
				//StatementVO[] ssv = clean(sv);
				
				TypeVO added = new TypeVO();
				added.setEntity("finance");
				added.setStatements(clean(sv));
				
				s  = ObjMapper.toJson(added);
				map.setSession("_cartsession", s);
				
				/* REMOVED TO Eliminate dups
				 * TypeVO added = new TypeVO();
				added.setEntity("finance");
				added.setStatements(sv);
				
				s  = ObjMapper.toJson(added);*/
				/*s = filter(sv).toString();
				map.setSession("_cartsession", s);*/
				//Logger.info("final "+s);
				//Logger.info("final "+s);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while processCart "+e.getMessage());
		}
		return s;
	}
	
	public static TypeVO processCart(String sessionjson, String[] add) {
		TypeVO result = new TypeVO();
		try {
			if (Operator.hasValue(sessionjson)) {
				TypeVO ss = ObjMapper.toTypeObj(sessionjson);
				if (Operator.hasValue(ss.getStatements())) {
					result = ss;
				}
			}
			ArrayList<StatementVO> sa = new ArrayList<StatementVO>();
			for (int i=0; i<add.length; i++) {
				String ta = add[i];
				TypeVO c = ObjMapper.toTypeObj(ta);
				StatementVO[] svoa = c.getStatements();
				for (int x=0; x<svoa.length; x++) {
					StatementVO svo = svoa[x];
					sa.add(svo);
				}
			}
			StatementVO[] csvoa = result.getStatements();
			for (int x=0; x<csvoa.length; x++) {
				StatementVO csvo = csvoa[x];
				sa.add(csvo);
			}
			StatementVO[] rvo = sa.toArray(new StatementVO[sa.size()]);
			result.setStatements(clean(rvo));
		}
		catch(Exception e){
			Logger.error("Problem while processCart "+e.getMessage());
		}
		return result;
	}
	
	public static String deleteCart(Cartographer map) {
		String s ="";
		try{
			
			TypeVO cartsession = new TypeVO();
			String sessionjson = map.getString("_cartsession");
			String deletejson = map.getString("cartjson");
			if(Operator.hasValue(sessionjson) && Operator.hasValue(deletejson)){
				cartsession = ObjMapper.toTypeObj(sessionjson);
				Logger.info("cartsession.getStatements()"+cartsession.getStatements().length);
				
				//int clen = cartsession.getStatements().length;
				//StatementVO[] sv =  new StatementVO[clen-1];// (ArrayUtils.addAll(cartcurrent.getStatements(), cartsession.getStatements()));
				
				ArrayList<StatementVO> ars = new ArrayList<StatementVO>();
				for(int i=0;i<cartsession.getStatements().length;i++){
					if(!Operator.equalsIgnoreCase(cartsession.getStatements()[i].getCombined(), deletejson)){
						ars.add(cartsession.getStatements()[i]);
						//sv[i] = cartsession.getStatements()[i];
						//sv[i].setOrder(i);
						Logger.info(cartsession.getStatements()[i].getActivitynumber()+"session");
					}
				}
				StatementVO[] sv = ars.toArray(new StatementVO[ars.size()]);
				TypeVO added = new TypeVO();
				added.setEntity("finance");
				added.setStatements(sv);
				s  = ObjMapper.toJson(added);
				map.setSession("_cartsession", s);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while deletingCart "+e.getMessage());
		}
		return s;
	}

	
	public static String clearCart(Cartographer map) {
		String s ="";
		try{
			
			TypeVO added = new TypeVO();
			added.setEntity("finance");
			s  = ObjMapper.toJson(added);
			map.setSession("_cartsession", s);
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while deletingCart "+e.getMessage());
		}
		return s;
	}

	
	public static String replaceCart(TypeVO t,Cartographer map) {
		String s ="";
		try{
			TypeVO added = new TypeVO();
			added.setEntity("finance");
			added.setStatements(t.getStatements());
			s  = ObjMapper.toJson(added);
			map.setSession("_cartsession", s);
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while deletingCart "+e.getMessage());
		}
		return s;
	}

	
	public static StatementVO[] clean(StatementVO[] vo){
		//JSONObject o = new JSONObject();
		StatementVO[] sv = null;
		try{
			Logger.info(vo.length);	
			for(int i=0;i<vo.length;i++){
				String projact = vo[i].getActivitynumber();
				Logger.info(projact);
				
			}
			int count =0;
			HashSet<String> pa = new HashSet<String>();
			for(int i=0;i<vo.length;i++){
				String projact = vo[i].getActivitynumber();
				Logger.info(projact);
				if(!pa.contains(projact)){
					pa.add(projact);
					count++;
				}
			}
			Logger.info("filtered"+count);	
			sv = new StatementVO[count];
			count =0;
			pa = new HashSet<String>();
			for(int i=0;i<vo.length;i++){
				String projact = vo[i].getActivitynumber();
				Logger.info(projact);
				if(!pa.contains(projact)){
					pa.add(projact);
					vo[i].setOrder(count);
					sv[count] = vo[i];
					count++;
				}
			}
		
		Logger.info(sv.length);	
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while clean "+e.getMessage());
		}
		return sv;
	}
	
	
	public static String orderCart(Cartographer map) {
		String s ="";
		try{
			TypeVO added = new TypeVO();
			added.setEntity("finance");
			
			String arr = map.getString("order");
			Logger.info(arr+"sort order");
			arr = Operator.replace(arr, "list", "");

			String sessionjson = map.getString("_cartsession");
			TypeVO cartsession = ObjMapper.toTypeObj(sessionjson);
			
			String o[] = Operator.split(arr,",");
			
			StatementVO[] sv = order(cartsession.getStatements(), o);
			added.setStatements(sv);
			s  = ObjMapper.toJson(added);
			map.setSession("_cartsession", s);
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while deletingCart "+e.getMessage());
		}
		return s;
	}
	
	
	public static StatementVO[] order(StatementVO[] vo,String[] o){
		//JSONObject o = new JSONObject();
		StatementVO[] sv = new StatementVO[o.length];
		try{
			Logger.info(vo.length);
			
			int c =0;
			for(int i=0;i<o.length;i++){
				//if(!o[i].equals("a") || o[i].equals("t")){
					sv[i]= getStatementOrder(vo,o[i],i);
					Logger.info(o[i]+"ordering"+sv[i].getActivitynumber());
				//}
			}
			
		Logger.info(sv.length);	
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while clean "+e.getMessage());
		}
		return sv;
	}
	
	public static StatementVO getStatementOrder(StatementVO[] vo,String o,int neworder){
		//JSONObject o = new JSONObject();
		StatementVO sv = new StatementVO();
		try{
			Logger.info(vo.length);	
			for(int i=0;i<vo.length;i++){
				if(vo[i].getOrder()==Operator.toInt(o)){
					sv = vo[i];
					sv.setOrder(neworder);
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while clean "+e.getMessage());
		}
		return sv;
	}
	
	public static JSONObject filter(StatementVO[] vo){
		JSONObject o = new JSONObject();
		try{
			JSONArray statements = new JSONArray();
			
			HashSet<String> pa = new HashSet<String>();
			for(int i=0;i<vo.length;i++){
				String projact = vo[i].getActivitynumber();
				Logger.info(projact);
				if(!pa.contains(projact)){
					pa.add(projact);
					JSONObject s = new JSONObject();
					s.put("projectid", vo[i].getProjectid());
					s.put("activityid", vo[i].getActivityid());
					s.put("projectname", vo[i].getProjectname());
					s.put("activitynumber", vo[i].getActivitynumber());
					s.put("amount", vo[i].getAmount());
					s.put("paidamount", vo[i].getPaidamount());
					s.put("balancedue", vo[i].getBalancedue());
					
					String  guniqueid = vo[i].getProjectid()+"_"+vo[i].getActivityid();
					s.put("inputamount", filterAmounts(vo, guniqueid));
					s.put("groups", filterGroups(vo, guniqueid));
					statements.put(s);
					Logger.info(s.toString());
				}
			}
			
			o.put("entity","finance");
			o.put("statements", statements);
			
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while processCart "+e.getMessage());
		}
		return o;
	}

	
	public static double filterAmounts(StatementVO[] vo,String guniqueid){
		double inputamount=0.00;
		try{
			for(int i=0;i<vo.length;i++){
				String uniqueId = vo[i].getProjectid()+"_"+vo[i].getActivityid();
				if(Operator.equalsIgnoreCase(uniqueId, guniqueid)){
					inputamount = Operator.addDouble(inputamount, vo[i].getInputamount());
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("Problem while processCart "+e.getMessage());
		}
		return inputamount;
	}
	
		public static JSONArray filterGroups(StatementVO[] vo,String guniqueid){
			JSONArray r = new JSONArray();
			try{
				
				HashSet<String> pagf = new HashSet<String>();
			
				for(int i=0;i<vo.length;i++){
					
					for(int j=0;j<vo[i].getGroups().length;j++){
						String uniqueId = vo[i].getProjectid()+"_"+vo[i].getActivityid();
						String stId = Operator.toString(vo[i].getGroups()[j].getGroupid());
						if(Operator.equalsIgnoreCase(uniqueId, guniqueid)){
							if(!pagf.contains(stId)){
								pagf.add(stId);
								JSONObject g = new JSONObject();
								g.put("group", vo[i].getGroups()[j].getGroup());
								g.put("groupid", vo[i].getGroups()[j].getGroupid());
								g.put("amount", vo[i].getGroups()[j].getAmount());
								g.put("paidamount", vo[i].getGroups()[j].getPaidamount());
								g.put("balancedue", vo[i].getGroups()[j].getBalancedue());
								//g.put("inputamount", vo[i].getGroups()[j].getInputamount());
								String funiqueId = vo[i].getProjectid()+"_"+vo[i].getActivityid()+"_"+vo[i].getGroups()[j].getGroupid();
								g.put("inputamount", filterGroupAmounts(vo, funiqueId));
								g.put("fees", filterFees(vo, funiqueId));
								r.put(g);
								
							}
						}
							
					}
					
					
				}
				
				
				
				
			}catch(Exception e){
				e.printStackTrace();
				Logger.error("Problem while processCart "+e.getMessage());
			}
			return r;
	}
		
		
		public static double filterGroupAmounts(StatementVO[] vo,String guniqueid){
			double inputamount=0.00;
			try{
				for(int i=0;i<vo.length;i++){
					for(int j=0;j<vo[i].getGroups().length;j++){
						String funiqueId = vo[i].getProjectid()+"_"+vo[i].getActivityid()+"_"+vo[i].getGroups()[j].getGroupid();
						if(Operator.equalsIgnoreCase(funiqueId, guniqueid)){
							inputamount = Operator.addDouble(inputamount, vo[i].getInputamount());
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
				Logger.error("Problem while processCart "+e.getMessage());
			}
			return inputamount;
		}
	
		public static JSONArray filterFees(StatementVO[] vo,String guniqueid){
			JSONArray r = new JSONArray();
			try{
				
				HashSet<String> pagf = new HashSet<String>();
			
				for(int i=0;i<vo.length;i++){
					
					for(int j=0;j<vo[i].getGroups().length;j++){
						
						
						for(int k=0;k<vo[i].getGroups()[j].getFees().length;k++){
							String uniqueId = vo[i].getProjectid()+"_"+vo[i].getActivityid()+"_"+vo[i].getGroups()[j].getGroupid();
							String stId = Operator.toString(vo[i].getGroups()[j].getFees()[k].getStatementdetailid());
							if(Operator.equalsIgnoreCase(uniqueId, guniqueid)){
								if(!pagf.contains(stId)){
									pagf.add(stId);
									JSONObject f = new JSONObject();
									f.put("statementdetailid", vo[i].getGroups()[j].getFees()[k].getStatementdetailid());
									f.put("name", vo[i].getGroups()[j].getFees()[k].getName());
									f.put("feeid", vo[i].getGroups()[j].getFees()[k].getFeeid());
									f.put("amount", vo[i].getGroups()[j].getFees()[k].getAmount());
									f.put("paidamount", vo[i].getGroups()[j].getFees()[k].getPaidamount());
									f.put("balancedue", vo[i].getGroups()[j].getFees()[k].getBalancedue());
									f.put("inputamount", vo[i].getGroups()[j].getFees()[k].getInputamount());
									r.put(f);
									
								}
							}
						}
					}
					
					
				}
				
				
				
				
			}catch(Exception e){
				e.printStackTrace();
				Logger.error("Problem while processCart "+e.getMessage());
			}
			return r;
	}


		public static String highlightCart(Cartographer map) {
			String s ="";
			try{
				
				TypeVO cartsession = new TypeVO();
				String sessionjson = map.getString("_cartsession");
				int method = map.getInt("m");
				String dc = map.getString("dc");
				double amount = map.getDouble("amt");
				double pamount = map.getDouble("pamt");
				boolean applydeposit = Operator.s2b(map.getString("applydeposit"));
				
				Logger.info("Highlisht cart" +amount);
				if(Operator.hasValue(sessionjson) && amount>0 && !applydeposit){
					cartsession = ObjMapper.toTypeObj(sessionjson);
					Logger.info("cartsession.getStatements()"+cartsession.getStatements().length);
					
					int clen = cartsession.getStatements().length;
					StatementVO[] sv =  new StatementVO[clen];
					double t = amount;
					for(int i=0;i<cartsession.getStatements().length;i++){
						double amt = cartsession.getStatements()[i].getInputamount();
						cartsession.getStatements()[i].setHighlight("");
						if(t<=0){
							cartsession.getStatements()[i].setHighlight(highlightred);
								
						}
						if(t>0 && t<amt){
							cartsession.getStatements()[i].setHighlight(highlightyellow);
							t = subDouble(t, amt);
						}
						
						if(t>=amt){
							cartsession.getStatements()[i].setHighlight(highlightgreen);
							t = subDouble(t, amt);
						}
						sv[i] = cartsession.getStatements()[i];
						
						//Logger.info(cartsession.getStatements()[i].get);
					}
					
					TypeVO added = new TypeVO();
					added.setEntity("finance");
					added.setStatements(sv);
					s  = ObjMapper.toJson(added);
					
					map.setSession("_cartsession", s);
				}
				
				if(Operator.hasValue(sessionjson) && amount>0 && applydeposit && Operator.hasValue(dc)){
					
					
					
					Logger.info(dc+"dcdc");
					DepositCreditVO d = new DepositCreditVO();
					String da[] = Operator.split(dc,"_");
					d.setLevel(da[0]);
					d.setParentid(Operator.toInt(da[1]));
					d.setAmount(Operator.toDouble(da[2]));
					d.setId(Operator.toInt(da[4]));
					double t = amount;
					
					cartsession = ObjMapper.toTypeObj(sessionjson);
					int clen = cartsession.getStatements().length;
					StatementVO[] sv =  new StatementVO[clen];
					if(d.getLevel().equalsIgnoreCase("ACTIVITY")){
						
						for(int i=0;i<cartsession.getStatements().length;i++){
							double amt = cartsession.getStatements()[i].getInputamount();
							cartsession.getStatements()[i].setHighlight("");
							
							if(d.getParentid()==cartsession.getStatements()[i].getActivityid()){
								if(t<=0){
									cartsession.getStatements()[i].setHighlight(highlightred);
										
								}
								if(t>0 && t<amt){
									cartsession.getStatements()[i].setHighlight(highlightyellow);
									t = subDouble(t, amt);
								}
								
								if(t>=amt){
									cartsession.getStatements()[i].setHighlight(highlightgreen);
									t = subDouble(t, amt);
								}
							}
							sv[i] = cartsession.getStatements()[i];
						
						}
					}
					
					if(d.getLevel().equalsIgnoreCase("PROJECT")){
						
						for(int i=0;i<cartsession.getStatements().length;i++){
							double amt = cartsession.getStatements()[i].getInputamount();
							cartsession.getStatements()[i].setHighlight("");
							Logger.info(t+"__"+d.getParentid()+"===="+cartsession.getStatements()[i].getProjectid());
							if(d.getParentid()==cartsession.getStatements()[i].getProjectid()){
								if(t<=0){
									cartsession.getStatements()[i].setHighlight(highlightred);
										
								}
								if(t>0 && t<amt){
									cartsession.getStatements()[i].setHighlight(highlightyellow);
									t = subDouble(t, amt);
								}
								
								if(t>=amt){
									cartsession.getStatements()[i].setHighlight(highlightgreen);
									t = subDouble(t, amt);
								}
							}
							sv[i] = cartsession.getStatements()[i];
						
						}
					}
					
					if(d.getLevel().equalsIgnoreCase("USER")){
						
						for(int i=0;i<cartsession.getStatements().length;i++){
							double amt = cartsession.getStatements()[i].getInputamount();
							cartsession.getStatements()[i].setHighlight("");
							Logger.info(t+"__"+d.getId()+"===="+cartsession.getStatements()[i].getActivityid());
							if(d.getId()==cartsession.getStatements()[i].getActivityid()){
								if(t<=0){
									cartsession.getStatements()[i].setHighlight(highlightred);
										
								}
								if(t>0 && t<amt){
									cartsession.getStatements()[i].setHighlight(highlightyellow);
									t = subDouble(t, amt);
								}
								
								if(t>=amt){
									cartsession.getStatements()[i].setHighlight(highlightgreen);
									t = subDouble(t, amt);
								}
							}
							sv[i] = cartsession.getStatements()[i];
						
						}
					}
					
					
					TypeVO added = new TypeVO();
					added.setEntity("finance");
					added.setStatements(sv);
					s  = ObjMapper.toJson(added);
					
					map.setSession("_cartsession", s);
				}
				
				
			}catch(Exception e){
				Logger.error("Problem while highlightCart "+e.getMessage());
				s= map.getString("_cartsession");
			}
			return s;
		}

		
		public static double subDouble(double a, double b){
			BigDecimal num1 = new BigDecimal(a+"");
			BigDecimal num2 = new BigDecimal(b+"");
	 
			return(num1.subtract(num2).doubleValue());
		}
		
		
		
		public static boolean processPermitCart(Cartographer map,TypeVO vo) {
			boolean result = false;
			
			if(vo.getGroups().length>0){
				ObjGroupVO g = vo.getGroups()[0];
				
				ObjMap[] values = g.getValues();
				for(int i=0;i<values.length;i++){
					ObjMap m = values[i];
					RequestVO r = new RequestVO();
					r.setGroup("finance");
					r.setEntity("finance");
					r.setType("finance");
					r.setReference(Operator.toString(m.getId()));
					r.setRequest("cart");
					Logger.info("reference"+m.getId());
					if(Operator.hasValue(map.getString("token"))){
						r.setToken(map.getString("token"));
					}else {
						r.setToken(map.token());
					}
					r.setIp(map.getRemoteIp());
					
					String s = ApiHandler.post(r); 
					map.setString("cartjson",s);
					processCart(map);
					result = true;
				}
			}
			return result;
			
		}
		
		public static String processPermitCart(Cartographer map, String type, String ids) {
			String result = "";
			String[] arr = Operator.split(ids, ",");
			String token = map.getString("token");
			if (!Operator.hasValue(token)) {
				token = map.token();
			}
			String ip = map.getRemoteIp();
			ArrayList<String> carts = new ArrayList<String>();
			for (int i=0; i<arr.length; i++) {
				int id = Operator.toInt(arr[i]);
				if (id > 0) {
					carts.add(getCartType("activity", id, token, ip));
				}
			}
			String[] acts = carts.toArray(new String[carts.size()]);
			TypeVO t = processCart(map.getString("_cartsession"), acts);
			result = ObjMapper.toJson(t);
			map.setSession("_cartsession", result);
			return result;
			
		}
		
		public static String getCartType(String type, int typeid, String token, String ip) {
			RequestVO r = new RequestVO();
			r.setGroup("finance");
			r.setEntity("finance");
			r.setGrouptype("finance");
			r.setType(type);
			r.setTypeid(typeid);
			r.setRequest("cart");
			r.setToken(token);
			r.setIp(ip);
			String s = ApiHandler.post(r); 
			return s;
		}

		public static String processPermitCart(Cartographer map) {
			if (map.hasValue("activities")) {
				return processPermitCart(map, "activity", map.getString("activities"));
			}
			String result = "";
		
			RequestVO r = new RequestVO();
			
			r.setGroup("finance");
			r.setEntity("finance");
			r.setType("finance");
			//r.setReference(map.getString("cartjson"));
			r.setRequest("cart");
			r.setId("a"+map.getString("cartjson"));
			
			if(Operator.hasValue(map.getString("token"))){
				r.setToken(map.getString("token"));
			}else {
				r.setToken(map.token());
			}
			r.setIp(map.getRemoteIp());
			
			Logger.info(r.getUrl());
			String s = ApiHandler.post(r); 
			map.setString("cartjson",s);
			result = processCart(map);
			
		
	
		//Logger.info("CART INFO######"+map.getString("_cartsession"));
			
			return result;
			
		}
		
		public static String scanPermitCart(Cartographer map) {
			String result = "";
		
			RequestVO r = new RequestVO();
			r.setGrouptype("finance");
			r.setEntity("finance");
			Logger.highlight("ID: "+map.getString(RequestMapper.typeid));
			Logger.highlight("Reference: "+map.getString(RequestMapper.reference));
			r.setType(map.getString(RequestMapper.type));
			r.setTypeid(map.getInt(RequestMapper.typeid));
			r.setReference(map.getString(RequestMapper.reference));
			r.setRequest("cart");
			
			if(Operator.hasValue(map.getString("token"))){
				r.setToken(map.getString("token"));
			}else {
				r.setToken(map.token());
			}
			r.setIp(map.getRemoteIp());
			
			String s = ApiHandler.post(r); 
			map.setString("cartjson",s);
			result = processCart(map);
			
		
	
		//Logger.info("CART INFO######"+map.getString("_cartsession"));
			
			return result;
			
		}
		
		public static String mergeMultiple(ArrayList<String> t){
			String result = "";
			try{
				List<StatementVO> updatedList = new ArrayList<StatementVO>();
				HashSet<String> existing = new HashSet<String>();
				double inputamount = 0;
				int cartid = 0;
				for(String currentjson: t){
					TypeVO cartcurrent = ObjMapper.toTypeObj(currentjson);
					for (int i = 0; i < cartcurrent.getStatements().length; i++) {
						inputamount += cartcurrent.getStatements()[i].getInputamount();
						existing.add(cartcurrent.getStatements()[i].getActivitynumber());
						updatedList.add(cartcurrent.getStatements()[i]);
						Logger.info(cartcurrent.getStatements()[i].getActivitynumber() + "current ---- " + inputamount);
					}
					
				}	
			
				StatementVO[] sv = updatedList.toArray(new StatementVO[updatedList.size()]);
	
				TypeVO added = new TypeVO();
				added.setEntity("finance");
				added.setStatements(sv);
				added.setInputamount(inputamount);
				added.setCartId(cartid);
				result = ObjMapper.toJson(added);
			}catch (Exception e){
				Logger.error(e.getMessage());
				result = "";
			}
			return result;
		}
		
}
