package csshared.vo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class AvailabilityDateVO {

	public String date = "";
	public String weekday = "";
	public boolean custom = false;
	public String holiday = "";
	public boolean closed = false;
	public boolean disabled = false;
	public boolean staff = false;
	public int dayactive = 0;
	public int daymax = -1;
	public String[] disabledtimes = new String[0];
	public String message = "";
	public LinkedHashMap<String, AvailabilityTimeVO> times = new LinkedHashMap<String, AvailabilityTimeVO>();

	public AvailabilityDateVO() { }

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getWeekday() {
		return weekday;
	}

	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}

	public boolean isCustom() {
		return custom;
	}

	public void setCustom(boolean custom) {
		this.custom = custom;
	}

	public String getHoliday() {
		return holiday;
	}

	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}

	public boolean isClosed() {
		return closed;
	}

	public void setClosed(boolean closed) {
		if (closed) {
			setTimes(new LinkedHashMap<String, AvailabilityTimeVO>());
		}
		this.closed = closed;
	}

	public int getDayactive() {
		return dayactive;
	}

	public void setDayactive(int dayactive) {
		this.dayactive = dayactive;
	}

	public int getDaymax() {
		return daymax;
	}

	public void setDaymax(int daymax) {
		this.daymax = daymax;
	}

	public void setDisabled(boolean d) {
		this.disabled = d;
	}

	public boolean isDisabled() {
		boolean r = false;
		if (disabled) { r = true; }
		else if (getDaymax() > 0 && getDayactive() >= getDaymax()) { return true; }
		else if (getTimes() == null) { r = true; }
		else if (getTimes().size() < 1) { r = true; }
		else if (getDisabledtimes().length >= getTimes().size()) { return true; }
		else { r = isClosed(); }
		return r;
	}

	public boolean isStaff() {
		return staff;
	}

	public void setStaff(boolean staff) {
		this.staff = staff;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setDisabledtimes(String[] d) {
		this.disabledtimes = d;
	}

	public String[] getDisabledtimes() {
		if (Operator.hasValue(disabledtimes)) { return disabledtimes; }
		else {
			ArrayList<String> l = new ArrayList<String>();
			for (Map.Entry<String, AvailabilityTimeVO> entry : times.entrySet()) {
				String f = entry.getKey();
				AvailabilityTimeVO v = entry.getValue();
				if (v.isDisabled()) {
					l.add(f);
				}
			}
			setDisabledtimes(Operator.toArray(l));
			return disabledtimes;
		}
	}

	public LinkedHashMap<String, AvailabilityTimeVO> getTimes() {
		return times;
	}

	public void setTimes(LinkedHashMap<String, AvailabilityTimeVO> times) {
		this.times = times;
	}

	public LinkedHashMap<String, AvailabilityTimeVO> copyTimes() {
		LinkedHashMap<String, AvailabilityTimeVO> map = getTimes();
		LinkedHashMap<String, AvailabilityTimeVO> r = new LinkedHashMap<String, AvailabilityTimeVO>();

		for (Map.Entry<String, AvailabilityTimeVO> entry : map.entrySet()) {
			String f = entry.getKey();
			AvailabilityTimeVO v = entry.getValue();
			r.put(f, v.copy());
		}

		return r;
	}

	public AvailabilityDateVO copy() {
		AvailabilityDateVO vo = new AvailabilityDateVO();
		vo.date = this.date;
		vo.weekday = this.weekday;
		vo.custom = this.custom;
		vo.holiday = this.holiday;
		vo.closed = this.closed;
		vo.disabled = this.disabled;
		vo.disabledtimes = this.disabledtimes;
		vo.message = this.message;
		vo.times = copyTimes();
		return vo;
	}

	public void addTime(AvailabilityTimeVO vo) {
		String t = vo.getStart();
		if (Operator.hasValue(t)) {
			times.put(t, vo);
		}
	}

	public void cutoff(String begindate) {
		Timekeeper now = new Timekeeper();
		Timekeeper stop = new Timekeeper();
		stop.addDay(1);
		Timekeeper cstop = new Timekeeper();

		Timekeeper begin = new Timekeeper();
		Timekeeper cbegin = new Timekeeper();
		if (Operator.hasValue(begindate)) {
			begin.setDate(begindate);
			begin.addDay(-1);
			cbegin.setDate(begindate);
		}

		Timekeeper d = new Timekeeper();
		d.setDate(getDate());

		LinkedHashMap<String, AvailabilityTimeVO> ntimes = new LinkedHashMap<String, AvailabilityTimeVO>();
		for (Map.Entry<String, AvailabilityTimeVO> entry : times.entrySet()) {
			String f = entry.getKey();
			AvailabilityTimeVO v = entry.getValue();
			String tstop = v.getStop();
			String tbegin = v.getBegin();
			if (d.DATECODE() < cstop.DATECODE()) {
				v.setDisabled(true);
			}
			else if (!isStaff() && d.DATECODE() <= cstop.DATECODE()) {
				v.setDisabled(true);
			}
			else if (!isStaff() && d.DATECODE() <= stop.DATECODE() && Operator.hasValue(tstop)) {
				Timekeeper t = new Timekeeper();
				t.setTime(tstop);
				if (t.HHMM() < now.HHMM()) {
					v.setDisabled(true);
				}
			}
			else if (Operator.hasValue(begindate)) {
				if (d.DATECODE() >= begin.DATECODE() && Operator.hasValue(tbegin)) {
					Timekeeper t = new Timekeeper();
					t.setTime(tbegin);
					if (t.HHMM() < now.HHMM()) {
						v.setDisabled(true);
					}
				}
				else if (d.DATECODE() >= cbegin.DATECODE()) {
					v.setDisabled(true);
				}
			}
			ntimes.put(v.start, v);
		}
		setTimes(ntimes);
	}

	public void processTimes() {
		ArrayList<String> l = new ArrayList<String>();
		String dt = getDate();
		LinkedHashMap<String, AvailabilityTimeVO> ntimes = new LinkedHashMap<String, AvailabilityTimeVO>();
		for (Map.Entry<String, AvailabilityTimeVO> entry : times.entrySet()) {
			String f = entry.getKey();
			AvailabilityTimeVO v = entry.getValue();
			v.setDate(dt);
			if (isDisabled()) {
				v.setDisabled(true);
			}
			if (v.isDisabled()) {
				v.setDisabled(true);
				l.add(f);
			}
			ntimes.put(v.start, v);
		}
		setTimes(ntimes);
		setDisabledtimes(Operator.toArray(l));
	}

	public void resetTimes() {
		setTimes(new LinkedHashMap<String, AvailabilityTimeVO>());
	}

	public void setSeats(Timekeeper time, int seat) {
		String t = time.getString("MILITARYTIME");
		if (Operator.hasValue(t)) {
			setSeats(t, seat);
		}
	}

	public void setSeats(String time, int seats) {
		if (Operator.hasValue(time)) {
			try { times.get(time).setPreseats(seats); } catch (Exception e) { }
		}
	}

	public void takeSeat(Timekeeper time) {
		String t = time.getString("MILITARYTIME");
		if (Operator.hasValue(t)) {
			takeSeat(t);
		}
	}

	public void takeSeat(Timekeeper time, int taken) {
		String t = time.getString("MILITARYTIME");
		if (Operator.hasValue(t)) {
			takeSeat(t, taken);
		}
	}

	public void takeSeat(String time) {
		if (Operator.hasValue(time)) {
			try { times.get(time).takeSeat(); } catch (Exception e) { }
		}
	}

	public void takeSeat(String time, int taken) {
		if (Operator.hasValue(time)) {
			try { times.get(time).setTaken(taken); } catch (Exception e) { }
		}
	}

	public AvailabilityTimeVO time(Timekeeper time) {
		String t = time.getString("MILITARYTIME");
		return time(t);
	}

	public AvailabilityTimeVO time(String time) {
		AvailabilityTimeVO vo = times.get(time);
		if (vo == null) {
			vo = new AvailabilityTimeVO();
		}
		return vo;
	}

	public LinkedHashMap<String, AvailabilityTimeVO> clonetimes() {
		return new LinkedHashMap<String, AvailabilityTimeVO>(times);
	}

	public AvailabilityDateVO clone() {
		AvailabilityDateVO vo = new AvailabilityDateVO();
		vo.date = date;
		vo.times = clonetimes();
		return vo;
	}





}




