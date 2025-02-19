package csshared.vo;

import alain.core.utils.Operator;

public class ToolVO {

	public int moduleid = -1;
	public int submoduleid = -1;
	public String tool = "";
	public String title = "";
	public String image = "";
	public String action = "";
	public boolean disableonhold = false;
	public boolean disabletoolonhold = false;
	public String holds = "";
	public String activitycopy = "N";
	public String projectcopy = "N";

	public ToolVO() {}

	public int getModuleid() {
		return moduleid;
	}

	public void setModuleid(int moduleid) {
		this.moduleid = moduleid;
	}

	public int getSubmoduleid() {
		return submoduleid;
	}

	public void setSubmoduleid(int submoduleid) {
		this.submoduleid = submoduleid;
	}

	public String id() {
		StringBuilder sb = new StringBuilder();
		sb.append(getTool());
		if (getSubmoduleid() > 0) {
			sb.append(":").append(getSubmoduleid());
		}
		return sb.toString();
	}

	public String getTool() {
		return tool;
	}

	public void setTool(String tool) {
		this.tool = tool;
	}

	public String getTitle() {
		if (!Operator.hasValue(title)) {
			return getTool();
		}
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getAction() {
		if (!Operator.hasValue(action)) {
			return "add";
		}
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public boolean isDisableonhold() {
		return disableonhold;
	}

	public void setDisableonhold(boolean disableonhold) {
		this.disableonhold = disableonhold;
	}

	public boolean isDisabletoolonhold() {
		return disabletoolonhold;
	}

	public void setDisabletoolonhold(boolean disabletoolonhold) {
		this.disabletoolonhold = disabletoolonhold;
	}

	public String getHolds() {
		return holds;
	}

	public void setHolds(String holds) {
		this.holds = holds;
	}

	public boolean isHeld() {
		return Operator.hasValue(getHolds());
	}
	
	public boolean isDisabled() {
		return isDisableonhold() && isHeld();
	}

	public boolean isToolDisabled() {
		return isDisabletoolonhold() && isHeld();
	}

	public String getActivitycopy() {
		return activitycopy;
	}

	public void setActivitycopy(String activitycopy) {
		this.activitycopy = activitycopy;
	}

	public boolean isActivitycopy() {
		return Operator.equalsIgnoreCase(getActivitycopy(), "Y");
	}

	public String getProjectcopy() {
		return projectcopy;
	}

	public void setProjectcopy(String projectcopy) {
		this.projectcopy = projectcopy;
	}

	public boolean isProjectcopy() {
		return Operator.equalsIgnoreCase(getProjectcopy(), "Y");
	}

}
