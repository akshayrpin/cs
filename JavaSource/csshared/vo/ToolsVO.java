package csshared.vo;


public class ToolsVO {

	public int entityid = -1;
	public String entity = "";
	public int typeid = -1;
	public String type = "";
	public ToolVO[] tools = new ToolVO[0];

	public ToolsVO() {}

	public int getEntityid() {
		return entityid;
	}

	public void setEntityid(int entityid) {
		this.entityid = entityid;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
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

	public ToolVO[] getTools() {
		return tools;
	}

	public void setTools(ToolVO[] tools) {
		this.tools = tools;
	}


	




}
