package cs.utils;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.SubObjVO;

public class ObjForm {

	public static String get(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		if (Operator.hasValue(vo.getChoices()) || Operator.hasValue(vo.getJson()) || Operator.hasValue(vo.getLkup())) {
			return select(req, id, group, groupid, vo, style);
		}
		return input(req, id, group, groupid, vo, vo.getItype(), style);
	}

	public static String empty(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return "&nbsp;";
	}

	public static String input(RequestVO req, int id, String group, String groupid, ObjVO vo, String type, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append("<input");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" type=\"").append(type).append("\"");
		sb.append(" itype=\"").append(vo.getItype().toLowerCase()).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		sb.append(" value=\"").append(vo.getValue()).append("\"");
		if (Operator.hasValue(vo.getPlaceholder())) {
			sb.append(" placeholder=\"").append(vo.getPlaceholder()).append("\"");
		}
		if (vo.isRequired()) {
			sb.append(" valrequired=\"true\"");
		}
		if (vo.getMaxchar() > 0) {
			sb.append(" maxchar=\"").append(vo.getMaxchar()).append("\"");
		}
		sb.append(">");
		return sb.toString();
	}

	public static String multiselect(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return select(req, id, group, groupid, vo, style);
	}

	public static String select(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String entity = req.getEntity();
		if (Operator.hasValue(vo.getEntity())) {
			entity = vo.getEntity();
		}
		SubObjVO[] sa = vo.getChoices();
		String v = vo.getValue();
		String[] a = Operator.split(v, "|");
		String json = vo.getJson();
		String lkup = vo.getLkup();
		int l = sa.length;
		StringBuilder sb = new StringBuilder();
		sb.append("<select");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" itype=\"").append(vo.getItype()).append("\"");
		sb.append(" val=\"").append(Operator.formFriendly(vo.getValue())).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		sb.append(" updateonchangeof=\"").append(vo.getUpdateonchangeof()).append("\"");
		sb.append(" ").append(RequestMapper.entity).append("=\"").append(entity).append("\"");
		if (vo.isRequired()) {
			sb.append(" valrequired=\"true\"");
		}
		if (Operator.hasValue(json)) {
			sb.append(" json=\"").append(vo.getJson()).append("\"");
		}
		if (Operator.hasValue(lkup)) {
			sb.append(" lkup=\"").append(vo.getLkup()).append("\"");
		}
		if (vo.getItype().equalsIgnoreCase("multiselect")) {
			sb.append(" multiple");
		}
		sb.append(">");
		sb.append("<option value=\"\"></option>");
		boolean sel = false;
		for (int i=0; i < l; i++) {
			SubObjVO s = sa[i];
			String c = s.getValue();
			String t = s.getText();
			
			
			sb.append("<option");
			if ((Operator.hasValue(c) && c.equalsIgnoreCase(v)) || t.equalsIgnoreCase(v)) {
				Logger.info(" apppendddddddddddddddddd");
				sb.append(" selected");
				sel = true;
			}
			else if (Operator.containsIgnoreCase(a, c) || Operator.containsIgnoreCase(a, t)) {
				if(!sel){
					sb.append(" selected");
					sel = true;
				}
			}
			else if (s.isSelected()) {
				if(!sel){
					sb.append(" selected");
					sel = true;
				}
			}
			if(Operator.hasValue(c)){
				sb.append(" value=\"").append(Operator.formFriendly(c)).append("\"");
			}
			
			sb.append(">");
			sb.append(s.getText());
			sb.append("</option>");
		}
		sb.append("</select>");
		return sb.toString();
	}

	public static String choice(RequestVO req, int id, String group, String groupid, ObjVO vo, String type, String style) {
		SubObjVO[] sa = vo.getChoices();
		String v = vo.getValue();
		String[] a = Operator.split(v, "|");
		int l = sa.length;
		StringBuilder sb = new StringBuilder();
		for (int i=0; i < l; i++) {
			SubObjVO s = sa[i];
			String c = s.getValue();
		
			if(!Operator.hasValue(c)){
				c = s.getText();
			}
			
			sb.append("<input");
			sb.append(" name=\"").append(vo.getFieldid()).append("\"");
			sb.append(" type=\"").append(type).append("\"");
			sb.append(" itype=\"").append(vo.getItype()).append("\"");
			sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
			if (Operator.hasValue(c) && Operator.hasValue(v) &&  c.equalsIgnoreCase(v) ) {
				sb.append(" checked");
			}
			else if (Operator.containsIgnoreCase(a, c)) {
				sb.append(" checked");
			}
			//sb.append(" value=\"").append(s.getValue()).append("\"");
			sb.append(" value=\"").append(c).append("\"");
			sb.append(">");
			sb.append(ObjDisplay.get(req, id, group, groupid, s.toObj(), style));
			sb.append("</br>");
		}
		return sb.toString();
	}

	public static String uneditable(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append(ObjDisplay.get(req, id, group, groupid, vo, style));
		return sb.toString();
	}

	public static String hidden(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return input(req, id, group, groupid, vo, "hidden", style);
	}

	public static String libraryid(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return input(req, id, group, groupid, vo, "hidden", style);
	}

	public static String date(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String d = vo.getDate();
		if (!Operator.hasValue(d)) { d = vo.getValue(); }

		if (Operator.hasValue(d)) {
			Timekeeper t = new Timekeeper();
			if (Operator.hasValue(d)) {
				t = new Timekeeper(d);
				if (t.hasValue()) {
					StringBuilder sb = new StringBuilder();
					sb.append(t.getString("YYYY/MM/DD"));
					vo.setValue(sb.toString());
				}
			}
		}
		else if (Operator.hasValue(vo.getDefaultvalue())) {
			Timekeeper dv = new Timekeeper();
			if (Operator.equalsIgnoreCase(vo.getDefaultvalue(), "current")) {
				d = dv.getString("YYYY/MM/DD");
				vo.setValue(d);
			}
			else if (Operator.isNumber(vo.getDefaultvalue())) {
				int adddays = Operator.toInt(vo.getDefaultvalue());
				dv.addDay(adddays);
				d = dv.getString("YYYY/MM/DD");
				vo.setValue(d);
			}
		}
		return input(req, id, group, groupid, vo, "text", style);
	}

	public static String datetime(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String d = vo.getDate();
		if (!Operator.hasValue(d)) { d = vo.getValue(); }
		if (Operator.hasValue(d)) {
			Timekeeper t = new Timekeeper();
			t.setTimestamp(d);
			if (t.hasValue()) {
				StringBuilder sb = new StringBuilder();
				sb.append(t.getString("YYYY/MM/DD"));
				sb.append(" ");
				sb.append(t.hh());
				sb.append(":");
				sb.append(t.minute());
				vo.setValue(sb.toString());
			}
		}
		else if (Operator.hasValue(vo.getDefaultvalue())) {
			Timekeeper dv = new Timekeeper();
			if (Operator.equalsIgnoreCase(vo.getDefaultvalue(), "current")) {
				StringBuilder sb = new StringBuilder();
				sb.append(dv.getString("YYYY/MM/DD"));
				sb.append(" ");
				sb.append(dv.hh());
				sb.append(":");
				sb.append(dv.minute());
				vo.setValue(sb.toString());
			}
			else if (Operator.isNumber(vo.getDefaultvalue())) {
				int adddays = Operator.toInt(vo.getDefaultvalue());
				dv.addDay(adddays);
				StringBuilder sb = new StringBuilder();
				sb.append(dv.getString("YYYY/MM/DD"));
				sb.append(" ");
				sb.append(dv.hh());
				sb.append(":");
				sb.append(dv.minute());
				vo.setValue(sb.toString());
			}
		}

		return input(req, id, group, groupid, vo, "text", style);
	}

	public static String checkbox(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		if (vo.getChoices().length > 0) {
			return choice(req, id, group, groupid, vo, "checkbox", style);
		}
		StringBuilder sb = new StringBuilder();
		sb.append("<input");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" type=\"checkbox\"");
		sb.append(" itype=\"").append(vo.getItype()).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		if (Operator.hasValue(vo.getValue())) {
			sb.append(" checked");
		}
		sb.append(" value=\"").append(vo.getValue()).append("\"");
		sb.append(">");

		sb.append(ObjDisplay.get(req, id, group, groupid, vo, style));
		return sb.toString();
	}

	public static String toggle(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		String v = vo.getValue();
		sb.append("<div>");
		sb.append("<input");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" type=\"checkbox\"");
		sb.append(" data-id=\"toggleCheckbox\"");
		sb.append(" itype=\"").append(vo.getItype()).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		if (v.equalsIgnoreCase("Y")) {
			sb.append(" checked");
		}
		sb.append(" value=\"Y\"");
		sb.append(">");
		sb.append("</div>");
		return sb.toString();
	}

	public static String yesno(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		vo.setItype("boolean");
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String inspectable(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String warning(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String complete(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String required(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String active(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String enable(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return toggle(req, id, group, groupid, vo, style);
	}

	public static String largetextarea(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return textarea(req, id, group, groupid, vo, style);
	}

	public static String librarydescription(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return textarea(req, id, group, groupid, vo, style);
	}

	public static String textarea(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append("<textarea");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" itype=\"").append(vo.getItype()).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		if (vo.isRequired()) {
			sb.append(" valrequired=\"true\"");
		}
		sb.append(">");
		sb.append(vo.getValue());
		sb.append("</textarea>");
		return sb.toString();
	}

	public static String comment(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return textarea(req, id, group, groupid, vo, style);
	}

	public static String richtext(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return textarea(req, id, group, groupid, vo, style);
	}

	public static String file(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		if( (req.getGroup().equalsIgnoreCase("attachments") || req.getGrouptype().equalsIgnoreCase("attachments") )&& Operator.toInt(req.getId())>0){
			String ext = Operator.getExt(vo.getValue());
			String icon = Config.getFileIcon(ext);
			String linkurl = vo.getLink();
			sb.append(" <a href=\"").append(linkurl).append("\" target=\"_blank\"><img src=\"").append(icon).append("\" border=\"0\"/></a> &nbsp; ");
		}

		sb.append("<input");
		sb.append(" name=\"").append(vo.getFieldid()).append("\"");
		sb.append(" type=\"file\"");
		
		sb.append(" itype=\"").append(vo.getItype().toLowerCase()).append("\"");
		sb.append(" updateval=\"").append(vo.getUpdatevalues()).append("\"");
		if (vo.isRequired() && !Operator.hasValue(vo.getValue())) {
			sb.append(" valrequired=\"true\"");
		}
		if( (req.getGroup().equalsIgnoreCase("attachments") || req.getGrouptype().equalsIgnoreCase("attachments") ) && Operator.toInt(req.getId())<=0){
			sb.append(" multiple=\"multiple\"");
		}
		sb.append("/>");
		
		return sb.toString();
	}

	public static String people(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String entity = req.getEntity();
		if (Operator.hasValue(vo.getEntity())) {
			entity = vo.getEntity();
		}
		String type = req.getType();
		if (Operator.hasValue(vo.getType())) {
			type = vo.getType();
		}
		String fieldid = vo.getFieldid();
		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\" itype=\"people\" width=\"100%\">\n");
		sb.append("<tr>\n");
		sb.append("<td></td>");
		sb.append("<td width=\"99%\" align=\"right\"><a class=\"lightbox-iframe\" href=\"").append(Config.fullcontexturl()).append("/addpeople.jsp?").append(RequestMapper.entity).append("=").append(Operator.urlFriendly(entity)).append("&").append(RequestMapper.type).append("=").append(Operator.urlFriendly(type)).append("&fieldid=").append(Operator.urlFriendly(fieldid)).append("\"><img src=\"").append(CsConfig.getImage("black", "add")).append("\"/></a></td>\n");
		sb.append("</tr>\n");
		SubObjVO[] s = vo.getChoices();
		int l = s.length;
		for (int i=0; i<l; i++) {
			SubObjVO svo = s[i];
			String value = svo.getValue();
			String text = svo.getText();
			String c = "";
			if (svo.isSelected()) {
				c = " checked";
			}
			sb.append("<tr>\n");
			sb.append("<td class=\"csform_checkbox\"><input type=\"checkbox\" name=\"").append(fieldid).append("\" value=\"").append(value).append("\" class=\"csform_checkbox\"").append(c).append("/></td>");
			sb.append("<td width=\"99%\" class=\"csform_checkboxtext\">").append(text).append("</td>\n");
			sb.append("</tr>\n");
		}
		sb.append("</table>\n");
		return sb.toString();
	}

	public static String team(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String entity = req.getEntity();
		if (Operator.hasValue(vo.getEntity())) {
			entity = vo.getEntity();
		}
		String type = req.getType();
		if (Operator.hasValue(vo.getType())) {
			type = vo.getType();
		}
		String fieldid = vo.getFieldid();
		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\" itype=\"team\" width=\"100%\" id=\"table_").append(fieldid).append("\">\n");
		sb.append("<tr>\n");
		sb.append("<td width=\"1%\" nowrap></td>");
		sb.append("<td colspan=\"3\" align=\"right\"><a target=\"lightbox-iframe\" href=\"").append(Config.fullcontexturl()).append("/selectteam.jsp?").append(RequestMapper.entity).append("=").append(Operator.urlFriendly(entity)).append("&").append(RequestMapper.type).append("=").append(Operator.urlFriendly(type)).append("&fieldid=").append(Operator.urlFriendly(fieldid)).append("\"><img src=\"").append(CsConfig.getImage("black", "add")).append("\"/></a></td>\n");
		sb.append("</tr>\n");
		SubObjVO[] s = vo.getChoices();
		int l = s.length;
		for (int i=0; i<l; i++) {
			SubObjVO svo = s[i];
			String value = svo.getValue();
			String text = svo.getText();
			String c = "";
			if (svo.isSelected()) {
				c = " checked";
			}
			sb.append("<tr>\n");
			sb.append("<td width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"").append(fieldid).append("\" value=\"").append(value).append("\" class=\"csform_checkbox\"").append(c).append("/></td>");
			sb.append("<td colspan=\"2\" class=\"csform_checkboxtext\">").append(text).append("</td>\n");
			sb.append("</tr>\n");
		}
		sb.append("</table>\n");
		return sb.toString();
	}

	public static String teammember(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		String entity = req.getEntity();
		if (Operator.hasValue(vo.getEntity())) {
			entity = vo.getEntity();
		}
		String type = req.getType();
		if (Operator.hasValue(vo.getType())) {
			type = vo.getType();
		}
		String fieldid = vo.getFieldid();
		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\" itype=\"team\" width=\"100%\" id=\"table_").append(fieldid).append("\">\n");
		sb.append("<tr>\n");
		sb.append("<td width=\"1%\" nowrap></td>");
		sb.append("<td colspan=\"3\" align=\"right\"><a target=\"lightbox-iframe\" href=\"").append(Config.fullcontexturl()).append("/selectteammember.jsp?").append(RequestMapper.entity).append("=").append(Operator.urlFriendly(entity)).append("&").append(RequestMapper.type).append("=").append(Operator.urlFriendly(type)).append("&fieldid=").append(Operator.urlFriendly(fieldid)).append("\"><img src=\"").append(CsConfig.getImage("black", "add")).append("\"/></a></td>\n");
		sb.append("</tr>\n");
		SubObjVO[] s = vo.getChoices();
		int l = s.length;
		for (int i=0; i<l; i++) {
			SubObjVO svo = s[i];
			String value = svo.getValue();
			String text = svo.getText();
			String c = "";
			if (svo.isSelected()) {
				c = " checked";
			}
			sb.append("<tr class=\"teamrow_").append(fieldid).append("\">\n");
			sb.append("<td width=\"1%\" nowrap class=\"csform_checkbox\"><input type=\"checkbox\" name=\"").append(fieldid).append("\" value=\"").append(value).append("\" class=\"csform_checkbox\"").append(c).append("/></td>");
			sb.append("<td colspan=\"2\" class=\"csform_checkboxtext\">").append(text).append("</td>\n");
			sb.append("</tr>\n");
		}
		sb.append("</table>\n");
		return sb.toString();
	}

	public static String apptreview(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return select(req, id, group, groupid, vo, style);
	}
	
	public static String reviewstatus(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return select(req, id, group, groupid, vo, style);
	}
	
	public static String reviewusers(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		return select(req, id, group, groupid, vo, style);
	}

	public static String username(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append(hidden(req, id, group, groupid, vo, style));
		sb.append(req.getUsername());
		return sb.toString();
	}

	public static String librarycode(RequestVO req, int id, String group, String groupid, ObjVO vo, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\" width=\"100%\">");
		sb.append("<tr>");
		sb.append("<td width=\"99%\">");
		sb.append(input(req, id, group, groupid, vo, "text", style));
		sb.append("</td>");
		sb.append("<td width=\"1%\" nowrap>");
		sb.append("<img src=\"").append(CsConfig.getImage("searchconditions")).append("\" itype=\"library\" border=\"0\">");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		return sb.toString();
	}



}











