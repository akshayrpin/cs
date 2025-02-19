package csshared.utils;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.MapSet;
import alain.core.utils.Operator;

public class CsConfig {

	public static String CONFIGFILE = "cs.config.xml";
	public static final String SKIPVALUE = "--SKIP--";

	
	/**
	 * Determines if admin screen can be shown
	 * @return true if admin screen can be shown in common user interface such as summary page
	 */
	public static boolean allowAdmin() {
		return Operator.equalsIgnoreCase(getAdmin(), "Y");
	}

	public static String getAdmin() {
		return getString("allowadmin");
	}

	public static boolean isPublic() {
		return Operator.equalsIgnoreCase(getPublic(), "Y");
	}

	public static String getPublic() {
		return getString("public");
	}

	public static String getApiPath() {
		return getString("api.path");
	}

	public static String getSummary() {
		return getString("jsp.summary");
	}

	public static String getForm() {
		return getString("jsp.form.default");
	}

	public static String getHistory() {
		return getString("jsp.history.default");
	}

	public static String getForm(String group, String type) {
		String r = group;
		if (type.equalsIgnoreCase("review")) { r = type; }
		if (!Operator.hasValue(r)) { return getForm(); }
		String f = getString("jsp.form."+r.toLowerCase());
		if (!Operator.hasValue(f)) { f = getForm(); }
		return f;
	}

	public static String getHistory(String group) {
		String r = group;
		if (!Operator.hasValue(r)) { return getHistory(); }
		String f = getString("jsp.history."+r.toLowerCase());
		if (!Operator.hasValue(f)) { f = getHistory(); }
		return f;
	}

	public static String getMore(String group) {
		String r = group;
		String f = getString("jsp.more."+r.toLowerCase());
		return f;
	}

	public static String getImport(String group) {
		String r = group;
		if (!Operator.hasValue(r)) { return ""; }
		String f = getString("jsp.import."+r.toLowerCase());
		return f;
	}

	public static String getDetails() {
		return getString("jsp.details.default");
	}

	public static String getDetails(String group) {
		if (!Operator.hasValue(group)) { return ""; }
		try {
			return getString("jsp.details."+group.toLowerCase());
		}
		catch (Exception e) { return ""; }
	}

	public static String getList() {
		return getString("jsp.list.default");
	}

	public static String getList(String group, String type) {
		String r = group;
		if (type.equalsIgnoreCase("review")) { r = type; }
		if (!Operator.hasValue(r)) { return getForm(); }
		String f = getString("jsp.list."+r.toLowerCase());
		if (!Operator.hasValue(f)) { f = getList(); }
		return f;
	}

	public static String getDomain(String entity) {
		StringBuilder sb = new StringBuilder();
		sb.append("entities.").append(entity).append(".domain");
		String r = getString(sb.toString());
		if (!Operator.hasValue(r)) { return getDefaultDomain(); }
		else { return r; }
	}

	public static String getDefaultDomain() {
		return getString("defaultdomain");
	}

	public static String getImage(String img) {
		StringBuilder sb = new StringBuilder();
		sb.append("images.").append(img.toLowerCase());
		return getString(sb.toString());
	}

	public static String getImage(String color, String img) {
		StringBuilder sb = new StringBuilder();
		sb.append("images.");
		if (Operator.hasValue(color) && Operator.equalsIgnoreCase(color, "black")) {
			sb.append(color.toLowerCase()).append(".");
		}
		sb.append(img.toLowerCase());
		return getString(sb.toString());
	}

	public static String[] getEntities() {
		return getValues("entities.entity");
	}

	public static MapSet getEntity(String entity) {
		MapSet map = new MapSet();
		map.set("entity", entity);
		map.set("type", entity);
		StringBuilder sb = new StringBuilder();
		sb.append("entities.").append(entity);
		String n = sb.toString();

		sb = new StringBuilder().append(n).append(".menuid");
		String menuid = getString(sb.toString());
		map.set("menuid", menuid);

		sb = new StringBuilder().append(n).append(".title");
		String title = getString(sb.toString());
		map.set("title", title);

		sb = new StringBuilder().append(n).append(".domain");
		String domain = getString(sb.toString());
		map.set("domain", domain);

		sb = new StringBuilder().append(n).append(".image");
		String image = getString(sb.toString());
		map.set("image", image);

		sb = new StringBuilder().append(n).append(".main");
		String main = getString(sb.toString());
		if (Operator.hasValue(main)) {
			map.set("main", main);
		}

		sb = new StringBuilder().append(n).append(".sub");
		String sub = getString(sb.toString());
		if (Operator.hasValue(sub)) {
			map.set("sub", sub);
		}

		sb = new StringBuilder().append(n).append(".link");
		String link = getString(sb.toString());
		if (Operator.hasValue(link)) {
			map.set("link", link);
		}

		sb = new StringBuilder().append(n).append(".admin");
		String admin = getString(sb.toString());
		if (Operator.hasValue(admin)) {
			map.set("admin", admin);
		}

		return map;
	}

	/**
	 * Get the value of specified node
	 * @param nodename - the name of the node to retrieve
	 * @return value of specified node
	 */
	public static String getString(String nodename) {
		return Config.getString(CONFIGFILE, nodename);
	}

	/**
	 * Get the number of instances of specified node
	 * @param nodename - the name of the node 
	 * @return number of instances of specified node
	 */
	public static int size(String nodename) {
		return Config.size(CONFIGFILE, nodename);
	}

	/**
	 * Get a MapSet object containing values of specified nodenames
	 * @param nodenames - a list of nodenames to retrieve
	 * @return MapSet object containing values of specified nodes
	 */
	public static MapSet getConfig(String[] nodenames) {
		return Config.getConfig(CONFIGFILE, nodenames);
	}

	public static String importTool(String tool) {
		return Config.importTool(CONFIGFILE, tool);
	}

	public static String[] getValues(String node) {
		return Config.getValues(CONFIGFILE, node);
	}
	


}