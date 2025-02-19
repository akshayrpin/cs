 package csshared.vo;

import java.util.HashMap;


public class BrowserVO {

	public HashMap<String, BrowserPanelsVO> panels = new HashMap<String, BrowserPanelsVO>();
	public BrowserHeaderVO header = new BrowserHeaderVO();
	public BrowserItemVO[] items = new BrowserItemVO[0];
	public BrowserItemVO[] root = new BrowserItemVO[0];

	public BrowserVO() { }

	public HashMap<String, BrowserPanelsVO> getPanels() {
		return panels;
	}
	public void setPanels(HashMap<String, BrowserPanelsVO> panels) {
		this.panels = panels;
	}
	public BrowserHeaderVO getHeader() {
		return header;
	}
	public void setHeader(BrowserHeaderVO header) {
		this.header = header;
	}
	public BrowserItemVO[] getItems() {
		return items;
	}
	public void setItems(BrowserItemVO[] items) {
		this.items = items;
	}
	public BrowserItemVO[] getRoot() {
		return root;
	}
	public void setRoot(BrowserItemVO[] root) {
		this.root = root;
	}


}




