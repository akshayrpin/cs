<!-- @author: sunil vijayakumar sunvoyage -->

<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="java.util.HashSet"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="alain.core.db.Sage"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

Cartographer map = new Cartographer(request,response);
String title = "";
JSONArray cat = new JSONArray();

JSONArray sg = new JSONArray();

String date = "";
 

if(map.getInt("ACT_ID")>0){
	int actId = map.getInt("ACT_ID");
	
	try{
	Sage db = new Sage();
	
	String command = "SELECT A.ACT_NBR,LAT.DESCRIPTION AS TYPE,LAS.DESCRIPTION AS STATUS,CONVERT(date, START_DATE) as START_DATE, ISSUED_DATE FROM ACTIVITY A JOIN LKUP_ACT_TYPE LAT ON A.LKUP_ACT_TYPE_ID=LAT.ID JOIN LKUP_ACT_STATUS LAS ON A.LKUP_ACT_STATUS_ID=LAS.ID WHERE A.ID = "+actId;
	db.query(command);
	
	if(db.next()){
		title = db.getString("ACT_NBR") +" - "+  db.getString("TYPE")  +" - "+ db.getString("STATUS") +"  START: "+  db.getString("START_DATE")  +" ISSUED: "+  db.getString("ISSUED_DATE"); 
	}
	
	StringBuilder sb  = new StringBuilder();
	sb.append(" select DISTINCT CR.ID,GROUP_NAME,TITLE, CONVERT(date, START_DATE) as START_DATE  from REF_ACT_COMBOREVIEW RACR ");
	sb.append(" left outer join COMBOREVIEW CR on RACR.COMBOREVIEW_ID=CR.ID ");
	sb.append(" left outer join REVIEW_GROUP RG on CR.REVIEW_GROUP_ID=RG.ID ");
	sb.append(" where ACTIVITY_ID =  ").append(actId);
	
	command = sb.toString();
	db.query(command);
	HashSet s = new HashSet();
	
	while(db.next()){
		
		if(!s.contains(db.getString("GROUP_NAME"))){
			s.add(db.getString("GROUP_NAME"));
			
			JSONObject ct = new JSONObject();
			ct.put("category", db.getString("GROUP_NAME"));
			ct.put("category_start", db.getString("START_DATE"));
		
			cat.put(ct);
		}
		JSONObject sgr = new JSONObject();
		sgr.put("COMBOREVIEW_ID", db.getInt("ID"));
		sgr.put("GROUP_NAME", db.getString("GROUP_NAME"));
			
			sg.put(sgr);
		
	}
	
	
	for(int k=0;k<cat.length();k++){
		JSONArray segments = new JSONArray();
		sb  = new StringBuilder();
		for(int i=0;i<sg.length();i++){
			if(cat.getJSONObject(k).getString("category").startsWith(sg.getJSONObject(i).getString("GROUP_NAME"))){
				if(i==0){
					date = cat.getJSONObject(k).getString("category_start");
				}
				sb.append(sg.getJSONObject(i).getInt("COMBOREVIEW_ID")).append(",");
				
			}
		}
			sb.append(0);
			String comboids =sb.toString(); 
		
			sb  = new StringBuilder();
			sb.append(" select R.NAME,CONVERT(date, RCA.DATE) as DATE ,LRS.STATUS from  REF_COMBOREVIEW_REVIEW RCR  ");
			sb.append(" left outer join REF_COMBOREVIEW_ACTION RCA on RCR.ID= RCA.REF_COMBOREVIEW_REVIEW_ID ");
			sb.append(" left outer join REVIEW R on RCR.REVIEW_ID=R.ID ");
			sb.append(" left outer join LKUP_REVIEW_STATUS LRS on RCA.LKUP_REVIEW_STATUS_ID=LRS.ID ");
			sb.append(" where LKUP_REVIEW_STATUS_ID!=127 AND RCR.COMBOREVIEW_ID IN  ( ").append(comboids).append(" ) ORDER BY RCA.DATE ");
			command = sb.toString();
			db.query(command);
			int l = 0;
			while(db.next()){
				
				JSONObject seg = new JSONObject();
				
				seg.put("start", date);
				seg.put("end",  db.getString("DATE"));
				date = db.getString("DATE");
				if(l%2==0){
					seg.put("color", "#6d9118");
				}else {
					seg.put("color",  "#1e4a51");
				}
				l++;
				seg.put("task", db.getString("STATUS"));
				segments.put(seg);
			}
	
		
		cat.getJSONObject(k).put("segments",segments);
		
	}
	

	
  db.clear();
}catch(Exception e){
	Logger.error(e.getMessage());
}

	
}
%>


<!DOCTYPE html>
<html>
<head>
<!-- Styles -->
<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
</style>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/gantt.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

<!-- Chart code -->
<script>
var chart = AmCharts.makeChart( "chartdiv", {
  "type": "gantt",
  "theme": "light",
  "marginRight": 70,
  "period": "DD",
  "dataDateFormat": "YYYY-MM-DD",
  "columnWidth": 0.5,
  "valueAxis": {
    "type": "date"
  },
  "titles": [{"text": "Review Cycle for <%=title %>","size": 15}],
  "brightnessStep": 7,
  "graph": {
    "fillAlphas": 1,
    "lineAlpha": 1,
    "lineColor": "#fff",
    "fillAlphas": 0.85,
    "balloonText": "<b>[[task]]</b>:<br />[[open]] -- [[value]]"
  },
  "rotate": true,
  "categoryField": "category",
  "segmentsField": "segments",
  "colorField": "color",
  "startDateField": "start",
  "endDateField": "end",
  "dataProvider": <%=cat.toString()%>,
  "valueScrollbar": {
    "autoGridCount": true
  },
  "chartCursor": {
    "cursorColor": "#55bb76",
    "valueBalloonsEnabled": false,
    "cursorAlpha": 0,
    "valueLineAlpha": 0.5,
    "valueLineBalloonEnabled": true,
    "valueLineEnabled": true,
    "zoomable": false,
    "valueZoomable": true
  },
  "export": {
    "enabled": true
  }
} );
</script>
</head>
<!-- HTML -->


<body >
<div id="chartdiv"></div>


</body>

</html>