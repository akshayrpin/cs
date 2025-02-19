 package csshared.vo;


public class BrowserPanelsVO {

	public BrowserPanelDetailsVO menu = new BrowserPanelDetailsVO();
	public BrowserPanelDetailsVO main = new BrowserPanelDetailsVO();
	public BrowserPanelDetailsVO sub = new BrowserPanelDetailsVO();
	public BrowserPanelDetailsVO link = new BrowserPanelDetailsVO();

	public BrowserPanelsVO() { }

	public BrowserPanelDetailsVO getMenu() {
		return menu;
	}
	public void setMenu(BrowserPanelDetailsVO menu) {
		this.menu = menu;
	}
	public BrowserPanelDetailsVO getMain() {
		return main;
	}
	public void setMain(BrowserPanelDetailsVO main) {
		this.main = main;
	}
	public BrowserPanelDetailsVO getSub() {
		return sub;
	}
	public void setSub(BrowserPanelDetailsVO sub) {
		this.sub = sub;
	}
	public BrowserPanelDetailsVO getLink() {
		return link;
	}
	public void setLink(BrowserPanelDetailsVO link) {
		this.link = link;
	}




}




