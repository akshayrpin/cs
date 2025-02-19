 package csshared.vo;

import csshared.utils.CsConfig;
import alain.core.utils.Config;
import alain.core.utils.Operator;


public class ReviewAttachmentVO {

	public int id = -1;
	public int comboid = -1;
	public int reviewid = -1;
	public int reviewrefid = -1;
	public int actionid = -1;
	public int attachid = -1;
	public String title = "";
	public int refattachid = -1;
	public String description = "";
	public String keywords = "";
	public int typeid = -1;
	public String type = "";
	public String path = "";

	public ReviewAttachmentVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getComboid() {
		return comboid;
	}

	public void setComboid(int comboid) {
		this.comboid = comboid;
	}

	public int getReviewid() {
		return reviewid;
	}

	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}

	public int getReviewrefid() {
		return reviewrefid;
	}

	public void setReviewrefid(int reviewrefid) {
		this.reviewrefid = reviewrefid;
	}

	public int getActionid() {
		return actionid;
	}

	public void setActionid(int actionid) {
		this.actionid = actionid;
	}

	public int getAttachid() {
		return attachid;
	}

	public void setAttachid(int attachid) {
		this.attachid = attachid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getRefattachid() {
		return refattachid;
	}

	public void setRefattachid(int refattachid) {
		this.refattachid = refattachid;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	//TODO url better approach
	public String getUrl() {
		if (!Operator.hasValue(getPath())) { return ""; }
		StringBuilder sb = new StringBuilder();
		//sb.append(Config.uploadedFileUrl(getPath()));
		sb.append(Config.rooturl()).append("/cs/viewfile.jsp?_id=").append(getAttachid());
		return sb.toString();
	}

	public String getExtension() {
		if (!Operator.hasValue(getPath())) { return ""; }
		return Operator.getExt(getPath());
	}

	public String getContentType() {
		if (!Operator.hasValue(getPath())) { return ""; }
		return Operator.contentType(getExtension());
	}

	public String getIcon() {
		if (!Operator.hasValue(getPath())) { return ""; }
		return Config.getFileIcon(getExtension());
	}

	public String getIconLink() {
		if (!Operator.hasValue(getPath())) { return ""; }
		StringBuilder sb = new StringBuilder();
		sb.append("<a href=\"").append(getUrl()).append("\" title=\"").append(getTitle()).append("\" target=\"_blank\"><img src=\"").append(getIcon()).append("\" border=\"0\"/></a>");
		return sb.toString();
	}









}






















