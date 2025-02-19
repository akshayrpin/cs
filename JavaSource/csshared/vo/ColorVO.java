package csshared.vo;

import alain.core.utils.Operator;


public class ColorVO {

	public int typeid = -1;
	public String type = "";
	public String color = "";
	public String style = "";
	public String label = "";
	public int year = -1;

	public ColorVO() { }

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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getLabel() {
		return label;
	}

	public String getLabel(String zone) {
		if (Operator.equalsIgnoreCase(label, "zone")) {
			return zone;
		}
		else {
			return getLabel();
		}
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}
	




}
