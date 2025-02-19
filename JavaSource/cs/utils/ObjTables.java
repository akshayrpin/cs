package cs.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONObject;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import csshared.utils.CsApi;
import csshared.utils.CsConfig;
import csshared.vo.AppointmentScheduleVO;
import csshared.vo.AppointmentVO;
import csshared.vo.ComboReviewList;
import csshared.vo.ComboReviewVO;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjMap;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.ResolutionDetailVO;
import csshared.vo.ResolutionVO;
import csshared.vo.ReviewActionVO;
import csshared.vo.ReviewVO;
import csshared.vo.SubObjVO;
import csshared.vo.ToolVO;
import csshared.vo.ToolsVO;

public class ObjTables {

	public static String WHITEEDITIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/edit.png";
	public static String WHITEHISTORYIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/history.png";
	public static String WHITEIMPORTIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/import.png";
	public static String WHITEADDIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/add.png";
	public static String WHITEEXPIREIMGURL = Config.fullcontexturl()+"/images/icons/hourglass.png";
	public static String WHITEALLIMGURL = Config.fullcontexturl()+"/images/icons/all.png";
	public static String WHITEMULTIEDITIMGURL = Config.fullcontexturl()+"/images/icons/multiedit.png";
	public static String WHITECOMPLETEIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/complete.png";
	public static String WHITEMOREINFOIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/info.png";
	public static String WHITEMOREIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/more.png";
	public static String WHITEQUESTIONIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/question.png";
	public static String WHITEHELPIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/help.png";
	public static String GRAYEDITIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/edit.png";
	public static String GRAYVIEWIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/view.png";
	public static String WHITEDELETEIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/delete.png";
	public static String GRAYDELETEIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/delete.png";
	public static String GRAYADDIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/add.png";
	public static String GRAYADDMINIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/addmin.png";
	public static String GRAYDOWNIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/down.png";
	public static String GRAYTEAMIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/team.png";
	public static String GRAYUSERIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/user.png";
	public static String GRAYCALENDARIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/calendar.png";
	public static String GRAYOPENEMAILIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/openemail.png";
	public static String GRAYHELPIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/help.png";
	public static String BLACKHELPIMGURL = Config.fullcontexturl()+"/images/icons/controls/black/help.png";
	
	
	public static String getTools(ToolsVO tools, String style) {
		ToolVO[] ta = tools.getTools();
		int l = ta.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("_tools\">\n");
			sb.append("  <tr>\n");
			for (int i = 0; i < l; i++) {
				ToolVO t = ta[i];
				String tool = t.getTool();
				String toolaction = t.getAction();
				if (!t.isToolDisabled()) {
					String img = t.getImage();
					if (!Operator.hasValue(img)) {
						img = t.getTool().toLowerCase();
					}
					String image = CsConfig.getImage(img);
					if (Operator.hasValue(image)) {
						if (Operator.equalsIgnoreCase(tool, "search")) {
							//if(!Operator.equalsIgnoreCase(CsConfig.getString("public"), "Y")){
								sb.append("<td class=\"").append(style).append("_tools typesearch\" style=\"cursor: pointer\" title=\"search\">\n");
								sb.append("<img src=\"").append(image).append("\" border=\"0\">\n");
								sb.append("</td>\n");
							//}
						}
						else {
							sb.append("<td class=\"").append(style).append("_tools\">\n");
							sb.append("<a href=\"");

							sb.append(Config.fullcontexturl()).append("/");
							if(Operator.equalsIgnoreCase(tool, "print")){
								sb.append("printall.jsp");
							}
							else if(Operator.equalsIgnoreCase(tool, "map")){
								sb.append("map.jsp");
							}
							else if(Operator.equalsIgnoreCase(toolaction, "more")){
								sb.append(Operator.removeOpeningSlash(CsConfig.getMore(tool)));
							}
							else {
								sb.append(Operator.removeOpeningSlash(CsConfig.getForm(tool, "")));
							}
							
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
							if(Operator.equalsIgnoreCase(tool, "print")){
								sb.append("&");
								sb.append(RequestMapper.reference).append("=").append(CsConfig.getPublic());
							}

							sb.append("\" title=\"").append(t.getTitle()).append("\" border=\"0\" ");
							
							if(Operator.equalsIgnoreCase(tool, "print")){
								//sb.append(" target=\"_blank\" ");
								sb.append(" target=\"lightbox-iframe\" ");
							}
							
							sb.append(" >").append("<img src=\"").append(image).append("\" border=\"0\"></a>\n");
							sb.append("</td>\n");
						}
					}
				}
			}
			sb.append("  </tr>\n");
			sb.append("</table>\n");
		}
		
		return sb.toString();
	}

	public static String getCloseTools(ToolsVO tools, String style) {
		ToolVO[] ta = tools.getTools();
		int l = ta.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("_tools\">\n");
			sb.append("  <tr>\n");

			String image = CsConfig.getImage("back");

			sb.append("<td class=\"").append(style).append("_tools\">\n");
			sb.append("<a href=\"");

			sb.append(Config.fullcontexturl()).append("/summary.jsp");
			sb.append("?");
			sb.append(RequestMapper.entity).append("=").append(tools.getEntity());
			sb.append("&");
			sb.append(RequestMapper.entityid).append("=").append(tools.getEntityid());
			sb.append("&");
			sb.append(RequestMapper.type).append("=").append(tools.getType());
			sb.append("&");
			sb.append(RequestMapper.typeid).append("=").append(tools.getTypeid());

			sb.append("\" title=\"Back to Summary\" border=\"0\" ");
			
			sb.append(" >").append("<img src=\"").append(image).append("\" border=\"0\"></a>\n");
			sb.append("</td>\n");
			sb.append("  </tr>\n");
			sb.append("</table>\n");
		}
		
		return sb.toString();
	}

	public static String getForm(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			ObjGroupVO vo = g[i];
			sb.append(vertical(req, vo, style, alert, 2, false, true));
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.groupid).append("\" value=\"").append(vo.getGroupid()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.group).append("\" value=\"").append(vo.getGroup()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.grouptype).append("\" value=\"").append(vo.getType()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.id).append("\" value=\"").append(req.getId()).append("\">\n");

			sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
		}
		return sb.toString();
	}

	public static String getVerticalForm(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			ObjGroupVO vo = g[i];
			sb.append(vertical(req, vo, style, alert, 1, false, true));
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.groupid).append("\" value=\"").append(vo.getGroupid()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.group).append("\" value=\"").append(vo.getGroup()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.grouptype).append("\" value=\"").append(vo.getType()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.id).append("\" value=\"").append(req.getId()).append("\">\n");

			sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
		}
		return sb.toString();
	}

	public static String getMiniForm(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			ObjGroupVO vo = g[i];
			sb.append(mini(req, vo, style, alert, true));
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.groupid).append("\" value=\"").append(vo.getGroupid()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.group).append("\" value=\"").append(vo.getGroup()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.grouptype).append("\" value=\"").append(vo.getType()).append("\">\n");
			sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.id).append("\" value=\"").append(req.getId()).append("\">\n");

			sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
		}
		return sb.toString();
	}

	public static String getTable(RequestVO req, ObjGroupVO[] g, String style, String alert, boolean sub) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			sb.append(getTable(req, g[i], style, alert, sub));
			sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
		}
		return sb.toString();
	}

	public static String getHistory(RequestVO req, ObjGroupVO[] g, String style, String alert) {
		int l = g.length;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < l; i++) {
			sb.append(getHistory(req, g[i], style, alert));
			sb.append("<div class=\"").append(style).append("_divider\"></div>\n");
		}
		return sb.toString();
	}

	public static String getHistory(RequestVO req, ObjGroupVO g, String style, String alert) {
		return getTable(req, g, style, alert, false, true);
	}

	public static String getTable(RequestVO req, ObjGroupVO g, String style, String alert, boolean sub) {
		return getTable(req, g, style, alert, sub, false);
	}

	public static String getTable(RequestVO req, ObjGroupVO g, String style, String alert, boolean sub, boolean history) {
		StringBuilder sb = new StringBuilder();
//		if (g != null) {
			String grouptype = g.getType();
			String display = g.getDisplay();
			if (display.equalsIgnoreCase("hz") || display.equalsIgnoreCase("horizontal")) {
				sb.append(horizontal(req, g, style, alert, sub, history));
			}
			else if (display.equalsIgnoreCase("vert") || display.equalsIgnoreCase("vertical")) {
				sb.append(vertical(req, g, style, alert, 2, false, false));
			}
			else if (display.equalsIgnoreCase("ct") || display.equalsIgnoreCase("crosstab")) {
				sb.append(crosstab(req, g, style, alert));
			}
			else if (grouptype.equalsIgnoreCase("review")) {
				sb.append(review(req, g, style));
			}
			else if (grouptype.equalsIgnoreCase("resolution")) {
				sb.append(resolution(req, g, style, alert));
			}
			else if (grouptype.equalsIgnoreCase("appointment")) {
				sb.append(appointment(req, g, style, alert, sub));
			}
			else if (grouptype.equalsIgnoreCase("holds")) {
				sb.append(horizontal(req, g, style, alert, sub, history));
			}
			else if (Operator.hasValue(g.getFields()) && Operator.hasValue(g.getValues())) {
				sb.append(horizontal(req, g, style, alert, sub, history));
			}
			else if (Operator.hasValue(g.getFields())) {
				if(grouptype.equalsIgnoreCase("finance") || grouptype.equalsIgnoreCase("setback")){
					sb.append(crosstab(req, g, style, alert));
				}
				else {
					sb.append(crosstab(req, g, style, alert));
				}
			}
			else {
				sb.append(vertical(req, g, style, alert, 2, false, false));
			}
			
//		}
		return sb.toString();
	}

	// ###############################
	// ## Title
	// ###############################

	public static String title(String title, String detailurl, String style, String alert, String addurl, String editurl, String[] options, String selectedoption, String historyurl, String contenttype) {
		return title(title, detailurl, style, alert, addurl, WHITEADDIMGURL, editurl, WHITEEDITIMGURL, "", "", options, selectedoption, historyurl, WHITEHISTORYIMGURL, contenttype, WHITEHELPIMGURL);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String editurl, String[] options, String selectedoption, String historyurl, String moreurl, String moreimg, String contenttype) {
		return title(title, detailurl, style, alert, addurl, WHITEADDIMGURL, editurl, WHITEEDITIMGURL, "", "", options, selectedoption, historyurl, WHITEHISTORYIMGURL, moreurl, moreimg, contenttype, WHITEHELPIMGURL);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String editurl, String[] options, String selectedoption, String historyurl, String contenttype, String helpimg) {
		return title(title, detailurl, style, alert, addurl, WHITEADDIMGURL, editurl, WHITEEDITIMGURL, "", "", options, selectedoption, historyurl, WHITEHISTORYIMGURL, contenttype, helpimg);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String addimg, String editurl, String editimg, String[] options, String selectedoption, String historyurl, String historyimg, String contenttype, String helpimg) {
		return title(title, detailurl, style, alert, addurl, addimg, editurl, editimg, "", "", options, selectedoption, historyurl, historyimg, contenttype, helpimg);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String addimg, String editurl, String editimg, String[] options, String selectedoption, String historyurl, String historyimg, String contenttype) {
		return title(title, detailurl, style, alert, addurl, addimg, editurl, editimg, "", "", options, selectedoption, historyurl, historyimg, contenttype, WHITEHELPIMGURL);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String addimg, String editurl, String editimg, String importurl, String importimg, String[] options, String selectedoption, String historyurl, String historyimg, String contenttype) {
		return title(title, detailurl, style, alert, addurl, addimg, editurl, editimg, importurl, importimg, options, selectedoption, historyurl, historyimg, contenttype, WHITEHELPIMGURL);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String addimg, String editurl, String editimg, String importurl, String importimg, String[] options, String selectedoption, String historyurl, String historyimg, String contenttype, String helpimg) {
		return title(title, detailurl, style, alert, addurl, addimg, editurl, editimg, importurl, importimg, options, selectedoption, historyurl, historyimg, "", "", contenttype, helpimg);
	}

	public static String title(String title, String detailurl, String style, String alert, String addurl, String addimg, String editurl, String editimg, String importurl, String importimg, String[] options, String selectedoption, String historyurl, String historyimg, String moreurl, String moreimg, String contenttype, String helpimg) {
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("_title ").append(style).append("alert\"");
		if (Operator.hasValue(alert)) {
			sb.append(" alert=\"").append(alert).append("\"");
		}
		sb.append(">\n");
		sb.append("<tr>\n");
		if (Operator.hasValue(contenttype)) {
			if (!Operator.hasValue(helpimg)) {
				helpimg = WHITEHELPIMGURL;
			}
			sb.append("<td class=\"").append(style).append("_contenttype\">");
			sb.append("<a href=\"").append(Config.fullcontexturl()).append("/jsp/content.jsp?content=").append(Operator.urlFriendly(contenttype)).append("\" title=\"More Information\" target=\"lightbox-iframe\">");
			sb.append("<img src=\"").append(helpimg).append("\" border=\"0\"/>");
			sb.append("</a>");
			sb.append("</td>\n");
		}
		sb.append("<td class=\"").append(style).append("_title\">");
		if (Operator.hasValue(detailurl)) {
//			sb.append("<a href=\"").append(detailurl).append("\" class=\"").append(style).append("_title\">");
		}
		sb.append(title);
		if (Operator.hasValue(detailurl)) {
//			sb.append("</a>");
		}
		sb.append("</td>\n");
		if (Operator.hasValue(options)) {
			sb.append("<td class=\"").append(style).append("_controls\" valign=\"bottom\">");
			sb.append("<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\" class=\"").append(style).append("_options_table\">");
			sb.append("<tr>");
			for (int i=0; i<options.length; i++) {
				sb.append("<td class=\"");
				sb.append(style).append("_options");
				if ((!Operator.hasValue(selectedoption) && i == 0) || Operator.equalsIgnoreCase(options[i], selectedoption)) {
					sb.append(" selected_option");
				}
				sb.append("\" option=\"").append(options[i]).append("\">");
				sb.append(options[i]);
				sb.append("</td>");
				sb.append("<td>&nbsp;</td>");
			}
			sb.append("<td style=\"padding-right: 10px\">&nbsp;</td>");
			sb.append("</tr>");
			sb.append("</table>");
			sb.append("</td>");
		}
//		if (Operator.hasValue(historyurl)) {
//			String i = Operator.randomString(10);
//			sb.append("<td class=\"").append(style).append("_controls\">");
//			sb.append("<a href=\"").append(historyurl).append("\" class=\"").append(style).append("_controls\" onclick=\"return(controlLoad('").append(i).append("'))\"><img id=\"").append(i).append("\" src=\"").append(historyimg).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
//			sb.append("</td>");
//			sb.append("<td class=\"").append(style).append("_controls\">&nbsp;</td>");
//		}
		if (Operator.hasValue(importurl)) {
			String i = Operator.randomString(10);
			sb.append("<td class=\"").append(style).append("_controls\">");
			sb.append("<a href=\"").append(importurl).append("\" class=\"").append(style).append("_controls\" onclick=\"return(controlLoad('").append(i).append("'))\" title=\"import\"><img id=\"").append(i).append("\" src=\"").append(importimg).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
			sb.append("</td>");
			sb.append("<td class=\"").append(style).append("_controls\">&nbsp;</td>");
		}
		if (Operator.hasValue(addurl)) {
			String i = Operator.randomString(10);
			sb.append("<td class=\"").append(style).append("_controls\">");
			sb.append("<a href=\"").append(addurl).append("\" class=\"").append(style).append("_controls\" onclick=\"return(controlLoad('").append(i).append("'))\" title=\"add\"><img id=\"").append(i).append("\" src=\"").append(addimg).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
			sb.append("</td>");
			sb.append("<td class=\"").append(style).append("_controls\">&nbsp;</td>");
		}
		if (Operator.hasValue(editurl)) {
			String i = Operator.randomString(10);
			sb.append("<td class=\"").append(style).append("_controls\">");
			sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("_controls\" onclick=\"return(controlLoad('").append(i).append("'))\" title=\"edit\"><img id=\"").append(i).append("\" src=\"").append(editimg).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
			sb.append("</td>");
		}
		if (Operator.hasValue(moreurl)) {
			String i = Operator.randomString(10);
			sb.append("<td class=\"").append(style).append("_controls\">");
			sb.append("<a href=\"").append(moreurl).append("\" class=\"").append(style).append("_controls\" onclick=\"return(controlLoad('").append(i).append("'))\" title=\"view more\"><img id=\"").append(i).append("\" src=\"").append(moreimg).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
			sb.append("</td>");
		}
		sb.append("<td class=\"").append(style).append("_controls\">&nbsp;</td>");
		sb.append("</tr>\n");
		sb.append("</table>\n");
		return sb.toString();
	}

	public static String descriptionDisplay(String label, String value, String style, String alert) {
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("\"");
		if (Operator.hasValue(alert)) {
			sb.append(" alert=\"").append(alert).append("\"");
		}
		sb.append(">\n");
		sb.append("<tr>\n");
		sb.append("<td class=\"").append(style).append("_label\" id=\"label_g_description\" valign=\"top\">");
		sb.append(label);
		sb.append("</td>");
		sb.append("<td class=\"").append(style).append(" id=\"field_g_description\" valign=\"top\">").append(value).append("</td>\n");
		sb.append("</tr>\n");
		sb.append("</table>\n");
		return sb.toString();
	}

	public static String descriptionForm(String label, String value, String style, String alert) {
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("\"");
		if (Operator.hasValue(alert)) {
			sb.append(" alert=\"").append(alert).append("\"");
		}
		sb.append(">\n");
		sb.append("<tr>\n");
		sb.append("<td class=\"").append(style).append("_label\" id=\"label_g_description\" valign=\"top\">");
		sb.append(label);
		sb.append("</td>");
		sb.append("<td class=\"").append(style).append(" id=\"field_g_description\" valign=\"top\">");
		sb.append("<input name=\"g_description\" type=\"text\" itype=\"String\" value=\"").append(value).append("\">");
		sb.append("</td>\n");
		sb.append("</tr>\n");
		sb.append("</table>\n");
		return sb.toString();
	}

	// ###############################
	// ## Tables
	// ###############################

	public static String vertical(RequestVO req, ObjGroupVO g, String style, String alert, int cols, boolean sub, boolean form) {
		int c = 0;
		ObjVO[] o = g.getObj();
		int l = o.length;
		StringBuilder sb = new StringBuilder();
		if (sub) {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, "", "", getFormUrl(req, g), GRAYADDIMGURL, g.getOptions(), req.getOption(), "", "", g.getContenttype()));
		}
		else {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, "", getFormUrl(req, g), g.getOptions(), req.getOption(), "", g.getContenttype()));
		}

		if (g.isDodescription()) {
			sb.append(ObjTables.descriptionDisplay(g.getDescriptionlabel(), g.getDescriptionvalue(), style, alert));
		}

		if (l > 0) {
			sb.append("<table class=\"").append(style).append("\" colnum=\"").append(cols).append("\" type=\"default\">\n");
			sb.append("<tr>\n");

			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				boolean hidden = false;
				if (form && vo.getItype().equalsIgnoreCase("hidden")) { hidden = true; }
				if (form && vo.getItype().equalsIgnoreCase("libraryid")) { hidden = true; }
				if (!form && !vo.isDisplay()) { hidden = true; }
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
					if (form) {
						value = ObjValues.getForm(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, g.getAction(), style, g.getToken());
					}
					else {
						value = ObjValues.getDisplay(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
					}
					String colspan = "";
					if (vo.getType().equalsIgnoreCase("largetext") || vo.getItype().equalsIgnoreCase("largetextarea")) {
						String e = emptycells(c+1, cols, style);
						if (Operator.hasValue(e)) {
							sb.append(emptycells(c+1, cols, style));
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
				else if (form) {
					sb.append(ObjForm.hidden(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style));
				}
			}
			sb.append(emptycells(c, cols, style));

			sb.append("</tr>\n");
			sb.append("</table>\n");
		}

		return sb.toString();
	}

	public static String emptycells(int count, int cols, String style) {
		StringBuilder sb = new StringBuilder();
		if (count < cols) {
			int l = cols - count;
			for (int i=0; i < l; i++) {
				sb.append("<td class=\"").append(style).append("_label\" colnum=\"").append(cols).append("\">&nbsp;</td>\n");
				sb.append("<td class=\"").append(style).append("\" colnum=\"").append(cols).append("\">&nbsp;</td>\n");
			}
		}
		return sb.toString();
	}

	public static String mini(RequestVO req, ObjGroupVO g, String style, String alert, boolean form) {
		ObjVO[] o = g.getObj();
		int l = o.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"mini\">\n");
			for (int i=0; i < l; i++) {
				ObjVO vo = o[i];
				String value = "";
				if (form) {
					value = ObjValues.getForm(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, g.getAction(), style, g.getToken());
				}
				else {
					value = ObjValues.getDisplay(req, vo.getId(), g.getGroup(), g.getGroupid(), vo, style, g.getToken());
				}
				sb.append("<tr>\n");
				sb.append("<td class=\"").append(style).append("\" type=\"").append(vo.getType()).append("\" itype=\"").append(vo.getItype()).append("\" alert=\"").append(vo.getAlert()).append("\">").append(value).append("</td>\n");
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString();
	}

	public static String review(RequestVO req, ObjGroupVO g, String style) {
		ComboReviewList o = g.getComboreview();
		StringBuilder sb = new StringBuilder();
		sb.append(title(g.getLabel(), getDetailUrl(req, g), style, "", getFormUrl(req, g, "add"), GRAYADDIMGURL, "", "", g.getOptions(), req.getOption(), "", "", g.getContenttype()));

		LinkedHashMap<Integer, ComboReviewVO> comboreviews = o.getComboreviews();
		if (comboreviews.size() > 0) {
			for (Map.Entry<Integer, ComboReviewVO> entry : comboreviews.entrySet()) {
				ComboReviewVO crv = entry.getValue();
				String approved = "N";
				String unapproved = "N";
				if (crv.isApproved()) {
					approved = "Y";
				}
				else if (crv.isUnapproved()) {
					unapproved = "Y";
				}
				Timekeeper s = new Timekeeper();
				s.setDate(crv.getStart());
				Timekeeper e = new Timekeeper();
				e.setDate(crv.getDue());
				String formurl = getFormUrl(req, g, crv, "");
//				sb.append(title(s.getString("MM/DD/YYYY"), "", style.concat("_header"), "", "", GRAYADDMINIMGURL, "", ""));

				sb.append("<table class=\"").append(style).append("_review_title\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\" type=\"review\">");
				sb.append("<tr>");
				sb.append("<td class=\"").append(style).append("_review_title\">");
				sb.append("<a href=\"").append(formurl).append("\" class=\"").append(style).append("_review_title\">");
				if (Operator.hasValue(crv.getCombotitle())) {
					sb.append(crv.getCombotitle()).append(" - ");
				}
				sb.append(s.getString("MM/DD/YYYY"));
				sb.append("</a>");
				sb.append("</td>");
				if (!crv.isFinal()) {
					sb.append("<td class=\"").append(style).append("_title_control\" width=\"20\" height=\"20\" expedited=\"").append(crv.getExpedited()).append("\">");
					sb.append("<a href=\"").append(formurl).append("\">").append("<img src=\"").append(GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
				}
				else {
					sb.append("<td class=\"").append(style).append("_title_control\" width=\"20\" height=\"20\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\">");
					sb.append("<a href=\"").append(formurl).append("\">").append("<img src=\"").append(Config.emptyImageUrl()).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
				}
				sb.append("</td>");
				sb.append("</tr>");
				sb.append("</table>");

				sb.append("<table class=\"").append(style).append("\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\" type=\"review\">");
				LinkedHashMap<Integer, ReviewVO> reviews = crv.getReviews();
				for (Map.Entry<Integer, ReviewVO> rentry : reviews.entrySet()) {
					ReviewVO rv = rentry.getValue();
					ReviewActionVO rva = rv.getCurrent();
					String currapproved = "N";
					String currunapproved = "N";
					if (rv.isApproved()) {
						currapproved = "Y";
					}
					else if (rv.isUnapproved()) {
						currunapproved = "Y";
					}

				    String expired = " expired=\"false\"";
				    if (rv.daystilldue >= 0) {
				    	if (rv.duedate().past()) {
				    		if (!rva.isApproved() && !rva.isFinal()) {
					    		expired = " expired=\"true\"";
				    		}
				    	}
				    }

				    sb.append("<tr>");

					sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"70%\" unapproved=\"").append(currunapproved).append("\" approved=\"").append(currapproved).append("\"").append(expired).append(">");

					sb.append("<a class=\"").append(style).append("\" href=\"");
					sb.append(Config.fullcontexturl()).append("/editreview.jsp");
					sb.append("?").append(RequestMapper.id).append("=").append(req.getId());
					sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
					sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
					sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
					sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
					sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
					sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
					sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
					sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
					sb.append("\" target=\"lightbox-iframe\">");

					sb.append(rv.getReview());
					sb.append("</a>");

					sb.append("</td>");

					sb.append("<td class=\"").append(style).append("_header\" align=\"right\" width=\"30%\" unapproved=\"").append(currunapproved).append("\" approved=\"").append(currapproved).append("\"").append(expired).append(">");
					sb.append("<a class=\"").append(style).append("_header\" href=\"");
					sb.append(Config.fullcontexturl()).append("/editreview.jsp");
					sb.append("?").append(RequestMapper.id).append("=").append(req.getId());
					sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
					sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
					sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
					sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
					sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
					sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
					sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
					sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
					sb.append("\" target=\"lightbox-iframe\">");
					sb.append(rv.getStatus());
					sb.append("</a>");
					sb.append("</td>");

					sb.append("</tr>");
				}
				sb.append("</table>");
				sb.append("<br/>");
			}
		}



//		for (int i=0; i < l; i++) {
//			ReviewVO vo = o[i];
//			RequestVO revreq = req.duplicate();
//			revreq.setId(Operator.toString(vo.getReviewid()));
//			sb.append(title(vo.getReview(), getDetailUrl(revreq, g), style.concat("_header"), "", getFormUrl(revreq, g, "add"), GRAYADDMINIMGURL, "", ""));
//			sb.append(review(revreq, vo, style));
//		}

		return sb.toString();
	}

	public static String apptReview(RequestVO req, ObjGroupVO g, String style) {
		ComboReviewList o = g.getComboreview();
		StringBuilder sb = new StringBuilder();

		LinkedHashMap<Integer, ComboReviewVO> comboreviews = o.getComboreviews();
		if (comboreviews.size() > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"review\">");
			sb.append("<tr>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>&nbsp;</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>PROJECT</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>ACTIVITY</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\">REVIEW</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>ADDRESS</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>APPT</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>TEAM</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>STATUS</td>");
			sb.append("</tr>");
			for (Map.Entry<Integer, ComboReviewVO> entry : comboreviews.entrySet()) {
				ComboReviewVO crv = entry.getValue();
				String approved = "N";
				String unapproved = "N";
				if (crv.isApproved()) {
					approved = "Y";
				}
				else if (crv.isUnapproved()) {
					unapproved = "Y";
				}

				Timekeeper s = new Timekeeper();
				s.setDate(crv.getStart());
				Timekeeper e = new Timekeeper();
				e.setDate(crv.getDue());

				LinkedHashMap<Integer, ReviewVO> reviews = crv.getReviews();
				for (Map.Entry<Integer, ReviewVO> rentry : reviews.entrySet()) {
					ReviewVO rv = rentry.getValue();
					LinkedHashMap<Integer, ReviewActionVO> actions = rv.getActions();
					for (Map.Entry<Integer, ReviewActionVO> aentry : actions.entrySet()) {
						ReviewActionVO actv = aentry.getValue();
						AppointmentVO apptv = actv.getAppointment();
						AppointmentScheduleVO schv = apptv.getFirstSchedule();
						String currapproved = "N";
						String currunapproved = "N";
						if (rv.isApproved()) {
							currapproved = "Y";
						}
						else if (rv.isUnapproved()) {
							currunapproved = "Y";
						}
						sb.append("<tr>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						if (!actv.isExpired()) {
							sb.append("<input");
							sb.append(" type=\"checkbox\" ");
							sb.append(" name=\"ID\" ");
							sb.append(" value=\"").append(schv.getId()).append("\" ");
							sb.append(" availabilityid=\"").append(rv.getAvailabilityid()).append("\"");
							sb.append(" reviewid=\"").append(rv.getReviewid()).append("\"");
							sb.append(" />");
						}
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getProject());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getActivity());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\">");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(rv.getReview());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getAddress());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(schv.asText());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(rv.teamMembers(actv.getId()));
						sb.append("</a>");
						sb.append("</td>");



						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("_header\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(actv.getStatus());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("</tr>");
					}
				}
			}
			sb.append("</table>");
			sb.append("<br/>");
		}

		return sb.toString();
	}

	public static String appointment(RequestVO req, ObjGroupVO g, String style, String alert, boolean sub) {
		String entity = req.getEntity();
		int entityid = req.getEntityid();
		String type = req.getType();
		int typeid = req.getTypeid();
		String group = g.getGroup();
		String grouptype = g.getType();
		String groupid = g.getGroupid();
		AppointmentVO[] a = g.getAppointments();

		StringBuilder sb = new StringBuilder();
		int l = a.length;

		if (l > 0) {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, getFormUrl(req, g, "add"), "", g.getOptions(), req.getOption(), "", g.getContenttype()));
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"TYPE\">TYPE</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"SUBJECT\">SUBJECT</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"DATE\">DATE</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"STATUS\">STATUS</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\">&nbsp;</td>\n");

			for (int i=0; i < l; i++) {
				AppointmentVO vo = a[i];
				AppointmentScheduleVO avo = vo.getFirstSchedule();

				sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(vo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(vo.getId()).append("\">\n");
				sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" label=\"TYPE\">").append(vo.getAppttype()).append("</td>");
				sb.append("<td class=\"").append(style).append("\" type=\"String\" itype=\"text\" label=\"SUBJECT\">").append(vo.getSubject()).append("</td>");
				sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"DATE\">").append(avo.asText()).append("</td>");
				sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"STATUS\">").append(avo.getStatus()).append("</td>");

				sb.append("<td class=\"").append(style).append("_rowcontrols\" nowrap>");
				if (vo.getComboreviewid() > 0) {
					sb.append("<a class=\"").append(style).append("\" href=\"");
					sb.append(Config.fullcontexturl()).append("/editreview.jsp");
					sb.append("?").append(RequestMapper.id).append("=").append(req.getId());
					sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
					sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
					sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
					sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
					sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
					sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
					sb.append("&").append(RequestMapper.reviewid).append("=").append(vo.getReviewid());
					sb.append("&").append(RequestMapper.reviewrefid).append("=").append(vo.getRefreviewid());
					sb.append("\" target=\"lightbox-iframe\">");
					if (avo.isScheduled()) {
						sb.append("<img src=\"").append(GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
					}
					else {
						sb.append("<img src=\"").append(GRAYVIEWIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
					}
					sb.append("</a>");
				}
				else if (avo.isScheduled()) {
						sb.append("<img src=\"").append(GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(vo.getId()).append("\"/>");
				}
				else {
					sb.append("&nbsp;");
				}
				sb.append("</td>");

				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 
	}

	public static String crosstab(RequestVO req, ObjGroupVO g, String style, String alert) {
		ObjVO[] o = g.getObj();
		String[] fields = g.getFields();
		int l = o.length;
		int fl = fields.length;
		StringBuilder sb = new StringBuilder();
		if (fl > 0 && l > 0) {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, getFormUrl(req, g, "add"), "", g.getOptions(), req.getOption(), "", g.getContenttype()));
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
					String editurl = getFormUrl(req, g);
					if (Operator.hasValue(editurl)) {
						sb.append("<td class=\"").append(style).append("_rowcontrols\">");
						sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("_rowcontrols\"><img src=\"").append(GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
						sb.append("</td>");
					}
				}
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 

	}

	public static String resolution(RequestVO req, ObjGroupVO g, String style, String alert) {
		ResolutionVO[] arr = g.getResolutions();
		String entity = req.getEntity();
		int entityid = req.getEntityid();
		String type = req.getType();
		int typeid = req.getTypeid();
		String group = g.getGroup();
		String grouptype = g.getType();
		String groupid = g.getGroupid();
		boolean editable = (g.isEditable());
		int l = arr.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {
			String addurl = "";
			if (g.isAddable()) {
				addurl = getFormUrl(req, g, "add");
			}

			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, addurl, "", g.getOptions(), req.getOption(), "", g.getContenttype()));
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"number\" colspan=\"2\" valign=\"top\">number</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"title\" valign=\"top\">title</td>\n");
			if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"complied\" width=\"1%\" nowrap  valign=\"top\">complied</td>\n");
			}
			else {
				sb.append("<td class=\"").append(style).append("_header\" label=\"type\" width=\"1%\" nowrap  valign=\"top\">type</td>\n");
				sb.append("<td class=\"").append(style).append("_header\" label=\"reference\" width=\"1%\" nowrap  valign=\"top\">reference</td>\n");
			}
			sb.append("<td class=\"").append(style).append("_header\" label=\"adopted\" valign=\"top\" width=\"1%\" nowrap>adopted</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\"></td>\n");
			sb.append("</tr>\n");

			String cls = style;
			if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
//				cls = style+"_groupheader";
			}

			for (int i=0; i<l; i++) {
				ResolutionVO vo = arr[i];

				String editurl = getUrl(CsConfig.getForm(g.getGroup(), g.getType()), "-1", entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");

				sb.append("<tr class=\"").append(style).append("\" resid=\"").append(vo.getId()).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(vo.getId()).append("\" recordid=\"").append(vo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(vo.getId()).append("_").append(vo.getId()).append("\">\n");

				sb.append("<td class=\"").append(cls).append("\" type=\"type\" itype=\"type\" label=\"number\" valign=\"top\" colspan=\"2\">");
				sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
				sb.append(vo.getNumber());
				sb.append("</a>");
				sb.append("</td>");

				if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
					sb.append("<td class=\"").append(cls).append("\" type=\"text\" itype=\"String\" label=\"title\" valign=\"top\">");
				}
				else {
					sb.append("<td class=\"").append(cls).append("\" type=\"text\" itype=\"String\" label=\"title\" valign=\"top\" colspan=\"3\">");
				}
				sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
				sb.append(vo.getTitle());
				sb.append("</a>");
				sb.append("</td>");

				if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
					sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"complete\" label=\"complied\" valign=\"top\" align=\"center\">");
					if (vo.isAdopted() && vo.isComplied()) {
						sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" _relid=\"").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					else {
						sb.append("<img src=\"").append(Config.emptyImageUrl()).append("\" _relid=\"").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					sb.append("</td>");
				}
				
				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"date\" label=\"adopted\" valign=\"top\">");
				if (Operator.hasValue(vo.getAdopted())) {
					sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
					sb.append(vo.adoptedDate().getString("MM/DD/YY"));
					sb.append("</a>");
				}
				else {
					sb.append("&nbsp;");
				}
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("_rowcontrols\" width=\"1%\" nowrap>");
				sb.append("<img src=\"").append(GRAYDOWNIMGURL).append("\" resid=\"").append(vo.getId()).append("\" on=\"false\" width=\"20\" height=\"20\" border=\"0\"/>");
				sb.append("</td>");

				sb.append("</tr>");

				ArrayList<ResolutionDetailVO> darr = vo.array();
				for (int di=0; di<darr.size(); di++) {
					ResolutionDetailVO dvo = darr.get(di);
					String detailediturl = getUrl(CsConfig.getForm(g.getGroup(), g.getType()), Operator.toString(dvo.getId()), entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");
					String ref = dvo.getRef();

					sb.append("<tr class=\"").append(style).append("\" style=\"display: none\" group=\"").append(g.getGroup()).append("\" resid=\"").append(vo.getId()).append("\" partid=\"").append(dvo.getId()).append("\" groupid=\"").append(vo.getId()).append("\" recordid=\"").append(dvo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(vo.getId()).append("_").append(dvo.getId()).append("\">\n");

					sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>part</td>");
					sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" label=\"part\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\">");
					if (Operator.hasValue(dvo.getPart())) {
						sb.append(dvo.getPart());
					}
					sb.append("</a>");
					sb.append("</td>");
					sb.append("<td class=\"").append(style).append("_grouppart\" type=\"text\" itype=\"text\" label=\"name\" valign=\"top\">");
					sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\">");
					sb.append(dvo.getName());
					sb.append("</a>");
					sb.append("</td>");

					if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
						sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" align=\"center\">");
						if (dvo.compliable() && vo.isAdopted()) {
							String complied = "N";
							if (dvo.isComplied()) { complied = "Y"; }
							sb.append(ObjDisplay.partcomply(req, dvo.getId(), grouptype, groupid, complied, Operator.toString(vo.getId()), style));
						}
						else {
							sb.append("&nbsp;");
						}
						sb.append("</td>");
					}
					else {
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" label=\"reference\" valign=\"top\">");
						if (dvo.isPermanent()) { sb.append("permanent"); }
						else { sb.append(dvo.getRef()); }
						sb.append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" label=\"reference\" valign=\"top\">");
						sb.append(dvo.getRefnum());
						sb.append("</td>");
					}
					sb.append("<td class=\"").append(style).append("_grouppart\" type=\"text\" itype=\"status\" label=\"status\" valign=\"top\">");
					sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\">");
					sb.append(dvo.getStatus());
					sb.append("</a>");
					sb.append("</td>");
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					if (ref.equalsIgnoreCase(type)) {
						sb.append("<img src=\"").append(GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"resolution\" _action=\"delete\" _grpid=\"").append(vo.getId()).append("\" _id=\"").append(dvo.getId()).append("\"/>");
					}
					else {
						sb.append("&nbsp;");
					}
					sb.append("</td>");
					sb.append("</tr>");
				}
			}
			
			sb.append("</table>\n");
		}
		return sb.toString();
	}

	public static String resolutionDetail(RequestVO req, String type, int typeid, String group, String groupid, String grouptype, ResolutionVO vo, ArrayList<ResolutionDetailVO> details, String style, String alert, boolean editable, boolean deletable) {
		String entity = req.getEntity();
		int entityid = req.getEntityid();

		boolean empty = true;
		StringBuilder sb = new StringBuilder();

		ResolutionDetailVO curr = vo.getDetail();
		int currid = curr.getId();

		if (details.size() > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"part\" valign=\"top\">part</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"title\" valign=\"top\">title/description</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"type\" width=\"1%\" nowrap  valign=\"top\">type</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"reference\" width=\"1%\" nowrap  valign=\"top\">reference</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"status\" valign=\"top\" width=\"1%\" nowrap>status</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"date\" valign=\"top\" width=\"1%\" nowrap>date</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"date\" valign=\"top\" width=\"1%\" nowrap>expiration</td>\n");
			if (editable) {
				if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
					sb.append("<td class=\"").append(style).append("_header\" label=\"date\" valign=\"top\" width=\"1%\">application complied</td>\n");
					sb.append("<td class=\"").append(style).append("_header\" label=\"date\" valign=\"top\" width=\"1%\">permit complied</td>\n");
				}
			}
			if (deletable) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\"></td>\n");
			}
			sb.append("</tr>\n");

			for (int di=0; di<details.size(); di++) {
				ResolutionDetailVO dvo = details.get(di);
				empty = false;
				String detailediturl = getUrl("resolutionparts.jsp", Operator.toString(dvo.getId()), entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");
				String ref = dvo.getRef();

				sb.append("<tr class=\"").append(style).append("\" group=\"").append(group).append("\" resid=\"").append(vo.getId()).append("\" partid=\"").append(dvo.getId()).append("\" groupid=\"").append(groupid).append("\" recordid=\"").append(dvo.getId()).append("\" id=\"tr_").append(group).append("_").append(groupid).append("_").append(dvo.getId()).append("\">\n");

				sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" label=\"part\" valign=\"top\" width=\"1%\" nowrap>");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\">"); }
				if (Operator.hasValue(dvo.getPart())) {
					sb.append(dvo.getPart());
				}
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");
				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"text\" label=\"name\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				if (Operator.hasValue(dvo.getDescription())) {
					sb.append("<b>").append(dvo.getName()).append("</b>");
					sb.append("<br/><br/>");
					sb.append(dvo.getDescription());
				}
				else {
					sb.append(dvo.getName());
				}
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" label=\"reference\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				if (dvo.isPermanent()) { sb.append("permanent"); }
				else { sb.append(dvo.getRef()); }
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" label=\"referencenumber\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				sb.append(dvo.getRefnum());
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" label=\"status\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				sb.append(dvo.getStatus());
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"date\" label=\"date\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				if (Operator.hasValue(dvo.getDate())) {
					sb.append(dvo.date().getString("MM/DD/YY"));
				}
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"exp\" label=\"date\" valign=\"top\">");
				if (editable) { sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">"); }
				if (dvo.expires()) {
					sb.append(dvo.expiration().getString("MM/DD/YY"));
				}
				if (editable) { sb.append("</a>"); }
				sb.append("</td>");


				if (editable) {
					if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
						if (dvo.compliable() && vo.isAdopted()) {
							String appcomplied = "N";
							if (dvo.isAppcomplied()) { appcomplied = "Y"; }
							sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" align=\"center\" valign=\"top\">");
							sb.append(ObjDisplay.apppartcomply(req, dvo.getId(), grouptype, groupid, appcomplied, Operator.toString(vo.getId()), style));
							sb.append("</td>");
							String complied = "N";
							if (dvo.isComplied()) { complied = "Y"; }
							sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" align=\"center\" valign=\"top\">");
							sb.append(ObjDisplay.partcomply(req, dvo.getId(), grouptype, groupid, complied, Operator.toString(vo.getId()), style));
							sb.append("</td>");
						}
						else {
							sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" align=\"center\" valign=\"top\">");
							sb.append("&nbsp;");
							sb.append("</td>");
							sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" align=\"center\" valign=\"top\">");
							sb.append("&nbsp;");
							sb.append("</td>");
						}
					}
				}
				if (deletable) {
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append("<img src=\"").append(GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"resolution\" _action=\"delete\" _grpid=\"").append(vo.getId()).append("\" _id=\"").append(dvo.getId()).append("\"/>");
					sb.append("</td>");
				}
				else {
				}
				sb.append("</tr>");
			}
			
			sb.append("</table>\n");
		}
		if (empty) { sb = new StringBuilder(); }
		return sb.toString();
	}

	public static String horizontal(RequestVO req, ObjGroupVO g, String style, String alert, boolean sub) {
		return horizontal(req, g, style, alert, sub, false);
	}

	public static String horizontal(RequestVO req, ObjGroupVO g, String style, String alert, boolean sub, boolean history) {
		ObjMap[] map = g.getValues();
		String[] fields = g.getFields();
		if (sub) { fields = g.getIndex(); }
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
			addurl = getFormUrl(req, g, "add");
		}
		if (sub) {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, addurl, GRAYADDIMGURL, "", "", g.getOptions(), req.getOption(), "", "", g.getContenttype()));
		}
		else {
			sb.append(title(g.getLabel(), getDetailUrl(req, g), style, alert, addurl, "", g.getOptions(), req.getOption(), "", g.getContenttype()));
		}
		if (fl > 0 && l > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			boolean editable = (g.isEditable());
			for (int x=0; x < fl; x++) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"").append(fields[x]).append("\" valign=\"top\">").append(fields[x]).append("</td>\n");
			}
			if (g.isDeletable() || (editable && !sub && !history)) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" valign=\"top\">&nbsp;</td>\n");
			}
			sb.append("</tr>\n");

			for (int i=0; i < l; i++) {
				ObjMap m = map[i];
				int id = m.getId();
				boolean deletable = (g.isDeletable() && !m.isFinaled());

				String editurl = "";
				if (editable) {
					editurl = getUrl(CsConfig.getForm(g.getGroup(), g.getType()), Operator.toString(id), entity, entityid, type, typeid, group, grouptype, groupid, "");
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
						String ot = o.getType();
						String oi = o.getItype();
						sb.append("<td class=\"").append(style).append("\" type=\"").append(ot).append("\" itype=\"").append(oi).append("\" label=\"").append(fields[x]).append("\" valign=\"top\">");
						if (editable && !history) {
							if (!Operator.hasValue(o.getLink()) && !Operator.equalsIgnoreCase(ot, "checkbox") && !Operator.equalsIgnoreCase(ot, "complete")) {
								sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
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
				if (deletable) {
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append("<img src=\"").append(GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(m.getId()).append("\"/>");
					sb.append("</td>");
				}
				else if (editable && !sub && !history) {
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
					sb.append("<img src=\"").append(GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
					sb.append("</td>");
				}
				else if (g.isDeletable()) {
					sb.append("<td class=\"").append(style).append("_rowcontrols\" nowrap>&nbsp;</td>");
				}
				sb.append("</tr>\n");
			}
			sb.append("</table>\n");
		}
		return sb.toString(); 

	}

	/**
	 * @deprecated Use hzReview on Review.java
	 */
	public static String hzReview(RequestVO req, ComboReviewVO rev, String style, boolean editable) {
	    Timekeeper startdate = new Timekeeper();
	    startdate.setDate(rev.getStart());
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
		sb.append("<tr>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"review\" width=\"1%\" nowrap>&nbsp;</td>\n");
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"review\" width=\"1%\" nowrap>review</td>\n");
	    }
		sb.append("<td class=\"").append(style).append("_header\" label=\"status\" width=\"1%\" nowrap>status</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"comments\">comments</td>\n");
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"team\" width=\"1%\" nowrap>team</td>\n");
	    }
	    else {
			sb.append("<td class=\"").append(style).append("_header\" label=\"assign\" width=\"1%\" nowrap>assign</td>\n");
	    }
		sb.append("<td class=\"").append(style).append("_header\" label=\"appt\" width=\"1%\" nowrap>appt</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"due\" width=\"1%\" nowrap>date</td>\n");
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"due\" width=\"1%\" nowrap>due date</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" nowrap></td>\n");
	    }
		sb.append("</tr>\n");
		LinkedHashMap<Integer, ReviewVO> reviews = rev.getReviews();
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {

			int field = entry.getKey();
		    ReviewVO value = entry.getValue();
		    String due = "";
		    if (Operator.hasValue(value.getDuedate())) {
		    	due = value.duedate().getString("MM/DD/YY");
		    }
		    else if (value.daystilldue < 0) {
		    	due = "--";
		    }

		    if (req.getReviewrefid() > 0) {
		    	// DISPLAY ACTIONS OF REVIEWS
				LinkedHashMap<Integer, ReviewActionVO> actions = value.getActions();
				String stold = "";
				for (Map.Entry<Integer, ReviewActionVO> action : actions.entrySet()) {
					try {
					    Integer afield = action.getKey();
					    ReviewActionVO avalue = action.getValue();
					    Timekeeper d = new Timekeeper();
					    d.setDate(avalue.getDate());

					    String expired = " expired=\"false\"";
					    if (value.daystilldue >= 0) {
					    	if (value.duedate().past()) {
					    		if (!avalue.isApproved() && !avalue.isFinal()) {
						    		expired = " expired=\"true\"";
					    		}
					    	}
					    }


					    String attachlink = avalue.getAttachment().getIconLink();
						sb.append("<tr id=\"combotr_").append(value.getId()).append("\" class=\"comboreview\"").append(expired).append(">\n");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" width=\"1%\" nowrap>");
						if (Operator.hasValue(attachlink)) {
							sb.append(attachlink);
						}
						else {
							sb.append("&nbsp;");
						}
						sb.append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"status\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getStatus()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"largetext\" actionid=\"").append(avalue.getId()).append("\">").append(avalue.getComments()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"team\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.assigned()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"appt\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getAppointment().getFirstSchedule().asText()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"due\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap").append(expired).append(">").append(d.getString("MM/DD/YY")).append("</td>");
						sb.append("</tr>\n");
						stold = " "+style+"_disabled";

						sb.append("<tr id=\"info_").append(avalue.getId()).append("\" style=\"display: none\">");
						sb.append("<td colspan=\"6\">");

						sb.append("<table cellpadding=\"5\" cellspacing=\"1\" width=\"100%\">");
						sb.append("<tr>");
						sb.append("<td class=\"").append(style).append("_header\" label=\"createdby\" width=\"1%\" nowrap>CREATED BY</td>");
						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(avalue.getCreatedby()).append("</td>");
						sb.append("<td class=\"").append(style).append("_header\" label=\"createddate\" width=\"1%\" nowrap>CREATED DATE</td>");
						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(d.getString("YYYY/MM/DD @ HH:MM")).append("</td>");
						sb.append("</tr>");
						sb.append("</table>");

						sb.append("</td>");
						sb.append("</tr>");
					}
					catch (Exception e) {
			    		Logger.error(e);
					}
				}
		    }
		    else {
		    	// DISPLAY REVIEWS OF COMBO
		    	try {
		    		LinkedHashMap<Integer, ReviewActionVO> actions = value.getActions();
		    		if (actions.size() > 0) {
					    Map.Entry<Integer, ReviewActionVO> action = actions.entrySet().iterator().next();
					    ReviewActionVO avalue = action.getValue();
					    String attachlink = avalue.getAttachment().getIconLink();
					    Timekeeper d = new Timekeeper();
					    d.setDate(avalue.getDate());

					    String expired = " expired=\"false\"";
					    if (value.daystilldue >= 0) {
					    	if (value.duedate().past()) {
					    		if (!avalue.isApproved() && !avalue.isFinal()) {
						    		expired = " expired=\"true\"";
					    		}
					    	}
					    }

					    sb.append("<tr id=\"combotr_").append(value.getId()).append("\" class=\"comboreview\"").append(expired).append(">\n");

						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" width=\"1%\" nowrap>");
						if (Operator.hasValue(attachlink)) {
							sb.append(attachlink);
						}
						else {
							sb.append("&nbsp;");
						}
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(value.getReview()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"status\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getStatus()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"largetext\" actionid=\"").append(avalue.getId()).append("\">").append(avalue.getComments()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"team\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(value.teamMembers()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"appt\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getAppointment().getFirstSchedule().asText()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"due\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(d.getString("MM/DD/YY")).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"due\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap").append(expired).append(">").append(due).append("</td>");

						sb.append("<td class=\"").append(style).append(" ").append(style).append("_header\" width=\"1%\" nowrap>");
						sb.append("<a href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(req.getId());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(value.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(value.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						if (value.isFinal() || value.isApproved() || value.isUnapproved()) {
							sb.append("<img src=\"").append(GRAYVIEWIMGURL).append("\"/>");
						}
						else {
							sb.append("<img src=\"").append(GRAYEDITIMGURL).append("\"/>");
						}
						sb.append("</a>");
						sb.append("</td>");
						sb.append("</tr>");

						sb.append("<tr id=\"info_").append(avalue.getId()).append("\" style=\"display: none\">");
						sb.append("<td colspan=\"10\">");

						sb.append("<table cellpadding=\"5\" cellspacing=\"0\" width=\"100%\" style=\"background-color: #ffffff\">");
						sb.append("<tr>");
						sb.append("<td class=\"").append(style).append("_header\" label=\"createdby\" width=\"1%\" nowrap>CREATED BY</td>");
						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(avalue.getCreatedby()).append("</td>");
						sb.append("<td class=\"").append(style).append("_header\" label=\"createddate\" width=\"1%\" nowrap>CREATED DATE</td>");
						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(d.getString("YYYY/MM/DD @ HH:MM")).append("</td>");
						sb.append("</tr>");
						sb.append("</table>");

						sb.append("</td>");
						sb.append("</tr>");
		    		}
		    	}
		    	catch (Exception e) {
		    		Logger.error(e);
		    	}
		    }

		}
		sb.append("</table>\n");
		return sb.toString();
	}



	public static String getDetailUrl(RequestVO vo, ObjGroupVO g) {
		return getUrl(CsConfig.getDetails(), vo, g, "");
	}

	public static String getListUrl(RequestVO vo, ObjGroupVO g) {
		return getUrl(CsConfig.getList(g.getGroup(), g.getType()), vo, g, "");
	}

	public static String getHistoryUrl(RequestVO vo, ObjGroupVO g) {
		if (!g.isHistory()) { return ""; }
		return getUrl(CsConfig.getHistory(g.getGroup()), vo, g, "");
	}

	public static String getMoreUrl(RequestVO vo, ObjGroupVO g) {
		String m = CsConfig.getMore(g.getGroup());
		if (!Operator.hasValue(m)) { return ""; }
		return getUrl(m, vo, g, "");
	}

	public static String getImportUrl(RequestVO vo, ObjGroupVO g) {
		if (!g.isCreate()) { return ""; }
		return getUrl(CsConfig.getImport(g.getGroup()), vo, g, "");
	}

	public static String getFormUrl(RequestVO vo, ObjGroupVO g) {
		return getUrl(CsConfig.getForm(g.getGroup(), g.getType()), vo, g, "");
	}

	public static String getFormUrl(RequestVO vo, ObjGroupVO g, String act) {
		if (Operator.equalsIgnoreCase(act, "add")) {
			if (!g.isCreate()) { return ""; }
		}
		else if (Operator.equalsIgnoreCase(act, "edit") || Operator.equalsIgnoreCase(act, "multiedit")) {
			if (!g.isUpdate()) { return ""; }
		}
		return getUrl(CsConfig.getForm(g.getGroup(), g.getType()), vo, g, act);
	}

	public static String getFormUrl(RequestVO vo, ObjGroupVO g, ComboReviewVO rv, String act) {
		return getUrl(CsConfig.getForm(g.getGroup(), g.getType()), Operator.toString(rv.getComboid()), vo.getEntity(), vo.getEntityid(), vo.getType(), vo.getTypeid(), g.getGroup(), "review", Operator.toString(rv.getReviewgroupid()), "");
	}

	public static String getUrl(String path, RequestVO vo, ObjGroupVO g) {
		return getUrl(path, vo, g, "");
	}

	public static String getUrl(String path, RequestVO vo, ObjGroupVO g, String act) {
		return getUrl(path, vo.getId(), vo.getEntity(), vo.getEntityid(), vo.getType(), vo.getTypeid(), g.getGroup(), g.getType(), g.getGroupid(), act);
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
		return cells(fieldid, fieldname, "", value, type, itype, required, style, colspan, choices, multiple, editable);
	}

	public static String cells(String fieldid, String fieldname, String description, String value, String type, String itype, boolean required, String style, int colspan, SubObjVO[] choices, boolean multiple, boolean editable) {
		return cells(fieldid, fieldname, description, value, type, itype, required, style, colspan, choices, multiple, editable, true);
	}

	public static String cells(String fieldid, String fieldname, String description, String value, String type, String itype, boolean required, String style, int colspan, SubObjVO[] choices, boolean multiple, boolean editable, boolean autoselect) {
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
		if (Operator.hasValue(description)) {
			sb.append("<div class=\"").append(style).append(" ").append(style).append("_fielddescription\">").append(description).append("</div>");
		}

		if (!editable) {
			if (choices.length > 0 || type.equalsIgnoreCase("select")) {
				for (int i=0; i<choices.length; i++) {
					SubObjVO typ = choices[i];
					String cval = Operator.toString(typ.getId());
					if (Operator.hasValue(cval) && cval.equalsIgnoreCase(value)) {
						sb.append(typ.getText());
					}
				}
			}
			else {
				sb.append(value);
			}
		}
		else if (choices.length > 0 || type.equalsIgnoreCase("select")) {
			sb.append("<select name=\"").append(fieldid).append("\" itype=\"").append(itype).append("\" val=\"").append(Operator.formFriendly(value)).append("\"").append(req).append(multi).append(">\n");
			sb.append("<option value=\"\"></option>\n");
			for (int i=0; i<choices.length; i++) {
				SubObjVO typ = choices[i];
				String cval = Operator.toString(typ.getId());
				boolean isselected = typ.isSelected();
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

				if (autoselect) {
					if (isselected || (Operator.hasValue(cval) && cval.equalsIgnoreCase(value))) {
						sb.append(" selected");
					}
				}

				for (Map.Entry<String,String> entry : addldata.entrySet()) {
					String f = entry.getKey();
					String v = entry.getValue();
					sb.append(" ").append(f).append("=\"").append(Operator.formFriendly(v)).append("\" ");
				}

				sb.append(">").append(typ.getText()).append("</option>\n");
			}
			sb.append("</select>\n");
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
		else if (itype.equalsIgnoreCase("boolean")) {
			String checked = "";
			if (Operator.equalsIgnoreCase(value, "Y")) { checked = " checked"; }
			sb.append("<div><input name=\"").append(fieldid).append("\" type=\"checkbox\" itype=\"").append(itype).append("\" value=\"Y\" data-id=\"toggleCheckbox\"").append(checked).append("></div>");
		}
		else if (itype.equalsIgnoreCase("date")) {
			String v = "";
			if (Operator.hasValue(value)) {
				Timekeeper d = new Timekeeper();
				d.setDate(value);
				v = d.getString("YYYY/MM/DD");
			}
			sb.append("<input name=\"").append(fieldid).append("\" type=\"text\" itype=\"").append(itype).append("\" value=\"").append(Operator.formFriendly(v)).append("\"").append(req).append(">");;
		}
		else if (itype.equalsIgnoreCase("datetime")) {
			String v = "";
			if (Operator.hasValue(value)) {
				Timekeeper d = new Timekeeper();
				d.setDate(value);
				StringBuilder dt = new StringBuilder();
				dt.append(d.getString("YYYY/MM/DD")).append(" ").append(d.getString("MILITARYTIME"));
				v = dt.toString();
			}
			sb.append("<input name=\"").append(fieldid).append("\" type=\"text\" itype=\"").append(itype).append("\" value=\"").append(Operator.formFriendly(v)).append("\"").append(req).append(">");;
		}
		else {
			sb.append("<input name=\"").append(fieldid).append("\" type=\"").append(type).append("\" itype=\"").append(itype).append("\" value=\"").append(Operator.formFriendly(value)).append("\"").append(req).append(">");;
		}
		sb.append("</td>");
		return sb.toString();
	}

	public static SubObjVO[] yesno() {
		SubObjVO[] s = new SubObjVO[2];
		SubObjVO y = new SubObjVO();
		y.setValue("Y");
		y.setText("Yes");
		SubObjVO n = new SubObjVO();
		n.setValue("N");
		n.setText("No");
		s[0] = n;
		s[1] = y;
		return s;
	}

	public static String numericalSelect(String name, int start, int end) {
		return numericalSelect(name, start, end, -99999);
	}

	public static String numericalSelect(String name, int start, int end, int selected) {
		StringBuilder sb = new StringBuilder();
		sb.append("<select name=\"").append(name).append("\">\n");
		for (int i=start; i<=end; i++) {
			sb.append("<option value=\"").append(i).append("\"");
			if (selected != -99999 && i == selected) {
				sb.append(" selected");
			}
			sb.append(">").append(i).append("</option>\n");
		}
		sb.append("</select>\n");
		return sb.toString();
	}

	public static String select(String fieldid, String fieldname, String value, String itype, boolean required, SubObjVO[] choices, HashMap<String, String> addl, boolean multiple) {
		String req = "";
		if (required) { req = " class=\"required\""; }
		String multi = "";
		if (multiple) { multi = " multiple"; }

		StringBuilder sb = new StringBuilder();
		sb.append("<select name=\"").append(fieldid).append("\" itype=\"").append(itype).append("\" val=\"").append(Operator.formFriendly(value)).append("\"").append(req).append(multi);
		for (Map.Entry<String,String> entry : addl.entrySet()) {
			String f = entry.getKey();
			String v = entry.getValue();
			sb.append(" ").append(f).append("=\"").append(Operator.formFriendly(v)).append("\" ");
		}

		sb.append(">");
		sb.append("<option value=\"\"></option>");
		for (int i=0; i<choices.length; i++) {
			SubObjVO typ = choices[i];
			String cval = Operator.toString(typ.getId());
			boolean isselected = typ.isSelected();
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
		return sb.toString();
	}
	
	
	

	public static JSONObject psearch(String searchtype, String query, int page, int max, String token, String ip) {
		
		JSONObject o = new JSONObject();
		
		try{
		ObjVO objo = new ObjVO();
		SubObjVO[] sobjo = new SubObjVO[0];
		int totalpages = 0;

		String acturl = Config.fullcontexturl() + "/psearch.jsp?s=activity&sq=" + Operator.urlFriendly(query);
		String lsourl = Config.fullcontexturl() + "/psearch.jsp?s=lso&sq=" + Operator.urlFriendly(query);
		String surl = "";
		String addrclss = "psearch_tabs";
		String actclss = "psearch_tabs";
		String table = "";
		if (!Operator.equalsIgnoreCase(searchtype, "activity")) {
			objo = CsApi.psearch("lso", "lso", query, page, max, token, ip);
			sobjo = objo.getChoices();
			table = lsopsearch(objo, query);
			actclss = "psearch_tabs";
			addrclss = "psearch_tabs_current";
			surl = lsourl;
		}

		if (sobjo.length < 1 && !Operator.equalsIgnoreCase(searchtype, "lso")) {
			objo = CsApi.psearch("lso", "activities", query, page, max, token, ip);
			sobjo = objo.getChoices();
			table = actpsearch(objo, query);
			addrclss = "psearch_tabs";
			actclss = "psearch_tabs_current";
			surl = acturl;
		}
		totalpages = Operator.getTotalPages(objo.getNumresults(), max);

		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"psearch_tabs\">");
		sb.append("<tr>");
		sb.append("<td class=\"").append(addrclss).append("\"><a href=\"").append(lsourl).append("\">Address</a></td>");
		sb.append("<td class=\"").append(actclss).append("\"><a href=\"").append(acturl).append("\">Activities</a></td>");
		sb.append("<td class=\"psearch_info\">").append(objo.getNumresults()).append(" Results found</td>");
		sb.append("</tr>");
		sb.append("</table>");
		sb.append(table);
		sb.append("<table cellpadding=\"20\" cellspacing=\"0\" border=\"0\" width=\"100%\" class=\"psearch_pagination\">");
		sb.append("<tr>");
		sb.append("<td align=\"center\" class=\"psearch_pagination\">").append(Operator.pageIndex(surl,totalpages,page)).append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		sb.append("<br/><br/><br/>");
		
		
		o.put("table", sb.toString());
		o.put("noofrecords", objo.getNumresults());
		}catch(Exception e){
			Logger.error(e.getMessage());
		}
		return o;
	}

	public static String lsopsearch(ObjVO obj, String query) {
		SubObjVO[] sobjo = obj.getChoices();
		if (sobjo.length < 1) { return ""; }
		String url = Config.fullcontexturl() + "?entity=lso&type=lso&typeid=";

		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"psearch\">");
		for (int i=0; i<sobjo.length; i++) {
			SubObjVO svo = sobjo[i];
			sb.append("<tr>");
			sb.append("<td class=\"psearch_highlight\"><a class=\"psearch_highlight\" href=\"").append(url).append(svo.getId()).append("\" target=\"_top\">").append(svo.getText()).append("</a> <span class=\"psearch_addl\">(").append(svo.getAddldata().get("LSO_TYPE")).append(")</span></td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"psearch_data\">");
			sb.append(svo.getDescription()).append("<br/>");
			String alias = svo.getAddldata().get("ALIAS");
			if (Operator.hasValue(alias)) {
				sb.append("ALIAS: ").append(alias).append("<br/>");
			}
			sb.append("APN: ").append(svo.getAddldata().get("APN"));
			sb.append("</td>");
			sb.append("</tr>");
		}
		sb.append("</table>");
		return sb.toString();
	}

	public static String actpsearch(ObjVO obj, String query) {
		SubObjVO[] sobjo = obj.getChoices();
		if (sobjo.length < 1) { return ""; }
		String url = Config.fullcontexturl() + "?entity=lso&type=activity&typeid=";

		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"psearch\">");
		for (int i=0; i<sobjo.length; i++) {
			SubObjVO svo = sobjo[i];
			sb.append("<tr>");
			sb.append("<td class=\"psearch_highlight\"><a class=\"psearch_highlight\" href=\"").append(url).append(svo.getId()).append("\" target=\"_top\">").append(svo.getAddldata().get("ACT_NBR")).append("</a></td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"psearch_data\">");
			sb.append(svo.getAddldata().get("ADDRESS")).append("<br/>");
			sb.append("ACTIVITY TYPE: ").append(svo.getAddldata().get("TYPE")).append("<br/>");
			sb.append("PROJECT TYPE: ").append(svo.getAddldata().get("PROJECT_TYPE")).append("<br/>");
			sb.append("ISSUED DATE: ").append(svo.getAddldata().get("ISSUED_DATE")).append("<br/>");
			sb.append("</td>");
			sb.append("</tr>");
		}
		sb.append("</table>");
		return sb.toString();
	}




}











