package csshared.vo;

import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class AvailabilityTimeVO {

	public String id = ""; // availability identifier
	public int defaultid = -1; // availability_default_id
	public int customid = -1; //availability_custom_id
	public String date = "";
	public String start = "";
	public String end = "";
	public String begin = "";
	public String stop = "";
	public int presched = -1;
	public int preseats = 0;
	public int bufferseats = 0;
	public int bufferhours = 0;
	public int taken = 0;
	public boolean disabled = false;
	public boolean staff = false;
	public String text = "";
	public String message = "";

	public AvailabilityTimeVO() { }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getDefaultid() {
		return defaultid;
	}

	public void setDefaultid(int defaultid) {
		this.defaultid = defaultid;
	}

	public int getCustomid() {
		return customid;
	}

	public void setCustomid(int customid) {
		this.customid = customid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Timekeeper dateObject() {
		Timekeeper d = new Timekeeper();
		d.setDate(getDate());
		d.setTime(getStart());
		return d;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getStop() {
		return stop;
	}

	public void setStop(String stop) {
		this.stop = stop;
	}

	public Timekeeper cutoff() {
		Timekeeper d = new Timekeeper();
		d.addDay(1);
		d.setHour(0);
		d.setMinute(0);
		d.setSecond(0);
		if (Operator.hasValue(getStop())) {
			d.setTime(getStop());
		}
		return d;
	}

	public int getPresched() {
		return presched;
	}

	public void setPresched(int presched) {
		this.presched = presched;
	}

	public Timekeeper preschedule() {
		Timekeeper d = new Timekeeper();
		d.setHour(23);
		d.setMinute(59);
		d.setSecond(59);
		if (getPresched() > 0) {
			d.addDay(getPresched());
		}
		else {
			d.addDay(100);
		}
		if (Operator.hasValue(getBegin())) {
			d.setTime(getBegin());
		}
		return d;
	}

	public Timekeeper bufferStart() {
		Timekeeper d = cutoff();
		if (getBufferhours() > 0) {
			d.addHour(-1 * getBufferhours());
		}
		return d;
	}

	public boolean tooEarly() {
		if (!Operator.hasValue(getDate())) { return false; }
		if (getPresched() < 1) { return false; }
		boolean r = false;
		Timekeeper start = preschedule();
		Timekeeper avdate = dateObject();
		if (start.DATECODE() == avdate.DATECODE()) {
			if (start.HHMM() <= avdate.HHMM()) {
				r = true;
			}
		}
		else if (start.DATECODE() < avdate.DATECODE()) {
			r = true;
		}
		return r;
	}

	public boolean tooLate() {
		if (!Operator.hasValue(getDate())) { return false; }
		boolean r = false;
		Timekeeper current = new Timekeeper();
		Timekeeper cutoff = cutoff();
		Timekeeper avdate = dateObject();
		if (avdate.DATECODE() < current.DATECODE()) {
			r = true;
		}
		else if (!isStaff() && avdate.DATECODE() == cutoff.DATECODE()) {
			if (current.HHMM() >= cutoff.HHMM()) {
				r = true;
			}
		}
		else if (!isStaff() && avdate.DATECODE() < cutoff.DATECODE()) {
			r = true;
		}
		return r;
	}

	public int getSeats() {
		if (staff) { return -1; }
		int sts = getPreseats();
		if (Operator.hasValue(getDate()) && getBufferhours() > 0 && getBufferseats() > 0) {
			Timekeeper avdate = dateObject();
			Timekeeper cutoff = bufferStart();
			if (cutoff.DATECODE() == avdate.DATECODE()) {
				Timekeeper k = new Timekeeper();
				if (k.HHMM()>= cutoff.HHMM()) {
					sts = sts + getBufferseats();
				}
			}else if (cutoff.DATECODE() >= avdate.DATECODE()) {
				sts = sts + getBufferseats();
			}
			
		}
		return sts;
	}

	public int getPreseats() {
		return preseats;
	}

	public void setPreseats(int preseats) {
		this.preseats = preseats;
	}

	public int getBufferseats() {
		return bufferseats;
	}

	public void setBufferseats(int bufferseats) {
		this.bufferseats = bufferseats;
	}

	public int getBufferhours() {
		return bufferhours;
	}

	public void setBufferhours(int bufferhours) {
		this.bufferhours = bufferhours;
	}

	public int getTaken() {
		return taken;
	}

	public void setTaken(int taken) {
		this.taken = taken;
	}

	public void setDisabled(boolean d) {
		this.disabled = d;
	}

	public boolean isDisabled() {
		boolean r = false;
		if (disabled) {
			r = true;
		}
		else if (tooLate()) {
			setMessage("Cut off time has passed.");
			r = true;
		}
		else if (tooEarly()) {
			setMessage("Too early to reserve this time.");
			r = true;
		}
		else if (isFull()) {
			setMessage("Availability is full.");
			r = true;
		}
		return r;
	}

	public boolean isStaff() {
		return staff;
	}

	public void setStaff(boolean staff) {
		this.staff = staff;
	}

	public boolean isFull() {
		if (getSeats() < 0) { return false; }
		int seats = getSeats();
		if (seats < 0) { return false; }
		return taken >= seats;
	}

	public int remaining() {
		int seats = getSeats();
		if (seats < 0) { return 100; }
		return seats - taken;
	}

	public void takeSeat() {
		taken++;
	}

	public String getText() {
		StringBuilder sb = new StringBuilder();
		if (getStart().equalsIgnoreCase("0:00") && getEnd().equalsIgnoreCase("23:59")) {
			sb.append("all day");
		}
		else if (Operator.equalsIgnoreCase(getStart(), getEnd())) {
			Timekeeper s = new Timekeeper();
			s.setTime(getStart());
			sb.append(s.getString("TIME"));
		}
		else {
			sb.append(getStart()).append(" - ").append(getEnd());
		}
		if (getSeats() >= 0) {
			sb.append(" &nbsp;&nbsp; (").append(getTaken()).append("/").append(getSeats()).append(") ");
		}
		else {
			sb.append(" &nbsp;&nbsp; (").append(getTaken()).append(" seats taken) ");
		}
		return sb.toString();
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public AvailabilityTimeVO copy() {
		AvailabilityTimeVO vo = new AvailabilityTimeVO();
		date = "";
		vo.id = this.id;
		vo.defaultid = this.defaultid;
		vo.customid = this.customid;
		vo.start = this.start;
		vo.end = this.end;
		vo.begin = this.begin;
		vo.stop = this.stop;
		vo.taken = this.taken;
		vo.preseats = this.preseats;
		vo.bufferseats = this.bufferseats;
		vo.bufferhours = this.bufferhours;
		vo.disabled = this.disabled;
		vo.text = this.text;
		vo.message = this.message;
		return vo;
	}



}




