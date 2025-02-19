package csshared.vo;

import java.util.HashMap;

import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;

public class InspectionStatisticsVO {

	public int availabilityid = -1;
	public String availability = "";
	public String type = "";
	public String date = "";
	public int seats = 0;
	public int bufferseats = 0;
	public int total = 0;
	public HashMap<String, Integer> source = new HashMap<String, Integer>();

	public InspectionStatisticsVO() { }

	public int getAvailabilityid() {
		return availabilityid;
	}

	public void setAvailabilityid(int availabilityid) {
		this.availabilityid = availabilityid;
	}

	public String getAvailability() {
		return availability;
	}

	public void setAvailability(String availability) {
		this.availability = availability;
	}

	public String getType() {
		return type;
	}

	public String typeAbbr() {
		if (Operator.equalsIgnoreCase(getType(), "CUSTOM")) {
			return  "C";
		}
		else {
			return "D";
		}
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getSeats() {
		if (seats < 1) { return 0; }
		return seats;
	}

	public void setSeats(int seats) {
		this.seats = seats;
	}

	public int getBufferseats() {
		if (bufferseats < 1) { return 0; }
		return bufferseats;
	}

	public void setBufferseats(int bufferseats) {
		this.bufferseats = bufferseats;
	}

	public int getTotalSeats() {
		return getSeats() + getBufferseats();
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void addTotal(int requests) {
		this.total = this.total + requests;
	}

	public HashMap<String, Integer> getSource() {
		return source;
	}

	public int getSource(String sourcename) {
		int r = 0;
		try {
			return source.get(sourcename);
		}
		catch (Exception e) { r = 0; }
		return r;
	}

	public void setSource(HashMap<String, Integer> source) {
		this.source = source;
	}

	public void addSource(String sourcename, int requests) {
		this.source.put(sourcename, requests);
	}





}
