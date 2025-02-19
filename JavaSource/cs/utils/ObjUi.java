package cs.utils;

import alain.core.utils.Config;
import csshared.vo.RequestVO;
import csshared.vo.ToolsVO;
import csshared.vo.TypeVO;

public class ObjUi {

	public static String WHITEEDITIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/edit.png";
	public static String WHITEADDIMGURL = Config.fullcontexturl()+"/images/icons/controls/white/add.png";
	public static String GRAYEDITIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/edit.png";
	public static String GRAYADDIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/add.png";
	public static String GRAYADDMINIMGURL = Config.fullcontexturl()+"/images/icons/controls/gray/addmin.png";

	public static String table(RequestVO req, TypeVO e, String style) {
		style = style.trim();
		return ObjTables.getTable(req, e.getGroups(), style, e.getAlert(), false);
	}

	public static String history(RequestVO req, TypeVO e, String style) {
		style = style.trim();
		return ObjTables.getHistory(req, e.getGroups(), style, e.getAlert());
	}

	public static String subTable(RequestVO req, TypeVO e, String style) {
		style = style.trim();
		return ObjTables.getTable(req, e.getGroups(), style, e.getAlert(), true);
	}

	public static String form(RequestVO req, TypeVO e, String style) {
		return form(req, e, style, true);
	}

	public static String form(RequestVO req, TypeVO e, String style, boolean buttons) {
		style = style.trim();
		int l = e.getGroups().length;
		StringBuilder sb = new StringBuilder();
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.entity).append("\" value=\"").append(e.getEntity()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.type).append("\" value=\"").append(e.getType()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.typeid).append("\" value=\"").append(e.getTypeid()).append("\">\n");
		if (l > 0) {
			sb.append(ObjTables.getForm(req, e.getGroups(), style, e.getAlert()));
			if (buttons) {
				sb.append("<div class=\"").append(style).append("_buttons\"><input type=\"submit\" name=\"action\" value=\"save\" class=\"").append(style).append("_button\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String verticalForm(RequestVO req, TypeVO e, String style, boolean buttons) {
		style = style.trim();
		int l = e.getGroups().length;
		StringBuilder sb = new StringBuilder();
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.entity).append("\" value=\"").append(e.getEntity()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.type).append("\" value=\"").append(e.getType()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.typeid).append("\" value=\"").append(e.getTypeid()).append("\">\n");
		if (l > 0) {
			sb.append(ObjTables.getVerticalForm(req, e.getGroups(), style, e.getAlert()));
			if (buttons) {
				sb.append("<div class=\"").append(style).append("_buttons\"><input type=\"submit\" name=\"action\" value=\"save\" class=\"").append(style).append("_button\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String miniForm(RequestVO req, TypeVO e, String style, boolean buttons) {
		style = style.trim();
		int l = e.getGroups().length;
		StringBuilder sb = new StringBuilder();
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.entity).append("\" value=\"").append(e.getEntity()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.type).append("\" value=\"").append(e.getType()).append("\">\n");
		sb.append("<input type=\"hidden\" name=\"").append(RequestMapper.typeid).append("\" value=\"").append(e.getTypeid()).append("\">\n");
		if (l > 0) {
			sb.append(ObjTables.getMiniForm(req, e.getGroups(), style, e.getAlert()));
			if (buttons) {
				sb.append("<div class=\"").append(style).append("_buttons\"><input type=\"submit\" name=\"action\" value=\"save\" class=\"").append(style).append("_button\"></div>\n");
			}
		}
		return sb.toString();
	}

	public static String tools(ToolsVO tools, String style) {
		style = style.trim();
		return ObjTables.getTools(tools, style);
	}

	public static String closetools(ToolsVO tools, String style) {
		style = style.trim();
		return ObjTables.getCloseTools(tools, style);
	}






}
