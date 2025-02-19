package cs.ui;

import alain.core.utils.Config;
import alain.core.utils.FileUtil;
import alain.core.utils.Operator;
import cs.utils.RequestMapper;
import csshared.utils.CsConfig;
import csshared.vo.ObjGroupVO;
import csshared.vo.ObjMap;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;

public class Images {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		String slides = slides(req, g, "slide", 6, true, true);
		return slides; 
	}

	public static String info(RequestVO req, ObjGroupVO g, String style, String alert) {
		String slides = slides(req, g, "slide", 1, false, true);
		return slides; 
	}

	public static String link(RequestVO req, int id) {
		StringBuilder sb = new StringBuilder();
		sb.append(Config.fullcontexturl()).append("/images.jsp");
		sb.append("?").append(RequestMapper.entity).append("=").append(req.getEntity());
		sb.append("&").append(RequestMapper.entityid).append("=").append(req.getEntityid());
		sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
		sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
		sb.append("&").append(RequestMapper.group).append("=images");
		sb.append("&").append(RequestMapper.grouptype).append("=images");
		sb.append("&").append(RequestMapper.id).append("=").append(id);
		return sb.toString();
	}

	public static String slides(RequestVO req, ObjGroupVO[] g, String style, int visible, boolean doreduce) {
		if (g.length < 1) { return ""; }
		return slides(req, g[0], style, visible, doreduce, false);
	}

	public static String slides(RequestVO req, ObjGroupVO g, String style, int visible, boolean doreduce, boolean border) {
		ObjMap[] map = g.getValues();
		int l = map.length;
		String reduce = "";
		if (doreduce) {
			if (visible > 1) {
				if (visible > l) {
					if (l < visible/3) {
						reduce = " reduce=\"1\"";
					}
					else if (l < visible/2) {
						reduce = " reduce=\"2\"";
					}
					else if (l < (visible/3) * 2) {
						reduce = " reduce=\"3\"";
					}
				}
			}
		}
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		sb.append(" <div class=\"").append(style).append("container\" visible=\"").append(visible).append("\"");
		if (border) {
			sb.append(" border=\"true\"");
		}
		sb.append(">\n");
		sb.append(" 	<div class=\"").append(style).append("wrapper\" visible=\"").append(visible).append("\"").append(reduce).append(">\n");
		sb.append(" 		<div class=\"").append(style).append("list\" visible=\"").append(visible).append("\">\n");
		for (int i=0; i < l; i++) {
			ObjMap m = map[i];
			if (!CsConfig.isPublic() || m.isShowpublic() || g.getToken().isStaff()) {
				String random = Operator.randomString();
				StringBuilder imgsb = new StringBuilder();
				imgsb.append(Config.fullcontexturl()).append("/viewimg.jsp?").append(RequestMapper.id).append("=").append(getValue(m, "ID")).append("&rndm=").append(Operator.urlFriendly(random));
				String img = imgsb.toString();

				if (Operator.hasValue(img)) {
					int id = m.getId();
					String link = link(req, id);
					String title = getValue(m, "TITLE");

					sb.append(slide(id, title, img, link, visible, style));
					empty = false;
				}
			}

		}
		if (empty) { return ""; }
		sb.append(" 		</div>\n");
		sb.append(" 	</div>\n");
		sb.append(" 	<a class=\"prevnav\">&#10094;</a> ");
		sb.append(" 	<a class=\"nextnav\">&#10095;</a> ");
		sb.append(" </div>\n");
		return sb.toString();
	}

	public static String thumbs(RequestVO req, ObjGroupVO[] g) {
		if (g.length < 1) { return ""; }
		return thumbs(req, g[0]);
	}

	public static String thumbs(RequestVO req, ObjGroupVO g) {
		ObjMap[] map = g.getValues();
		int l = map.length;
		String reduce = "";
		if (l < 10) {
			if (l < 4) {
				reduce = " reduce=\"1\"";
			}
			else if (l < 6) {
				reduce = " reduce=\"2\"";
			}
			else if (l < 8) {
				reduce = " reduce=\"3\"";
			}
		}
		int visible = 10;
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		sb.append(" <div class=\"thumbcontainer\" visible=\"").append(visible).append("\">\n");
		sb.append(" 	<div class=\"thumbwrapper\" visible=\"").append(visible).append("\"").append(reduce).append(">\n");
		sb.append(" 		<div class=\"thumblist\" visible=\"").append(visible).append("\">\n");
		for (int i=0; i < l; i++) {
			ObjMap m = map[i];

			String random = Operator.randomString();
			StringBuilder imgsb = new StringBuilder();
			imgsb.append(Config.fullcontexturl()).append("/viewimg.jsp?view=thumb&").append(RequestMapper.id).append("=").append(getValue(m, "ID")).append("&rndm=").append(Operator.urlFriendly(random));
			String img = imgsb.toString();

			if (Operator.hasValue(img)) {
				int id = m.getId();
				sb.append(thumb(id, img));
				empty = false;
			}
		}
		if (empty) { return ""; }
		sb.append(" 		</div>\n");
		sb.append(" 	</div>\n");
		sb.append(" 	<a class=\"prevthumb\">&#10094;</a> ");
		sb.append(" 	<a class=\"nextthumb\">&#10095;</a> ");
		sb.append(" </div>\n");
		return sb.toString();
	}

	public static String table(RequestVO req, ObjGroupVO[] g) {
		if (g.length < 1) { return ""; }
		return table(req, g[0]);
	}

	public static String table(RequestVO req, ObjGroupVO g) {
		ObjMap[] map = g.getValues();
		int l = map.length;
		int visible = 1;
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		sb.append(" <div class=\"slidecontainer\" visible=\"").append(visible).append("\">\n");
		sb.append(" 	<div class=\"slidewrapper\" visible=\"").append(visible).append("\">\n");
		sb.append(" 		<div class=\"slidelist\" visible=\"").append(visible).append("\">\n");
		for (int i=0; i < l; i++) {
			ObjMap m = map[i];

			String random = Operator.randomString();
			StringBuilder imgsb = new StringBuilder();
			imgsb.append(Config.fullcontexturl()).append("/viewimg.jsp?view=pic&").append(RequestMapper.id).append("=").append(getValue(m, "ID")).append("&rndm=").append(Operator.urlFriendly(random));
			String img = imgsb.toString();

			if (Operator.hasValue(img)) {
				int id = m.getId();

				String title = getValue(m, "TITLE");

				sb.append(table(id, getContent(m), img, "slide"));
				empty = false;
			}
		}
		if (empty) { return ""; }
		sb.append(" 		</div>\n");
		sb.append(" 	</div>\n");
		sb.append(" 	<a class=\"prevnav\">&#10094;</a> ");
		sb.append(" 	<a class=\"nextnav\">&#10095;</a> ");
		sb.append(" </div>\n");
		return sb.toString();
	}

	public static String getContent(ObjMap m) {
		String id = getValue(m, "ID");
		StringBuilder sb = new StringBuilder();
		sb.append("<table cellpadding=\"10\" cellspacing=\"5\" border=\"0\" width=\"100%\">");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">TITLE</td>");
		sb.append("<td class=\"slidevalue\">").append(getValue(m,"TITLE")).append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">TYPE</td>");
		sb.append("<td class=\"slidevalue\">").append(getValue(m,"TYPE")).append("</td>");
		sb.append("</tr>");
		String source = getValue(m,"REF");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">SOURCE</td>");
		sb.append("<td class=\"slidevalue\">").append(source).append("</td>");
		sb.append("</tr>");
		if (Operator.equalsIgnoreCase(source, "review")) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">REVIEW GROUP</td>");
			sb.append("<td class=\"slidevalue\">").append(getValue(m,"REVIEW_GROUP")).append("</td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">REVIEW</td>");
			sb.append("<td class=\"slidevalue\">").append(getValue(m,"REVIEW")).append("</td>");
			sb.append("</tr>");
		}
		String actnbr = getValue(m, "ACT_NBR");
		if (Operator.hasValue(actnbr)) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">ACTIVITY NUMBER</td>");
			sb.append("<td class=\"slidevalue\">").append(actnbr).append("</td>");
			sb.append("</tr>");
		}
		String acttype = getValue(m, "ACTIVITY_TYPE");
		if (Operator.hasValue(acttype)) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">ACTIVITY TYPE</td>");
			sb.append("<td class=\"slidevalue\">").append(acttype).append("</td>");
			sb.append("</tr>");
		}
		String prnbr = getValue(m, "PROJECT_NBR");
		if (Operator.hasValue(prnbr)) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">PROJECT NUMBER</td>");
			sb.append("<td class=\"slidevalue\">").append(prnbr).append("</td>");
			sb.append("</tr>");
		}
		String ptype = getValue(m, "PROJECT_TYPE");
		if (Operator.hasValue(ptype)) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">PROJECT TYPE</td>");
			sb.append("<td class=\"slidevalue\">").append(ptype).append("</td>");
			sb.append("</tr>");
		}
		String entity = getValue(m, "ENTITY");
		if (Operator.hasValue(entity)) {
			sb.append("<tr>");
			sb.append("<td class=\"slidelabel\">LOCATION</td>");
			sb.append("<td class=\"slidevalue\">").append(entity).append("</td>");
			sb.append("</tr>");
		}
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">ATTACHMENT ID</td>");
		sb.append("<td class=\"slidevalue\">").append(id).append("</td>");
		sb.append("</tr>");
		String path = getValue(m, "PATH");
		String fname = FileUtil.getFilename(path);
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">FILENAME</td>");
		sb.append("<td class=\"slidevalue\">").append(fname).append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">CREATED DATE</td>");
		sb.append("<td class=\"slidevalue\">").append(getValue(m,"DATE")).append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">CREATED BY</td>");
		sb.append("<td class=\"slidevalue\">").append(getValue(m,"CREATED")).append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td class=\"slidelabel\">DESCRIPTION</td>");
		sb.append("<td class=\"slidevalue\">").append(getValue(m,"DESCRIPTION")).append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		return sb.toString();
	}

	public static String getValue(ObjMap m, String field) {
		try {
			ObjVO o = m.value(field);
			return o.getValue();
		}
		catch (Exception e) { return ""; }
	}

	public static String thumb(int id, String img) {
		return slide(id, "", img, "", 10, "thumb", "slide");
	}

	public static String slide(int id, String title, String img, String link, int visible, String style) {
		return slide(id, title, img, link, visible, style, "");
	}

	public static String slide(int id, String title, String img, String link, int visible, String style, String rel) {
		StringBuilder sb = new StringBuilder();
		sb.append(" <div class=\"").append(style).append("\" id=\"").append(style).append("_").append(id).append("\"");
		if (Operator.hasValue(rel)) {
			sb.append(" rel=\"").append(rel).append("_").append(id).append("\"");
		}
		sb.append(">\n");

		sb.append(" 	<div class=\"").append(style).append("img\" id=\"thumbimg_").append(id).append("\" visible=\"").append(visible).append("\" data-original=\"").append(img).append("\" style=\"background: url(").append(CsConfig.getImage("placeholder")).append("); background-size: cover; background-repeat: no-repeat; background-position: center;\">\n");
		if (Operator.hasValue(link)) {
			sb.append(" 		<a href=\"").append(link).append("\" target=\"lightbox-iframe\"><img src=\"").append(Config.emptyImageUrl()).append("\" style=\"width: 100%; height: 100%\" border=\"0\"/></a>");
		}
		sb.append(" 	</div>\n");
		if (Operator.hasValue(title)) {
			sb.append(" 	<div class=\"").append(style).append("caption\">").append(title).append("</div>\n");
		}
		sb.append(" </div>\n");
		return sb.toString();
	}

	public static String table(int id, String content, String img, String style) {
		StringBuilder sb = new StringBuilder();
		sb.append(Config.fullcontexturl()).append("/viewfile.jsp?").append(RequestMapper.id).append("=").append(id).append("&rndm=").append(Operator.urlFriendly(Operator.randomString()));
		String link = sb.toString();

		sb = new StringBuilder();
		sb.append(" <div class=\"").append(style).append("\" id=\"slide_").append(id).append("\" rel=\"thumb_").append(id).append("\" visible=\"1\">\n");

		sb.append(" <table cellpadding=\"5\" cellspacing=\"0\" border=\"0\" class=\"").append(style).append("table\">\n");
		sb.append(" 	<tr>\n");
		sb.append(" 		<td width=\"60%\" class=\"").append(style).append("img\">\n");
		sb.append(" 			<a href=\"").append(link).append("\" target=\"_blank\"><img data-original=\"").append(img).append("\" id=\"slideimg_").append(id).append("\" src=\"").append(CsConfig.getImage("placeholder")).append("\" style=\"max-width: 100%; max-height: 600px\" border=\"0\"/></a>\n");
		sb.append(" 		</td>\n");
		sb.append(" 		<td width=\"1%\" valign=\"top\" nowrap>\n");
		sb.append(" 			<img src=\"").append(CsConfig.getImage("rotate")).append("\" class=\"rotate\" rel=\"").append(id).append("\" border=\"0\" title=\"rotate\"/>\n");
		sb.append(" 		</td>\n");
		sb.append(" 		<td width=\"39%\" class=\"").append(style).append("caption\">\n");
		sb.append(" 			").append(content).append("\n");
		sb.append(" 		</td>\n");
		sb.append(" 	</tr>\n");
		sb.append(" </table>\n");

		sb.append(" </div>\n");
		return sb.toString();
	}


}
