package csshared.vo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import alain.core.utils.Timekeeper;

public class InspectionStatisticsList {

	public LinkedHashMap<String, InspectionStatisticsVO> statistics = new LinkedHashMap<String, InspectionStatisticsVO>();

	public InspectionStatisticsList() { }

	public String field(String date, int avid) {
		StringBuilder sb = new StringBuilder();
		sb.append(date);
		sb.append("_");
		sb.append(avid);
		return sb.toString();
	}

	public InspectionStatisticsVO get(String date, int avid) {
		String field = field(date, avid);
		InspectionStatisticsVO vo = new InspectionStatisticsVO();
		try {
			vo = statistics.get(field);
			if (vo == null) { vo = new InspectionStatisticsVO(); }
		}
		catch (Exception e) {
			vo = new InspectionStatisticsVO();
		}
		return vo;
	}

	public void add(String date, int avid, InspectionStatisticsVO vo) {
		String field = field(date, avid);
		this.statistics.put(field, vo);
	}

	public void add(String date, int avid, String source, int requests) {
		InspectionStatisticsVO vo = get(date, avid);
		vo.addSource(source, requests);
		add(date, avid, vo);
	}

	public void add(String date, int avid, String availability, String type, int seats, int buffer, int total) {
		InspectionStatisticsVO vo = get(date, avid);
		vo.setDate(date);
		vo.setAvailability(availability);
		vo.setAvailabilityid(avid);
		vo.setType(type);
		vo.setSeats(seats);
		vo.setBufferseats(buffer);
		vo.setTotal(total);
		add(date, avid, vo);
	}

	public void add(String date, int avid, String availability, String type, int seats, int buffer, String source, int requests) {
		InspectionStatisticsVO vo = get(date, avid);
		vo.setDate(date);
		vo.setAvailability(availability);
		vo.setAvailabilityid(avid);
		vo.setType(type);
		vo.setSeats(seats);
		vo.setBufferseats(buffer);
		vo.addSource(source, requests);
		vo.addTotal(requests);
		add(date, avid, vo);
	}

	public void add(String date, int avid, String availability, String source, int requests) {
		InspectionStatisticsVO vo = get(date, avid);
		vo.setDate(date);
		vo.setAvailability(availability);
		vo.setAvailabilityid(avid);
		vo.addSource(source, requests);
		add(date, avid, vo);
	}

	public ArrayList<InspectionStatisticsVO> getList() {
		ArrayList<InspectionStatisticsVO> r = new ArrayList<InspectionStatisticsVO>();
		for (Map.Entry<String, InspectionStatisticsVO> entry : statistics.entrySet()) {
//			String field = entry.getKey();
			InspectionStatisticsVO value = entry.getValue();
			r.add(value);
		}
		return r;
	}

}








