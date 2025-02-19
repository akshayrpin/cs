package cs.utils;

import java.lang.reflect.Method;

import alain.core.security.Token;
import alain.core.utils.Operator;
import csshared.utils.CsConfig;
import csshared.vo.ObjVO;
import csshared.vo.RequestVO;
import csshared.vo.SubObjVO;

public class ObjValues {

	public static String getDisplay(RequestVO req, int id, String group, String groupid, ObjVO vo, String style, Token u) {
		return run("display", req, id, group, groupid, vo, style, u);
	}

	public static String getDetails(RequestVO req, int id, String group, String groupid, ObjVO vo, String style, Token u) {
		return run("details", req, id, group, groupid, vo, style, u);
	}

	public static String getForm(RequestVO req, int id, String group, String groupid, ObjVO vo, String action, String style, Token u) {
		return run("form", req, id, group, groupid, vo, action, style, u);
	}

	public static String getDisplay(RequestVO req, int id, String group, String groupid, SubObjVO vo, String style, Token u) {
		return getDisplay(req, id, group, groupid, vo.toObj(), style, u);
	}

	public static String getForm(RequestVO req, int id, String group, String groupid, SubObjVO vo, String action, String style, Token u) {
		return getForm(req, id, group, groupid, vo.toObj(), action, style, u);
	}

	public static String getHtml(RequestVO req, int id, String group, String groupid, ObjVO vo, String style, Token u) {
		String value = getDisplay(req, id, group, groupid, vo, style, u);
		if (!Operator.hasValue(value)) { return "&nbsp;"; }
		return Operator.toHTML(value);
	}

	public static String getHtml(RequestVO req, int id, String group, String groupid, SubObjVO vo, String style, Token u) {
		String value = getDisplay(req, id, group, groupid, vo, style, u);
		if (!Operator.hasValue(value)) { return "&nbsp;"; }
		return Operator.toHTML(value);
	}

	private static String run(String t, RequestVO req, int id, String group, String groupid, ObjVO vo, String style, Token u) {
		return run(t, req, id, group, groupid, vo, "", style, u);
	}

	private static String run(String t, RequestVO req, int id, String group, String groupid, ObjVO vo, String action, String style, Token u) {
		if (CsConfig.isPublic() && !vo.isShowpublic()) {
			if (!u.isStaff()) {
				return "";
			}
		}
		String classname = "";
		if (t.equalsIgnoreCase("form")) {
			classname = "cs.utils.ObjForm";
			if (vo.getItype().equalsIgnoreCase("hidden")) {
				return ObjForm.hidden(req, id, group, groupid, vo, style);
			}
			if (action.equalsIgnoreCase("add")) {
				if (!vo.isAddable()) {
					return ObjForm.uneditable(req, id, group, groupid, vo, style);
				}
			}
			else {
				if (!vo.isEditable()) {
					return ObjForm.uneditable(req, id, group, groupid, vo, style);
				}
				if (vo.isEmptyonedit()) {
					vo.setValue("");
				}
			}
		}
		else {
			classname = "cs.utils.ObjDisplay";
		}
		String result = "";
		if (Operator.hasValue(classname)) {
			String type = vo.getType().toLowerCase();
			if (t.equalsIgnoreCase("form")) {
				type = vo.getItype().toLowerCase();
			}
			if (Operator.hasValue(type)) {
				if (type.equalsIgnoreCase("boolean")) {
					type = "yesno";
				}
				try {
					Class<?> _class = Class.forName(classname);
					Method _method = _class.getDeclaredMethod(type.toLowerCase(), new Class[]{RequestVO.class, int.class, String.class, String.class, ObjVO.class, String.class});
					result = (String) _method.invoke(null, new Object[]{req, id, group, groupid, vo, style});
				}
				catch (Exception e) {
					if (t.equalsIgnoreCase("form")) {
						result = ObjForm.get(req, id, group, groupid, vo, style);
					}
					else if (t.equalsIgnoreCase("details")) {
						result = ObjDisplay.get(req, id, group, groupid, vo, style, false);
					}
					else {
						result = ObjDisplay.get(req, id, group, groupid, vo, style);
					}
				}
			}
		}
		return result;
	}













}
