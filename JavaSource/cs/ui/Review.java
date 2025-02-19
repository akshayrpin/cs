package cs.ui;

import java.util.LinkedHashMap;
import java.util.Map;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import alain.core.utils.Operator;
import alain.core.utils.Timekeeper;
import cs.utils.ObjTables;
import cs.utils.RequestMapper;
import csshared.vo.AppointmentScheduleVO;
import csshared.vo.AppointmentVO;
import csshared.vo.ComboReviewList;
import csshared.vo.ComboReviewVO;
import csshared.vo.ObjGroupVO;
import csshared.vo.RequestVO;
import csshared.vo.ReviewActionVO;
import csshared.vo.ReviewVO;

public class Review {

	public static String info(RequestVO req, ObjGroupVO g, String style, String alert) {
		ComboReviewList o = g.getComboreview();
		LinkedHashMap<Integer, ComboReviewVO> comboreviews = o.getComboreviews();
//		if (comboreviews.size() < 1) { return ""; }

		StringBuilder sb = new StringBuilder();
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, "", ObjTables.getFormUrl(req, g, "add"), ObjTables.GRAYADDIMGURL, "", "", g.getOptions(), req.getOption(), "", "", g.getContenttype(), ObjTables.BLACKHELPIMGURL));

		if (comboreviews.size() > 0) {
			for (Map.Entry<Integer, ComboReviewVO> entry : comboreviews.entrySet()) {
				ComboReviewVO crv = entry.getValue();
				int comboid = crv.getComboid();
				String approved = "N";
				String unapproved = "N";
				if (crv.isApproved()) {
					approved = "Y";
				}
				else if (crv.isUnapproved()) {
					unapproved = "Y";
				}
				Timekeeper s = new Timekeeper();
				s.setDate(crv.getStart());
				Timekeeper e = new Timekeeper();
				e.setDate(crv.getDue());
				String formurl = ObjTables.getFormUrl(req, g, crv, "");
//				sb.append(ObjTables.title(s.getString("MM/DD/YYYY"), "", style.concat("_header"), "", "", GRAYADDMINIMGURL, "", ""));

				sb.append("<table class=\"").append(style).append("_review_title\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\" type=\"review\">");
				sb.append("<tr>");
				sb.append("<td class=\"").append(style).append("_review_title\">");
				sb.append("<a href=\"").append(formurl).append("\" class=\"").append(style).append("_review_title\">");
				if (Operator.hasValue(crv.getCombotitle())) {
					sb.append(crv.getCombotitle()).append(" - ");
				}
				sb.append(s.getString("MM/DD/YYYY"));
				sb.append("</a>");
				sb.append("</td>");
				if (!crv.isFinal() && g.isUpdate()) {
					sb.append("<td class=\"").append(style).append("_title_control\" width=\"20\" height=\"20\" expedited=\"").append(crv.getExpedited()).append("\">");
					sb.append("<a href=\"").append(formurl).append("\">").append("<img src=\"").append(ObjTables.GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
				}
				else {
					sb.append("<td class=\"").append(style).append("_title_control\" width=\"20\" height=\"20\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\">");
					sb.append("<a href=\"").append(formurl).append("\">").append("<img src=\"").append(Config.emptyImageUrl()).append("\" width=\"20\" height=\"20\" border=\"0\"/></a>");
				}
				sb.append("</td>");
				sb.append("</tr>");
				sb.append("</table>");

				sb.append("<table class=\"").append(style).append("\" expedited=\"").append(crv.getExpedited()).append("\" unapproved=\"").append(unapproved).append("\" approved=\"").append(approved).append("\" type=\"review\">");
				LinkedHashMap<Integer, ReviewVO> reviews = crv.getReviews();
				for (Map.Entry<Integer, ReviewVO> rentry : reviews.entrySet()) {
					ReviewVO rv = rentry.getValue();
					ReviewActionVO rva = rv.getCurrent();
					String currapproved = "N";
					String currunapproved = "N";
					if (rv.isApproved()) {
						currapproved = "Y";
					}
					else if (rv.isUnapproved()) {
						currunapproved = "Y";
					}

				    String expired = " expired=\"false\"";
				    if (rv.daystilldue >= 0) {
				    	if (rv.duedate().past()) {
				    		if (!rva.isApproved() && !rva.isFinal()) {
					    		expired = " expired=\"true\" title=\"Expired\"";
				    		}
				    	}
				    }

				    StringBuilder lsb = new StringBuilder();
					lsb.append(Config.fullcontexturl()).append("/editreview.jsp");
					lsb.append("?").append(RequestMapper.id).append("=").append(comboid);
					lsb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
					lsb.append("&").append(RequestMapper.type).append("=").append(req.getType());
					lsb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
					lsb.append("&").append(RequestMapper.group).append("=review");
					lsb.append("&").append(RequestMapper.groupid).append("=").append(rv.getId());
					lsb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
					lsb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
					lsb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
				    String link = lsb.toString();

				    sb.append("<tr>");

					sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"70%\" unapproved=\"").append(currunapproved).append("\" approved=\"").append(currapproved).append("\"").append(expired).append(" style=\"vertical-align: middle\">");

					sb.append("<a class=\"").append(style).append("\" href=\"");
					sb.append(link);
					sb.append("\" target=\"lightbox-iframe\">");

					sb.append(rv.getReview());
					sb.append("</a>");

					sb.append("</td>");

					sb.append("<td class=\"").append(style).append("_header\" align=\"right\" width=\"30%\" unapproved=\"").append(currunapproved).append("\" approved=\"").append(currapproved).append("\">");
					sb.append("<a class=\"").append(style).append("_header\" href=\"");
					sb.append(link);
					sb.append("\" target=\"lightbox-iframe\">");
					sb.append(rv.getStatus());
					sb.append("</a>");
					sb.append("</td>");

					sb.append("</tr>");
				}
				sb.append("</table>");
				sb.append("<br/>");
			}
		}

		return sb.toString();
	}

	public static String apptReview(RequestVO req, ObjGroupVO g, String style) {
		ComboReviewList o = g.getComboreview();
		StringBuilder sb = new StringBuilder();

		LinkedHashMap<Integer, ComboReviewVO> comboreviews = o.getComboreviews();
		if (comboreviews.size() > 0) {
			sb.append("<table class=\"").append(style).append("\" type=\"review\">");
			sb.append("<tr>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>&nbsp;</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>PROJECT</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>ACTIVITY</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\">REVIEW</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>ADDRESS</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>APPT</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>TEAM</td>");
			sb.append("<td class=\"").append(style).append("_header\" align=\"left\" width=\"1%\" nowrap>STATUS</td>");
			sb.append("</tr>");
			for (Map.Entry<Integer, ComboReviewVO> entry : comboreviews.entrySet()) {
				ComboReviewVO crv = entry.getValue();
				String approved = "N";
				String unapproved = "N";
				if (crv.isApproved()) {
					approved = "Y";
				}
				else if (crv.isUnapproved()) {
					unapproved = "Y";
				}

				Timekeeper s = new Timekeeper();
				s.setDate(crv.getStart());
				Timekeeper e = new Timekeeper();
				e.setDate(crv.getDue());

				LinkedHashMap<Integer, ReviewVO> reviews = crv.getReviews();
				for (Map.Entry<Integer, ReviewVO> rentry : reviews.entrySet()) {
					ReviewVO rv = rentry.getValue();
					LinkedHashMap<Integer, ReviewActionVO> actions = rv.getActions();
					for (Map.Entry<Integer, ReviewActionVO> aentry : actions.entrySet()) {
						ReviewActionVO actv = aentry.getValue();
						AppointmentVO apptv = actv.getAppointment();
						AppointmentScheduleVO schv = apptv.getFirstSchedule();
						String currapproved = "N";
						String currunapproved = "N";
						if (rv.isApproved()) {
							currapproved = "Y";
						}
						else if (rv.isUnapproved()) {
							currunapproved = "Y";
						}
						sb.append("<tr>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						if (!actv.isExpired()) {
							sb.append("<input");
							sb.append(" type=\"checkbox\" ");
							sb.append(" name=\"ID\" ");
							sb.append(" value=\"").append(schv.getId()).append("\" ");
							sb.append(" availabilityid=\"").append(rv.getAvailabilityid()).append("\"");
							sb.append(" reviewid=\"").append(rv.getReviewid()).append("\"");
							sb.append(" />");
						}
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getProject());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getActivity());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\">");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(rv.getReview());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(crv.getAddress());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(schv.asText());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" align=\"left\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(rv.teamMembers(actv.getId()));
						sb.append("</a>");
						sb.append("</td>");



						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>");
						sb.append("<a class=\"").append(style).append("_header\" href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(crv.getComboid());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(crv.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(crv.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(rv.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(rv.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						sb.append(rv.getStatus());
						sb.append("</a>");
						sb.append("</td>");

						sb.append("</tr>");
					}
				}
			}
			sb.append("</table>");
			sb.append("<br/>");
		}

		return sb.toString();
	}

	public static String hzReview(RequestVO req, ComboReviewVO rev, String style, boolean editable) {
	    Timekeeper startdate = new Timekeeper();
	    startdate.setDate(rev.getStart());
		StringBuilder sb = new StringBuilder();
		sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
		sb.append("<tr>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"review\" width=\"1%\" nowrap>&nbsp;</td>\n");
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"review\" width=\"1%\" nowrap>review</td>\n");
	    }
		sb.append("<td class=\"").append(style).append("_header\" label=\"status\" width=\"1%\" nowrap>status</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"comments\">comments</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"appt\" width=\"1%\" nowrap>appointment</td>\n");
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"user\" width=\"1%\" nowrap>team</td>\n");
	    }
	    else {
			sb.append("<td class=\"").append(style).append("_header\" label=\"user\" width=\"1%\" nowrap>user</td>\n");
	    }
	    if (req.getReviewrefid() <= 0) {
			sb.append("<td class=\"").append(style).append("_header\" label=\"due\" width=\"1%\" nowrap>due date</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"date\" width=\"1%\" nowrap>updated date</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" width=\"1%\" nowrap></td>\n");
	    }
	    else {
			sb.append("<td class=\"").append(style).append("_header\" label=\"date\" width=\"1%\" nowrap>updated date</td>\n");
			sb.append("<td class=\"").append(style).append("_header\" label=\"date\" width=\"1%\" nowrap>emails</td>\n");
	    }
		sb.append("</tr>\n");
		LinkedHashMap<Integer, ReviewVO> reviews = rev.getReviews();
		for (Map.Entry<Integer, ReviewVO> entry : reviews.entrySet()) {

			int field = entry.getKey();
		    ReviewVO value = entry.getValue();
		    String due = "";
		    if (Operator.hasValue(value.getDuedate())) {
		    	due = value.duedate().getString("MM/DD/YY");
		    }
		    else if (value.daystilldue < 0) {
		    	due = "--";
		    }

		    if (req.getReviewrefid() > 0) {
		    	// DISPLAY ACTIONS OF REVIEWS
				LinkedHashMap<Integer, ReviewActionVO> actions = value.getActions();
				String stold = "";
				for (Map.Entry<Integer, ReviewActionVO> action : actions.entrySet()) {
					try {
					    Integer afield = action.getKey();
					    ReviewActionVO avalue = action.getValue();
					    Timekeeper d = new Timekeeper();
					    d.setDate(avalue.getDate());

					    String expired = " expired=\"false\"";
					    if (value.daystilldue >= 0) {
					    	if (value.duedate().past()) {
					    		if (!avalue.isApproved() && !avalue.isFinal()) {
						    		expired = " expired=\"true\"";
					    		}
					    	}
					    }

					    AppointmentVO avo = avalue.getAppointment();
						StringBuilder lsb = new StringBuilder();
						lsb.append("<a class=\"").append(style).append("\" href=\"");
						lsb.append(Config.fullcontexturl()).append("/editappointment.jsp");
						lsb.append("?").append(RequestMapper.id).append("=").append(avo.getId());
						lsb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						lsb.append("&").append(RequestMapper.type).append("=").append(req.getType());
						lsb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
						lsb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						lsb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						lsb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						lsb.append("\" target=\"lightbox-iframe\">");
						String ahref= lsb.toString();
						
					    String attachlink = avalue.getAttachment().getIconLink();
					    
					    
						sb.append("<tr id=\"combotr_").append(value.getId()).append("\" class=\"comboreview\">\n");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" width=\"1%\" nowrap>");
						if (Operator.hasValue(attachlink)) {
							sb.append(attachlink);
						}
						else {
							sb.append("&nbsp;");
						}
						sb.append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"status\" width=\"1%\" nowrap>").append(avalue.getStatus()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"largetext\">").append(avalue.getComments()).append("</td>");

						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"appt\" width=\"1%\" nowrap>");
						String appt = avo.getFirstSchedule().asText();
						if (Operator.hasValue(appt)) {
							sb.append("<table cellpadding=\"1\" cellspacing=\"0\" border=\"0\">");
							sb.append("<tr>");
							sb.append("<td class=\"").append(style).append(stold).append("\" nowrap>");
							sb.append(ahref);
							sb.append(appt);
							sb.append("</a>");
							sb.append("</td>");
							sb.append("<td>");
							sb.append(ahref);
							sb.append("<img src=\"").append(ObjTables.GRAYCALENDARIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
							sb.append("</a>");
							sb.append("</td>");
							sb.append("</tr>");
							sb.append("</table>");
						}
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"user\" width=\"1%\" nowrap>").append(avalue.getCreatedby()).append("</td>");
						sb.append("<td class=\"").append(style).append(stold).append("\" type=\"text\" itype=\"date\" width=\"1%\" nowrap>").append(d.getString("MM/DD/YY")).append("</td>");
						int n = avalue.getNotifications();
						if (n > 0) {
							sb.append("<td class=\"").append(style).append(stold).append(" showemail\" rel=\"").append(avalue.getId()).append("\" type=\"text\" itype=\"date\" width=\"1%\" align=\"right\" style=\"cursor: pointer\" nowrap>");
							sb.append(avalue.getNotifications()).append(" &darr;");
							sb.append("</td>");
						}
						else {
							sb.append("<td class=\"").append(style).append(stold).append("\" rel=\"").append(avalue.getId()).append("\" type=\"text\" itype=\"date\" width=\"1%\" align=\"right\" nowrap>");
							sb.append(0);
							sb.append("</td>");
						}

						sb.append("</tr>\n");
						sb.append("<tr id=\"notifications_").append(avalue.getId()).append("_row\" style=\"display: none\">\n");
						sb.append("<td id=\"notifications_").append(avalue.getId()).append("_cell\" class=\"csui\" colspan=\"7\" style=\"padding: 0px\">&nbsp;</td>\n");
						sb.append("</tr>\n");
						stold = " "+style+"_disabled";

//						sb.append("<tr id=\"info_").append(avalue.getId()).append("\" style=\"display: none\">");
//						sb.append("<td colspan=\"7\">");
//
//						sb.append("<table cellpadding=\"5\" cellspacing=\"1\" width=\"100%\">");
//						sb.append("<tr>");
//						sb.append("<td class=\"").append(style).append("_header\" label=\"createdby\" width=\"1%\" nowrap>CREATED BY</td>");
//						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(avalue.getCreatedby()).append("</td>");
//						sb.append("<td class=\"").append(style).append("_header\" label=\"createddate\" width=\"1%\" nowrap>CREATED DATE</td>");
//						sb.append("<td class=\"").append(style).append("\" width=\"1%\" nowrap>").append(d.getString("YYYY/MM/DD @ HH:MM")).append("</td>");
//						sb.append("</tr>");
//						sb.append("</table>");
//
//						sb.append("</td>");
//						sb.append("</tr>");
					}
					catch (Exception e) {
			    		Logger.error(e);
					}
				}
		    }
		    else {
		    	// DISPLAY REVIEWS OF COMBOS
		    	try {
		    		String team = value.teamMembers();
		    		LinkedHashMap<Integer, ReviewActionVO> actions = value.getActions();
		    		if (actions.size() > 0) {
					    Map.Entry<Integer, ReviewActionVO> action = actions.entrySet().iterator().next();
					    ReviewActionVO avalue = action.getValue();
					    String attachlink = avalue.getAttachment().getIconLink();
					    Timekeeper d = new Timekeeper();
					    d.setDate(avalue.getDate());

					    String expired = " expired=\"false\"";
					    if (value.daystilldue >= 0) {
					    	if (value.duedate().past()) {
					    		if (!avalue.isApproved() && !avalue.isFinal()) {
						    		expired = " expired=\"true\"";
					    		}
					    	}
					    }

					    sb.append("<tr id=\"combotr_").append(value.getId()).append("\" class=\"comboreview\">\n");

						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" width=\"1%\" nowrap>");
						if (Operator.hasValue(attachlink)) {
							sb.append(attachlink);
						}
						else {
							sb.append("&nbsp;");
						}
						sb.append("</td>");

						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"type\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(value.getReview()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"status\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getStatus()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"largetext\" actionid=\"").append(avalue.getId()).append("\">").append(avalue.getComments()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"appt\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(avalue.getAppointment().getFirstSchedule().asText()).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"user\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(team).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"due\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap").append(expired).append(">").append(due).append("</td>");
						sb.append("<td class=\"").append(style).append("\" type=\"text\" itype=\"due\" actionid=\"").append(avalue.getId()).append("\" width=\"1%\" nowrap>").append(d.getString("MM/DD/YY")).append("</td>");

						sb.append("<td class=\"").append(style).append(" ").append(style).append("_header\" width=\"1%\" nowrap>");
						sb.append("<a href=\"");
						sb.append(Config.fullcontexturl()).append("/editreview.jsp");
						sb.append("?").append(RequestMapper.id).append("=").append(req.getId());
						sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
						sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
						sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
						sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
						sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
						sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
						sb.append("&").append(RequestMapper.reviewid).append("=").append(value.getReviewid());
						sb.append("&").append(RequestMapper.reviewrefid).append("=").append(value.getId());
						sb.append("\" target=\"lightbox-iframe\">");
						if (value.isFinal() || value.isApproved() || value.isUnapproved()) {
							sb.append("<img src=\"").append(ObjTables.GRAYVIEWIMGURL).append("\"/>");
						}
						else {
							sb.append("<img src=\"").append(ObjTables.GRAYEDITIMGURL).append("\"/>");
						}
						sb.append("</a>");
						sb.append("</td>");
						sb.append("</tr>");

		    		}
		    	}
		    	catch (Exception e) {
		    		Logger.error(e);
		    	}
		    }

		}
		sb.append("</table>\n");
		return sb.toString();
	}






}
