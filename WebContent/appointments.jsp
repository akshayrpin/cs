<!-- @author: sunil vijayakumar sunvoyage -->
<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.address.AddressTest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%@include file="search/gsappointment.jsp"%>
<% 
Cartographer map = new Cartographer(request,response,true);
boolean logon = true;
if(!Operator.hasValue(map.token())){
	map.logout();
	logon = false;
	map.redirect("index.jsp");
}
String solrurl = CsConfig.getString("search.inspection");
String entity = map.getString(RequestMapper.entity);
String type = map.getString(RequestMapper.type);

String q = map.getString("sq","*");
String query = q;
q = Operator.toText(q);
//System.out.println(q);
%>


<!DOCTYPE html>
<html>
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	 <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<%= CsUiTools.getHTMLImports() %>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.search.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/simplepagination/simplePagination.css">
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	
	
    <script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/simplepagination/jquery.simplePagination.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.apptlist.js"></script>
	
	
	
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
	
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/funnel.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
	
<!-- 	<script type="text/javascript" src="/search/search.js"></script> -->
<style>
 .rowhighlight { background-color: yellow; }

</style>
	<script>
	
	var chartpie1 = AmCharts.makeChart( "chartdivpie1", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Activity Types","size": 15}],
		  "legend":{
			   	"position":"right",
			    "marginRight":100,
			    "autoMargins":false
			  },
			  "innerRadius": "30%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	var chartpie2 = AmCharts.makeChart( "chartdivpie2", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Review Status","size": 15}],
		  "legend":{
			   	"position":"right",
			    "marginRight":100,
			    "autoMargins":false
			  },
			  "innerRadius": "30%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	
	var chartpie3 = AmCharts.makeChart( "chartdivpie3", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Work Load","size": 15}],
		  "legend":{
			   	"position":"right",
			    "marginRight":100,
			    "autoMargins":false
			  },
			  "innerRadius": "30%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	
	var chartpie4 = AmCharts.makeChart( "chartdivpie4", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Review","size": 15}],
		  "legend":{
			   	"position":"right",
			    "marginRight":100,
			    "autoMargins":false
			  },
			  "innerRadius": "30%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	
	var chartpie5 = AmCharts.makeChart( "chartdivpie5", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Appointments Due","size": 15}],
		  "legend":{
			   	"position":"right",
			    "marginRight":100,
			    "autoMargins":false
			  },
			  "innerRadius": "30%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	/* var chart2 = AmCharts.makeChart( "chartdiv2", {
		  "type": "funnel",
		  "theme": "light",
		  "balloon": {
		    "fixedPosition": true
		  },
		  "valueField": "value",
		  "titleField": "title",
		  "marginRight": 240,
		  "marginLeft": 50,
		  "startX": -500,
		  "depth3D": 100,
		  "angle": 40,
		  "outlineAlpha": 1,
		  "outlineColor": "#FFFFFF",
		  "outlineThickness": 2,
		  "labelPosition": "right",
		  "balloonText": "[[title]]: [[value]]n[[description]]",
		  "export": {
		    "enabled": true
		  }
		} ); */
	
	function showchart(output){
		var f = output['facets'];
	 	var ctype =[];
	 	var cstatus =[];
	 	var cdivisions =[];
	 	var conline =[];
 		var c = '';
 		var ft ="";
 		
 		var tt = '[';
 		$.each(f, function(k,v) {
 			if(k!="count"){
 				var	ft =  f[k];
 				var g =0;
 				$.each(ft['buckets'], function(i,j) {
 					g = g+1;
 					if(g<15){
 					
 						var d ='{ "title":"'+j.val+'","value":'+j.count+' }';
 						
 					
					if(k=="activitytype"){
						ctype.push(d);	
 					}
					if(k=="review_status"){
						cstatus.push(d);	
 					}
					
					if(k=="inspector"){
						cdivisions.push(d);	
 					}
					
					if(k=="review"){
						conline.push(d);	
 					}
					
 					}
 				});
 			}
 		});
 		//alert(data);
 		
 		
 		var g = ctype+"";
 		g = g.replace(/"{"/g, "{");
 		g = g.replace(/}"/g, "}");
 		g = "["+g+"]";
 	
 		
 	
 		
 		chartpie1.dataProvider = JSON.parse(g);
 		chartpie1.validateData();
 		
 		
 		
 		//chart2.dataProvider = JSON.parse(g);
 		//chart2.validateData();
 		
 		g = cstatus+"";
 		g = g.replace(/"{"/g, "{");
 		g = g.replace(/}"/g, "}");
 		g = "["+g+"]";
 		
 		
 		
 		chartpie2.dataProvider = JSON.parse(g);
 		chartpie2.validateData();
 		
 		
 		g = cdivisions+"";
 		g = g.replace(/"{"/g, "{");
 		g = g.replace(/}"/g, "}");
 		g = "["+g+"]";
 		
 		
 		
 		chartpie3.dataProvider = JSON.parse(g);
 		chartpie3.validateData();
 		
 		

 		g = conline+"";
 		g = g.replace(/"{"/g, "{");
 		g = g.replace(/}"/g, "}");
 		g = "["+g+"]";
 		
 		chartpie4.dataProvider = JSON.parse(g);
 		chartpie4.validateData();
 		
 		
 		
	}
	
	
	function showoverdue(currentdue,overdue,futuredue){
		
		
	 	var coverdue =[];
	 	
 		var c = '';
 		var ft ="";
 		
 		var tt = '[';
 		
 		var d ='{ "title":"Current Due","value":'+currentdue+' }';
 		coverdue.push(d);
 		
 		d ='{ "title":"Over Due","value":'+overdue+' }';
 		coverdue.push(d);
 		
 		d ='{ "title":"Future Scheduled","value":'+futuredue+' }';
 		coverdue.push(d);
 		
 		//alert(data);
 		
 		
 		var g = "";
 		
 		
 		g = coverdue+"";
 		g = g.replace(/"{"/g, "{");
 		g = g.replace(/}"/g, "}");
 		g = "["+g+"]";
 		
 		chartpie5.dataProvider = JSON.parse(g);
 		chartpie5.validateData();
 		
 		

 		
 		
 		
	}
	
	</script>

	<script language="JavaScript">
	var q = "<%=query%>";
	var facets = "<%=facets%>";
	
	var facetvalues = new Array();
	var dt = "";
	var pr = "";
	var showm = new Array();
	//alert(facets);
	var fullcontexturl = '<%=Config.fullcontexturl()%>';
		var cbtoggle = true;
		
	
	
	$(document).ready(function() {
		
		$('#loader').hide();
		 $(".chosen").chosen({width: "95%"}); 
		$('input[itype=date]').datetimepicker({
			timepicker:false,
			format:'Y-m-d'
		});
		
		
		var m = $('#routeordr');
		m.removeClass('enabled');
		m.addClass('disabled');
		
		$('#facetvalues').val(facetvalues);
		if(q!=''){
			doSearch(facets,"","");
			
		}
		
		$('input[itype="date"]').blur(function(){
			if($(this).val!=""){
				$('#startresult').val(0);
				$('.selector').pagination('drawPage', 1);
				 
				faceting();
			}
		});
		
		
		$('input[itype="currency"]').blur(function(){
			if($(this).val!=""){
				$('#startresult').val(0);
				$('.selector').pagination('drawPage', 1);
				 
				faceting();
			}
		});
		
		$('input[itype="date"]').keypress(function(e) {
		    if(e.which == 13) {
		    	if($(this).val!=""){
			    	$('#startresult').val(0);
					$('.selector').pagination('drawPage', 1);
					 
					faceting();
		    	}
		    }
		});
		
		$('input[itype="currency"]').keypress(function(e) {
		    if(e.which == 13) {
		    	if($(this).val!=""){
			    	$('#startresult').val(0);
					$('.selector').pagination('drawPage', 1);
					 
					faceting();
		    	}
		    }
		});
	
		 $('.mapadd').hide();
		 $('.maproute').hide();
		 $("#gis").click(function(){
			    
				
	   		$(".mapadd").toggle();
	    	google.maps.event.trigger(map, 'resize');
					
				
		 });
		 
		 
		 $('#display_type').change(function(){
				
			 var v = $(this).val();
		
				window.location = v;	
				
			});
		 
		  $("#tablechart").hide();
		 $("#charts").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").hide();
			  $("#tablechart").show();
			  $('.selector').hide();
			 
		 });
		 
		 $("#viewrow").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").show();
			  $("#tablechart").hide();
			  $('.selector').show();
			  $("#view").val("viewrow");
			  doSearch(facets,$('#sffq').val(), $('#sfq').val());
		 });
		 
		
		 
		 $("#def").click(function(){
			  $("#tablesort").show();
			  $("#tablerow").hide();
			  $("#tablechart").hide();
			  $('.selector').show();
			  $("#view").val("def");
			  $("#view").val("def");
			  doSearch(facets,$('#sffq').val(), $('#sfq').val());
		 });
		 
		
		
		 
		 $(".sort").click(function(){
			var sort = $(this).attr("sort");
			var sorttype = $(this).attr("sorttype");
			var htm = $(this).html();
			//console.log(htm);
			if(sorttype=="asc"){
				$(this).attr("sorttype","desc");
				//var img = htm + '<img src="/cs/images/arrow-down-black.png" border="0" />';
				//$(this).remove();
				//$(this).html(img);
			}else {
				//var img =  htm +  '<img src="/cs/images/arrow-up-black.png" border="0" />';
				$(this).attr("sorttype","asc");
				//$(this).remove();
				//$(this).html(img);
			}
			$('#_sort').val(sort+"%20"+sorttype);
			 doSearch(facets,$('#sffq').val(), $('#sfq').val());
			 //console.log($(this).attr("sort"));
		 });
		 
		 
		 $('.selector').pagination({
		        itemsOnPage: $('#endresult').val(),
		        cssStyle: 'light-theme',
		        onPageClick : function(pageNumber) {
		            //alert(pageNumber);
		            //if(pageNumber>1){
		            var r = (pageNumber - 1) * $('#endresult').val();
				    $('#startresult').val(r);
				   // console.log($('#sfq').val());
				   // console.log($('#sffq').val());
				 
				   	 doSearch(facets,$('#sffq').val(), $('#sfq').val());
		           // }
		        }
		     
		   });	
		
		 $(".rw").hover(function() {
			 alert("hi");
			 $(this).css("background-color", "yellow");
		 }, function(){
			  $(this).css("background-color", "pink");
			});
		 
		  $(".childshow").click(function (e) {
		        e.stopPropagation();
		        jQuery(this).children('.childshow').toggle();
		    });
		  
		  $('#subsearch').on('keypress',function(e) {
			    if(e.which == 13) {
			       var v = $('#subsearch').val();
			       if(v!=''){
			    	   q = v;
			    	   faceting();
			       }else{
			    	   q = "*";
			    	   faceting();
			       }
			       
			    }
			});
		  
		  //inspections
		  $("a.csui").fancybox({
				width				: '75%',
				height				: '75%',
				autoScale			: false,
				transitionIn		: 'none',
				transitionOut		: 'none',
				type				: 'iframe'
			});
			$('#reassign').apptreassign();
			$('#reschedule').apptreschedule();
			$('input[type=checkbox][availabilityid]').apptavailability();
	
			 $("#route").click(function(){
				
				 var v = $('input:checkbox.inspresults:checked').map(function() {    return $(this).attr('projectid'); }).get();
					if(v==""){
						swal("Select projects in order to proceed");
						return false;
					}
					
				
					if(v.length>20){
						swal("Only 20 locations could be selected for routing ");
						return false;
					}
					
				 
			   		$(".maproute").toggle();
			   		initialize();	
						
			 });
			 
			 $("#statistics").click(function(){
					
				 $(' <a title="View Stats" id="viewstatistics"  href="<%=Config.fullcontexturl() %>/appointmentstatistics.jsp?_ent=lso&_entid=-1&_type=inspections&_typeid=-1&_grp=inspections&_grptype=inspections&_act=statistics" >Friendly description</a>').fancybox({
			       		'width'				: '75%',
							'height'			: '75%',
							'autoScale'			: false,
							'transitionIn'		: 'none',
							'transitionOut'		: 'none',
							'type'				: 'iframe'
						
			          }).click();
						
			 });
			 
			 
			 
			 /*  $(window).load(function() { 
			    loaddefaults();
			  });  */
			  
			 $("#selectorall").click(function(){
					$('input:checkbox.inspresults').not(this).prop('checked', this.checked);
//					$('input:checkbox.inspresults');
					var avid = -1;
					$.each($("input:checkbox.inspresults:checked"), function(){   
						avid = $(this).attr('availabilityid');
						return false;
		            });
					if (avid > 0) {
						toggleButtons(avid);
					}
			 });
			  
		
		 
	});
	
	function selectAll() {
		var cb = $('td[label=SELECT] input[type=checkbox]');
		cb.prop('checked', cbtoggle);
		if (cbtoggle) {
			cbtoggle = false;
		}
		else {
			cbtoggle = true;
		}
	}
	
	 function openexport(){
		 //alert($('#_sort').val());
		 var url = "actionsearch.jsp?method=csv&q=";
	 	 url += q;	 url += "&wt=csv"; url += "&defType=edismax"; url += "&mm=100"; 
	 	 url += "&_facet="+facets; 
	 	 url += "&start=0"; url += "&rows=800000"; 
	 	 url += "&_fq="+$('#sffq').val();
	 	 url += "&fl=project_nbr,act_nbr,activitytype,review,status,address,inspector,latitude,longitude,start_date,appt_start_date,appt_end_date";
	 	 url += "&_filters="+$('#sfq').val();  
	 	 url += "&_dt="+dt; 
	 	 url += "&_price="+pr; 
	 	 url += "&_sort="+$('#_sort').val();  
	 	 url += "&_view="+$('#view').val();
	 	 url += "&_url="+"<%=solrurl%>"; 
	 	 var n = url;
	 	 window.open(n,"_blank");
		 	
		 } 
	function show_more(t){
		// alert(t);
		//$("#"+t).show();
		$(".extra_facet_"+t).toggle();
	}
	
	function loaddefaults(){
		if($('#ldef').val()=="N"){
			$('#ldef').val("Y");
			var utc = new Date().toJSON().slice(0,10).replace(/-/g,'-');
			console.log(utc);
			// $('#appt_start_date_st').val("*");
			 $('#appt_start_date_ed').val(utc);
			 
			 $('#startresult').val(0);
			 //$('.selector').pagination('drawPage', 1);
			 
			 $('#complete_No').attr("checked",true);
				 
			faceting();
		}
	}
	
	
	function doSearch(facets,fq,filters){
		
		var st = $('#startresult').val();
		var rows = $('#endresult').val();
		
		
		
		if($('#facetdates').val()=="Y"){
			dt = dodates();
			pr = doprice();
		}
		
		
		
		
		var _sort = $('#_sort').val();
		var view = $('#view').val();
		
		$.ajax({
			  type: "GET",
			
			  url: "actionsearch.jsp",
			  dataType: 'json',		  
			  data: { 
				 q : q,
				 start: st,
				 rows: rows,
				 indent : "on",
				 wt : "json",
				// qf:"act_nbr",
				 defType : "edismax",
				 mm : 100,
				 _facet : facets,
				 _fq:fq,
				 _filters:filters,
				 _dt:dt,
				 _price:pr,
				 _sort:_sort,
				 _view:view,
				 _url:"<%=solrurl%>"
			     // valuation : valuation,
			      //mode : mode
			    },
			    beforeSend: function() {
			        $('#loader').show();
			     },
			     complete: function(){
			    	 $('#loader').hide();
			        $(".childshow").click(function (e) {
				        e.stopPropagation();
				        var idk = $(this).attr("id");
				        $('#h_'+idk).toggle();
				       // $(".extra_facet_"+idk).toggle();
				       // jQuery(this).children('.childshow').toggle();
				    });
			        
			        loaddefaults();
			        
			        $(".shls").click(function() {
						var idk= $(this).attr('rel');
						
						
						$(".extra_facet_"+idk).toggle();
			        	var t = $(this).html();
			        	
			        	
						if(t=="Show More +"){
							$(this).html("Show Less -");
						
						
						}else {
							$(this).html("Show More +");
							
						
						}
						showopen(idk,t);
					});
			       
			        
			        $(".shlsc").click(function() {
						var idk= $(this).attr('rel');
					
						$('input:checkbox.'+idk).prop('checked', false);
						faceting();
					});
			        
			        $(".shlsa").click(function() {
						var idk= $(this).attr('rel');
						$('input:checkbox.'+idk).prop('checked', true);		
						faceting();
					});
			        

			        $("#resultsadd tr").hover(function() {
						
			        	$(this).find('td').each(function(column, td) {
			        		 $(td).css({ 'color': '#ffffff','background-color': '#336699' });
			        		 var a_href = $(td).find('a');
			        		 $(a_href).css({ 'color': '#ffffff','background-color': '#336699' });
			        		
						});
			        	 
			        }, function() {
			        	$(this).find('td').each (function( column, td) {
			        		 $(td).css({ 'color': '#000000','background-color': '#ffffff' });
			        		 var a_href = $(td).find('a');
			        		 $(a_href).css({ 'color': '#000000','background-color': '#ffffff' });
						    
						});
						});
			        
			        
			     },
			    success: function(output) {
			    	
			    		displayresults(output);
			    		displayfacets(output);
			    	
			    	$('#facetdates').val("Y");
			    	
			    },
		    error: function(data) {
		        swal('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	
	function appointmentsdue(){
		
	}
		
	
	function showopen(idk,show){
		var r= "N";
		if(show=="Show More +"){
			r="Y";
		}
		if(r=="Y"){
			var g = idk;
			showm.push(g);
			$('#showm').val(showm);
		}else {
			var v = $('#showm').val().split(",");
			//console.log("before final"+v.length);
			showm = new Array();
			for(var i=0;i<v.length;i++){
				if(v[i]!==idk){
					showm.push(v[i]);
				}
			}
			
			$('#showm').val(showm);
				
		}
		//console.log("final"+$('#showm').val());
		//$(".extra_facet_"+idk).toggle();
		//var v = $('#showm').val().split(",");
	//	for(var i=0;i<v.length;i++){
		//	$(".extra_facet_"+v[i]).toggle();
		//}
		
		
		
	}


	
	function dodates(){
		var ads = 'T00:00:00Z';
		var ade = 'T23:59:59.999Z';
		var d ="";
		var ft="";
		$('input[itype="date"]').each(function(){
			var t = $(this).attr("ftype");
			if(ft!=t){
				ft = t;
				var st = $("#"+t+"_st").val();
				var ed = $("#"+t+"_ed").val();
				
				if(st!='' || ed !=''){
				var c = "";
				if(st==''){	st ="*"; c +=st; }else { c += st+ads;}
				
				c +="%20TO%20";
				
				if(ed==''){	ed ="*"; c +=ed; } else { c += ed+ade;}
				
				
				d += ""+t+":["; 
				d += c
				d += "]&";
				}
			}
			
		});
		return d;
	
	}
	
	function doprice(){
		var d ="";
		var ft="";
		
		$('input[itype="currency"]').each(function(){
			var t = $(this).attr("ftype");
			if(ft!=t){
				ft = t;
				var st = $("#"+t+"_st").val();
				var ed = $("#"+t+"_ed").val();
				
				if(st!='' || ed !=''){
				var c = "";
				if(st==''){	st ="*"; c +=st; }else { c += st;}
				
				c +="%20TO%20";
				
				if(ed==''){	ed ="*"; c +=ed; } else { c += ed;}
				
				
				d += ""+t+":["; 
				d += c
				d += "]&";
				}
			}
			
		});
		
	  return d;
	
	}
	
	function faceting(){
		$('#facetvalues').val("");
		$('#sffq').val("");
		$('#sfq').val("");
		$('input:checkbox.inspresults').prop('checked', false);
		$('input:checkbox#selectorall').prop('checked', false);
		
		var chkIds = $("input:checkbox:checked").map(function(){
	    	if($(this).attr('class')!="insproute"){
				return $(this).val();
	    	}
	    }).toArray();
		
	
		
		$('#startresult').val(0);
		$('.selector').pagination('drawPage', 1);
		 
		var t ="";
		var fq = [];
		if(chkIds.length>0){
			var t = ""; 
			for(var i=0;i<chkIds.length;i++){
				var el = chkIds[i].split("|");
				var ty = el[0];
				if(t!=ty){
					t = ty;
					fq.push(t);
				}
			}
			//alert(fq);
			$('#facetvalues').val(chkIds);
			var ffq ="";
			for(var j=0;j<fq.length;j++){
				ffq += "["
				var val= [];
				for(var i=0;i<chkIds.length;i++){
					if(chkIds[i].startsWith(fq[j])){
						var el = chkIds[i].split("|");
						var va = el[1];
						
						//va= va.replace(/\s/g, '\\%20\\');
						//alert(va);
						val.push(va);
						
					}
				}
				ffq += val;
				ffq +="],";
			}
			
		} 
	    
		$('#sffq').val(ffq);
	    $('#sfq').val(fq);
	    doSearch(facets, ffq,fq);
	     
	    routebtn();
	    
		
	}
	
	
	function funSearch(){	
		var val = document.all.sq.value;
		document.forms[0].action='search.jsp?q='+val;
		document.forms[0].submit();
	}

	function displayKeyCode(evt){
		
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode == 13){
	    	funSearch();		
	    } 
	}
	
	
	function displayresults(output){
		output = JSON.stringify(output);
 		output = JSON.parse(output);
 		var rh = output['responseHeader'];
 		var latlong =[];
 		var resp = output['response'];
 		
 		var c = '';
 		//
 		var hd = "";
 		 	hd += resp.numFound.toLocaleString() ;
 		 	hd += " results (0.0";
 		 	hd += rh.QTime%60;
 		 	hd += "0) seconds ";
 		 	$('#headmsg').html(hd);
 		 
 		$('.selector').pagination('updateItems', resp.numFound);
 		//if($('#startresult').val()<=0){
 			//paginate(resp.numFound);
 		//}
	
 		var u = "<%=Config.fullcontexturl() %>/?entity=lso&type=activity&reference=";
 		var t = $('#startresult').val();
 		
 		var overdue=0;
 		var currentdue=0;
 		var futuredue=0;
 		var utc = new Date();
 		
		
 		if($('#view').val()=="viewrow"){
	 		var high = output['highlighting'];
	 		$.each(high, function(k,v) {
	 			var l = u + k;
	 			t++;
	 			if(v.id!=''){
					var tx = "";
					if(v._text_==undefined){ tx ="";} else {tx=v._text_; }
	 				
					c+= '<tr class="csuisub"  style="cursor:pointer;" >';
					c += '<td class="csuisub" type="String" itype="String"><a class="csui" href="'+l+'" ><p>'+k+' <br>';
					if(v._text_==undefined){ description ="";} else {description=v.description; }
					c += ''+tx+'</a></td>';
					c += '</tr>';
				}	
	 		});
 		}
 		else {
	 		$.each(resp['docs'], function(k,v) {
	 			
	 			var l = u + v.title;
	 			t++;
	 			
	 			if(v.id!=''){
	 				
	 					var project ="" ;
	 					var activity="";
	 					var review="";
	 					var appt="";
	 					var status="";
	 					var address="";
	 					
	 					var inspector="";
	 					var start_date="";
	 					var activitytype="";
	 					
	 					//if(v.updated_date==undefined){ updated ="";}
	 					if(v.project_nbr==undefined){ project ="";} else {project=v.project_nbr; }
	 					if(v.longitude==undefined){ lon ="";} else {lon=v.longitude; }
	 					if(v.latitude==undefined){ lat ="";} else {lat=v.latitude; 	var latlon ='{ "lat":'+parseFloat(lat)+',"lng":'+parseFloat(lon)+' }'; 	latlong.push(latlon); }
	 				
	 					
	 					if(v.act_nbr==undefined){ activity ="";} else {activity=v.act_nbr; }
	 					if(v.review==undefined){ review ="";} else {review=v.review; }
	 					if(v.status==status){ status ="";} else {status=v.review_status; }
	 					if(v.address==undefined){ address ="";} else {address=v.address; }
	 					if(v.inspector==undefined){ inspector ="";} else {inspector=v.inspector; }
	 					if(v.activitytype==undefined){ activitytype ="";} else {activitytype=v.activitytype; }
	 					
		 					var color = '';
		 					var ttl = '';
		 					if (v.availability_id < 1) {
		 						color=' style="background-color:#f3e9e9 !important" ';
		 						ttl=' title="Availability not set in configuration. Rescheduling will not be available for this appointment." ';
		 					}

		 					
		 					var d = new Date(v.start_date);
		 					
		 					start_date = (d.getMonth() + 1) + '/' + d.getDate() + '/' +  d.getFullYear();
		 					var ovrdate= new Date(v.start_date);
		 					
		 					var cd = v.start_date.slice(0, 10).split('-');   
		 					var std = (cd[1]) + '/' + cd[2] + '/' +  cd[0];
		 					
		 					if(v.complete="Y"){
			 					if(ovrdate.toDateString() ==utc.toDateString()){
			 						currentdue++;
			 					}else if(ovrdate<utc){
			 						overdue++;
			 					}else {
			 						futuredue++;
			 					}
		 					}
		 					
		 					var ap = "";	
							//d = new Date(v.start_date);
							var stt = v.time_start;
								stt = stt.replace(":00.0000000","");
		 					ap += stt;
		 					//ap += d.getHours() +":00";
		 					ap +="-";
		 					stt = v.time_end;
							stt = stt.replace(":00.0000000","");
							ap += stt;
							//d = new Date(v.end_date);
		 					
		 					//ap += d.getHours() +":00";
		 					
		 					var projectht ="";
		 					projectht +='<a class="csui" target="lightbox-iframe" href="editreview.jsp?_id='+v.comboid+'';
		 					projectht +='&_ent=inspections';
		 					projectht +='&_type='+v.ref+'';
		 					if(v.ref=="activity"){
		 						projectht +='&_typeid='+v.act_id+'';
		 					}else {
		 						projectht +='&_typeid='+v.project_id+'';
		 					}
		 					projectht +='&_grp=';
		 					projectht +='&_grpid=';
		 					projectht +='&_grptype=';
		 					projectht +='&_reviewid='+v.reviewid+'';
		 					projectht +='&_revrefid='+v.refreviewid+'';
		 					
		 					projectht +='">';
		 					
		 					
		 					var projectlink ="";
		 					projectlink +='<a class="csui" target="lightbox-iframe" href="/cs/summary.jsp?';
		 					projectlink +='&_ent=lso';
		 					projectlink +='&_type=project';
		 					projectlink +='&_typeid='+v.project_id;
		 					projectlink +='">';
		 					
		 					var activitylink ="";
		 					activitylink +='<a class="csui" target="lightbox-iframe" href="/cs/summary.jsp?';
		 					activitylink +='&_ent=lso';
		 					activitylink +='&_type=activity';
		 					activitylink +='&_typeid='+v.act_id;
		 					activitylink +='">';
		 					
		 					var addresslink ="";
		 					addresslink +='<a class="csui" target="lightbox-iframe" href="/cs/summary.jsp?';
		 					addresslink +='&_ent=lso';
		 					addresslink +='&_type=lso';
		 					addresslink +='&_typeid='+v.lsoid;
		 					addresslink +='">';
		 					
		 					
		 					var golink ="";
		 					golink +='<a   target="_top" href="/cs/?';
		 					golink +='_ent=lso';
		 					golink +='&_type=activity';
		 					golink +='&_typeid='+v.act_id;
		 					golink +='">';
		 					
		 					//projectht +=project;
		 					//projectht +='</a>';
		 					
		 					/* var ctr = $('<tr/>');
							ctr.addClass('csuisub');
							ctr.id("list'+v.order+'");
							
		 					var ctd = $('<td/>');
		 					ctd.html('<input type="checkbox" '+ttl+' name="ID" onclick=\"toggleButtons('+v.availability_id+')\" class="inspresults" value="'+v.id+'" projectid="'+v.project_id+'"  availabilityid="'+v.availability_id+'"  reviewid="'+v.reviewid+'" address="'+address+' Beverly Hills CA 90210" lat="'+lat+'" lon="'+lon+'"  latlon="'+latlon+'"/>');
		 					
		 					ctr.append(ctd);

		 					var ctp = $('<td/>');
		 					ctp.html(project);
		 					ctr.append(ctp);

		 					ctr.hover(function(){
		 						  $(this).addClass("rowhighlight");
		 						  }, function(){
		 						  $(this).removeClass("rowhighlight");
	 						});
		 		 			c += ctr; */
						
						c+= '<tr class="csuisub rw" id="list'+v.order+'" style="cursor:pointer">';
 						c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'><input type="checkbox" '+ttl+' name="ID" onclick=\"toggleButtons('+v.availability_id+')\" class="inspresults" value="'+v.id+'" projectid="'+v.project_id+'"  availabilityid="'+v.availability_id+'"  reviewid="'+v.reviewid+'" address="'+address+' Beverly Hills CA 90210" lat="'+lat+'" lon="'+lon+'"  latlon="'+latlon+'"/> </td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectlink+''+project+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+activitylink+''+activity+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+activitylink+''+activitytype+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+review+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+address+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+std+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+ap+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+v.inspector+'</a></td>';
 				 		c += '<td class="csui" type="String" itype="String"'+color+''+ttl+'>'+projectht+''+status+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String">'+golink+'<img src="/cs/images/icons/controls/black/go.png" border="0"></a>  </td>';

 				 		c += '</tr>';
				}	
	 		});
 		}
 		if ($('#view').val()=="viewrow"){
 			$("#resultsadd").html("");
 			//$("#resultsaddviewrow").html(c);
 		}
 		else {
 			$("#resultsadd").html(c);
 			
 			
 			//showoverdue(currentdue,overdue,futuredue);
 			var g = latlong+"";
 	 		
 	 		g = g.replace(/"{"/g, "{");
 	 		g = g.replace(/}"/g, "}");
 	 		g = "["+g+"]";
 			
 			loadMap(g);
 			
 		}
 		
	}
	
	
	function showui(obj){
	
		
		$('.fitem').css({
			height: '100%',
			overflow: 'auto !important'
		});
	}
	
	function displayfacets(output){
		
		//var chktt = $('#facetvalues').val();
		
		//console.log("chktt"+chktt);
		
 		var f = output['facets'];
 	
 		
 		
 		var _type = '';
 		var _r = '';

 		var rfinal = '';

 		var shwn = $('#showm').val();
 		
 		$.each(f, function(k,v) {
 			var c = '';
 			if(k!="count" && k!="divisions"){

	 			c += '<div id="'+k+'" class="childshow csuisub_title rearrange"  style="cursor:pointer;" title="Show/Hide" >'+k+' ';
 				var ft =  f[k];
	 			var g = 0;
	 			var ext = false;
	 			
	 			
	 			c += '<div id="h_'+k+'" class="childshow"> ';
	 			$.each(ft['buckets'], function(i,j) {
	 				g = g+1;
	 				var vrr = k+'|'+j.val;
	 				if(g>10){
	 					ext = true;
	 					c +=' <div id="c" class="childshow cssearch_facets extra_facet extra_facet_'+k+'" ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}else {
	 					c +=' <div id="c" class="childshow cssearch_facets " ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}
	 			
	 			});
	 			
	 			c +='</div> ';
	 			c +='</div> ';
	 			if(ext){
	 				
	 				c +='<table> ';
		 			c +='<tr> ';
		 		
		 			c +='<td title="'+k+'" style="align:right;"> ';
		 			c +='<div class="shlsc" rel="'+k+'">Clear All</div>'; 
		 			c +='</td> ';
		 			c +='<td title="'+k+'"> ';
		 			c +='<div class="shlsa" rel="'+k+'">Select All</div>';
		 			c +='</td> ';
		 			c +='<td title="'+k+'" align="right"> ';
		 			
	 				c +='<div class="shls" rel="'+k+'">Show More +</div>';
	 				c +='</td> ';
		 			
	 				c +='</tr> ';
		 			c +='</table> ';
	 			}
	 		
	 			c +='<div class="csui_divider"></div>';
 			}
 			
 			
 			
 			if (k=='complete') {
 			
				_type += c;
				
			}
			else {
				_r += c;
			}

 			
 		});
 		//console.log(c);
 		
 		rfinal = _type + _r;

 		$("#filtershtml").html(rfinal);
 		
 		//$('.extra_facet').hide();
 		 extra_hide();
 		var chk = $('#facetvalues').val();
 		
 		if(chk!=''){
 			chk= chk.replace(/\|/g, '_');
 			var ch = chk.split(",")
 			for(var i=0;i<ch.length;i++){
 				$("[id='"+ch[i]+"']").prop("checked",true);
 			}
 		} 
 		
 		
 		
 		showchart(output);
 		
 		//rearrange();
 		
	}
	
	function rearrange(){
		
		$(".rearrange").each(function(){
	    	//var c = $(this).attr('class');
	    	var html = $(this).html();
	    	console.log(html);
			
	    })
	}
	
	function extra_hide(){
		$('.extra_facet').hide();
		
		var v = $('#showm').val().split(",");
		
		
		$('.shls').each(function(i, obj) {
			var idk= $(this).attr('rel');
			for(var j=0;j<v.length;j++){
				$('.extra_facet_'+v[j]).show();
				if(idk==v[j]){
					$(this).html("Show Less -");
				}
			}
		});
		
	}
	
	function reroute(){
		faceting();
	}
	
	function routebtn(){
		var chk = $('#facetvalues').val();
		
		var u = "";
		
		var c = chk.split(",");
		for(var i=0;i<c.length;i++){
			 var b = c[i].split("|");
			 if(b[0] =="inspector" && (b[1] !="unassigned" && b[1] !="UNASSIGNED")){
			 	u = b[1];
			 	break;
			 }	 
			 
		}
		
		if(u!=""){
			var m = $('#routeordr');
			m.removeClass('disabled');
			m.addClass('enabled');
		}
		
		if(u==""){
			var m = $('#routeordr');
			m.removeClass('enabled');
			m.addClass('disabled');
		}
	}
	
	
	function addroute(){
		var chk = $('#facetvalues').val();
		
		var u = "";
		
		var c = chk.split(",");
		for(var i=0;i<c.length;i++){
			 var b = c[i].split("|");
			 if(b[0] =="inspector" && (b[1] !="unassigned" && b[1] !="UNASSIGNED")){
			 	u = b[1];
			 	break;
			 }	 
			 
		}
		var appt_start_date_st = $('#appt_start_date_st').val();
		var appt_start_date_ed = $('#appt_start_date_ed').val();
	
		if(u==""){
			swal("Select an individual inspector for routing");
			return false;
		}
		
		
		$(' <a title="Config Route" id="addroute"  href="<%=Config.fullcontexturl() %>/appointmentsroute.jsp?chk='+u+'&appt_start_date_st='+appt_start_date_st+'&appt_start_date_ed='+appt_start_date_ed+'" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
				
	          }).click();
	}	
	
	
	function printall(){
		 var v = $('input:checkbox.inspresults:checked').map(function() {    return $(this).attr('projectid'); }).get();
			if(v==""){
				swal("Select projects in order to proceed");
				return false;
			}
			
			//alert(v);

		$(' <a title="Print" id="addroute"  href="<%=Config.fullcontexturl() %>/printall.jsp?_ent=lso&_entid=-1&_type=templatetype&_typeid=1&_grp=project&_grptype=print&_act=print&chk='+v+'" >Friendly description</a>').fancybox({
	       		'width'				: '75%',
					'height'			: '75%',
					'autoScale'			: false,
					'transitionIn'		: 'none',
					'transitionOut'		: 'none',
					'type'				: 'iframe'
				
	          }).click();
	}	
	
	
	if (!String.prototype.startsWith) {
		  String.prototype.startsWith = function(searchString, position) {
		    position = position || 0;
		    return this.indexOf(searchString, position) === position;
		  };
		}
	
	
	Number.prototype.formatMoney = function(c, d, t){
		var n = this, 
		    c = isNaN(c = Math.abs(c)) ? 2 : c, 
		    d = d == undefined ? "." : d, 
		    t = t == undefined ? "," : t, 
		    s = n < 0 ? "-" : "", 
		    i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))), 
		    j = (j = i.length) > 3 ? j % 3 : 0;
		   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
		 };
	
	</script>
	<style>
		 html, body { height: 100%; padding: 0px; margin: 0px; }
		
		 #csui { display: table; width: 100%; height: calc(100% - 60px); background-color: #cccccc; list-style-type: none; padding: 0px; margin: 0px }
		 #csui li { display: table-cell; vertical-align: top; }
		 #csheader { display: table; width: 100%; height: 60px; background-color: #555555; list-style-type: none; padding: 0px; margin: 0px }
		 #csheader li { display: table-cell; vertical-align: middle }
		 #shield { width: 60px; background-color: #111111; text-align: center }
		 #cslogo { width: 200px; text-align: center }
		 #glsearch { }
		 .glsearch { background-color: #777777; }
		 table.glsearch { border-radius: 20px; box-shadow: inset 0px 0px 5px 0px #000000; }
		 input.glsearch { border: 0px; color: #ffffff; font-family: Arial, Helvetica, sans-serif; font-size: 18px; outline: none }
		 #csadmin { width: 50px; text-align: center; }
		
		 #menu { width: 60px; background-color: #555555; height: 100%; }
		 #main { width: 225px; background-color: #dddddd; height: 100%; border-right: 1px solid #cccccc }
		 #sub { width: 225px; background-color: #eeeeee; height: 100%; border-right: 1px solid #cccccc }
		 #linkcontainer { background-color: #ffffff; height: 100%; }
		
		 
		 .panel_main, .panel_sub { position: relative; }
		 .panelcontent_main { position: absolute; overflow: auto; z-index: 1 }
		 .panelcontent_sub { position: absolute; overflow: auto; overflow-x: hidden; z-index: 1 }
		
		 .blocks_menu { width: 100% }
		 .block_menu { width: 100%; border-bottom: 1px solid #6a6a6a; border-top: 0px; border-left: 0px; text-align: center }
		 .blockimage_menu { width: 30px; }
		 .blockcontent_menu { width: 100%; text-align: center; padding-top: 10px; padding-bottom: 10px }
		 .blocktitle_menu { font-size: 8px; color: #ffffff }
		
		 .blockcontent_main, .blockcontent_sub { height: 22px }
		 .blocktitle_main, .blocktitle_sub { font-size: 11px; white-space: nowrap; }
		 .block_main { border-top: 1px solid #cccccc }
		 .block_sub { border-top: 1px solid #dddddd }
		
		 form.search { text-align: center; padding: 10px }
		 input.search { width: 90%; border: 0px; border-radius: 10px; box-shadow: inset 0px 0px 4px 0px #000000; font-family: Arial, Helvetica, sans-serif; font-size: 12px; padding: 5px; outline: none }
		
		
		 .label                { background-color: #aaaaaa; font-family: Roboto Condensed, Arial; font-size: 12px; padding: 10px; font-weight: 700; text-transform: uppercase; color: #ffffff }
		 .message              { font-family: Arial, Helvetica, sans-serif; font-size: 12px; padding: 10px; padding-top: 30px }
		 .options              { background-color: #cccccc; width: 100%; text-align: right }
		 .option               { font-family: Arial; font-size: 8px; padding: 5px; text-transform: uppercase; color: #ffffff; display: inline-block; *display: inline; zoom: 1 }
		 .optionactive         { color: #ffffff; background-color: #336699 }
		 .optioninactive:hover { color: #336699 }
		 .panel                { height: 100%; width: 100% }
		 .panelcontent         { height: 100%; width: 100% }
		 .blocks               { height: 100% }
		 .blocktitle           { font-family: Roboto Condensed, Arial, Helvetica, sans-serif; text-transform: uppercase }
		 .highlight            { background-color: #336699; color: #ffffff; }
		
	.left-panel
    {        
        background-color:#F2F0F0;
        width:10%;
       height:1200px;
        float:left;            
    }
    .right-panel
    {        
        background-color:#FFFFFF;
        width:80%;
       height:1200px;
        float:left;
    }
    
    .results {
    width: 800px;
    height: 100px;
   
}


 #chartdivpie1 {
  width: 100%;
  height: 700px;
   overflow: scroll;
    font-size: 11px;
}	

 #chartdivpie2  {
  width: 100%;
  height: 700px;
   overflow: scroll;
    font-size: 11px;
}

 #chartdivpie3  {
  width: 100%;
  height: 700px;
   overflow: scroll;
    font-size: 11px;
}


#chartdivpie4  {
  width: 100%;
  height: 700px;
   overflow: scroll;
    font-size: 11px;
}

#chartdivpie5  {
  width: 100%;
  height: 700px;
   overflow: scroll;
    font-size: 11px;
}


#chartdiv2 {
  width: 100%;
  height: 600px;
}			

.plus:after {
    content:" +";
}
.minus:after {
    content:" -";
}
	</style>
	
	<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. csuibody csuimain	csuicontent*/
  .csuibody, .csuimain,	.csuicontent, .mapadd, #map {
    
    height: 70%;
    
}
#map_canvas {
    
    height: 70%;
    background-color:#990000
    
}
#map {
   position:inherit;
}
.multibutton {
			white-space: nowrap;
			background-color: #eeeeee;
			border: 1px solid #cccccc;
			font-family: Oswald, Arial, Helvetica;
			text-transform: uppercase;
			padding: 10px;
			padding-left: 20px;
			padding-right: 20px;
			margin: 10px;
			font-size: 14px;
			font-weight: bold;
			border-radius: 5px;
			color: #000000;
			cursor: pointer;
			/*
			background-image: url(/cs/images/icons/input/docedit.png);
			background-repeat: no-repeat;
			background-position : left 4px center
			*/
		}
		.multibutton.disabled {
			background-color: #dddddd;
			color: #aaaaaa;
		}
		.multibutton.enabled:hover {
			background-color: #669966;
			color: #ffffff;
		}

      
     
      
   
  	

      
    </style>
		  	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/maps/markerclusterer.js"></script>
		  
    <script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7xtGshY7YvvmMXrxKJ9CGzgW_2ezyrLs"></script>
	<script type="text/javascript">
	function initMap(){
		var  map =  new google.maps.Map(document.getElementById('map'), {
	        zoom: 13,
	        center: {lat: 34.08665, lng: -118.446795}
	      });
	}
	
	 function loadMap(loc) {
		
			//console.log(loc);
	      	var locations = JSON.parse(loc);
	    
		
			var  map =  new google.maps.Map(document.getElementById('map'), {
		        zoom: 15,
		        center: {lat: 34.08665, lng: -118.446795}
		      });
	

	     
	        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	      
	      
	     
	       
	        var markers = locations.map(function(location, i) {
	        
	        	return new google.maps.Marker({
	              position: location,
	              label: labels[i % labels.length]
	            });
	          });
	        
	     
	        var markerCluster = new MarkerClusterer(map, markers,
	            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
	      
	 	
	       
    }
	 
	 
	
	
	</script>
	
	 <script type="text/javascript">
	    var directionDisplay;
	    var directionsService = new google.maps.DirectionsService();
	    var map;
	
	    function initialize() {
	        directionsDisplay = new google.maps.DirectionsRenderer();
	        var chicago = new google.maps.LatLng(34.08665, -118.446795);
	       // var geocoder = new google.maps.Geocoder();
	        
	        var myOptions = {
	            zoom: 7,
	            mapTypeId: google.maps.MapTypeId.ROADMAP,
	            center: {lat: 34.08665, lng: -118.446795}
	        }
	        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
	        directionsDisplay.setMap(map);
	        calcRoute();
	    }
	
	    function calcRoute() {

       // sunil
       var wy = [];
         $('input:checkbox.inspresults:checked').each(function () {
       		
       		var loc1 = (this.checked ? $(this).attr("address") : "");
   		 	
   		 	wy.push({
            location: loc1
             
           });
  		 });
        
        
      	
	    	

        var a = new google.maps.LatLng(34.10314358, -118.3926977); //1145 maytor pl 0 a
        var b = new google.maps.LatLng(34.09766545, -118.3991574); // 1067 loma vista 1 b
        var c = new google.maps.LatLng(34.06478044, -118.376951); // 202 Le doux 2 c 
        var d = new google.maps.LatLng(34.07136696, -118.3944405); // 307 maple 3 d  3120 dbca
        var waypts = [{location: a},
                      {location: b},{location: c},
                      {location: d}];
		
        start  = new google.maps.LatLng(34.07329276, -118.3993475);
        end = new google.maps.LatLng(34.072008, -118.398886);
        //start  = new google.maps.LatLng(34.10314358, -118.3926977);
       // end = new google.maps.LatLng(34.07136696, -118.3944405);
       //start  = new google.maps.LatLng(34.10314358, -118.3926977);
        var request = {
            origin: "468 N Crescent dr Beverly hills CA 90210",
            destination: "444 N rexford dr Beverly hills CA 90210",
            waypoints: wy,
            optimizeWaypoints: true,
            travelMode: google.maps.DirectionsTravelMode.DRIVING
        };
        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
                var route = response.routes[0];
                var summaryPanel = document.getElementById("directions_panel");
                summaryPanel.innerHTML = "";
              
                // For each route, display summary information.
                var totaldistance=0;
                var totaltime=0;
                summaryPanel.innerHTML += "</br>";
                for (var i = 0; i < route.legs.length; i++) {
                    var routeSegment = i + 1;
                    summaryPanel.innerHTML += "<b>Route Segment: " + routeSegment + "</br>";
                    summaryPanel.innerHTML += route.legs[i].start_address + " ->  ";
                    summaryPanel.innerHTML += route.legs[i].end_address + "</br> Miles : ";
                    
                    summaryPanel.innerHTML += route.legs[i].distance.text + "Time : ";
                  	var dis = route.legs[i].distance.text;
                  	
                  	if(dis.indexOf("ft")>0){
                  		dis = "0."+dis;
                  	}
                  	
                    totaldistance += parseFloat(dis);
                    summaryPanel.innerHTML += route.legs[i].duration.text + "<br /><br />";
                    totaltime += parseFloat(route.legs[i].duration.text);
                    
                   // console.log("Distance: "+route.legs[i]+" Duration: "+route.legs[i].duration.text);
                    
                }
                summaryPanel.innerHTML += "Current route order <br />";
                summaryPanel.innerHTML += route.waypoint_order + "<br /><br />";
                
                summaryPanel.innerHTML += "<b>Total Distance : "+parseFloat(totaldistance).toFixed(2)+" miles </b><br />";
                summaryPanel.innerHTML += "<b>Total Time : "+totaltime+"  mins </b><br />";
            }
        });
    }
	    
	    
        </script>
</head>

<body >


<form name="idx"  >
	<input type="hidden" id="facettypes" name="facettypes" value="">
	<input type="hidden" id="facetvalues" name="facetvalues" value="">
	<input type="hidden" id="facetdates" name="facetdates" value="N">
	<input type="hidden" id="startresult" name="startresult" value="0">
	<input type="hidden" id="endresult" name="endresult" value="50">
	<input type="hidden" id="sffq" name="sffq" value="">
	<input type="hidden" id="sfq" name="sfq" value="">
	<input type="hidden" id="_sort" name="_sort" value="routeorder%20asc,start_date%20desc">
	<input type="hidden" id="view" name="view" value="def">
	<input type="hidden" id="ldef" name="ldef" value="N">
	
	<input type="hidden" id="showm" name="showm" value="">
	</form>




	

	<div id="csuibody">
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent" style="padding-left:30px;padding-right:30px">
				
				<table cellpadding="5" cellspacing="2" width="100%">
				
					
					
				
					<tr>
						<td colspan="2" class="csuisub_title">APPOINTMENT DATE</td>
					</tr>
					<tr>
						<td width="50%" class="cssearch_date"><input type="text" itype="date" class="cssearch" id="appt_start_date_st" name="appt_start_date_st" value="" ftype="appt_start_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" itype="date" class="cssearch" id="appt_start_date_ed" name="appt_start_date_ed" value="" ftype="appt_start_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
				
				
				</table>

				

				<div class="csui_divider"></div>

				<div class="csuisub_title" id="filtershtml">
				</div>

				
				<table class="csuisub sortable" type="horizontal" id="itemsadd" >
					
					
				</table>
				
				
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
		
		<div id="csuimain">
		<div id="loader1"></div>
			<div class="csuicontent">

				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right">
							<table class="csui_tools">
								 <tr>
								 
									<td class="csui_tools">
										<a href="javascript:void(0);" title="View Default" border="0" id="def" title="View Table"><img src="/cs/images/icons/glsearch/table.png" border="0"></a>
									</td>
								 	
								 
									<td class="csui_tools">
											<a  href="javascript:void(0);" id="route" title="route"><img src="/cs/images/icons/dark/route.png" border="0"></a>
									</td>
									
								 	<td class="csui_tools">
										<a href="javascript:void(0);" title="Charts" border="0"  id="charts" title="View Chart"><img src="/cs/images/icons/glsearch/chart.png" border="0"></a>
									</td>
									<td class="csui_tools">
										<a href="javascript:void(0);" title="View GIS" border="0" id="gis" title="View Map"><img src="/cs/images/icons/glsearch/map.png" border="0"></a>
									</td>
									
									<td class="csui_tools">
											<a  href="javascript:void(0);" id="statistics" title="Statistics"><img src="/cs/images/icons/controls/black/statistics.png" border="0"></a>
									</td>
								 
								 <!-- 
									<td class="csui_tools">
											<a  href="javascript:void(0);" id="appointmentschedule" title="appointment schedule"><img src="/cs/images/icons/controls/black/appointment.png" border="0"></a>
									</td>
									 -->
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  onclick="printall();"  ><img src="/cs/images/icons/controls/black/print.png" border="0"></a>
									</td>
									
								
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  onclick="openexport();" title="Download"><img src="/cs/images/icons/controls/black/csv.png" border="0"></a>
									</td>
									
								
								</tr>
						   </table>
					   </td>
					</tr>
				</table>

				
					
						<div class="csui_divider"></div>
							
						<table cellpadding="10" cellspacing="0" border="0" width="100%" class="sticky">
							<tr>
								<td align="right" width="1%" nowrap>
								<span id="routeordr" class="multibutton" onclick="addroute();" >Route Sort</span>
								<span id="reassign" class="multibutton " rel="inspector" _ent="<%=entity%>" _type="<%=type%>">Reassign</span>
								<span id="reschedule" class="multibutton " rel="inspector" _ent="<%=entity%>" _type="<%=type%>">Reschedule</span>
									
								</td>
							</tr>
						</table>
						
						<div class="csui_divider"></div>
						
						<table  class="mapadd" >
						 	<div id="map" class="mapadd" ></div>
						</table>
	 
						<table id="maproute" class="maproute" >
							<div id="map_canvas" class="maproute" ></div>
	 						<div id="directions_panel" class="maproute"  style="padding: 6px; font-family: Armata, Arial, Helvetica, sans-serif; font-size: 12px; background-color: #ffffff;"></div>
	 					</table>
						
						<div class="csui_divider"></div>
						
						<table class="csui" type="horizontal">
							<tr>
								<td  class="csui"  align="right"><input type="text" style="width: 40%; border: 0px; border-radius: 10px; box-shadow: inset 0px 0px 4px 0px #000000; font-family: Arial, Helvetica, sans-serif; font-size: 12px; padding: 5px; outline: none " id="subsearch" name="subsearch" value=""  placeholder="Search" > </td>
							</tr> 
						</table>
						<table class="csui" type="horizontal">
						
								<tr>
									<td class="csui_title csuialert" id="headmsg"> </td>
								</tr>
								
								
						</table>
						
						<table class="csui" type="review" id="tablesort">
							<thead>
						 		<tr>
						 			<td class="csui_header" type="String" itype="String"><input type="checkbox" name="selectorall" id="selectorall" class="selectorall"></td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="project" sorttype="asc" >PROJECT</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="activity" sorttype="asc" >ACTIVITY</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="activitytype" sorttype="asc" >TYPE</td>
							 		
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="review" sorttype="asc" >REVIEW</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="address" sorttype="asc" >ADDRESS</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="start_date" sorttype="asc" >DATE</td>
							 		
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="time" sorttype="asc" >APPT</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="inspector" sorttype="asc" >INSPECTOR</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="review_status" sorttype="asc" >STATUS</td>
							 		<td class="csui_header" type="String" itype="String"  style="cursor:pointer;"  >&nbsp;</td>
						 		</tr>
 							</thead>
 							<tbody id="resultsadd" >
 								<tr>
 								<td id="resultsloading" colspan="11">loading...</td>
 								</tr>
 							</tbody>
						</table>	
						
						
						
						
						<table class="csui" type="horizontal" id="tablerow">
							<tbody id="resultsaddviewrow">
							</tbody>
						</table>	
						
						<div class="csui_divider"></div>
						<div class="selector" style="align: right; "></div>
						
						
						<table id="tablechart" width="100%">
						
						<tr>
							<td>
								<div id="chartdivpie1" ></div>
							</td>
							
						</tr>
						<tr>
							<td>
								<div id="chartdivpie2" ></div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="chartdivpie3" ></div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div id="chartdivpie4" ></div>
							</td>
						</tr>
						<tr>
							<td>
							<div id="chartdiv2" ></div>
							</td>
							
						</tr>
						
						
						</table>
					
			
			</div>
			
			
			
		</div>
		
	</div>


</br><br/>

</body>

</html>




















