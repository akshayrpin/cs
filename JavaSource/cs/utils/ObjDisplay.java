package cs.utils;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Numeral;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;

public class ObjDisplay {

	public static String get(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return get(req, id, group, groupid, vo, style, true);
	}

	public static String get(RequestVO req, int id, String group, String groupid, ObjVO vo, String style, boolean addlink) {
		String value = Operator.toHTML(vo.getText());

		if (Operator.equalsIgnoreCase(value, "-1")) {
			if (!Operator.equalsIgnoreCase(vo.getType(), "integer") && !Operator.equalsIgnoreCase(vo.getType(), "decimal") && !Operator.equalsIgnoreCase(vo.getType(), "currency")) {
				value = "";
			}
		}
		if (!Operator.hasValue(value)) { value = "&nbsp;"; }

		StringBuilder sb = new StringBuilder();

		int sid = vo.getSummaryid();
		if (sid < 1) { sid = vo.getId(); }

		int lid = vo.getLinkid();
		if (lid < 1) { lid = vo.getId(); }

		boolean haslink = 
				Operator.hasValue(vo.getLink()) || 
				(Operator.hasValue(vo.getSummarytype()) && sid > 0) || 
				(Operator.hasValue(vo.getLinktype()) && lid > 0) || 
				(Operator.hasValue(vo.getAdminlink()) && CsConfig.allowAdmin()) ||
				Operator.hasValue(CsConfig.getDetails(group))
				;

		if (!vo.isEditable()) {
			if (Operator.hasValue(vo.getLinktype()) && lid > 0) {
				
			}
			else if(group.equals("attachments")) {
				//TODO temporary fix for PI attachment url need to write separate Attachment.java instead of Horizontal.java
			}
			else {
				haslink = false;
			}
		}

		if (addlink && haslink) {
			sb.append("<a href=\"");

			if (Operator.hasValue(vo.getAdminlink()) && CsConfig.allowAdmin()) {
				sb.append(vo.getAdminlink());
			}
			else if (Operator.hasValue(vo.getLink())) {
				sb.append(vo.getLink());
			}
			else if (Operator.hasValue(vo.getSummarytype()) && sid > 0) {
				sb.append("summary.jsp?");
				sb.append(RequestMapper.entity).append("=").append(req.getEntity());
				sb.append("&");
				sb.append(RequestMapper.type).append("=").append(vo.getSummarytype());
				sb.append("&");
				sb.append(RequestMapper.id).append("=").append(sid);
				sb.append("&");
				sb.append(RequestMapper.typeid).append("=").append(sid);
			}
			else if (Operator.hasValue(vo.getLinktype()) && lid > 0) {
				sb.append(Config.fullcontexturl());
				sb.append("?");
				sb.append(RequestMapper.entity).append("=").append(req.getEntity());
				sb.append("&");
				sb.append(RequestMapper.type).append("=").append(vo.getLinktype());
				sb.append("&");
				sb.append(RequestMapper.typeid).append("=").append(lid);
				vo.setTarget("_top");
			}
			else if (Operator.hasValue(CsConfig.getDetails(group))) {
				sb.append(Config.fullcontexturl());
				sb.append(CsConfig.getDetails(group)).append("?");
				sb.append(RequestMapper.entity).append("=").append(req.getEntity());
				sb.append("&");
				sb.append(RequestMapper.type).append("=").append(req.getType());
				sb.append("&");
				sb.append(RequestMapper.grouptype).append("=").append(group);
				sb.append("&");
				sb.append(RequestMapper.id).append("=").append(id);
				sb.append("&");
				sb.append(RequestMapper.typeid).append("=").append(req.getTypeid());
			}

			sb.append("\"");

			if (Operator.hasValue(vo.getType())) {
				sb.append(" type=\"").append(vo.getType()).append("\"");
			}
			if (Operator.hasValue(vo.getItype())) {
				sb.append(" itype=\"").append(vo.getItype()).append("\"");
			}
			if (Operator.hasValue(style)) {
				sb.append(" class=\"").append(style).append("\"");
			}
			if (Operator.hasValue(vo.getTarget())) {
				sb.append(" target=\"").append(vo.getTarget()).append("\"");
			}
			sb.append(">");
		}

		sb.append(value);
		if (addlink && haslink) { sb.append("</a>"); }
		return sb.toString();
	}

	public static String currency(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();
		value = Numeral.dollar(Operator.toDouble(value));
		return value;
	}

	public static String date(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();
		if (!Operator.hasValue(value)) { return ""; }
		Timekeeper d = new Timekeeper();
		d.setDate(value);
		StringBuilder sb = new StringBuilder();
		sb.append(d.getString("MM/DD/YY"));
		return sb.toString();
	}

	public static String time(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();
		if (!Operator.hasValue(value)) { return ""; }
		Timekeeper d = new Timekeeper();
		d.setTime(value);
		StringBuilder sb = new StringBuilder();
		sb.append(d.getString("TIME"));
		return sb.toString();
	}

	public static String datetime(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();
		if (!Operator.hasValue(value)) { return ""; }
		Timekeeper d = new Timekeeper();
		d.setDate(value);
		StringBuilder sb = new StringBuilder();
		sb.append(d.getString("MM/DD/YYYY @ HH:MM"));
		return sb.toString();
	}

	public static String checkbox(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();
		String fieldid = vo.getFieldid();
		String rel = vo.getRel();
		StringBuilder sb = new StringBuilder();
		sb.append("<input type=\"checkbox\" name=\"").append(fieldid).append("\" rel=\"").append(rel).append("\" value=\"").append(value).append("\"/>");
		return sb.toString();
	}

	public static String dynamiccheckbox(String yesaction, String noaction, RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		if (!vo.isEditable()) {
			return dynamiccheckboxuneditable(yesaction, noaction, req, id, group, groupid, vo, style);
		}

		String value = vo.getValue();

		StringBuilder sb = new StringBuilder();

		if (Operator.equalsIgnoreCase(vo.getType(), yesaction)) {
			if (Operator.equalsIgnoreCase(value, "Y")) {
				sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"Y\" _action=\"").append(noaction).append("\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "N")) {
				sb.append("<img src=\"").append(CsConfig.getImage("incomplete")).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"N\" _action=\"").append(yesaction).append("\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
			}
		}

		return sb.toString();
	}

	public static String dynamiccheckboxuneditable(String yesaction, String noaction, RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();

		StringBuilder sb = new StringBuilder();

		if (Operator.equalsIgnoreCase(vo.getType(), yesaction)) {
			if (Operator.equalsIgnoreCase(value, "Y")) {
				sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" border=\"0\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "N")) {
				sb.append("<img src=\"").append(CsConfig.getImage("incomplete")).append("\" border=\"0\"/>");
			}
		}

		return sb.toString();
	}

	public static String dynamicradio(String radioname, String yesaction, String noaction, RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		if (!vo.isEditable()) {
			return dynamicradiouneditable("primary", "primary", "unprimary", req, id, group, groupid, vo, style);
		}
		String value = vo.getValue();

		StringBuilder sb = new StringBuilder();

		if (Operator.equalsIgnoreCase(vo.getType(), yesaction)) {
			if (Operator.equalsIgnoreCase(value, "Y")) {
				sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" border=\"0\" _ref=\"").append(vo.getRef()).append("\" _grp=\"").append(group).append("\" _deflt=\"N\" _val=\"Y\" _yes=\"").append(yesaction).append("\" _no=\"").append(noaction).append("\" _radio=\"").append(radioname).append("\" _action=\"").append(noaction).append("\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "D")) {
				sb.append("<img src=\"").append(CsConfig.getImage("defaultcomplete")).append("\" border=\"0\" _ref=\"").append(vo.getRef()).append("\" _grp=\"").append(group).append("\" _deflt=\"Y\" _val=\"N\" _yes=\"").append(yesaction).append("\" _no=\"").append(noaction).append("\" _radio=\"").append(radioname).append("\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "N")) {
				sb.append("<img src=\"").append(CsConfig.getImage("incomplete")).append("\" border=\"0\" _ref=\"").append(vo.getRef()).append("\" _grp=\"").append(group).append("\" _deflt=\"N\" _val=\"N\" _yes=\"").append(yesaction).append("\" _no=\"").append(noaction).append("\" _radio=\"").append(radioname).append("\" _action=\"").append(yesaction).append("\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "X")) {
				sb.append("<img src=\"").append(CsConfig.getImage("no")).append("\" border=\"0\"/>");
			}
		}

		return sb.toString();
	}

	public static String dynamicradiouneditable(String radioname, String yesaction, String noaction, RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String value = vo.getValue();

		StringBuilder sb = new StringBuilder();

		if (Operator.equalsIgnoreCase(vo.getType(), yesaction)) {
			if (Operator.equalsIgnoreCase(value, "Y")) {
				sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" border=\"0\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "D")) {
				sb.append("<img src=\"").append(CsConfig.getImage("defaultcomplete")).append("\" border=\"0\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "N")) {
				sb.append("<img src=\"").append(CsConfig.getImage("incomplete")).append("\" border=\"0\"/>");
			}
			else if (Operator.equalsIgnoreCase(value, "X")) {
				sb.append("<img src=\"").append(CsConfig.getImage("no")).append("\" border=\"0\"/>");
			}
		}

		return sb.toString();
	}

	public static String comply(RequestVO req, int id, String group, String groupid, String value, String rel, String style) {
		return comply(req, id, group, groupid, value, rel, CsConfig.getImage("complete"), CsConfig.getImage("incomplete"), style);
	}

	public static String partcomply(RequestVO req, int id, String group, String groupid, String value, String rel, String style) {
		return comply(req, id, group, groupid, value, rel, CsConfig.getImage("partcomplete"), CsConfig.getImage("incomplete"), style);
	}

	public static String comply(RequestVO req, int id, String group, String groupid, String value, String rel, String yesimg, String noimg, String style) {
		StringBuilder sb = new StringBuilder();
		if (Operator.equalsIgnoreCase(value, "Y")) {
			sb.append("<img src=\"").append(yesimg).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"Y\" _rel=\"").append(rel).append("\" _action=\"uncomply\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
		}
		else if (Operator.equalsIgnoreCase(value, "N")) {
			sb.append("<img src=\"").append(noimg).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"N\" _rel=\"").append(rel).append("\" _action=\"comply\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
		}
		return sb.toString();
	}

	public static String apppartcomply(RequestVO req, int id, String group, String groupid, String value, String rel, String style) {
		return appcomply(req, id, group, groupid, value, rel, CsConfig.getImage("partcomplete"), CsConfig.getImage("incomplete"), style);
	}

	public static String appcomply(RequestVO req, int id, String group, String groupid, String value, String rel, String yesimg, String noimg, String style) {
		StringBuilder sb = new StringBuilder();
		if (Operator.equalsIgnoreCase(value, "Y")) {
			sb.append("<img src=\"").append(yesimg).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"Y\" _rel=\"").append(rel).append("\" _action=\"appuncomply\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
		}
		else if (Operator.equalsIgnoreCase(value, "N")) {
			sb.append("<img src=\"").append(noimg).append("\" border=\"0\" _grp=\"").append(group).append("\" _val=\"N\" _rel=\"").append(rel).append("\" _action=\"appcomply\" _grpid=\"").append(groupid).append("\" _id=\"").append(id).append("\"/>");
		}
		return sb.toString();
	}

	public static String complete(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return dynamiccheckbox("complete", "incomplete", req, id, group, groupid, vo, style);
	}

	public static String comply(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return dynamiccheckbox("comply", "uncomply", req, id, group, groupid, vo, style);
	}

	public static String primary(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return dynamicradio("primary", "primary", "unprimary", req, id, group, groupid, vo, style);
	}

	public static String notifylink(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append("<a target=\"lightbox-iframe\" href=\"/cs/notification.jsp?_ent=").append(req.getEntity()).append("&_entid=").append(req.getEntityid()).append("&_type=").append(req.getType()).append("&_typeid=").append(req.getTypeid()).append("&_grptype=communications&_id=").append(vo.getValue()).append("\">");
		sb.append("<img src=\"").append(ObjTables.GRAYOPENEMAILIMGURL).append("\" border=\"0\">");
		sb.append("</a>");
		return sb.toString();
	}









}
