package cs.ui;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.utils.ObjTables;
import cs.utils.ObjValues;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjMap;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;

public class Horizontal {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		ObjMap[] map = g.getValues();
		String[] fields = g.getFields();
		int fl = fields.length;
		int l = map.length;
		String entity = req.getEntity();
		int entityid = req.getEntityid();
		String type = req.getType();
		int typeid = req.getTypeid();
		String group = g.getGroup();
		String grouptype = g.getType();
		String groupid = g.getGroupid();
		boolean empty = true;

		StringBuilder sb = new StringBuilder();
		String addurl = "";
		if (g.isAddable() && g.isCreate()) {
			addurl = ObjTables.getFormUrl(req, g, "add");
		}
		
		if (g.getGroup().equalsIgnoreCase("team")) {
			addurl = ObjTables.getFormUrl(req, g, "add");
			
		}
		String multiedit = "";
		if (g.isMultieditable() && g.isEditable()) {
			multiedit = ObjTables.getFormUrl(req, g, "multiedit");
		}
		String moreurl = ObjTables.getMoreUrl(req, g);
		String moreimg = ObjTables.WHITEMOREIMGURL;
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, addurl, multiedit, g.getOptions(), req.getOption(), "", moreurl, moreimg, g.getContenttype()));

		if (fl > 0 && l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			boolean editable = (g.isEditable());
			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"").append(fields[x]).append("\" valign=\"top\">").append(fields[x]).append("</td>\n");
			}
			if ((g.isDeletable() && g.isDelete()) || (editable && g.isUpdate())) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" valign=\"top\">&nbsp;</td>\n");
			}
			sb.append("</tr>\n");

			for (int i=0; i < l; i++) {
				ObjMap m = map[i];
				boolean display = false;
				if (!CsConfig.isPublic()) {
					display = true;
				}
				else if (m.isShowpublic()) {
					display = true;
				}
				else if (g.getToken().isStaff()) {
					display = true;
				}
				display = true;
				if (display) {
					int id = m.getId();
					if (id > 0) {
						empty = false;
						boolean deletable = (g.isDeletable() && !m.isFinaled());

						String editurl = "";
						if (editable) {
							editurl = ObjTables.getUrl(CsConfig.getForm(g.getGroup(), g.getType()), Operator.toString(id), entity, entityid, type, typeid, group, grouptype, groupid, "");
						}

						sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(m.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(m.getId()).append("\">\n");
						for (int x=0; x < fl; x++) {
							try {
								if (editable) {
									String ef = g.getDisableeditfield();
									String ev = g.getDisableeditvalue();
									if (Operator.hasValue(ef)) {
										ObjVO evo = m.getValues().get(ef);
										String evv = evo.getValue();
										if (Operator.equalsIgnoreCase(evv, ev)) {
											editable = false;
										}
									}
								}
								if (deletable) {
									String df = g.getDisabledeletefield();
									String dv = g.getDisabledeletevalue();
									if (Operator.hasValue(df)) {
										ObjVO dvo = m.getValues().get(df);
										String evv = dvo.getValue();
										if (Operator.equalsIgnoreCase(evv, dv)) {
											deletable = false;
										}
									}
								}
								
								ObjVO o = m.getValues().get(fields[x]);
								if (!g.isEditable()) {
									o.setEditable("N");
								}
								String ot = o.getType();
								String oi = o.getItype();
								sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\">");
								if (editable) {
									if (!Operator.hasValue(o.getLink()) && !Operator.equalsIgnoreCase(ot, "checkbox") && !Operator.equalsIgnoreCase(ot, "complete")) {
										sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\"");
										if (Operator.hasValue(o.getTarget())) {
											sb.append(" target=\"").append(o.getTarget()).append("\"");
										}
										sb.append(">");
									}
									sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
									if (!Operator.hasValue(o.getLink()) && !Operator.equalsIgnoreCase(ot, "checkbox") && !Operator.equalsIgnoreCase(ot, "complete")) {
										sb.append("</a>");
									}
								}
								else {
									sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
								}
								sb.append("</td>\n");
							}
							catch (Exception e) {
								sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
							}
						}
						req.setId(Operator.toString(m.getId()));
						if (deletable && g.isDelete()) {
							sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
							sb.append(CsUiTools.getDelete(m.getId(), m.getRef(), m.getRefid(), g));
//							sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(m.getId()).append("\"/>");
							sb.append("</td>");
						}
						else if (editable && g.isUpdate()) {
							sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
							sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
							sb.append("<img src=\"").append(ObjTables.GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
							sb.append("</td>");
						}
						else if (g.isDeletable() && g.isDelete()) {
							sb.append("<td class=\"").append(style).append("_rowcontrols\" nowrap>&nbsp;</td>");
						}
						sb.append("</tr>\n");
					}
				}
			}
			sb.append("</table>\n");
		}
		if (empty) {
			if (!g.isDisplayempty()) {
				return "";
			}
		}
		return sb.toString(); 

	}

	public static String info(RequestVO req, ObjGroupVO g, String style, String alert) {
		if (!Operator.hasValue(g.getLabel())) { return ""; }
		ObjMap[] map = g.getValues();
		String[] fields = g.getIndex();
		int fl = fields.length;
		int l = map.length;
		String entity = req.getEntity();
		int entityid = req.getEntityid();
		String type = req.getType();
		int typeid = req.getTypeid();
		String group = g.getGroup();
		String grouptype = g.getType();
		String groupid = g.getGroupid();
		boolean empty = true;

		String addurl = "";
		if (g.isAddable() && g.isCreate() ) {
			addurl = ObjTables.getFormUrl(req, g, "add");
		}
		

		if (g.getGroup().equalsIgnoreCase("team")) {
			addurl = ObjTables.getFormUrl(req, g, "add");
			
		}
		StringBuilder sb = new StringBuilder();
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, addurl, ObjTables.GRAYADDIMGURL, "", "", g.getOptions(), req.getOption(), "", "", g.getContenttype(), ObjTables.BLACKHELPIMGURL));
		String titlebar = sb.toString();
		sb = new StringBuilder();
		if (fl > 0 && l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			Logger.info(sb.toString());
			boolean editable = (g.isEditable() && g.isUpdate());
			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"").append(fields[x]).append("\" valign=\"top\">").append(fields[x]).append("</td>\n");
			}
			if (g.isDeletable()) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" valign=\"top\">&nbsp;</td>\n");
			}
			sb.append("</tr>\n");
			for (int i=0; i < l; i++) {
				ObjMap m = map[i];
				boolean display = false;
				if (!CsConfig.isPublic()) {
					display = true;
				}
				else if (m.isShowpublic()) {
					display = true;
				}
				else if (g.getToken().isStaff()) {
					display = true;
				}
				display = true;
				
				
				if (display) {
					int id = m.getId();
					boolean deletable = (g.isDeletable() && !m.isFinaled() && g.isDelete());

					String editurl = "";
					if (editable) {
						editurl = ObjTables.getUrl(CsConfig.getForm(g.getGroup(), g.getType()), Operator.toString(id), entity, entityid, type, typeid, group, grouptype, groupid, "");
					}

					sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(m.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(m.getId()).append("\">\n");
					for (int x=0; x < fl; x++) {
						try {
							if (editable) {
								String ef = g.getDisableeditfield();
								String ev = g.getDisableeditvalue();
								if (Operator.hasValue(ef)) {
									ObjVO evo = m.getValues().get(ef);
									String evv = evo.getValue();
									if (Operator.equalsIgnoreCase(evv, ev)) {
										editable = false;
									}
								}
							}
							if (deletable) {
								String df = g.getDisabledeletefield();
								String dv = g.getDisabledeletevalue();
								if (Operator.hasValue(df)) {
									ObjVO dvo = m.getValues().get(df);
									String evv = dvo.getValue();
									if (Operator.equalsIgnoreCase(evv, dv)) {
										deletable = false;
									}
								}
							}
							
							if(group.equals("gis")){
								StringBuilder maplink  = new StringBuilder();
								Logger.info(Config.fullcontexturl());
								maplink.append("<iframe src=\"").append(Config.fullcontexturl()).append("/map.jsp?_ent=lso&_entid=-1&_type=lso&_typeid=").append(typeid).append("&_grptype=map&_act=view\" width=\"100%\" height=\"400\" ></iframe>");
								//maplink.append("<iframe src=\"").append("https://gis.beverlyhills.org/vbhforcs/public/?Q=").append("").append(typeid).append("&_grptype=map&_act=view\" width=\"400\" height=\"400\" ></iframe>");
								sb.append(maplink.toString());
							} else {
							
							
								ObjVO o = m.getValues().get(fields[x]);
								String ot = o.getType();
								String oi = o.getItype();
								sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\">");
								if (editable) {
									if (!Operator.hasValue(o.getLink()) && !Operator.equalsIgnoreCase(ot, "checkbox") && !Operator.equalsIgnoreCase(ot, "complete")) {
										sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\"");
										if (Operator.hasValue(o.getTarget())) {
											sb.append(" target=\"").append(o.getTarget()).append("\"");
										}
										sb.append(">");
									}
									sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
									if (!Operator.hasValue(o.getLink()) && !Operator.equalsIgnoreCase(ot, "checkbox") && !Operator.equalsIgnoreCase(ot, "complete")) {
										sb.append("</a>");
									}
								}
								else {
									sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
								}
								sb.append("</td>\n");
							}
						}
						catch (Exception e) {
							sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
						}
					}
					req.setId(Operator.toString(m.getId()));
					if (deletable) {
						sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
						sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(m.getId()).append("\"/>");
						sb.append("</td>");
					}
					else if (g.isDeletable()) {
						sb.append("<td class=\"").append(style).append("_rowcontrols\" nowrap>&nbsp;</td>");
					}
					sb.append("</tr>\n");
					empty = false;
				}
			}
			sb.append("</table>\n");
		}
		String content = sb.toString();
		if (empty) {
			if (g.isEditable()) {
				return titlebar;
			}
			else {
				return "";
			}
		}
		sb = new StringBuilder();
		sb.append(titlebar);
		sb.append(content);
		
		Logger.info("MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP"+group);
		Logger.info(sb.toString());
		Logger.info(type);
		Logger.info(typeid);
		Logger.info(group);
		Logger.info(grouptype);
		
		return sb.toString(); 

	}

	public static String list(RequestVO req, ObjGroupVO g, String style, String alert) {
		return id(req, g, style, alert);
	}

	public static String id(RequestVO req, ObjGroupVO g, String style, String alert) {
		ObjMap[] map = g.getValues();
		String[] fields = g.getFields();
		int fl = fields.length;
		int l = map.length;

		StringBuilder sb = new StringBuilder();
		if (fl > 0 && l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");

			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"").append(fields[x]).append("\" valign=\"top\">").append(fields[x]).append("</td>\n");
			}
			sb.append("</tr>\n");

			for (int i=0; i < l; i++) {
				ObjMap m = map[i];
				sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(m.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(m.getId()).append("\">\n");
				for (int x=0; x < fl; x++) {
					try {
						ObjVO o = m.getValues().get(fields[x]);
						String ot = o.getType();
						String oi = o.getItype();
						sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\">");
						sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
						sb.append("</td>\n");
					}
					catch (Exception e) {
						sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
					}
				}
				req.setId(Operator.toString(m.getId()));
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 

	}







}
