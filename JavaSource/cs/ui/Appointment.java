package cs.ui;

import alain.core.utils.Config;
import alain.core.utils.Logger;
import cs.utils.ObjTables;
import cs.utils.RequestMapper;
import csshared.vo.AppointmentScheduleVO;
import csshared.vo.AppointmentVO;
import csshared.vo.ObjGroupVO;
import csshared.vo.RequestVO;

public class Appointment {

	public static String summary(RequestVO req, ObjGroupVO g, String style, String alert) {
		AppointmentVO[] a = g.getAppointments();

		StringBuilder sb = new StringBuilder();
		int l = a.length;
		sb.append(ObjTables.title(g.getLabel(), ObjTables.getDetailUrl(req, g), style, alert, ObjTables.getFormUrl(req, g, "add"), "", g.getOptions(), req.getOption(), "", g.getContenttype()));
		sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
		sb.append("<tr>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"TYPE\">TYPE</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"SUBJECT\">SUBJECT</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"DATE\">DATE</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" label=\"STATUS\">STATUS</td>\n");
		sb.append("<td class=\"").append(style).append("_header\" width=\"1%\">&nbsp;</td>\n");

		for (int i=0; i < l; i++) {
			AppointmentVO vo = a[i];
			AppointmentScheduleVO avo = vo.getFirstSchedule();
			StringBuilder lsb = new StringBuilder();
			lsb.append("<a class=\"").append(style).append("\" href=\"");
			lsb.append(Config.fullcontexturl()).append("/editappointment.jsp");
			lsb.append("?").append(RequestMapper.id).append("=").append(vo.getId());
			lsb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
			lsb.append("&").append(RequestMapper.type).append("=").append(req.getType());
			lsb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
			lsb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
			lsb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
			lsb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
			lsb.append("\" target=\"lightbox-iframe\">");
			String ahref= lsb.toString();

			sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(vo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(vo.getId()).append("\">\n");
			sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" label=\"TYPE\">").append(ahref).append(vo.getAppttype()).append("</a></td>");
			sb.append("<td class=\"").append(style).append("\" type=\"String\" itype=\"text\" label=\"SUBJECT\">").append(ahref).append(vo.getSubject()).append("</a></td>");
			sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"DATE\">").append(ahref).append(avo.asText()).append("</a></td>");
			sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"STATUS\">").append(ahref).append(avo.getStatus()).append("</a></td>");

			sb.append("<td class=\"").append(style).append("_rowcontrols\" nowrap>");
//			sb.append("<a class=\"").append(style).append("\" href=\"");
//			sb.append(Config.fullcontexturl()).append("/collaborators.jsp");
//			sb.append("?").append(RequestMapper.id).append("=").append(avo.getId());
//			sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
//			sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
//			sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
//			sb.append("&").append(RequestMapper.group).append("=appointment");
//			sb.append("&").append(RequestMapper.groupid).append("=").append(vo.getId());
//			sb.append("&").append(RequestMapper.grouptype).append("=users");
//			sb.append("&").append(RequestMapper.reviewid).append("=").append(vo.getReviewid());
//			sb.append("&").append(RequestMapper.reviewrefid).append("=").append(vo.getRefreviewid());
//			sb.append("\" title=\"View or Add Collaborators\">");
//			sb.append("<img src=\"").append(ObjTables.GRAYUSERIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
//			sb.append("</a>");
//			sb.append("&nbsp;");
//
//			sb.append("<a class=\"").append(style).append("\" href=\"");
//			sb.append(Config.fullcontexturl()).append("/team.jsp");
//			sb.append("?").append(RequestMapper.id).append("=").append(avo.getId());
//			sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
//			sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
//			sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
//			sb.append("&").append(RequestMapper.group).append("=appointment");
//			sb.append("&").append(RequestMapper.groupid).append("=").append(vo.getId());
//			sb.append("&").append(RequestMapper.grouptype).append("=team");
//			sb.append("&").append(RequestMapper.reviewid).append("=").append(vo.getReviewid());
//			sb.append("&").append(RequestMapper.reviewrefid).append("=").append(vo.getRefreviewid());
//			sb.append("\" title=\"View or Add Team Members\">");
//			sb.append("<img src=\"").append(ObjTables.GRAYTEAMIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\"/>");
//			sb.append("</a>");
//			sb.append("&nbsp;");

			if (vo.getComboreviewid() > 0) {

				sb.append("<a class=\"").append(style).append("\" href=\"");
				sb.append(Config.fullcontexturl()).append("/editreview.jsp");
				sb.append("?").append(RequestMapper.id).append("=").append(vo.getId());
				sb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
				sb.append("&").append(RequestMapper.type).append("=").append(req.getType());
				sb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
				sb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
				sb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
				sb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
				sb.append("&").append(RequestMapper.reviewid).append("=").append(vo.getReviewid());
				sb.append("&").append(RequestMapper.reviewrefid).append("=").append(vo.getRefreviewid());
				sb.append("\" target=\"lightbox-iframe\">");
				if (avo.isScheduled()) {
					sb.append("<img src=\"").append(ObjTables.GRAYEDITIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" title=\"Edit Review\"/>");
				}
				else {
					sb.append("<img src=\"").append(ObjTables.GRAYVIEWIMGURL).append("\" width=\"20\" height=\"20\" border=\"0\" title=\"View Review\"/>");
				}
				sb.append("</a>");
			}
			else if (avo.isScheduled()) {
					sb.append("<img src=\"").append(ObjTables.GRAYDELETEIMGURL).append("\" title=\"Cancel Appointment\" width=\"20\" height=\"20\" border=\"0\" _grp=\"").append(g.getGroup()).append("\" _action=\"delete\" _grpid=\"").append(g.getGroupid()).append("\" _id=\"").append(vo.getId()).append("\"/>");
			}
			else {
				sb.append("&nbsp;");
			}
			sb.append("</td>");

			sb.append("</tr>\n");
		}
		sb.append("</table>\n");
		return sb.toString(); 
	}

	public static String id(RequestVO req, ObjGroupVO g, String style, String alert) {
		return Vertical.id(req, g, style, alert);
//		AppointmentVO[] a = g.getAppointments();
//		
//		StringBuilder sb = new StringBuilder();
//		int l = a.length;
//
//		sb.append("<table class=\"").append(style).append("\" type=\"horizontal\">\n");
//		sb.append("<tr>\n");
//		sb.append("<td class=\"").append(style).append("_header\" label=\"TYPE\">TYPE</td>\n");
//		sb.append("<td class=\"").append(style).append("_header\" label=\"SUBJECT\">SUBJECT</td>\n");
//		sb.append("<td class=\"").append(style).append("_header\" label=\"DATE\">DATE</td>\n");
//		sb.append("<td class=\"").append(style).append("_header\" label=\"STATUS\">STATUS</td>\n");
//
//		for (int i=0; i < l; i++) {
//			AppointmentVO vo = a[i];
//			AppointmentScheduleVO avo = vo.getFirstSchedule();
//			StringBuilder lsb = new StringBuilder();
//			lsb.append("<a class=\"").append(style).append("\" href=\"");
//			lsb.append(Config.fullcontexturl()).append("/viewappointment.jsp");
//			lsb.append("?").append(RequestMapper.id).append("=").append(vo.getId());
//			lsb.append("&").append(RequestMapper.entity).append("=").append(req.getEntity());
//			lsb.append("&").append(RequestMapper.type).append("=").append(req.getType());
//			lsb.append("&").append(RequestMapper.typeid).append("=").append(req.getTypeid());
//			lsb.append("&").append(RequestMapper.group).append("=").append(req.getGroup());
//			lsb.append("&").append(RequestMapper.groupid).append("=").append(req.getGroupid());
//			lsb.append("&").append(RequestMapper.grouptype).append("=").append(req.getGrouptype());
//			lsb.append("\" target=\"lightbox-iframe\">");
//			String ahref= lsb.toString();
//
//			sb.append("<tr class=\"").append(style).append("\" group=\"").append(g.getGroup()).append("\" groupid=\"").append(g.getGroupid()).append("\" recordid=\"").append(vo.getId()).append("\" id=\"tr_").append(g.getGroup()).append("_").append(g.getGroupid()).append("_").append(vo.getId()).append("\">\n");
//			sb.append("<td class=\"").append(style).append("\" type=\"type\" itype=\"type\" label=\"TYPE\">").append(ahref).append(vo.getAppttype()).append("</a></td>");
//			sb.append("<td class=\"").append(style).append("\" type=\"String\" itype=\"text\" label=\"SUBJECT\">").append(ahref).append(vo.getSubject()).append("</a></td>");
//			sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"DATE\">").append(ahref).append(avo.asText()).append("</a></td>");
//			sb.append("<td class=\"").append(style).append("\" type=\"datetime\" itype=\"datetime\" label=\"STATUS\">").append(ahref).append(avo.getStatus()).append("</a></td>");
//
//			sb.append("</tr>\n");
//		}
//		sb.append("</table>\n");
//		return sb.toString(); 
	}





}
