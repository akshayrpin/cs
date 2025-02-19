package cs.ui;

import java.lang.reflect.Method;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import cs.utils.ObjTables;
import cs.utils.RequestMapper;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.RequestVO;
import csshared.vo.ToolVO;
import csshared.vo.ToolsVO;
import csshared.vo.TypeVO;

public class CsUi {

	public static String summary(RequestVO req, TypeVO t, String style) {
		return summary(req, t.getGroups(), style, "");
	}

	public static String summary(RequestVO req, TypeVO t, String style, String alert) {
		return summary(req, t.getGroups(), style, alert);
	}

	public static String summary(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			String ui = getUi("summary", req, g[i], style, alert);
			if (Operator.hasValue(ui)) {
				sb.append(ui);
//				sb.append(getUi("summary", req, g[i], style, alert));
				sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String id(RequestVO req, TypeVO t, String style) {
		return id(req, t.getGroups(), style, "");
	}

	public static String id(RequestVO req, TypeVO t, String style, String alert) {
		return id(req, t.getGroups(), style, alert);
	}

	public static String id(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			String ui = getUi("id", req, g[i], style, alert);
			if (Operator.hasValue(ui)) {
				sb.append(ui);
//				sb.append(getUi("summary", req, g[i], style, alert));
				sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String details(RequestVO req, TypeVO t, String style) {
		return details(req, t.getGroups(), style, "");
	}

	public static String details(RequestVO req, TypeVO t, String style, String alert) {
		return details(req, t.getGroups(), style, alert);
	}

	public static String details(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			String ui = getUi("details", req, g[i], style, alert);
			if (Operator.hasValue(ui)) {
				sb.append(ui);
//				sb.append(getUi("details", req, g[i], style, alert));
				sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String info(RequestVO req, TypeVO t, String style) {
		return info(req, t.getGroups(), style, "");
	}

	public static String info(RequestVO req, TypeVO t, String style, String alert) {
		return info(req, t.getGroups(), style, alert);
	}

	public static String info(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			String ui = getUi("info", req, g[i], style, alert);
			if (Operator.hasValue(ui)) {
				sb.append(ui);
				sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String form(RequestVO req, TypeVO t, String style) {
		return form(req, t, style, "");
	}

	public static String form(RequestVO req, TypeVO t, String style, String alert) {
		StringBuilder sb = new StringBuilder();
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.entity).append("\" value=\"").append(t.getEntity()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.type).append("\" value=\"").append(t.getType()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.typeid).append("\" value=\"").append(t.getTypeid()).append("\">\n");
		sb.append(form(req, t.getGroups(), style, alert));
		return sb.toString();
	}

	public static String form(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		style = style.trim();
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			boolean empty = true;
			for (int i = 0; i < l; i++) {
				ObjGroupVO vo = g[i];
				String f = getUi("form", req, vo, style, alert);
				if (Operator.hasValue(f)) {
					empty = false;
				}
				sb.append(f);
				sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.groupid).append("\" value=\"").append(vo.getGroupid()).append("\">\n");
				sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.group).append("\" value=\"").append(vo.getGroup()).append("\">\n");
				sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.grouptype).append("\" value=\"").append(vo.getType()).append("\">\n");
				sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.id).append("\" value=\"").append(req.getId()).append("\">\n");
				sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
			}
			if (empty) {
				sb.append("<table class=\"").append(style).append("\">\n");
				sb.append("<tr>\n");
				
				sb.append("<td class=\"").append(style).append(" ").append(style).append("_field\" valign=\"top\">No records to update</td>\n");

				sb.append("</tr>\n");
				sb.append("</table>\n");
			}
			else {
				sb.append("<div class=\"").append(style).append("_buttons\"><input type=\"submit\" name=\"action\" value=\"save\" class=\"").append(style).append("_button\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String history(RequestVO req, TypeVO t, String style) {
		return history(req, t.getGroups(), style, "");
	}

	public static String history(RequestVO req, TypeVO t, String style, String alert) {
		return history(req, t.getGroups(), style, alert);
	}

	public static String history(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		String date = "";
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("_timeline\" cellpadding=\"10\" cellspacing=\"0\" width=\"100%\">\n");
		for (int i = 0; i < l; i++) {
			ObjGroupVO vo = g[i];
			String ui = getUi("id", req, vo, style, alert);
			if (Operator.hasValue(ui)) {
				String first = "N";
				if (empty) { first = "Y"; }
				empty = false;
				String id = Operator.randomString(25);
				sb.append("<tr>");

				sb.append("<td class=\"").append(style).append("_timeline_date\">");
				if (Operator.hasValue(vo.getUpdated())) {
					Timekeeper d = new Timekeeper();
					d.setDate(vo.getUpdated());
					String uidate = d.getString("SHORTDATE");
					if (Operator.equalsIgnoreCase(uidate, date)) {
						sb.append("&nbsp;");
					}
					else {
						sb.append(uidate);
					}
					date = uidate;
				}
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("_timeline_bullet\" group=\"").append(vo.getModulechanged()).append("\" groupid=\"").append(vo.getModulechangedid()).append("\" first=\"").append(first).append("\" rel=\"").append(id).append("\"><img src=\"").append(Config.emptyImageUrl()).append("\" width=\"20\" height=\"20\"/></td>");

				sb.append("<td class=\"").append(style).append("_timeline_title\">");
				sb.append("<table cellpadding=\"2\" cellspacing=\"0\" width =\"100%\">");
				sb.append("<tr>");
				sb.append("<td class=\"").append(style).append("_timeline_title\" width=\"1%\" nowrap>");
				Timekeeper d = new Timekeeper();
				d.setDate(vo.getUpdated());
				sb.append(d.standardTime()).append(": ");
				sb.append(vo.getModulechangedaction().toUpperCase());
				sb.append(" ");
				sb.append(vo.getModulechanged().toUpperCase());
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("_timeline_label\">");
				sb.append("&nbsp;");
				sb.append("</td>");
				
				sb.append("<td class=\"").append(style).append("_timeline_label\" align=\"right\" width=\"1%\" nowrap>");
				sb.append(vo.getLabel());
				sb.append("</td>");
				sb.append("</tr>");
				sb.append("</table>");

				sb.append("</td>");
				sb.append("</tr>");
				sb.append("<tr class=\"").append(style).append("_timeline_content\" id=\"").append(id).append("\" first=\"").append(first).append("\">");
				sb.append("<td class=\"").append(style).append("_timeline_date\">&nbsp;</td>");
				sb.append("<td class=\"").append(style).append("_timeline_line\"><img src=\"").append(Config.emptyImageUrl()).append("\" width=\"20\" height=\"20\"/></td>");
				sb.append("<td class=\"").append(style).append("_timeline_content\" id=\"content_").append(id).append("\">");
				if (vo.getModulechanged().equalsIgnoreCase("lso") || vo.getModulechanged().equalsIgnoreCase("project") || vo.getModulechanged().equalsIgnoreCase("activity")) {
					sb.append(ui);
				}
				sb.append("</td>");
				sb.append("</tr>");
			}
		}
		sb.append("</table>");
		return sb.toString();
	}

	public static String list(RequestVO req, TypeVO t, String style) {
		return list(req, t.getGroups(), style, "");
	}

	public static String list(RequestVO req, TypeVO t, String style, String alert) {
		return list(req, t.getGroups(), style, alert);
	}

	public static String list(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			ObjGroupVO vo = g[i];
			String ui = getUi("list", req, vo, style, alert);
			if (Operator.hasValue(ui)) {
				sb.append(ui);
			}
		}
		return sb.toString();
	}

	public static String getTitle(TypeVO t) {
		String title = t.getTitle();
		try {
			if (t.getGroups().length == 1) {
				ObjGroupVO g = t.getGroups()[0];
				if (Operator.hasValue(g.getTitle())) {
					title = g.getTitle();
				}
			}
		}
		catch (Exception e) { }
		return title;
	}

	public static String getSubtitle(TypeVO t) {
		String subtitle = t.getSubtitle();
		try {
			if (t.getGroups().length == 1) {
				ObjGroupVO g = t.getGroups()[0];
				if (Operator.hasValue(g.getSubtitle())) {
					subtitle = g.getSubtitle();
				}
			}
		}
		catch (Exception e) { }
		return subtitle;
	}

	public static String getUi(String uitype, RequestVO req, ObjGroupVO g, String style, String alert) {

		String result = "";
		String method = g.getType();
		String display = g.getDisplay();
		
		//Logger.info("IFRAMEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"+display);
		//if (Operator.equalsIgnoreCase(display, "iframe")) { display = "iframe"; }
		if (Operator.equalsIgnoreCase(display, "hz")) { display = "horizontal"; }
		if (Operator.equalsIgnoreCase(display, "ct")) { display = "crosstab"; }
		if (Operator.equalsIgnoreCase(display, "vert")) { display = "vertical"; }
		if (Operator.equalsIgnoreCase(display, "details")) { display = "details"; }
		if (!Operator.hasValue(uitype)) { uitype = "summary"; }

		if (!Operator.hasValue(display)) {
			if (Operator.hasValue(g.getFields()) && Operator.hasValue(g.getValues())) {
				display = "horizontal";
			}
			else if (Operator.hasValue(g.getFields())) {
				display = "crosstab";
			}
			else {
				display = "vertical";
			}

		}
		boolean v = false;
		try {
			StringBuilder sb =  new StringBuilder();
			sb.append("cs.ui.").append(Operator.toTitleCase(method));
			String classname = sb.toString();
			Logger.info("REFLECT METHOD", method + " - " + classname + "." + uitype.toLowerCase() +"(RequestVO req, ObjGroupVO g, String style, String alert)");
			Class<?> _class = Class.forName(classname);
			Method _method = _class.getDeclaredMethod(uitype, new Class[]{RequestVO.class, ObjGroupVO.class, String.class, String.class});
			result = (String) _method.invoke(null, new Object[]{req, g, style, alert});
			v = true;
		}
		catch (Exception e) {
			if (Operator.hasValue(display)) {
				try {
					StringBuilder sb =  new StringBuilder();
					sb.append("cs.ui.").append(Operator.toTitleCase(display));
					String classname = sb.toString();
					Logger.info("CATCH REFLECT METHOD", method + " - " + classname + "." + uitype.toLowerCase() +"(RequestVO req, ObjGroupVO g, String style, String alert)");
					Class<?> _class = Class.forName(classname);
					Method _method = _class.getDeclaredMethod(uitype, new Class[]{RequestVO.class, ObjGroupVO.class, String.class, String.class});
					result = (String) _method.invoke(null, new Object[]{req, g, style, alert});
					v = true;
				}
				catch (Exception se) {
					result = getDefaultUi(uitype, req, g, style, alert);
					v = true;
				}
			}
			else {
				result = getDefaultUi(uitype, req, g, style, alert);
				v = true;
			}
		}

		if (!v) {
			result = getDefaultUi(uitype, req, g, style, alert);
		}
		return result;
	}


	public static String getDefaultUi(String uitype, RequestVO req, ObjGroupVO g, String style, String alert) {
		if (Operator.equalsIgnoreCase(uitype, "info")) {
			return Horizontal.info(req, g, style, alert);
		}
		else if (Operator.equalsIgnoreCase(uitype, "form")) {
			return Vertical.form(req, g, style, alert);
		}
//		else if (Operator.equalsIgnoreCase(uitype, "history")) {
//			return Horizontal.history(req, g, style, alert);
//		}
		else {
			return Vertical.summary(req, g, style, alert);
		}
	}

	public static String getTools(ToolsVO tools, String style) {
		ToolVO[] ta = tools.getTools();
		int l = ta.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("_tools\">\n");
			sb.append("  <tr>\n");
			for (int i = 0; i < l; i++) {
				ToolVO t = ta[i];
				if (!t.isDisabled()) {
					String image = CsConfig.getImage(t.getImage());
					String tool = t.getTool();
					String random = Operator.randomString(10);
					sb.append("<td class=\"").append(style).append("_tools\">\n");
					sb.append("<a onclick=\"return(controlLoad('").append(random).append("'))\" href=\"");
					sb.append(Config.fullcontexturl()).append("/");

					if(Operator.equalsIgnoreCase(tool, "print")) { sb.append("printall.jsp"); }
					else if(Operator.equalsIgnoreCase(tool, "map")){ sb.append("map.jsp"); }
					else { sb.append(Operator.removeOpeningSlash(CsConfig.getForm(tool, ""))); }

					sb.append("?");
					sb.append(RequestMapper.entity).append("=").append(tools.getEntity());
					sb.append("&");
					sb.append(RequestMapper.entityid).append("=").append(tools.getEntityid());
					sb.append("&");
					sb.append(RequestMapper.type).append("=").append(tools.getType());
					sb.append("&");
					sb.append(RequestMapper.typeid).append("=").append(tools.getTypeid());
					sb.append("&");
					sb.append(RequestMapper.grouptype).append("=").append(tool);
					sb.append("&");
					sb.append(RequestMapper.action).append("=").append(t.getAction());
					sb.append("\"");

					if (Operator.hasValue(t.getTitle())) {
						sb.append(" title=\"").append(t.getTitle()).append("\" border=\"0\" ");
					}
					
					if(Operator.equalsIgnoreCase(tool, "print")){
						sb.append(" target=\"_blank\" ");
					}
					
					sb.append(" >").append("<img id=\"").append(random).append("\" src=\"").append(image).append("\" border=\"0\"></a>\n");
					sb.append("</td>\n");
				}
			}
			sb.append("  </tr>\n");
			sb.append("</table>\n");
		}
		
		return sb.toString();
	}

	public static String modules(RequestVO req, TypeVO t, String ui, String style, String alert) {
		String[] modules = t.getModule(ui);
		if (!Operator.hasValue(modules)) {
			modules = new String[0];
		}
		return modules(req, modules, ui, style, alert);
	}

	public static String modules(RequestVO req, String[] modules, String ui, String style, String alert) {
		StringBuilder sb = new StringBuilder();
		if (Operator.hasValue(modules)) {
			int l = modules.length;
			for (int i = 0; i < l; i++) {
				String group = modules[i];
				sb.append(ajaxElem(group, ui, style, alert));
			}
		}
		return sb.toString();
	}

	public static String ajaxElem(String group, String ui, String uistyle, String alert) {
		StringBuilder sb = new StringBuilder();
		sb.append("<div group=\"").append(group).append("\" ui=\"").append(ui).append("\" uistyle=\"").append(uistyle).append("\" uialert=\"").append(alert).append("\">");
//		sb.append(ObjTables.title("Loading "+group+"...", "", uistyle, alert, "", "", new String[0], "", ""));
//		sb.append("<div class=\"").append(uistyle).append("_divider\"></div>\n");
		sb.append("</div>");
		return sb.toString();
	}




}
