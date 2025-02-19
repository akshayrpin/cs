package cs.ui;

import java.util.HashMap;
import java.util.Map;

import alain.core.utils.Config;
import alain.core.utils.Operator;
import cs.utils.ObjTables;
import cs.utils.RequestMapper;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.SubObjVO;

public class CsUiTools {

	public static String getHTMLImports() {
		StringBuilder sb = new StringBuilder();
		String[] fonts = CsConfig.getValues("htmlimports.fonts.font");
		for (int i=0; i<fonts.length; i++) {
			String font  = fonts[i];
//			font = Operator.replace(font, "/_contextroot", Config.fullcontexturl());
			if (Operator.hasValue(font)) {
				sb.append("<link href=\"").append(font).append("\" rel=\"stylesheet\" type=\"text/css\">\n");
			}
		}

		String[] styles = CsConfig.getValues("htmlimports.style");
		for (int i=0; i<styles.length; i++) {
			String style = styles[i];
			if (Operator.hasValue(style)) {
//				style = Operator.replace(style, "/_contextroot", Config.fullcontexturl());
				sb.append("<link href=\"").append(style).append("\" rel=\"stylesheet\" type=\"text/css\">\n");
			}
		}

		String jquery = CsConfig.getString("htmlimports.jquery");
		if (Operator.hasValue(jquery)) {
//			jquery = Operator.replace(jquery, "/_contextroot", Config.fullcontexturl());
			sb.append("<script language=\"javascript\" type=\"text/javascript\" src=\"").append(jquery).append("\"></script>\n");
		}
		String jqueryui = CsConfig.getString("htmlimports.jqueryui");
		if (Operator.hasValue(jqueryui)) {
//			jqueryui = Operator.replace(jqueryui, "/_contextroot", Config.fullcontexturl());
			sb.append("<script language=\"javascript\" type=\"text/javascript\" src=\"").append(jqueryui).append("\"></script>\n");
		}

		String[] scripts = CsConfig.getValues("htmlimports.script");
		for (int i=0; i<scripts.length; i++) {
			String script  = scripts[i];
			if (Operator.hasValue(script)) {
//				script = Operator.replace(scripts[i], "/_contextroot", Config.fullcontexturl());
				sb.append("<script language=\"javascript\" type=\"text/javascript\" src=\"").append(script).append("\"></script>\n");
			}
		}


		return sb.toString();
	}

	public static String getUrl(String path, String id, String entity, int entityid, String type, int typeid, String group, String grouptype, String groupid, String act) {

		StringBuilder sb = new StringBuilder();
		sb.append(Config.fullcontexturl());
		sb.append("/");
		sb.append(Operator.removeOpeningSlash(path)).append("");

		sb.append("?");
	
		if (Operator.hasValue(act)) {
			sb.append(RequestMapper.id).append("=").append(0).append("");
		}
		else {
			sb.append(RequestMapper.id).append("=").append(Operator.urlFriendly(id)).append("");
		}
		if (grouptype.equalsIgnoreCase("review")) {
			sb.append("&");
			sb.append(RequestMapper.reviewid).append("=").append(id).append("");
		}
		sb.append("&");
		sb.append(RequestMapper.entityid).append("=").append(entityid).append("");
		sb.append("&");
		sb.append(RequestMapper.entity).append("=").append(Operator.urlFriendly(entity)).append("");
		sb.append("&");
		sb.append(RequestMapper.typeid).append("=").append(typeid).append("");
		sb.append("&");
		sb.append(RequestMapper.type).append("=").append(Operator.urlFriendly(type)).append("");
		sb.append("&");
		sb.append(RequestMapper.groupid).append("=").append(Operator.urlFriendly(groupid)).append("");
		sb.append("&");
		sb.append(RequestMapper.group).append("=").append(Operator.urlFriendly(group)).append("");
		sb.append("&");
		sb.append(RequestMapper.grouptype).append("=").append(Operator.urlFriendly(grouptype)).append("");
		if (Operator.hasValue(act)) {
			sb.append("&");
			sb.append(RequestMapper.action).append("=").append(act);
		}
		return sb.toString();
	}

	public static String cells(String fieldid, String fieldname, String value, String type, String itype, int colspan, boolean required, String style, boolean editable) {
		return cells(fieldid, fieldname, value, type, itype, required, style, colspan, new SubObjVO[0], false, editable);
	}

	public static String cells(String fieldid, String fieldname, String value, String type, String itype, boolean required, String style, boolean editable) {
		return cells(fieldid, fieldname, value, type, itype, required, style, 1, new SubObjVO[0], false, editable);
	}

	public static String cells(String fieldid, String fieldname, String value, String type, String itype, boolean required, String style, String choices, boolean multiple, boolean editable) {
		String[] c = Operator.split(choices, ",");
		return cells(fieldid, fieldname, value, type, itype, required, style, c, multiple, editable);
	}

	public static String cells(String fieldid, String fieldname, String value, String type, String itype, boolean required, String style, String[] choices, boolean multiple, boolean editable) {
		SubObjVO[] s = new SubObjVO[choices.length];
		for (int i=0; i<choices.length; i++) {
			String choice = choices[i];
			SubObjVO vo = new SubObjVO();
			vo.setValue(choice);
			vo.setText(choice);
			s[i] = vo;
		}
		return cells(fieldid, fieldname, value, type, itype, required, style, 1, s, false, editable);
	}

	public static String cells(String fieldid, String fieldname, String value, String type, String itype, boolean required, String style, int colspan, SubObjVO[] choices, boolean multiple, boolean editable) {
		String req = "";
		if (required) { req = " class=\"required\""; }
		String cs = "";
		if (itype.equalsIgnoreCase("largetextarea") || itype.equalsIgnoreCase("reviewcomment") || itype.equalsIgnoreCase("largetext")) { cs = " colspan=\"3\""; }
		else if (colspan > 1) {
			cs = " colspan=\""+colspan+"\"";
		}
		String multi = "";
		if (multiple) { multi = " multiple"; }

		StringBuilder sb = new StringBuilder();
		sb.append("<td class=\"").append(style).append("_label\" id=\"label_").append(fieldid).append("\" valign=\"top\">");
		sb.append(fieldname);
		sb.append("</td>");
		sb.append("<td class=\"").append(style).append(" vertical ").append(style).append("_field\" id=\"field_").append(fieldid).append("\"").append(cs).append(" valign=\"top\">");

		if (!editable) {
			sb.append(value);
		}
		else if (choices.length > 0 || type.equalsIgnoreCase("select")) {
			sb.append("<select name=\"").append(fieldid).append("\" itype=\"").append(itype).append("\" val=\"").append(Operator.formFriendly(value)).append("\"").append(req).append(multi).append(">");
			sb.append("<option value=\"\"></option>");
			for (int i=0; i<choices.length; i++) {
				SubObjVO typ = choices[i];
				String cval = Operator.toString(typ.getId());
				if (typ.getId() < 0) {
					if (Operator.hasValue(typ.getValue())) {
						cval = typ.getValue();
					}
					else {
						cval = "";
					}
				}
				HashMap<String, String> addldata = typ.getAddldata();
				sb.append("<option ");
				sb.append(" value=\"").append(cval).append("\" ");
				if (Operator.hasValue(cval) && cval.equalsIgnoreCase(value)) {
					sb.append(" selected");
				}

				for (Map.Entry<String,String> entry : addldata.entrySet()) {
					String f = entry.getKey();
					String v = entry.getValue();
					sb.append(" ").append(f).append("=\"").append(Operator.formFriendly(v)).append("\" ");
				}

				sb.append(">").append(typ.getText()).append("</option>");
			}
			sb.append("</select>");
		}
		else if (itype.equalsIgnoreCase("largetextarea") || itype.equalsIgnoreCase("textarea")) {
			sb.append("<textarea name=\"").append(fieldid).append("\" itype=\"").append(itype).append("\"").append(req).append(" style=\"min-height: 50px\">").append(value).append("</textarea>");
		}
		else if (itype.equalsIgnoreCase("reviewcomment")) {
			sb.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">");
			sb.append("<tr>");
			sb.append("<td width=\"99%\">");
			sb.append("<textarea name=\"").append(fieldid).append("\" itype=\"").append(itype).append("\"").append(req).append(" style=\"min-height: 50px\">").append(value).append("</textarea>");
			sb.append("</td>");
			sb.append("<td width=\"30\" valign=\"top\" align=\"right\" nowrap>");
			sb.append("<img src=\"").append(CsConfig.getImage("searchconditions")).append("\" itype=\"reviewlibrary\" border=\"0\" style=\"display: none\">");
			sb.append("</td>");
			sb.append("</tr>");
			sb.append("</table>");
		}
		else if (itype.equalsIgnoreCase("attachment")) {
			sb.append("<input name=\"").append(fieldid).append("\" type=\"file\" itype=\"").append(itype).append("\"").append(req).append(">");;
		}
		else {
			sb.append("<input name=\"").append(fieldid).append("\" type=\"").append(type).append("\" itype=\"").append(itype).append("\" value=\"").append(Operator.formFriendly(value)).append("\"").append(req).append(">");;
		}

		sb.append("</td>");
		return sb.toString();
	}

	public static String getDelete(int id, ObjGroupVO g) {
		return getDelete(id, "", -1, g);
	}

	public static String getDelete(int id, String ref, int refid, ObjGroupVO g) {
		StringBuilder sb = new StringBuilder();
		sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _ref=\"").append(ref).append("\" _refid=\"").append(refid).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(id).append("\"/>");
		return sb.toString();
	}




}
