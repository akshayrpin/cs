package cs.ui;

import java.util.HashMap;

import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.utils.ObjTables;
import cs.utils.ObjValues;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjMap;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;

public class People {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		HashMap<String, String> accounts = g.getExtras();
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

		StringBuilder sb = new StringBuilder();
		String addurl = "";
		if (g.isAddable()) {
			addurl = ObjTables.getFormUrl(req, g, "add");
		}

		boolean empty = true;
		if (fl > 0 && l > 0) {
			sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, addurl, "", g.getOptions(), req.getOption(), "", g.getContenttype()));
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" valign=\"top\">&nbsp;</td>\n");
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
				if (!CsConfig.isPublic()) { display = true; }
				else if (g.getToken().isStaff()) { display = true; }
				else if (m.isShowpublic()) { display = true; }
				if (display) {
					String exp = "";
					if (m.hasExpired()) {
						exp = " title=\"Expired\" expired=\"true\"";
					}

					sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(m.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(m.getId()).append("\">\n");
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					if (!Operator.hasValue(m.getRef()) || !g.isEditable()) {
						sb.append("&nbsp;");
					}
					else if (Operator.hasValue(accounts.get(m.getRef().toLowerCase()))) {
						sb.append("<img src=\"/cs/images/icons/controls/color/onlineaccount.png\" class=\"refusersonlineaccount\" style=\"cursor:pointer\" title=\"User has an existing account. Click here to reset user password.\" width=\"20\" height=\"20\" border=\"0\" onclick=\"refusersonlineaccount(").append(m.getId()).append(", '").append(m.getRef()).append("')\"/>");
					}
					else {
						sb.append("<img src=\"/cs/images/icons/controls/gray/onlineaccount.png\" class=\"refusersonlineaccount\" style=\"cursor:pointer\" title=\"Create User Online Account\" width=\"20\" height=\"20\" border=\"0\" onclick=\"refusersonlineaccount(").append(m.getId()).append(", '").append(m.getRef()).append("')\"/>");
					}
					sb.append("</td>");
					for (int x=0; x < fl; x++) {
						try {
							ObjVO o = m.getValues().get(fields[x]);
							if (!g.isEditable()) {
								o.setEditable("N");
							}
							String ot = o.getType();
							String oi = o.getItype();
							sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\"").append(exp).append(">");
							String d = ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken());
							sb.append(d);
							sb.append("</td>\n");
						}
						catch (Exception e) {
							sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
						}
					}
					req.setId(Operator.toString(m.getId()));
					if (g.isDeletable()) {
						sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
						sb.append(CsUiTools.getDelete(m.getId(), m.getRef(), m.getRefid(), g));
//					sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(m.getId()).append("\"/>");
						sb.append("</td>");
					}
					sb.append("</tr>\n");
					empty = false;
				}
			}
			sb.append("</table>\n");
		}
		if (empty) { return ""; }
		return sb.toString(); 

	}

	public static String info(RequestVO req, ObjGroupVO g, String style, String alert) {
		ObjMap[] map = g.getValues();
		String[] fields = g.getIndex();
		int fl = fields.length;
		int l = map.length;
		boolean empty = true;

		StringBuilder sb = new StringBuilder();
		String addurl = "";
		if (g.isAddable()) {
			addurl = ObjTables.getFormUrl(req, g, "add");
		}

		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, addurl, ObjTables.GRAYADDIMGURL, "", "", g.getOptions(), req.getOption(), "", "", g.getContenttype()));
		if (fl > 0 && l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"").append(fields[x]).append("\" valign=\"top\">").append(fields[x]).append("</td>\n");
			}
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" valign=\"top\">&nbsp;</td>\n");
			sb.append("</tr>\n");

			for (int i=0; i < l; i++) {
				ObjMap m = map[i];
				boolean display = false;
				if (!CsConfig.isPublic()) { display = true; }
				else if (g.getToken().isStaff()) { display = true; }
				else if (m.isShowpublic()) { display = true; }

				if (display) {
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
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append(CsUiTools.getDelete(m.getId(), m.getRef(), m.getRefid(), g));
//					sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(m.getId()).append("\"/>");
					sb.append("</td>");
					sb.append("</tr>\n");
					empty = false;
				}
			}
			sb.append("</table>\n");
		}
		if (empty) { return ""; }
		return sb.toString(); 

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
				String exp = "";
				if (m.hasExpired()) {
					exp = " title=\"Expired\" expired=\"true\"";
				}

				sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(m.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(m.getId()).append("\">\n");
				for (int x=0; x < fl; x++) {
					try {
						ObjVO o = m.getValues().get(fields[x]);
						String ot = o.getType();
						String oi = o.getItype();
						sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\"").append(exp).append(">");
						sb.append(ObjValues.getDisplay(req, m.getId(), g.getGroup(), g.getGroupid(), o, style, g.getToken()));
						sb.append("</td>\n");
					}
					catch (Exception e) {
						sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
					}
				}
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 

	}






}
