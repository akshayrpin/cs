package csshared.vo;

import java.util.HashMap;



public class TaskVO {
	
	public int id = -1;
	public int typeid = -1;
	public int lkupid = -1;
	public String type = ""; 
	public String taskid = "";
	public String task = "";
	public String description = "";
	public boolean immediate = false;
	public boolean prescheduled = false;
	public int referenceid = -1;
	public HashMap<String,String> taskdetails = new HashMap<String,String>();
	public String result = "";
	public boolean repeat = false;
	
	public TaskVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getReferenceid() {
		return referenceid;
	}

	public void setReferenceid(int referenceid) {
		this.referenceid = referenceid;
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

	public String getTaskid() {
		return taskid;
	}

	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isImmediate() {
		return immediate;
	}

	public void setImmediate(boolean immediate) {
		this.immediate = immediate;
	}

	public boolean isPrescheduled() {
		return prescheduled;
	}

	public void setPrescheduled(boolean prescheduled) {
		this.prescheduled = prescheduled;
	}

	public HashMap<String, String> getTaskdetails() {
		return taskdetails;
	}

	public void setTaskdetails(HashMap<String, String> taskdetails) {
		this.taskdetails = taskdetails;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public boolean isRepeat() {
		return repeat;
	}

	public void setRepeat(boolean repeat) {
		this.repeat = repeat;
	}

	public int getLkupid() {
		return lkupid;
	}

	public void setLkupid(int lkupid) {
		this.lkupid = lkupid;
	}

	
	




}
