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
Cartographer map = new Cartographer(request,response);
String solrurl = CsConfig.getString("search.inspection");
String entity = map.getString(RequestMapper.entity);
String type = map.getString(RequestMapper.type);
String typeid = map.getString(RequestMapper.typeid);


String rfilter = map.getString("chk","");

String appt_start_date_st = map.getString("appt_start_date_st","");
String appt_start_date_ed = map.getString("appt_start_date_ed","");

//System.out.println(appt_start_date_st+"rfilterrfilterrfilterrfilterrfilterrfilterrfilterrfilterrfilterrfilterrfilterrfilter"+appt_start_date_ed);


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
	
	

<style>

</style>


	<script language="JavaScript">
	var q = "<%=query%>";
	var facets = "<%=facets%>";
	
	var facetvalues = new Array();
	var dt = "";
	var pr = "";
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
		 
		 
		  $(".childshow").click(function (e) {
		        e.stopPropagation();
		        jQuery(this).children('.childshow').toggle();
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
				
			   		$(".maproute").toggle();
			   		initialize();	
						
			 });
			 
			 $('#resultsadd').sortable({
					update: function saveOrder(){
						var result = $('#resultsadd').sortable('toArray');
						var order ="";
						for (var i = 0; i < result.length; i++) {
							order += result[i] + ",";
						}
						
						if(order != ''){
							order = order.substring(0, order.length-1);
							//alert(order);
							$('#ordr').val(order);
							//sortrefs(order);
						}
						else {
							return false;
						}
					}
				});	
			 
			 
			 
			 
			 
		 
	});
	
	
	function sortrefs(){
		var order = $('#ordr').val();
		var method = "reroute";
		var find = 'list_';
		order = order.replace(new RegExp(find, 'g'), "");
		 $('#loader').show();
		$.ajax({
			  type: "POST",
			  url: "action.jsp?_act="+method,
			  dataType: 'json',		  
			  data: { 
				  _type : "appointment",
				  _typeid : "<%=typeid%>",
				 _id : $('#refteamid').val(),
				 _reference : order,
				  _ent : "lso",
				  _grp : "appointment",
				  _grptype : "appointment"
			      //mode : mode
			    },
			    success: function(output) {
			    	swal("Route sorted successfully ");
			    	
			    	parent.reroute();
			    	parent.$.fancybox.close();
			    		
			    },
		    error: function(data) {
		    	swal("Problem while processing the request");  
		    }
		 });		
		
		
		
	}
	
	
	
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
		 var url = "actionsearch.jsp?method=csv&q=";
	 	 url += q;	 url += "&wt=csv"; url += "&defType=edismax"; url += "&mm=100"; url += "&_facet="+facets; url += "&start=0"; url += "&rows=100000"; 
	 	 url += "&_fq="+$('#sffq').val();
	 	 url += "&fl=title,act_id,lso_type,apn,latitude,longitude,description,start_date,act_nbr,id,address,applied_date,final_date,issued_date,created_date,updated_date,valuation_calculated,type,status";
	 	 url += "&_filters="+$('#sfq').val();  url += "&_dt="+dt; url += "&_price="+pr; url += "&_sort="+$('#_sort').val();  url += "&_view="+$('#view').val(); url += "&_url="+"<%=solrurl%>"; 
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
			 $('#appt_start_date_st').val("<%=appt_start_date_st%>");
			 $('#appt_start_date_ed').val("<%=appt_start_date_ed%>");
			 
			 
			 $('#startresult').val(0);
			 //$('.selector').pagination('drawPage', 1);
			 
			 $('#complete_No').attr("checked",true);
				 
			faceting();
		}
	}
	
	
	function doSearch(facets,fq,filters){
		
		var st = $('#startresult').val();
		var rows = $('#endresult').val();
		
		fq = "[<%=rfilter%>],[No],";
		filters = "inspector,complete";
		
		
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
				        $(".extra_facet_"+idk).toggle();
				        jQuery(this).children('.childshow').toggle();
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
	 					
	 				
		 				
		 					var d = new Date(v.start_date);
		 					
		 					start_date = (d.getMonth() + 1) + '/' + d.getDate() + '/' +  d.getFullYear();
		 					var ovrdate= new Date(v.start_date);
		 					
		 					
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
		 					projectht +='<a class="csui" target="_self" href="editreview.jsp?_id='+v.comboid+'';
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
		 					//projectht +=project;
		 					//projectht +='</a>';
		 					
							if($('#refteamid').val()==0){
								$('#refteamid').val(v.refteamid);
		 					}
		 					
						c+= '<tr class="csuisub" id="list_'+v.refactid+'" tid="'+v.refteamid+'" style="cursor:pointer;" >';
					
						//c += '<td class="csuisub" type="String" itype="String">'+t+'</td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+project+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+activity+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+activitytype+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+review+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+address+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+start_date+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+ap+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+v.inspector+'</a></td>';
				 		c += '<td class="csuisub" type="String" itype="String">'+projectht+''+status+'</a></td>';
				 		c += '</tr>';
				}	
	 		});
 		}
 		if ($('#view').val()=="viewrow"){
 			$("#resultsadd").html("");
 			$("#resultsaddviewrow").html(c);
 		}
 		else {
 			$("#resultsadd").html(c);
 			//showoverdue(currentdue,overdue,futuredue);
 			var g = latlong+"";
 	 		
 	 		g = g.replace(/"{"/g, "{");
 	 		g = g.replace(/}"/g, "}");
 	 		g = "["+g+"]";
 			
 			//loadMap(g);
 			
 		}
 		
	}
	
	
	function showui(obj){
	
		
		$('.fitem').css({
			height: '100%',
			overflow: 'auto !important'
		});
	}
	
	function displayfacets(output){
		
 		var f = output['facets'];
 	
 		var c = '';
 	
 		$.each(f, function(k,v) {
 			if(k!="count" && k!="divisions"){
	 			//c +='<tr> 	<td class="csuisub_title">'+k+'</td>	</tr>';
	 			//c +='<tr> <td> <table> '
//	 			c +='<div  class="fitems"> <label for="ch" rel="'+k+'" class="shls"> Show more</label>'
	 			c += '<div id="'+k+'" class="childshow csuisub_title"  style="cursor:pointer;" title="Show/Hide" >'+k+' ';
 				var ft =  f[k];
	 			var g = 0;
	 			var ext = false;
	 			$.each(ft['buckets'], function(i,j) {
	 				g = g+1;
	 				if(g>10){
	 					ext = true;
	 					//c +='<tr class="extra_facet extra_facet_'+k+'"> <td class="csui" width="1%"><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > </td> 	<td class="csui">'+j.val+' ('+j.count+')</td>	</tr>';
	 					//c +=' <div id="c" class="cssearch_facets extra_facet extra_facet_'+k+'" ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 					//if(!ext){
		 					//c +='<tr > <td width="1%" class="csui_header" style="cursor:pointer;"  colspan="2"><a class="csui" href="javascript:void(0);" title="Show more" onclick="show_more(&quot;'+k+'&quot;);" >Show More/Less ('+k+')</a></td></tr>';
						//	c +='<div class="cssearch_facets"><a class="csui" href="javascript:void(0);" title="Show more" onclick="show_more(&quot;'+k+'&quot;);" >Show More/Less ('+k+')</a></div>';		 					ext = true;
	 					//}
	 					c +=' <div id="c" class="childshow cssearch_facets extra_facet extra_facet_'+k+'" ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}else {
	 					//c +='<tr> <td class="csui" width="1%"><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > </td> 	<td class="csui">'+j.val+' ('+j.count+')</td>	</tr>';
	 					c +=' <div id="c" class="childshow cssearch_facets " ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}
	 				//c +=' <div id="c" class="childshow cssearch_facets " ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 			});
	 			//c +='</table> </td> </tr> ';
	 			c +='</div> ';
	 			if(ext){
	 			c +='<div class="shls" rel="'+k+'">Show More +</div>';
	 			}
//	 			c +='</div> ';
	 			c +='<div class="csui_divider"></div>';
 			}
 			
 			if(k=="divisions"){
 				c += '<div id="'+k+'" class="childshow csuisub_title" style="cursor:pointer;" title="Show/Hide" >'+k+' ';
 				var ft =  f[k];
 				 var hs = "";
 				 var arr = [];
 				 var a =0;
 				$.each(ft['buckets'], function(i,j) {
 					arr[a] = j.val +"|"+j.count;
 					a = a+1;
 				});
 				
 				 for(var i=0;i<arr.length;i++){
 					 var spl = arr[i].split(" ");
 					 if (hs.indexOf(spl[0]) < 0){
 						 hs += spl[0]+",";
 					 }
 					
 				 }
 				
 				 var res = hs.split(",");
 				
 				 for(var n=0;n<res.length;n++){
 					 var p = res[n];
 					 if(p!=''){
 	 					 c += '<div id="'+k+'" class="childshow cssearch_facets" style="cursor:pointer;" title="Show/Hide" >'+p+'';
						 
 						 for(var i=0;i<arr.length;i++){
 							 var mlv = arr[i];
 							
 							 if(mlv.startsWith(p)){
 								 var spl = mlv.replace(p,"");
 								
 								var ot =  spl.split("|")
 								var org = mlv.split("|");
 			 					c +=' <div id="c" class="childshow cssearch_facets" style="display:none"><input type="checkbox" class="'+k+'" name="'+org[0]+'" id=\"'+k+'_'+org[0]+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+org[0]+'\" > '+ot[0]+' ('+ot[1]+')	</div>';
 								
 							 }
 						 }
 						c += '</div>';
 					 }
 				 } 
 				
 				
 				
 				
 				
 				
 				c += '</div>';   
 		 	    
 				c +='<div class="csui_divider"></div>';
 				
 			}
 			
 		});
 		//console.log(c);
 		$("#filtershtml").html(c);
 		$('.extra_facet').hide();
 		 
 		var chk = $('#facetvalues').val();
 		
 		if(chk!=''){
 			chk= chk.replace(/\|/g, '_');
 			var ch = chk.split(",")
 			for(var i=0;i<ch.length;i++){
 				$("[id='"+ch[i]+"']").prop("checked",true);
 			}
 		} 
 		
 		//showchart(output);
 		
 		
 		
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
		
	
	
</head>

<body >


<form name="idx"  >
	<input type="hidden" id="facettypes" name="facettypes" value="">
	<input type="hidden" id="facetvalues" name="facetvalues" value="<%=rfilter%>">
	<input type="hidden" id="facetdates" name="facetdates" value="N">
	<input type="hidden" id="startresult" name="startresult" value="0">
	<input type="hidden" id="endresult" name="endresult" value="150">
	<input type="hidden" id="sffq" name="sffq" value="">
	<input type="hidden" id="sfq" name="sfq" value="">
	<input type="hidden" id="_sort" name="_sort" value="routeorder%20asc,start_date%20desc">
	<input type="hidden" id="view" name="view" value="def">
	<input type="hidden" id="ldef" name="ldef" value="N">
	<input type="hidden" id="refteamid" name="refteamid" value="0">
	<input type="hidden" id="ordr" name="ordr" value="">
	<input type="hidden" id="appt_start_date_st" name="appt_start_date_st" itype="date" value="" ftype="appt_start_date" placeholder="start" ad="T00:00:00Z">
	<input type="hidden" id="appt_start_date_ed" name="appt_start_date_ed" itype="date" value="" ftype="appt_start_date" placeholder="end" ad="T23:59:59.999Z">
	</form>




	

	<div id="csuibody">
		<div id="csuimain">
		<div id="loader"></div>
			<div class="csuicontent">

										
						<div class="csui_divider"></div>
						
						<table cellpadding="10" cellspacing="0" border="0" width="100%" class="sticky">
							<tr>
								<td align="right" width="1%" nowrap>
									<span id="routeordr" class="multibutton enabled" onclick="sortrefs();" >Update Order</span>
								</td>
							</tr>
						</table>
						<div class="csui_divider"></div>
						<table class="csui" type="horizontal">
								<tr>
									<td class="csui_header csuialert"><%=rfilter%> </td>
								</tr>
								<tr>
									<td class="csui_title csuialert" id="headmsg"> </td>
								</tr>
								
								
						</table>
						
						<table class="csui" type="review" id="tablesort">
							<thead>
						 		<tr>
						 			
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="project" sorttype="asc" >PROJECT</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="activity" sorttype="asc" >ACTIVITY</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="activitytype" sorttype="asc" >TYPE</td>
							 		
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="review" sorttype="asc" >REVIEW</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="address" sorttype="asc" >ADDRESS</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="start_date" sorttype="asc" >DATE</td>
							 		
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="time" sorttype="asc" >APPT</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="inspector" sorttype="asc" >INSPECTOR</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="status" sorttype="asc" >STATUS</td>
						 		</tr>
 							</thead>
 							<tbody id="resultsadd">
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
						
						
						
					
			
			</div>
			
			
			
		</div>
		
	</div>


</br><br/>

</body>

</html>




















