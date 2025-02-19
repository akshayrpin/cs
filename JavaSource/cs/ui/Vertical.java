package cs.ui;

import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.utils.ObjForm;
import cs.utils.ObjTables;
import cs.utils.ObjValues;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;

public class Vertical {

	public static String details(RequestVO req, ObjGroupVO g, String style, String alert) {
		return ui(req, g, style, alert, "details");
	}

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		return ui(req, g, style, alert, "summary");
	}

	public static String id(RequestVO req, ObjGroupVO g, String style, String alert) {
		return id(req, g, style, alert, "history");
	}

	public static String ui(RequestVO req, ObjGroupVO g, String style, String alert, String type) {
		int c = 0;
		int cols = 2;
		ObjVO[] o = g.getObj();
		int l = o.length;
		boolean editable = g.isEditable();
		String editurl = "";
		
		if (g.getGroup().equalsIgnoreCase("projectinfo")) {
            req.setType(g.getObj()[0].getRef());
            req.setTypeid(g.getObj()[0].getRefid());
		}
		
		if (editable) {
			editurl = ObjTables.getFormUrl(req, g);
		}
		String historyurl = "";
		if (g.isHistory()) {
			historyurl = ObjTables.getHistoryUrl(req, g);
		}
		StringBuilder sb = new StringBuilder();
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, "", editurl, g.getOptions(), req.getOption(), historyurl, g.getContenttype()));
		
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("\" colnum=\"").append(cols).append("\" type=\"default\">\n");
			sb.append("<tr>\n");

			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				if (!g.isEditable()) {
					vo.setEditable("N");
				}
				boolean display = vo.isDisplay();
				if (display && CsConfig.isPublic() && !vo.isShowpublic()) { display = false; }
				if (display) {
					String label = vo.getLabel();
					if (c >= cols) {
						sb.append("</tr>\n");
						sb.append("<tr>\n");
						c = 1;
					}
					else { c++; }

					String value = "";
					String empty = "";
					if (vo.getItype().equalsIgnoreCase("empty")) {
						label = "&nbsp;";
						empty = style+"_empty";
					}
					if (Operator.equalsIgnoreCase(type, "details")) {
						value = ObjValues.getDetails(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
					}
					else {
						value = ObjValues.getDisplay(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
					}

					String colspan = "";
					if (vo.getType().equalsIgnoreCase("largetext") || vo.getItype().equalsIgnoreCase("largetextarea")) {
						String e = ObjTables.emptycells(c+1, cols, style);
						if (Operator.hasValue(e)) {
							sb.append(ObjTables.emptycells(c+1, cols, style));
							sb.append("</tr>\n");
							sb.append("<tr>\n");
						}
						c = cols;
						colspan = " colspan=\"" + ((cols * 2) - 1) + "\"";
					}
					else {

					}
					String datatype = "";
					if (Operator.hasValue(vo.getDatatype())) {
						datatype = " datatype=\"" + vo.getDatatype() + "\"";
					}
					sb.append("<td class=\"").append(style).append("_label\" colnum=\"").append(cols).append("\" alert=\"").append(vo.getAlert()).append("\" ").append(datatype).append(" id=\"label_").append(vo.getFieldid()).append("\" valign=\"top\">").append(label).append("</td>\n");
					sb.append("<td class=\"").append(style).append(" vertical ").append(empty).append(" ").append(style).append("_field\"").append(colspan).append(" colnum=\"").append(cols).append("\" ").append(datatype).append(" type=\"").append(vo.getType()).append("\" itype=\"").append(vo.getItype()).append("\" alert=\"").append(vo.getAlert()).append("\" id=\"field_").append(vo.getFieldid()).append("\" valign=\"top\">").append(value).append("</td>\n");
				}
			}
			sb.append(ObjTables.emptycells(c, cols, style));

			sb.append("</tr>\n");
			sb.append("</table>\n");
		}
		else {
			return "";
		}

		return sb.toString();
	}


	public static String form(RequestVO req, ObjGroupVO g, String style, String alert) {
		Logger.highlight("form");
		int c = 0;
		int cols = 2;
		ObjVO[] o = g.getObj();
		int l = o.length;
		boolean editable = g.isEditable();
		String editurl = "";
		if (editable) {
			editurl = ObjTables.getFormUrl(req, g);
		}
		StringBuilder sb = new StringBuilder();
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, "", editurl, g.getOptions(), req.getOption(), "", g.getContenttype()));

		if (g.isDodescription()) {
			sb.append(ObjTables.descriptionForm(g.getDescriptionlabel(), g.getDescriptionvalue(), style, alert));
		}

		if (l < 1) { return ""; }
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("\">\n");
			sb.append("<tr>\n");

			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				boolean hidden = false;
				if (vo.getItype().equalsIgnoreCase("hidden")) { hidden = true; }
				if (vo.getItype().equalsIgnoreCase("libraryid")) { hidden = true; }
				if (!vo.isDisplay()) { hidden = true; }
				if (!hidden) {
					String label = vo.getLabel();
					if (c >= cols) {
						sb.append("</tr>\n");
						sb.append("<tr>\n");
						c = 1;
					}
					else { c++; }

					String value = "";
					String empty = "";

					if (vo.getItype().equalsIgnoreCase("empty")) {
						label = "&nbsp;";
						empty = style+"_empty";
					}

					value = ObjValues.getForm(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, g.getAction(), style, g.getToken());

					String colspan = "";
					if (vo.getType().equalsIgnoreCase("largetext") || vo.getItype().equalsIgnoreCase("largetextarea")) {
						String e = ObjTables.emptycells(c+1, cols, style);
						if (Operator.hasValue(e)) {
							sb.append(ObjTables.emptycells(c+1, cols, style));
							sb.append("</tr>\n");
							sb.append("<tr>\n");
						}
						c = cols;
						colspan = " colspan=\"" + ((cols * 2) - 1) + "\"";
					}
					else {

					}
					sb.append("<td class=\"").append(style).append("_label\" colnum=\"").append(cols).append("\" alert=\"").append(vo.getAlert()).append("\" id=\"label_").append(vo.getFieldid()).append("\" valign=\"top\">").append(label).append("</td>\n");
					sb.append("<td class=\"").append(style).append(" vertical ").append(empty).append(" ").append(style).append("_field\"").append(colspan).append(" colnum=\"").append(cols).append("\" type=\"").append(vo.getType()).append("\" itype=\"").append(vo.getItype()).append("\" alert=\"").append(vo.getAlert()).append("\" id=\"field_").append(vo.getFieldid()).append("\" valign=\"top\">").append(value).append("</td>\n");
				}
				else {
					sb.append(ObjForm.hidden(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style));
				}
			}
			sb.append(ObjTables.emptycells(c, cols, style));

			sb.append("</tr>\n");
			sb.append("</table>\n");
		}
		return sb.toString();
	}

	public static String id(RequestVO req, ObjGroupVO g, String style, String alert, String type) {
		int c = 0;
		int cols = 2;
		ObjVO[] o = g.getObj();
		int l = o.length;
		
		StringBuilder sb = new StringBuilder();

		if (l > 0) {
			sb.append("<table class=\"").append(style).append("\" colnum=\"").append(cols).append("\" type=\"default\">\n");
			sb.append("<tr>\n");

			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				String label = vo.getLabel();
				if (c >= cols) {
					sb.append("</tr>\n");
					sb.append("<tr>\n");
					c = 1;
				}
				else { c++; }

				String value = "";
				String empty = "";
				if (vo.getItype().equalsIgnoreCase("empty")) {
					label = "&nbsp;";
					empty = style+"_empty";
				}
				if (Operator.equalsIgnoreCase(type, "details")) {
					value = ObjValues.getDetails(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
				}
				else {
					value = ObjValues.getDisplay(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
				}

				String colspan = "";
				if (vo.getType().equalsIgnoreCase("largetext") || vo.getItype().equalsIgnoreCase("largetextarea")) {
					String e = ObjTables.emptycells(c+1, cols, style);
					if (Operator.hasValue(e)) {
						sb.append(ObjTables.emptycells(c+1, cols, style));
						sb.append("</tr>\n");
						sb.append("<tr>\n");
					}
					c = cols;
					colspan = " colspan=\"" + ((cols * 2) - 1) + "\"";
				}
				else {

				}
				sb.append("<td class=\"").append(style).append("_label\" colnum=\"").append(cols).append("\" alert=\"").append(vo.getAlert()).append("\" id=\"label_").append(vo.getFieldid()).append("\" valign=\"top\">").append(label).append("</td>\n");
				sb.append("<td class=\"").append(style).append(" vertical ").append(empty).append(" ").append(style).append("_field\"").append(colspan).append(" colnum=\"").append(cols).append("\" type=\"").append(vo.getType()).append("\" itype=\"").append(vo.getItype()).append("\" alert=\"").append(vo.getAlert()).append("\" id=\"field_").append(vo.getFieldid()).append("\" valign=\"top\">").append(value).append("</td>\n");
			}
			sb.append(ObjTables.emptycells(c, cols, style));

			sb.append("</tr>\n");
			sb.append("</table>\n");
		}
		else {
			return "";
		}

		return sb.toString();
	}






}
