package cs.ui;

import java.util.ArrayList;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import cs.utils.ObjDisplay;
import cs.utils.ObjTables;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.RequestVO;
import csshared.vo.ResolutionDetailVO;
import csshared.vo.ResolutionVO;

public class Resolution {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		ResolutionVO[] arr = g.getResolutions();
		String entity = req.getEntity();
		int entityid = req.getEntityid();
		String type = req.getType();
		int typeid = req.getTypeid();
		String group = g.getGroup();
		String grouptype = g.getType();
		String groupid = g.getGroupid();
		int l = arr.length;
		StringBuilder sb = new StringBuilder();
		if (l > 0) {

			String addurl = "";
			String importurl = "";
			if (g.isAddable() && g.isEditable()) {
				addurl = ObjTables.getFormUrl(req, g, "add");
				importurl = ObjTables.getImportUrl(req, g);
			}
			sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, addurl, ObjTables.WHITEADDIMGURL, "", "", importurl, ObjTables.WHITEIMPORTIMGURL, g.getOptions(), req.getOption(), "", "", g.getContenttype()));
			sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
			sb.append("<tr>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"number\" colspan=\"2\" valign=\"top\">number</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"title\" valign=\"top\">title</td>\n");
			if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
				sb.append("<td class=\"").append(style).append("_header\" label=\"pcomplied\" width=\"1%\" valign=\"top\">application complied</td>\n");
				sb.append("<td class=\"").append(style).append("_header\" label=\"pcomplied\" width=\"1%\" valign=\"top\">permit complied</td>\n");
			}
			else {
				sb.append("<td class=\"").append(style).append("_header\" label=\"type\" width=\"1%\" nowrap  valign=\"top\">type</td>\n");
				sb.append("<td class=\"").append(style).append("_header\" label=\"reference\" width=\"1%\" nowrap  valign=\"top\">reference</td>\n");
			}
			sb.append("<td class=\"").append(style).append("_header\" label=\"adopted\" valign=\"top\" width=\"1%\" nowrap>adopted</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\"></td>\n");
			sb.append("</tr>\n");

			String cls = style;

			for (int i=0; i<l; i++) {
				ResolutionVO vo = arr[i];

				String editurl = "";
				if (g.isEditable()) {
					editurl = ObjTables.getUrl(CsConfig.getForm(g.getGroup(), g.getType()), "-1", entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");
				}

				sb.append("<tr class=\"").append(style).append("\" resid=\"").append(vo.getId()).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(vo.getId()).append("\" recordid=\"").append(vo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(vo.getId()).append("_").append(vo.getId()).append("\">\n");

				sb.append("<td class=\"").append(cls).append("\" type=\"type\" itype=\"type\" label=\"number\" valign=\"top\" colspan=\"2\">");
				if (Operator.hasValue(editurl)) {
					sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
				}
				sb.append(vo.getNumber());
				if (Operator.hasValue(editurl)) {
					sb.append("</a>");
				}
				sb.append("</td>");

				if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
					sb.append("<td class=\"").append(cls).append("\" type=\"text\" itype=\"String\" label=\"title\" valign=\"top\">");
				}
				else {
					sb.append("<td class=\"").append(cls).append("\" type=\"text\" itype=\"String\" label=\"title\" valign=\"top\" colspan=\"3\">");
				}
				if (Operator.hasValue(editurl)) {
					sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
				}
				sb.append(vo.getTitle());
				if (Operator.hasValue(editurl)) {
					sb.append("</a>");
				}
				sb.append("</td>");

				if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
					sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"complete\" label=\"appcomplied\" valign=\"top\" align=\"center\">");
					if (vo.isAdopted() && vo.isAppcomplied()) {
						sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" _relid=\"app_").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					else {
						sb.append("<img src=\"").append(Config.emptyImageUrl()).append("\" _relid=\"app_").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					sb.append("</td>");
					sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"complete\" label=\"complied\" valign=\"top\" align=\"center\">");
					if (vo.isAdopted() && vo.isComplied()) {
						sb.append("<img src=\"").append(CsConfig.getImage("complete")).append("\" _relid=\"permit_").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					else {
						sb.append("<img src=\"").append(Config.emptyImageUrl()).append("\" _relid=\"permit_").append(vo.getId()).append("\" height=\"20\" width=\"20\" border=\"0\"/>");
					}
					sb.append("</td>");
				}
				
				sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"date\" label=\"adopted\" valign=\"top\">");
				if (Operator.hasValue(vo.getAdopted())) {
					if (Operator.hasValue(editurl)) {
						sb.append("<a href=\"").append(editurl).append("\" class=\"").append(style).append("\">");
					}
					sb.append(vo.adoptedDate().getString("MM/DD/YY"));
					if (Operator.hasValue(editurl)) {
						sb.append("</a>");
					}
				}
				else {
					sb.append("&nbsp;");
				}
				sb.append("</td>");

				sb.append("<td class=\"").append(style).append("_rowcontrols\" width=\"1%\" nowrap>");
				sb.append("<img src=\"").append(ObjTables.GRAYDOWNIMGURL).append("\" resid=\"").append(vo.getId()).append("\" on=\"false\" width=\"20\" height=\"20\" border=\"0\"/>");
				sb.append("</td>");

				sb.append("</tr>");

				ArrayList<ResolutionDetailVO> darr = vo.array();
				for (int di=0; di<darr.size(); di++) {
					ResolutionDetailVO dvo = darr.get(di);
					String detailediturl = "";
					if (g.isEditable()) {
						detailediturl = ObjTables.getUrl("resolutionparts.jsp", Operator.toString(dvo.getId()), entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");
					}
					String ref = dvo.getRef();

					sb.append("<tr class=\"").append(style).append("\" style=\"display: none\" group=\"").append(g.getGroup()).append("\" resid=\"").append(vo.getId()).append("\" partid=\"").append(dvo.getId()).append("\" groupid=\"").append(vo.getId()).append("\" recordid=\"").append(dvo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(vo.getId()).append("_").append(dvo.getId()).append("\">\n");

					sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>part</td>");
					sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" label=\"part\" valign=\"top\" width=\"1%\" nowrap>");
					if (Operator.hasValue(detailediturl)) {
						sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">");
					}
					if (Operator.hasValue(dvo.getPart())) {
						sb.append(dvo.getPart());
					}
					if (Operator.hasValue(detailediturl)) {
						sb.append("</a>");
					}
					sb.append("</td>");
					sb.append("<td class=\"").append(style).append("_grouppart\" type=\"text\" itype=\"text\" label=\"name\" valign=\"top\">");
					if (Operator.hasValue(detailediturl)) {
						sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">");
					}
					sb.append(dvo.getName());
					if (Operator.hasValue(detailediturl)) {
						sb.append("</a>");
					}
					sb.append("</td>");

					if (type.equalsIgnoreCase("project") || type.equalsIgnoreCase("activity")) {
						if (dvo.compliable() && vo.isAdopted()) {
							String applcomplied = "N";
							if (dvo.isAppcomplied()) { applcomplied = "Y"; }
							sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" align=\"center\">");
							sb.append(ObjDisplay.apppartcomply(req, dvo.getId(), grouptype, groupid, applcomplied, "app_" + Operator.toString(vo.getId()), style));
							sb.append("</td>");
							String complied = "N";
							if (dvo.isComplied()) { complied = "Y"; }
							sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" align=\"center\">");
							sb.append(ObjDisplay.partcomply(req, dvo.getId(), grouptype, groupid, complied, "permit_" + Operator.toString(vo.getId()), style));
							sb.append("</td>");
						}
						else {
							sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" align=\"center\">");
							sb.append("&nbsp;");
							sb.append("</td>");
							sb.append("<td class=\"").append(style).append("_grouppart\" type=\"type\" itype=\"type\" align=\"center\">");
							sb.append("&nbsp;");
							sb.append("</td>");
						}
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
					if (Operator.hasValue(detailediturl)) {
						sb.append("<a href=\"").append(detailediturl).append("\" class=\"").append(style).append("\" target=\"lightbox-iframe\">");
					}
					sb.append(dvo.getStatus());
					if (Operator.hasValue(detailediturl)) {
						sb.append("</a>");
					}
					sb.append("</td>");
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					if (ref.equalsIgnoreCase(type) && g.isDeletable()) {
						sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"resolution\" _action=\"delete\" _grpid=\"").append(vo.getId()).append("\" _id=\"").append(dvo.getId()).append("\"/>");
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
					sb.append("<td class=\"").append(style).append("_header\" label=\"date\" valign=\"top\" width=\"1%\" nowrap>complied</td>\n");
				}
			}
			if (deletable) {
				sb.append("<td class=\"").append(style).append("_header\" width=\"1%\"></td>\n");
			}
			sb.append("</tr>\n");

			for (int di=0; di<details.size(); di++) {
				ResolutionDetailVO dvo = details.get(di);
				empty = false;
				String detailediturl = "";
				detailediturl = ObjTables.getUrl("resolutionparts.jsp", Operator.toString(dvo.getId()), entity, entityid, type, typeid, group, grouptype, Operator.toString(vo.getId()), "");

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
						sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" align=\"center\" valign=\"top\">");
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
				}
				if (deletable) {
					sb.append("<td class=\"").append(style).append("_rowcontrols\" valign=\"top\" width=\"1%\" nowrap>");
					sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" _grp=\"resolution\" _action=\"delete\" _grpid=\"").append(vo.getId()).append("\" _id=\"").append(dvo.getId()).append("\"/>");
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

	public static String id(RequestVO req, ObjGroupVO g, String style, String alert) {
		return Vertical.id(req, g, style, alert);
	}







}
