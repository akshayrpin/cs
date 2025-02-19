package csshared.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;


public class AvailabilityVO {

	public int id = -1;
	public String title = "";
	public String mindate = "";
	public String maxdate = "";
	public int preschedule = 0;
	public int childmax = -1;
	public int childtotal = -1;
	public String[] disableddates = new String[0];
	public LinkedHashMap<String, AvailabilityDateVO> dates = new LinkedHashMap<String, AvailabilityDateVO>();
	public String messagecode = "";
	public String message = "";

	public AvailabilityVO() { }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMindate() {
		return mindate;
	}

	public void setMindate(String mindate) {
		this.mindate = mindate;
	}

	public String getMaxdate() {
		return maxdate;
	}

	public void setMaxdate(String maxdate) {
		this.maxdate = maxdate;
	}

	public int getPreschedule() {
		return preschedule;
	}

	public void setPreschedule(int preschedule) {
		this.preschedule = preschedule;
	}

	public Timekeeper prescheduleEnd() {
		Timekeeper d = new Timekeeper();
		d.setHour(23);
		d.setMinute(59);
		d.setSecond(59);
		if (preschedule < 0) {
			d.addYear(100);
		}
		else {
			d.addDay(getPreschedule());
		}
		return d;
	}

	public void setDisableddates(String[] d) {
		this.disableddates = d;
	}

	public String[] getDisableddates() {
		if (Operator.hasValue(disableddates)) { return disableddates; }
		else {
			ArrayList<String> l = new ArrayList<String>();
			for (Map.Entry<String, AvailabilityDateVO> entry : dates.entrySet()) {
				String f = entry.getKey();
				AvailabilityDateVO v = entry.getValue();
				if (v.isDisabled()) {
					l.add(f);
				}
			}
			setDisableddates(Operator.toArray(l));
			return disableddates;
		}
	}

	public LinkedHashMap<String, AvailabilityDateVO> getDates() {
		return dates;
	}

	public void setDates(LinkedHashMap<String, AvailabilityDateVO> dates) {
		this.dates = dates;
	}


	public String getMessagecode() {
		return messagecode;
	}

	public void setMessagecode(String messagecode) {
		this.messagecode = messagecode;
	}

	public String getMessage() {
		if (disableddates.length >= dates.size()) {
			return "No available dates";
		}
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String toString() {
		String r = "";
		try {
			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			r = ow.writeValueAsString(this);
		}
		catch (Exception e) {}
		return r;
	}

	public void addDate(AvailabilityDateVO a) {
		String date = a.getDate();
		if (Operator.hasValue(date)) {
			dates.put(date, a);
		}
	}

	public void addTime(String date, AvailabilityTimeVO time) {
		String t = time.getStart();
		if (Operator.hasValue(t)) {
			try { dates.get(date).addTime(time); }
			catch (Exception e) { }
		}
	}

	public void takeSeat(Timekeeper date) {
		String d = date.getString("YYYY/MM/DD");
		if (Operator.hasValue(d)) {
			try { dates.get(d).takeSeat(date); } catch (Exception e) { }
		}
	}

	public void setSeats(Timekeeper date, int seats) {
		String d = date.getString("YYYY/MM/DD");
		if (Operator.hasValue(d)) {
			try { dates.get(d).setSeats(date, seats); } catch (Exception e) { }
		}
	}

	public void takeSeat(Timekeeper date, int taken) {
		String d = date.getString("YYYY/MM/DD");
		if (Operator.hasValue(d)) {
			try { dates.get(d).takeSeat(date, taken); } catch (Exception e) { }
		}
	}

	public AvailabilityDateVO date(Timekeeper date) {
		String d = date.getString("YYYY/MM/DD");
		return date(d);
	}

	public AvailabilityDateVO date(String date) {
		AvailabilityDateVO vo = dates.get(date);
		if (vo == null) { vo = new AvailabilityDateVO(); }
		return vo;
	}

	public AvailabilityTimeVO time(Timekeeper time) {
		AvailabilityDateVO d = date(time);
		return d.time(time);
	}

	public AvailabilityTimeVO time(String time) {
		AvailabilityDateVO d = date(time);
		return d.time(time);
	}

	public boolean custom(Timekeeper date) {
		String d = date.getString("YYYY/MM/DD");
		return custom(d);
	}

	public boolean custom(String date) {
		boolean r = false;
		try {
			dates.get(date).isCustom();
		}
		catch (Exception e) { }
		return r;
	}

	public AvailabilityDateVO getDate(String date) {
		return dates.get(date);
	}

	public void setCustom(String date, AvailabilityTimeVO time) {
		if (!custom(date)) {
			try {
				dates.get(date).setCustom(true);
				dates.get(date).resetTimes();
				dates.get(date).addTime(time);
			}
			catch (Exception e) { }
		}
		else {
			try {
				dates.get(date).addTime(time);
			}
			catch (Exception e) { }
		}
	}

	public void setHoliday(String date, String holiday, String message, boolean closed) {
		try {
			dates.get(date).setHoliday(holiday);
			dates.get(date).setMessage(message);
			dates.get(date).setClosed(true);
		}
		catch (Exception e) { }
	}

	public void create(Timekeeper start, Timekeeper end, HashMap<String, Integer> maxinfo, AvailabilityDateVO[] arr) {
		if (Operator.hasValue(arr)) {
			if (arr.length > 6) {
				create(start, end, maxinfo, arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6]);
			}
		}
	}

	public void createEmpty(Timekeeper start, Timekeeper end) {
		if (start.DATECODE() == end.DATECODE()) {
			AvailabilityDateVO vo = makeEmptyDate();
			create(start, end, new HashMap<String, Integer>(), vo, vo, vo, vo, vo, vo, vo);
		}
	}

	public void create(Timekeeper start, Timekeeper end, HashMap<String, Integer> maxinfo, AvailabilityDateVO sun, AvailabilityDateVO mon, AvailabilityDateVO tue, AvailabilityDateVO wed, AvailabilityDateVO thu, AvailabilityDateVO fri, AvailabilityDateVO sat) {

		String smon = makeString(mon);
		String stue = makeString(tue);
		String swed = makeString(wed);
		String sthu = makeString(thu);
		String sfri = makeString(fri);
		String ssat = makeString(sat);
		String ssun = makeString(sun);
		this.mindate = start.getString("YYYY/MM/DD");
		this.maxdate = end.getString("YYYY/MM/DD");
		Timekeeper today = new Timekeeper();

		int s = start.DATECODE();
		int e = end.DATECODE();

		try { childmax = maxinfo.get("MAX_CHILD_APPOINTMENTS"); } catch (Exception me) { childmax = -1; }
		try { childtotal = maxinfo.get("CHILD_APPOINTMENTS"); } catch (Exception me) { childtotal = -1; }

		int daymax = -1;
		try { daymax = maxinfo.get("MAX_DAY_APPOINTMENTS"); } catch (Exception me) { daymax = -1; }

		int activemax = -1;
		try { activemax = maxinfo.get("MAX_ACTIVE_APPOINTMENTS"); } catch (Exception me) { activemax = -1; }

		int activeappt = -1;
		try { activeappt = maxinfo.get("ACTIVE_APPOINTMENTS"); } catch (Exception me) { activeappt = -1; }

		int reviewmax = -1;
		try { reviewmax = maxinfo.get("MAX_REVIEW_APPOINTMENTS"); } catch (Exception me) { reviewmax = -1; }

		int reviewappt = -1;
		try { reviewappt = maxinfo.get("REVIEW_APPOINTMENTS"); } catch (Exception me) { reviewappt = -1; }

		int presched = -1;
		String begindate = "";
		try { presched = maxinfo.get("PRESCHEDULE_DAYS"); } catch (Exception me) { presched = -1; }
		Timekeeper begin = new Timekeeper();
		if (presched > 0) {
			begin.addDay(presched);
			begindate = begin.getString("YYYY/MM/DD");
		}

		while (s <= e) {
			String wk = start.weekday();
			AvailabilityDateVO vo = new AvailabilityDateVO();
			if (Operator.equalsIgnoreCase(wk, "monday")) {
				vo = makeDateObj(smon);
			}
			else if (Operator.equalsIgnoreCase(wk, "tuesday")) {
				vo = makeDateObj(stue);
			}
			else if (Operator.equalsIgnoreCase(wk, "wednesday")) {
				vo = makeDateObj(swed);
			}
			else if (Operator.equalsIgnoreCase(wk, "thursday")) {
				vo = makeDateObj(sthu);
			}
			else if (Operator.equalsIgnoreCase(wk, "friday")) {
				vo = makeDateObj(sfri);
			}
			else if (Operator.equalsIgnoreCase(wk, "saturday")) {
				vo = makeDateObj(ssat);
			}
			else if (Operator.equalsIgnoreCase(wk, "sunday")) {
				vo = makeDateObj(ssun);
			}
			String field = start.getString("YYYY/MM/DD");
			vo.setDate(field);
			vo.setWeekday(wk);
			if (prescheduleEnd().DATECODE() < start.DATECODE()) {
				vo.setDisabled(true);
			}
			if (today.DATECODE() > start.DATECODE()) {
				vo.setDisabled(true);
			}

			int dayappt = -1;
			try { dayappt = maxinfo.get(field); } catch (Exception me) { dayappt = -1; }

			if (daymax > 0) {
				vo.setDaymax(daymax);
				vo.setDayactive(dayappt);
				if (dayappt >= daymax) {
					vo.setDisabled(true);
					vo.setMessage("Maximum number of daily appointments has been reached");
				}
			}
			if (activemax > 0) {
				if (activeappt >= activemax) {
					vo.setDisabled(true);
					vo.setMessage("Maximum number of active appointments has been reached");
					setMessage("Maximum number of active appointments has been reached");
				}
			}
			if (reviewmax > 0) {
				if (reviewappt >= reviewmax) {
					vo.setDisabled(true);
					vo.setMessage("Maximum number of active review appointments has been reached");
					setMessage("Maximum number of active review appointments has been reached");
				}
			}
			if (childmax > 0) {
				if (childtotal >= childmax) {
					vo.setDisabled(true);
					vo.setMessage("Maximum number of active appointments has been reached for the project");
					setMessage("Maximum number of active appointments has been reached for the project");
				}
			}

//			vo.cutoff(begindate);
			vo.processTimes();
			addDate(vo);
			start.addDay(1);
			s = start.DATECODE();
		}
	}

	public static String makeString(AvailabilityDateVO vo) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			r = mapper.writeValueAsString(vo);
		} catch (Exception e) { }
		return r;
	}

	public static AvailabilityDateVO makeDateObj(String str) {
		AvailabilityDateVO vo = new AvailabilityDateVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo = mapper.readValue(str, AvailabilityDateVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return vo;
	}

	public static AvailabilityDateVO deserialize(AvailabilityDateVO vo) {
		String s = makeString(vo);
		return makeDateObj(s);
	}

	public static String makeString(AvailabilityTimeVO vo) {
		String r = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			r = mapper.writeValueAsString(vo);
		} catch (Exception e) { }
		return r;
	}

	public static AvailabilityTimeVO makeTimeObj(String str) {
		AvailabilityTimeVO vo = new AvailabilityTimeVO();
		try {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			vo = mapper.readValue(str, AvailabilityTimeVO.class);
		}
		catch (Exception e) { Logger.error(e); }
		return vo;
	}

	public static AvailabilityTimeVO deserialize(AvailabilityTimeVO vo) {
		String s = makeString(vo);
		return makeTimeObj(s);
	}

	public static AvailabilityDateVO makeEmptyDate() {
		AvailabilityDateVO vo = new AvailabilityDateVO();

		Timekeeper d = new Timekeeper();
		d.setHour(0);
		d.setMinute(0);

		int datecode = d.DATECODE();
		while (d.DATECODE() == datecode) {
			AvailabilityTimeVO t = new AvailabilityTimeVO();
			t.setId(d.getString("MILITARYTIME"));
			t.setDefaultid(-1);
			t.setStart(d.getString("MILITARYTIME"));
			t.setEnd(d.getString("MILITARYTIME"));
			t.setPreseats(-1);
			vo.addTime(t);
			d.addMinute(30);
		}

		return vo;
	}







}




