package cs.ui;

import alain.core.utils.Operator;
import cs.utils.ObjTables;
import cs.utils.ObjValues;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.SubObjVO;

public class Crosstab {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		ObjVO[] o = g.getObj();
		String[] fields = g.getFields();
		int l = o.length;
		int fl = fields.length;
		StringBuilder sb = new StringBuilder();
		if (fl > 0 && l > 0) {
			sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, "", ObjTables.getFormUrl(req, g, "edit"), g.getOptions(), req.getOption(), "", g.getContenttype()));
			boolean editable = g.isEditable();
			sb.append("<table class=\"").append(style).append("\" type=\"crosstab\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\">&nbsp;</td>\n");
			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\">").append(fields[x]).append("</td>\n");
			}
			if(editable) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\">&nbsp;</td>\n");
			}
			sb.append("</tr>\n");

			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				if (!g.isEditable()) {
					vo.setEditable("N");
				}
				sb.append("<tr class=\"").append(style).append("\">\n");
				sb.append("<td class=\"").append(style).append("_label\" alert=\"").append(vo.getAlert()).append("\">").append(vo.getLabel()).append("</td>\n");
				for (int x=0; x < fl; x++) {
					try {
						SubObjVO s = vo.getValues().get(fields[x]);
						sb.append("<td class=\"").append(style).append("\" type=\"").append(s.getType()).append("\" itype=\"").append(vo.getItype()).append("\">").append(ObjValues.getDisplay(req, vo.getId(), g.getGroup(), g.getGroupid(), s, style, g.getToken())).append("</td>\n");
					}
					catch (Exception e) {
						sb.append("<td class=\"").append(style).append("\">&nbsp;</td>\n");
					}
				}
				req.setId(Operator.toString(vo.getId()));
				if(editable) {
					String editurl = ObjTables.getFormUrl(req, g);
					if (Operator.hasValue(editurl)) {
						sb.append("<td class=\"").append(style).append("_rowcontrols\">");
						sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("_rowcontrols\"><img src=\"").append(ObjTables.GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
						sb.append("</td>");
					}
				}
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 

	}







}
