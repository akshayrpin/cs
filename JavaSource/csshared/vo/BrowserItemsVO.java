 package csshared.vo;

import java.util.HashMap;


public class BrowserItemsVO {

	public HashMap<String, BrowserItemVO> panels = new HashMap<String, BrowserItemVO>();

	public BrowserItemsVO() { }

	public HashMap<String, BrowserItemVO> getPanels() {
		return panels;
	}

	public void setPanels(HashMap<String, BrowserItemVO> panels) {
		this.panels = panels;
	}

	public void addPanel(String name, BrowserItemVO item) {
		panels.put(name, item);
	}

	public BrowserItemVO item(String name) {
		BrowserItemVO v = panels.get(name);
		if (v == null) { v = new BrowserItemVO(); }
		return v;
	}

}




