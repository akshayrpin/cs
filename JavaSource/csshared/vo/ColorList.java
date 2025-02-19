package csshared.vo;

import java.util.HashMap;


public class ColorList {

	public HashMap<String, ColorVO> colors = new HashMap<String, ColorVO>();
	public HashMap<String, ColorVO> deflt = new HashMap<String, ColorVO>();

	public ColorList() { }

	public HashMap<String, ColorVO> getColors() {
		return colors;
	}

	public void setColors(HashMap<String, ColorVO> colors) {
		this.colors = colors;
	}

	public HashMap<String, ColorVO> getDefault() {
		return deflt;
	}

	public void setDefault(HashMap<String, ColorVO> deflt) {
		this.deflt = deflt;
	}

	public ColorVO getColor(String type, int expyear) {
		ColorVO vo = new ColorVO();
		try {
			String field = field(type, expyear);
			vo = colors.get(field);
			if (vo ==  null) {
				vo = getDefault(type);
			}
		}
		catch(Exception e) { vo = new ColorVO(); }
		return vo;
	}

	public ColorVO getDefault(String type) {
		ColorVO vo = new ColorVO();
		try {
			vo = deflt.get(type);
			if (vo ==  null) { vo = new ColorVO(); }
		}
		catch(Exception e) { vo = new ColorVO(); }
		return vo;
	}

	public void addColor(ColorVO vo) {
		String field = field(vo.getType(), vo.getYear());
		colors.put(field, vo);
	}

	public void addColor(int expyear, int typeid, String type, String color, String style, String label) {
		ColorVO vo = new ColorVO();
		vo.setTypeid(typeid);
		vo.setType(type);
		vo.setColor(color);
		vo.setStyle(style);
		vo.setLabel(label);
		vo.setYear(expyear);
		addColor(vo);
	}

	public String field(String type, int expyear) {
		StringBuilder sb = new StringBuilder();
		sb.append(type).append("_").append(expyear);
		return sb.toString();
	}

	public void addDefault(ColorVO vo) {
		String field = vo.getType();
		deflt.put(field, vo);
	}

	public void addDefault(int expyear, int typeid, String type, String color, String style, String label) {
		ColorVO vo = new ColorVO();
		vo.setTypeid(typeid);
		vo.setType(type);
		vo.setColor(color);
		vo.setStyle(style);
		vo.setLabel(label);
		vo.setYear(expyear);
		addDefault(vo);
	}













}
