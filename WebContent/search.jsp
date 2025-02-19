<!-- @author: sunil vijayakumar sunvoyage -->
<%@page import="cs.ui.CsUiTools"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="alain.core.utils.MapSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.address.AddressTest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<% 
Cartographer map = new Cartographer(request,response,true);
boolean logon = true;
if(!Operator.hasValue(map.token())){
	map.logout();
	logon = false;
	map.redirect("index.jsp");
}
int userid = GlobalSearch.userId(map.token(), map.getRemoteIp());
String solrurl = CsConfig.getString("search.global");
int bookmarkId = map.getInt("bookmarkId",0);

String q = map.getString("sq","*");
String query = q;
q = Operator.toText(q);
query = Operator.javascriptFriendly(q);
String specific = map.getString("specific");


String bookurl = "";
String gislink  = CsConfig.getString("tools.map");
%>
<%@include file="search/gsfacet.jsp"%>

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
	

    <script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/simplepagination/jquery.simplePagination.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
     


<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
	
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>

<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/funnel.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
	
<!-- 	<script type="text/javascript" src="/search/search.js"></script> -->
<style>

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
		  
		  "labelsEnabled": true,
		  "titles": [{"text": "Activity Types","size": 15}],
		  "legend":{
			 	 divId: "legenddivpie1"
			  
			  },
			  "innerRadius": "20%",
		  "export": {
		    "enabled": true
		  }
		 
		} );
	
	
	
	var chartpie2 = AmCharts.makeChart( "chartdivpie2", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "labelsEnabled": true,
		  "titleField": "title",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Activity Status","size": 15}],
		  "legend":{
			 	 divId: "legenddivpie2"
			  
			  },
// 		  "legend":{
// 			   	"position":"right",
// 			    "marginRight":100,
// 			    "autoMargins":false
// 			  },
			  "innerRadius": "10%",
		  "export": {
		    "enabled": true
		  }
		} );
	
	
	var chartpie3 = AmCharts.makeChart( "chartdivpie3", {
		  "type": "pie",
		  "theme": "light",
		  "valueField": "value",
		  "titleField": "title",
		  "labelsEnabled": true,
		   "balloon":{
		   "fixedPosition":true
		  },
		  "titles": [{"text": "Divisions","size": 15}],
		  "legend":{
			 	 divId: "legenddivpie3"
			  
			  },
// 		  "legend":{
// 			   	"position":"right",
// 			    "marginRight":100,
// 			    "autoMargins":false
// 			  },
			  "innerRadius": "10%",
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
		  "titles": [{"text": "Online","size": 15}],
		  "legend":{
			 	 divId: "legenddivpie4"
			  
			  },
// 		  "legend":{
// 			   	"position":"right",
// 			    "marginRight":100,
// 			    "autoMargins":false
// 			  },
			  "innerRadius": "10%",
		  "export": {
		    "enabled": true
		  }
		} );
	
// 	var chart2 = AmCharts.makeChart( "chartdiv2", {
// 		  "type": "funnel",
// 		  "theme": "light",
// 		  "balloon": {
// 		    "fixedPosition": true
// 		  },
// 		  "valueField": "value",
// 		  "titleField": "title",
// 		  "marginRight": 240,
// 		  "marginLeft": 50,
// 		  "startX": -500,
// 		  "depth3D": 100,
// 		  "angle": 40,
// 		  "outlineAlpha": 1,
// 		  "outlineColor": "#FFFFFF",
// 		  "outlineThickness": 2,
// 		  "labelPosition": "right",
// 		  "balloonText": "[[title]]: [[value]]n[[description]]",
// 		  "export": {
// 		    "enabled": true
// 		  }
// 		} );



	
	function showchart(output){
		var f = output['facets'];
	 	var ctype =[];
	 	var cstatus =[];
	 	var cdivisions =[];
	 	var conline =[];
 		var c = '';
 		var ft ="";
 		
		var chkIds = $("input:checkbox:checked").map(function(){
	    	
			return $(this).val();
	    }).toArray();
		
		//alert(chkIds);
 		
 		var tt = '[';
 		$.each(f, function(k,v) {
 			if(k!="count"){
 				var	ft =  f[k];
 				var g =0;
 				$.each(ft['buckets'], function(i,j) {
 					g = g+1;
 					if(g<50){
 					
 						var d ='{ "title":"'+j.val+'","value":'+j.count+' }';
 						//alert(d);
 					
					if(k=="type"){
						ctype.push(d);	
 					}
					if(k=="status"){
						cstatus.push(d);	
 					}
					
					if(k=="divisions"){
						cdivisions.push(d);	
 					}
					
					if(k=="online"){
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
	
	
	function updatetrends1(output){
		output = JSON.stringify(output);
    	output = JSON.parse(output);
    	var rh = output[0].trend1;
    	alert(rh);
 		trend1.dataProvider = rh;
		trend1.validateData();
	}
	
	</script>

	<script language="JavaScript">
	var q = '<%=query%>';
	var facets = "<%=facets%>";
	
	var facetvalues = new Array();
	var dt = "";
	var pr = "";
	//alert(facets);
	var showm = new Array();
	
	
	
	$(document).ready(function() {
		
		$('#loader').hide();
		$(".chosen").chosen({width: "95%"});
		try{
			parent.unSelect('menu');
		}catch(e){}
		
		<%if(!logon){%>
			window.location = "https://cs/";
		<%}%>
		
		$('input[itype=date]').datetimepicker({
			timepicker:false,
			format:'Y-m-d'
		});
	//	
	//	
	//	
		
		 $('#display_set').change(function(){
			 var v = $(this).val();
			 $('#endresult').val(v);
			 $('.selector').pagination('updateItemsOnPage', $('#endresult').val());
			 faceting();
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
		 $("#gis").click(function(){
			    
			    
	    	$(".mapadd").toggle();
	    	google.maps.event.trigger(map, 'resize');
					
				
		 });
		 
		 
		 $('#display_type').change(function(){
				
			 var v = $(this).val();
		
				window.location = v;	
				
			});
		 
		 
		 
		  $("#tablechart").hide();
		  $("#tabletrends").hide();
		 $("#charts").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").hide();
			  $("#tablechart").show();
			  $("#tabletrends").hide();
			  $('.selector').hide();
			
			  $("#cbhgis2").hide();
			  $("#cbhgis3").val("N");
		 });
		 
		 $("#cbhgis").click(function(){
			  $("#tablesort").show();
			  $("#tablerow").hide();
			  $("#tablechart").hide();
			  $("#tabletrends").hide();
			  $("#cbhgis2").show();
			  $("#cbhgis3").val("Y");
			  $('.selector').show();
			
			  viewgis();
		 });
		 
		 $("#trends").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").hide();
			  $("#tablechart").hide();
			  
			  $("#tabletrends").show();
			  $('.selector').hide();
			  
			  $("#cbhgis2").hide();
			  $("#cbhgis3").val("N");
		 });
		
		 
		
		 
		 $("#viewrow").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").show();
			  $("#tablechart").hide();
			  $("#tabletrends").hide();
			  $('.selector').show();
			  $("#view").val("viewrow");
			  $("#cbhgis2").hide();
			  $("#cbhgis3").val("N");
			 
			  doSearch(facets,$('#sffq').val(), $('#sfq').val());
		 });
		 
		
		 
		 $("#def").click(function(){
			  $("#tablesort").show();
			  $("#tablerow").hide();
			  $("#tablechart").hide();
			  $("#tabletrends").hide();
			  $('.selector').show();
			  $("#view").val("def");
			  $("#view").val("def");
			  $("#cbhgis2").hide();
			  $("#cbhgis3").val("N");
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
		          // alert(pageNumber);
		            //if(pageNumber>1){
		            var r = (pageNumber - 1) * $('#endresult').val();
				    $('#startresult').val(r);
				   // console.log($('#sfq').val());
				   // console.log($('#sffq').val());
				   //console.log( $('#startresult').val()+"666666666666");
				   //console.log( $('#endresult').val()+"666666666666");
				   	 doSearch(facets,$('#sffq').val(), $('#sfq').val());
		           // }
		        }
		     
		   });	
		 
		  $(".docustomdates").each(function (e) {
				var id = $(this).attr("id");
				var h = "";
				h += '<option value="">Any time</option>';
				h += '<option value="P24">Past 24 hours</option>';
				h += '<option value="C1M">Current month</option>';
				h += '<option value="C1Y">Current year</option>';
				h += '<option value="F1Y">Current fiscal year</option>';
				h += '<option value="custom">Custom Range</option>';
				
				$('#'+id).append(h);
				$('#'+id).trigger('chosen:updated');
		  });
		 
		  $(".docustomdates").change(function (e) {
		      	
			  	var id = $(this).attr("id");
			  	var v = $(this).val();
			  	//alert(id+"--"+v);
			  	if(v =="custom"){
			  		$("#custom_"+id).show();
			  	}else {
			  		
			  		
			  		$("#"+id+"_st").val("");
			  		$("#"+id+"_ed").val("");
			  		$("#custom_"+id).hide();
			  	}
			  	docustomdateshandler();
		    });
		  
		  $(".childshow").click(function (e) {
		        e.stopPropagation();
		        jQuery(this).children('.childshow').toggle();
		    });
		  
		  $(".childshowd").click(function (e) {
		        e.stopPropagation();
		        jQuery(this).children('.childshow').toggle();
		    });
		  
		  
		  
		  $("#selectorall").click(function(){
				$('input:checkbox.inspresults').not(this).prop('checked', this.checked);
			 });
		  
		  
		 
		  
		  $("#CUSTOM_SINGLE").change(function(){
				 var grpid = $(this).val();
				 $('#CUSTOM_SINGLE_VALUE').empty();
				 if(grpid>0){
				 	var method = 'showselector';
				 	$('#CUSTOM_SINGLE_VALUE').empty();
					 $.ajax({
			   			  type: "POST",
			   			  url: "action.jsp?_action="+method,
			   			  dataType: 'json',		  
			   			  data: { 
			   				   ID : grpid
			   			      //mode : mode
			   			    },
			   			    success: function(output) {
			   			     	var h = $('<option value="">Please Select </option>');
		   			    		$('#CUSTOM_SINGLE_VALUE').append(h);
			   			    	$.each(output, function(k,v) {
			   		            	 var c = $('<option value="custom_'+v.FIELD_GROUPS_ID+'_'+v.ID+'">'+v.NAME+'</option>');
			   			    		$('#CUSTOM_SINGLE_VALUE').append(c);
			   		            });
			   			    	$('#CUSTOM_SINGLE_VALUE').trigger('chosen:updated');		
			   			    },
			   		    error: function(data) {
			   		    	swal("Problem while perfoming the operation ");
			   		    }
		   			});		
				 }
			
			 });
		 
	});
	
	 function openexport(){
		 var url = "exportcsv.jsp?method=csv&source=activity&q=";
	 	 url += $('#sq').val();	 url += "&wt=csv"; url += "&defType=edismax"; url += "&mm=100"; url += "&_facet="+facets; url += "&start=0"; url += "&rows=5000000"; url += "&_customdt="+$('#_customdt').val();
	 	 url += "&_fq="+$('#sffq').val();
	 	 //url += "&expfl=act_id,act_nbr,type,status,department,projectname,parking_account_no,lso_type,apn,description,address,start_date,applied_date,final_date,exp_date,issued_date,created_date,updated_date,valuation_calculated,amount,paid,balance,project_id,latitude,longitude,people";
	 	 url += "&_filters="+$('#sfq').val();  url += "&_dt="+dt; url += "&_price="+pr; url += "&_sort="+$('#_sort').val();  url += "&_view="+$('#view').val(); url += "&_url=<%=solrurl%>&bookmarkid=<%=bookmarkId%>";
	 	var n = url.replaceAll("\"","%22");
	 	$(' <a title="csv download" id="exportcsv"  href="'+n+'" >Friendly description</a>').fancybox({
 			'width'				: '75%',
			'height'			: '75%',
			'autoScale'			: false,
			'transitionIn'		: 'none',
			'transitionOut'		: 'none',
			'type'				: 'iframe'
    	}).click();
		 	
	}

	function show_more(t){
		// alert(t);
		//$("#"+t).show();
		$(".extra_facet_"+t).toggle();
	}
	
	
	
	
	
	
	function doSearch(facets,fq,filters){
		
		var st = $('#startresult').val();
		var rows = $('#endresult').val();
		
		
		
		if($('#facetdates').val()=="Y"){
			dt = dodates();
			pr = doprice();
		}
		
		//alert($('#facetvalues').val());
		
		var _sort = $('#_sort').val();
		var view = $('#view').val();
		
		$.ajax({
			  type: "GET",
			
			  url: "actionsearch.jsp",
			  dataType: 'json',		  
			  data: { 
				 q : $('#sq').val(),
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
				 _facetvalues : $('#facetvalues').val(),
				 _customdt: $('#_customdt').val(),
				 _userId:<%=userid%>,
				 specific:"<%=specific%>",
				 _bookmark:$('#bookmark').val(),
				 _bookmarktitle:$('#bookmarktitle').val(),
				 _location : "search",
				 fl:"act_id,projectname,project_id,parking_account_no,title,lso_type,apn,lso_id,latitude,longitude,description,start_date,act_nbr,id,address,applied_date,final_date,issued_date,exp_date,created_date,updated_date,_text_,valuation_calculated,type,status",
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
				       //jQuery(this).children('.childshow').toggle();
				       //$(".extra_facet_"+idk+"").toggle();
				    });
			        
			        $(".childshowd").click(function (e) {
				        e.stopPropagation();
				        var idk = $(this).attr("id");
				       
				        //$('#h_'+idk).toggle();
				       jQuery(this).children('.childshowd').toggle();
				       //$(".extra_facet_"+idk+"").toggle();
				    });
			        
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
			        		// $(td).addClass("rowhighlight");
						    // compare id to what you want
						});
			        	 
			        }, function() {
			        	$(this).find('td').each (function( column, td) {
			        		 $(td).css({ 'color': '#000000','background-color': '#ffffff' });
			        		 var a_href = $(td).find('a');
			        		 $(a_href).css({ 'color': '#000000','background-color': '#ffffff' });
						    // compare id to what you want
						});
						});
			        
			     },
			    success: function(output) {
			    	
			    		displayresults(output);
			    		displayfacets(output);
			    	
			    	$('#facetdates').val("Y");
			    	
			    	if($('#bookmark').val()=="Y"){
			    		$('#bookmark').val("N");
			    		$('#bookmarkhtml').html("");$('#bookmarkhtml').hide();
			    		$('#bookmarktitle').val("");
			    		$('#bookmarkmsg').slideUp(300).delay(200).fadeIn(400).hide(800);
			    	}
			    	doSpellcheck();
			    	viewbookmarks();
			    	//trends(facets,fq,filters);
			    },
		    error: function(data) {
		        swal('Your request was not processed. Please check your input data.');
		    }
		});
	}
	
	
	function trends(facets,fq,filters){
		
		if($('#facetdates').val()=="Y"){
			dt = dodates();
			pr = doprice();
		}
		
		$.ajax({
			  type: "GET",
			  url: "actionsearch.jsp?method=trends",
			  dataType: 'json',		  
			  data: { 
				 q : $('#sq').val(),
				 start: 0,
				 rows: 0,
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
				 _facetvalues : $('#facetvalues').val(),
				 _customdt: $('#_customdt').val(),
				 _userId:<%=userid%>,
				 specific:"<%=specific%>",
				 _location : "search",
				 _url:"<%=solrurl%>"
			    },
			    success: function(output) {
			    	
			    	
			    	updatetrends(output);	
			    		
			    },
		    error: function(data) {
		        swal('Your request was not processed. Please check your input data.');
		    }
		});
	
	
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

	function doSpellcheck(){
		
		$.ajax({
			  type: "GET",
			
			  url: "actionsearch.jsp?method=spell",
			  dataType: 'json',		  
			  data: { 
				 q : q,
				 indent : "on",
				 wt : "json",
				 _url:"<%=solrurl%>"
			    },
			    success: function(output) {
			    	//console.log(output);	
			    	displayspell(output,q);
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
		$('input:checkbox.inspresults').prop('checked', false);
		$('input:checkbox#selectorall').prop('checked', false);
		
		var chkIds = $("input:checkbox:checked").map(function(){
	    	
			return $(this).val();
	    }).toArray();
		
		
		 $('#startresult').val(0);
		
		 $('.selector').pagination('drawPage',1);
			
		 
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
	
 		var u = "<%=Config.fullcontexturl() %>/?entity=lso&type=activity&_typeid=";
 		var ul = "<%=Config.fullcontexturl() %>/summary.jsp?_ent=lso&_type=activity&_typeid=";
 		var ull = "<%=Config.fullcontexturl() %>/summary.jsp?_ent=lso&_type=lso&_typeid=";
 		var fll = "<%=Config.fullcontexturl() %>/fees.jsp?_ent=lso&_type=activity&_grpid=0&_grp=finance&_grptype=finance&_act=edit&_typeid=";
 		var pl = "<%=Config.fullcontexturl() %>/summary.jsp?_ent=lso&_type=project&_typeid=";
 		var al = "<%=Config.fullcontexturl() %>/activity.jsp?_id=&_entid=0&_ent=lso&_type=activity&_grpid=activity&_grp=ACTIVITY&_grptype=activity&_typeid=";
 		var t = $('#startresult').val();
 		
 		var gisadlinku = "<%=Config.fullcontexturl() %>/map.jsp?_ent=lso&_entid=-1&_type=lso&_grptype=map&_act=view&_typeid=";
 		
		
 		if($('#view').val()=="viewrow"){
 		var high = output['highlighting'];
 		
 		
 		
 		$.each(high, function(k,v) {
 			
 			
 			var l = ul + k;
 			t++;
 			if(v.id!=''){
					var tx = "";
					if(v._text_==undefined){ tx ="";} else {tx=v._text_; }
 				
					c+= '<tr class="csuisub"  style="cursor:pointer;" >';
					c += '<td class="csuisub" type="String" itype="String"><a class="csui" href="'+l+'" target="_top" ><p>'+k+' <br>';
					if(v._text_==undefined){ description ="";} else {description=v.description; }
					c += ''+tx+'</a></td>';
					c += '</tr>';
				
			}	
 		});
 		}else {
 			var lsos = "";
	 		$.each(resp['docs'], function(k,v) {
	 			
	 			var golink = u + v.id;
	 			var l = ul + v.id;
	 			var lsolink = ull + v.lso_id;
	 			var financelink = fll + v.id;
	 			var projectlink = pl + v.project_id;
	 			var editlink = al + v.id;
	 			var gisadlink = gisadlinku + v.lso_id;
	 			t++;
	 			
	 			if(v.id!=''){
	 				
	 					var title ="" ;
	 					var type="";
	 					var status="";
	 					var address="";
	 					var apn ="";
	 					var description="";
	 					var updated ="";
	 					var projectdesc ="" ;
	 					//if(v.updated_date==undefined){ updated ="";}
	 					if(v.description==undefined){ description ="";} else {description=v.description; }
	 					if(v.longitude==undefined){ lon ="";} else {lon=v.longitude; }
	 					if(v.latitude==undefined){ lat ="";} else {lat=v.latitude; 	var latlon ='{ "lat":'+parseFloat(lat)+',"lng":'+parseFloat(lon)+' }'; 	latlong.push(latlon); }
	 					
	 					
	 					if(v.lso_id==undefined){ } else {lsos +=v.lso_id +","; }
	 					if(v.type==undefined){ type ="";} else {type=v.type; }
	 					if(v.status==status){ status ="";} else {status=v.status; }
	 					if(v.address==undefined){ address ="";} else {address=v.address; }
	 					if(v.apn==undefined){ apn ="";} else {apn=v.apn; }
	 					if(v.projectname==undefined){ projectdesc ="";} else {projectdesc=v.projectname; }
	 					if(v.parking_account_no==undefined){ } else { projectdesc += ' - '+v.parking_account_no;  }
	 					//var parking_account_no ="" ;
	 					//if(v.parking_account_no==undefined){ parking_account_no ="";} else {parking_account_no=v.parking_account_no; }
	 				
	 						title =v.act_nbr ;
		 					type=type;
		 					status=status;
		 					address=address;
		 					apn =apn;
		 					description=description;
		 					
		 					var d = new Date(v.updated_date);
		 					
		 					updated = (d.getMonth() + 1) + '/' + d.getDate() + '/' +  d.getFullYear();
	 					
	 				
	 				
						c+= '<tr class="csuisub" id="list'+v.order+'" style="cursor:pointer; " >';
						//c += '<td class="csuisub" type="String" itype="String"><a class="csui" href="'+l+'" >'+t+'</a></td>';
						
						c += '<td class="csui" type="String" itype="String"><input type="checkbox" name="ID"  class="inspresults" value="'+v.id+'" act_id="'+v.act_id+'"  /> </td>';
						c += '<td class="csui" type="String" itype="String"><a title="Show Project" class="csui " href="'+projectlink+'" target="lightbox-iframe" >'+projectdesc+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Activity"  class="csui" href="'+l+'" target="lightbox-iframe" >'+title+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Activity" class="csui" href="'+l+'" target="lightbox-iframe"  >'+type+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Edit Activity" class="csui" href="'+editlink+'" target="lightbox-iframe"  >'+status+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Address" class="csui" href="'+lsolink+'" target="lightbox-iframe"  >'+address+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Map" class="csui" href="'+gisadlink+'" target="lightbox-iframe"  >'+apn+'</a></td>';
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Activity" class="csui" href="'+l+'" target="lightbox-iframe"  >'+description+'</a></td>';
				 		
				 		
				 		c += '<td class="csui" type="String" itype="String"><a title="Show Finance" class="csui" href="'+financelink+'" target="lightbox-iframe"  >';
				 		if(v.valuation_calculated>0){
				 			c += '$'+v.valuation_calculated.formatMoney(2, '.', ',')+'';
				 		}else {
				 			c +='$0.00';
				 		}
				 		c += '</a></td>';
				 		c += '<td class="csui" type="String" itype="String"> <a  href="history.jsp?_ent=lso&_entid=-1&_type=activity&_typeid='+v.act_id+'&_grptype=history&_act=add&banner=N" title="Show History" target="lightbox-iframe" class="csui"  >'+updated+'</a></td>';
				 		
				 		c += '<td class="csui" type="String" itype="String"><a title="Go to Activity"  class="csui" href="'+golink+'" target="_top"  ><img src="/cs/images/icons/controls/black/go.png" border="0"></a>  </td>';

				 		c += '</tr>';
					
				}	
	 		});
	 		$('#lsos').val(lsos);
	 		
	 		if($('#cbhgis3').val()=="Y"){
		 	
		 		var str = $('#lsos').val();
				str = str.substring(0, str.length - 1);
				var u = "<%=gislink%>?Q="+str;
				//alert(u);
				//console.log(u);
				var iframe = document.getElementById('ggui');
				iframe.src = u;
				$('#ggui2').attr("href",u);
	 		}
 		}
 		if($('#view').val()=="viewrow"){
 			$("#resultsaddviewrow").html(c);
 		}else {
 			$("#resultsadd").html(c);
 			
 			var g = latlong+"";
 			
 	 		
 	 		g = g.replace(/"{"/g, "{");
 	 		g = g.replace(/}"/g, "}");
 	 		g = "["+g+"]";
 	 		
 	
 			
 			//loadMap(g);
 		}
 		
 		
 		
	}
	
	
	function displayspell(output,q){
	output = JSON.stringify(output);
		//console.log(output);
 	output = JSON.parse(output);
 		try{
	 		 var resp = output['spellcheck'];
	 		
	 		
	 		var correct = resp['correctlySpelled'];
	 		var collations = resp['collations'];
	 		
	 		
	 
	 		var h = '';
	 		
	 		$.each(collations, function(k,v) {
	 	 		h +=  'Did you mean <a href="search.jsp?sq='+v.collationQuery+'" target="_self">'+v.collationQuery+'</a> which has '+v.hits+' results </br>';
	 		});
	 		
	 		if(h!=''){
	 			$('#spelling').html(h);
	 		}
 		}catch(Exception){}
 			
	}
	
	
	function showui(obj){
	
		
		$('.fitem').css({
			height: '100%',
			overflow: 'auto !important'
		});
	}
	
	function displayfacets(output){
		
 		var f = output['facets'];

 		var _type = '';
 		var _r = '';
 		var rfinal = '';
 	
 		$.each(f, function(k,v) {
 	 		var c = '';
 			if(k!="count" && k!="divisions"){
	 			//c +='<tr> 	<td class="csuisub_title">'+k+'</td>	</tr>';
	 			//c +='<tr> <td> <table> '
//	 			c +='<div  class="fitems"> <label for="ch" rel="'+k+'" class="shls"> Show more</label>'
	 			c += '<div id="'+k+'" class="childshow csuisub_title"  style="cursor:pointer;" title="Show/Hide" >'+k+' ';
 				var ft =  f[k];
	 			var g = 0;
	 			var ext = false;
	 			c += '<div id="h_'+k+'" class="childshow"> ';
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
//	 			c +='</div> ';
	 			c +='<div class="csui_divider"></div>';
 			}
 			
 			if(k=="divisions"){
 				c += '<div id="'+k+'" class="childshowd csuisub_title" style="cursor:pointer;" title="Show/Hide" >'+k+' ';
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
 					//	c += '<div id="h_'+p+'" class="childshow"> ';
 	 					 c += '<div id="'+k+'" class="childshowd cssearch_facets" style="cursor:pointer;" title="Show/Hide" >'+p+'';
						 
 						 for(var i=0;i<arr.length;i++){
 							 var mlv = arr[i];
 							
 							 if(mlv.startsWith(p)){
 								 var spl = mlv.replace(p,"");
 								
 								var ot =  spl.split("|")
 								var org = mlv.split("|");
 			 					c +=' <div id="c" class="childshowd cssearch_facets" style="display:none"><input type="checkbox" class="'+k+'" name="'+org[0]+'" id=\"'+k+'_'+org[0]+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+org[0]+'\" > '+ot[0]+' ('+ot[1]+')	</div>';
 								
 							 }
 						 }
 						c += '</div>';
 						//c += '</div>';
 					 }
 				 } 
 				
 				c += '</div>';   
 				c +='<div class="csui_divider"></div>';
 				
 			}
			if (k=='department') {
				_type += c;
			}
			else {
				_r += c;
			}
 		});
		rfinal = _type + _r;
 		
 		$("#filtershtml").html(rfinal);
 		//$('.extra_facet').hide();
 		 extra_hide();
 		var chk = $('#facetvalues').val();
 		//alert(chk);
 		if(chk!=''){
 			chk= chk.replace(/\|/g, '_');
 			var ch = chk.split(",")
 			for(var i=0;i<ch.length;i++){
 				$("[id='"+ch[i]+"']").prop("checked",true);
 				//console.log(ch[i]+"sunil"+$("[id='"+ch[i]+"']").parent.html());
 			}
 		} 
 		
 		showchart(output);
 		
 		
 		
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
	
	function grouping(){
		 var arr =[];
		 arr[0] = "ALLEYXXNO (RDD)";
		 arr[1] = "RZONEXXNone";
		 arr[2] = "RZONEXXR1";
		 arr[3] = "ALLEYXXYES";
		 var hs = "";
		 console.log(arr.length);
		 for(var i=0;i<arr.length;i++){
			 var spl = arr[i].split("XX");
			 if (hs.indexOf(spl[0]) < 0){
				 hs += spl[0]+",";
			 }
			
		 }
		 console.log("FINAL HS"+hs);
		 var res = hs.split(",");
		 console.log(res.length+"****************");
		 for(var n=0;n<res.length;n++){
			 var p = res[n];
			 if(p!=''){
				 console.log(p+"****************");
				 for(var i=0;i<arr.length;i++){
					 var mlv = arr[i];
					 //console.log("-->>>"+mlv);
					 if(mlv.startsWith(p)){
						 var spl = mlv.replace(p+"XX","");
						 console.log("-->"+spl);
					 }
				 }
			 }
		 }
		//console.log(hs);
	}
	
	function docustomdateshandler(){
		var h = "";
		$(".docustomdates").each(function (e) {
	      	
		  	var id = $(this).attr("id");
		  	var v = $(this).val();
		  
			if(v!=""){			  
			  	if(v =="custom"){
			  		//$("#custom_"+id).show();
			  	}else {
			  		h += id+"-"+v+",";
			  	}
			}
		  	
	    });
		
		$('#_customdt').val(h);
		faceting();
	}
	
	function viewbookmarks(){
		
		if($('#bookmarkId').val()>0){
		$.ajax({
			  type: "GET",
			  url: "actionsearch.jsp?method=viewbookmark",
			  dataType: 'json',		  
			  data: { 
				  bookmarkId : <%=bookmarkId%>,
				 _url:"<%=solrurl%>"
			    },
			    success: function(output) {
			    	output = JSON.stringify(output);
			 		output = JSON.parse(output);	
			 		
			 		$('#bookmarkhtml').html("Bookmark : "+output._BTITLE);
			 		$('#bookmarkhtml').slideUp(300).delay(200).fadeIn(400);
			 		
			 		$('#_customdt').val(output._customdt);
			 		$('#sq').val(output.q);
			 		var chk = output._facetvalues;
			 		if(chk!=''){
			 			chk= chk.replace(/\|/g, '_');
			 			var ch = chk.split(",")
			 			for(var i=0;i<ch.length;i++){
			 				$("[id='"+ch[i]+"']").prop("checked",true);
			 				
			 			}
			 		} 
			 		var customdt = output._customdt.split(",");
			 		for(var i=0;i<customdt.length;i++){
			 			var cd = customdt[i].split("-")
			 			$('#'+cd[0]).val(cd[1]);
			 			$('#'+cd[0]).trigger('chosen:updated');
			 		}
			 		
			 		var customrdt = output._dt;
			 		replacer(customrdt);
			 		var custompr = output._price;
			 		replacer(custompr);
			 		
			 		$('#bookmarkId').val(0);
			 		faceting();
			 		
			    	
			    },
		    error: function(data) {
		        swal('Your request was not processed. Please check your input data.');
		    }
		});
		}
	}
	
	function replacer(option){
		var customrdt = option.split("&");
		for(var i=0;i<customrdt.length;i++){
 			var cd = customrdt[i];
 				cd = cd.replace("T00:00:00Z","");
 				cd = cd.replace("T23:59:59.999Z","");
 				cd = cd.replace("[","");
 				cd = cd.replace("]","");
 				cd = cd.replace("%20","");
 				cd = cd.replace("%20","");
 			var	cdd = cd.split(":");
 			
 			if(cd!=''){
	 			var ids = cdd[0];
	 			var vss = cdd[1];
	 				vss = vss.replace("TO","|");
	 			var vs = vss.split("|");
	 			
	 			var st = "";
	 			if(vs[0]!=undefined){ st = vs[0]; st = st.replace("*",""); }
	 			var ed = "";
	 			if(vs[1]!=undefined){ ed = vs[1]; ed = ed.replace("*",""); 	}
	 		
	 			$('#'+ids+"_st").val(st);
	 			$('#'+ids+"_ed").val(ed);
	 			$('#'+ids).val("custom");
	 			$('#'+ids).trigger('chosen:updated');
	 			$('#custom_'+ids).show();
 			}
 		}
	}
	
	
	
	function addbookmark(){
		var c = "";
		swal({  
			title: "Do you want to create this bookmark ?",   
			text: "Enter Bookmark Title",   
			type: "input",   
			showCancelButton: true,   
			confirmButtonColor: "#DD6B55",   
			
			cancelButtonText: "No, cancel plx!",   
			animation: "slide-from-top",
			closeOnConfirm: true,   
			inputValue: ""
		}, 
		function(inputValue){
			  if (inputValue == false) return false;
			  if (inputValue == "") {
                  swal("You need to write something!");
                  return false;
                }
			
				$('#bookmark').val("Y");
				$('#bookmarktitle').val(inputValue);
				faceting();
			
			
			
			
		
		});
		
		
	}
	
	function viewgis(){
		var str = $('#lsos').val();
		str = str.substring(0, str.length - 1);
		var u = "<%=gislink%>?Q="+str;
		//alert(u);
		//console.log(u);
		var iframe = document.getElementById('ggui');
		iframe.src = u;
		$('#ggui2').attr("href",u);
		//window.open(u,"_blank");
		//('#ggui').attr('src',u);
		
		 
	}
	
	function printall(){
		 var v = $('input:checkbox.inspresults:checked').map(function() {    return $(this).attr('act_id'); }).get();
			if(v==""){
				swal("Select activities in order to proceed");
				return false;
			}
			
			//alert(v);

		$(' <a title="Config Route" id="addroute"  href="<%=Config.fullcontexturl() %>/printall.jsp?_ent=lso&_entid=-1&_type=templatetype&_typeid=3&_grp=activity&_grptype=print&_act=print&chk='+v+'" >Friendly description</a>').fancybox({
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
       height:700px;
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

.chartwrapper {
  width: 100%;
   height: 100%;
  position: relative;
  padding-bottom: 10%;
  box-sizing: border-box;
  overflow: scroll;
}

 #chartdivpie1  {
 font-size: 11px;
 width : 100%;
 height: 700px;
 overflow: scroll;
  
}


 #chartdivpie2  {
  width: 100%;
  height: 900px;
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

#trenddiv1 {
  width	: 100%;
  height	: 500px;
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
#map {
   position:inherit;
}



	
      
    </style>
		  <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
    <script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7xtGshY7YvvmMXrxKJ9CGzgW_2ezyrLs"></script>
	<script>
	function initMap(){
		var  map =  new google.maps.Map(document.getElementById('map'), {
	        zoom: 13,
	        center: {lat: 34.08665, lng: -118.446795}
	      });
	}
	
	 function loadMap(loc) {
		
			console.log(loc);
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
	 
	 
	 function recenter(){
			var latnlg = new google.maps.LatLng(34.08665, -118.446795);
			map.setCenter(latnlg);
			
			
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
	<input type="hidden" id="_sort" name="_sort" value="updated_date%20desc">
	<input type="hidden" id="view" name="view" value="def">
	<input type="hidden" id="showm" name="showm" value="">
	
	<input type="hidden" id="bookmark" name="bookmark" value="N">
	<input type="hidden" id="bookmarktitle" name="bookmarktitle" value="">
	<input type="hidden" id="_customdt" name="_customdt" value="">
	<input type="hidden" id="sq" name="sq" value='<%=q%>'>
	<input type="hidden" id="bookmarkId" name="bookmarkId" value="<%=bookmarkId%>">
	<input type="hidden" id="lsos" name="lsos" value="">
	<input type="hidden" id="cbhgis3" name="cbhgis3" value="N">
	</form>




	

	<div id="csuibody">
		<div id="csuisub">
				<div class="csuisub_divider"></div>
				<div class="csuisubcontent" style="padding-left:30px;padding-right:30px">
				
				<table cellpadding="5" cellspacing="2" width="100%">
				
				
					<tr>
						<td colspan="2" class="csuisub_title">DISPLAY TYPE</td>
					</tr>
					<tr>
						<td class="csui" colnum="2" type="String" itype="String" alert="">
							<select  class="chosen" id="display_type" name="display_type" itype="String" val="" _ent="lso" valrequired="false" style="width:95%">
								<option value="search.jsp?sq=<%=q%>&specific=<%=specific%>" selected="selected">ACTIVITY</option>
								<option value="searchlso.jsp?sq=<%=q%>">ADDRESS</option>	
								<option value="searchreview.jsp?sq=<%=q%>">REVIEW</option>	
								<option value="searchattachments.jsp?sq=<%=q%>">ATTACHMENTS</option>	
								<option value="searchfinance.jsp?sq=<%=q%>">FINANCE</option>	
								<option value="searchledger.jsp?sq=<%=q%>">LEDGER</option>	
																
							</select>
						</td>
						
					</tr> 
				</table>
				
				<table cellpadding="5" cellspacing="2" width="100%">
				
				
				
					
					
					<tr>
						<td colspan="2" class="csuisub_title">START DATE</td>
					</tr>
					<tr>
						<td colspan="2">
							<select name="start_date" id="start_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
					
					<tr id="custom_start_date" style="display:none;">
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="start_date_st" name="start_date_st" value="" ftype="start_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="start_date_ed" name="start_date_ed" value="" ftype="start_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
					<tr>
						<td colspan="2" class="csuisub_title">APPLIED DATE</td>
					</tr>
					<tr>
						<td colspan="2">
							<select name="applied_date" id="applied_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
					
					<tr id="custom_applied_date" style="display:none;">
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="applied_date_st" name="applied_date_st" value="" ftype="applied_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="applied_date_ed" name="applied_date_ed" value="" ftype="applied_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
					<tr>
						<td colspan="2" class="csuisub_title">ISSUED DATE</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<select name="issued_date" id="issued_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
						<tr id="custom_issued_date" style="display:none;">
						<td width="50%" class="cssearch_date"><input type="text" itype="date" class="cssearch" id="issued_date_st" name="issued_date_st" value="" ftype="issued_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" itype="date" class="cssearch" id="issued_date_ed" name="issued_date_ed" value="" ftype="issued_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
					
					
					<tr>
						<td colspan="2" class="csuisub_title">EXPIRATION DATE</td>
					</tr>
					<tr>
						<td colspan="2">
							<select name="exp_date" id="exp_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
					<tr id="custom_exp_date" style="display:none;">
					
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="exp_date_st" name="exp_date_st" value="" ftype="exp_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="exp_date_ed" name="exp_date_ed" value="" ftype="exp_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
					
					<tr>
						<td colspan="2" class="csuisub_title">FINAL DATE</td>
					</tr>
					<tr>
						<td colspan="2">
							<select name="final_date" id="final_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
					<tr id="custom_final_date" style="display:none;">
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="final_date_st" name="final_date_st" value="" ftype="final_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="final_date_ed" name="final_date_ed" value="" ftype="final_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
				</table>

				<table cellpadding="5" cellspacing="2" width="100%">
					<tr>
						<td colspan="2" class="csuisub_title csuialert">VALUATION</td>
					</tr>
					<tr>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency" id="valuation_calculated_st" name="valuation_calculated_st" value="" ftype="valuation_calculated" placeholder="0.00"> </td>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency" id="valuation_calculated_ed" name="valuation_calculated_ed" value="" ftype="valuation_calculated" placeholder="">	</td>
					</tr> 
				</table>

				<div class="csui_divider"></div>

				<div class="csuisub_title" id="filtershtml">
				</div>

				<table cellpadding="5" cellspacing="2" width="100%">
					<tr>
						<td colspan="2"  class="csuisub_title">FEE AMOUNT </td>
					</tr>
					<tr>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency"  id="amount_st" name="amount_st" value="" ftype="amount" placeholder="0.00"> </td>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency" id="amount_ed" name="amount_ed" value="" ftype="amount" placeholder="0.00">	</td>
					</tr> 
					
					<tr>
						<td colspan="2"  class="csuisub_title">PAID AMOUNT </td>
					</tr>
					<tr>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency"  id="paid_st" name="paid_st" value="" ftype="paid" placeholder="0.00"> </td>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency" id="paid_ed" name="paid_ed" value="" ftype="paid" placeholder="0.00">	</td>
					</tr> 
					<tr>
						<td colspan="2" class="csuisub_title">BALANCE DUE </td>
					</tr>
					<tr>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency"  id="balance_st" name="balance_st" value="" ftype="balance" placeholder="0.00"> </td>
						<td width="50%" class="cssearch_currency"><input type="text" class="cssearch" itype="currency" id="balance_ed" name="balance_ed" value="" ftype="balance" placeholder="0.00">	</td>
					</tr> 
					
					<tr>
						<td colspan="2" class="csuisub_title"> UPDATED</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<select name="updated_date" id="updated_date" class="chosen docustomdates">
							
							</select>
						</td>
					</tr>
					<tr id="custom_updated_date" style="display:none;">
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="updated_date_st" name="updated_date_st" value="" ftype="updated_date" placeholder="start" ad="T00:00:00Z" > </td>
						<td width="50%" class="cssearch_date"><input type="text" class="cssearch" itype="date" id="updated_date_ed" name="updated_date_ed" value="" ftype="updated_date" placeholder="end" ad="T23:59:59.999Z">	</td>
					</tr> 
					
					
					
					
				</table>
				<table class="csuisub sortable" type="horizontal" id="itemsadd" >
					
					
				</table>
				
				
				</div>
				<div class="csuisub_divider"></div>
				<div class="csui_divider"></div>
		</div>
		
		<div id="csuimain">
		<div id="loader"></div>
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
										<a href="javascript:void(0);" title="View row" border="0" id="viewrow" title="View List"><img src="/cs/images/icons/glsearch/list.png" border="0"></a>
									</td>
								 	<td class="csui_tools">
										<a href="javascript:void(0);" title="Charts" border="0"  id="charts" title="View Chart"><img src="/cs/images/icons/glsearch/chart.png" border="0"></a>
									</td>
									<!-- 
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  id="cbhgis" title="View Gis"  ><img src="/cs/images/icons/glsearch/map.png" border="0"></a>
									</td>
									
									
									<td class="csui_tools">
										<a href="javascript:void(0);" title="View GIS" border="0" id="gis" title="View Map"><img src="/cs/images/icons/glsearch/map.png" border="0"></a>
									</td>
									
									 
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  id="trends"  title="Trends"><img src="/cs/images/icons/controls/black/statistics.png" border="0"></a>
									</td>
									 -->
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  onclick="printall();"  ><img src="/cs/images/icons/controls/black/print.png" border="0"></a>
									</td>
									
								
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  onclick="openexport();" title="Download"><img src="/cs/images/icons/controls/black/csv.png" border="0"></a>
									</td>
									
									<td class="csui_tools">
										<a href="javascript:void(0);" border="0"  onclick="addbookmark();" title="Add Bookmark"><img src="/cs/images/icons/controls/black/bookmark.png" border="0"></a>
									</td>
									
								</tr>
						   </table>
					   </td>
					</tr>
					
				</table>

				
					
						<div class="csui_divider"></div>
						<div class="mapadd" >
								<div class="selector" style="align: right; "></div>
								 <div id="map"></div>
								
								
							</div>
						<div id="bookmarkmsg"  style="display:none;background-color:#7caf81;padding: 2px; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 18px; font-weight: 700; text-transform: uppercase; vertical-align: top; color: #ffffff" > Bookmark saved successfully</div>
						<div id="bookmarkhtml"  style="display:none;background-color:#7aa2e2;adding: 2px; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 18px; font-weight: 700; text-transform: uppercase; vertical-align: top; color: #ffffff" > </div>
								
						<div id="spelling" class="cssearch_facets" ></div>
						
						<div  id="cbhgis2" style="display:none;">
							<iframe width="100%" height="500" src="" id="ggui"></iframe>
							<div  align="right">
								<a href="" target="_blank" id="ggui2" class="csuisub_title">GIS FULL SCREEN </a>
							</div>
						</div>
							
						<table class="csui" type="horizontal">
								<tr>
									<td class="csui_title csuialert" id="headmsg"> </td>
									<td class="csui_title" colnum="2" type="String" itype="String" alert="" >
										<select  class="chosen" id="display_set" name="display_set" itype="String" val="" _ent="lso" valrequired="false" title="Views Per Page" >
											<option value="50">50 &nbsp;&nbsp;&nbsp;&nbsp;</option>
											<option value="100">100 &nbsp;&nbsp;&nbsp;&nbsp;</option>	
											<option value="150">150 &nbsp;&nbsp;&nbsp;&nbsp;</option>	
											<option value="200">200 &nbsp;&nbsp;&nbsp;&nbsp;</option>	
										</select>
									</td>
								</tr>
								
						</table>
						
						<table class="csui" type="horizontal" id="tablesort">
							<thead>
						 		<tr>
						 			<td class="csui_header" type="String" itype="String"><input type="checkbox" name="selectorall" id="selectorall" class="selectorall"></td>
						 			<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="projectname" sorttype="asc" >PROJECT</td>
						 			
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="title" sorttype="asc" >ACTIVITY NUMBER </td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="type" sorttype="asc" >TYPE</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="status" sorttype="asc" >STATUS</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="address" sorttype="asc" >ADDRESS</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="apn" sorttype="asc" >APN</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="description" sorttype="asc" >DESC</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="valuation_calculated" sorttype="asc" >VALUATION</td>
							 		<td class="csui_header sort" type="String" itype="String" title="Sort" style="cursor:pointer;" sort="updated_date" sorttype="asc" >UPDATED</td>
							 		<td class="csui_header" type="String" itype="String">&nbsp;</td>
						 		</tr>
 							</thead>
 							<tbody id="resultsadd"> </tbody>
						</table>	
						
						
						
						
						<table class="csui" type="horizontal" id="tablerow">
							<tbody id="resultsaddviewrow"> </tbody>
						</table>	
						
						<div class="csui_divider"></div>
						<div class="selector" style="align: right; "></div>
						
						
						<table id="tablechart" width="100%">
						
						<tr>
							<td>
								
								<div class="chartwrapper">
								<div id="chartdivpie1"  ></div>
								</div>
								<div id="legenddivpie1" style="border: 2px dotted #3f3; margin: 5px 0 20px 0;position: relative;"></div>
								
							</td>
							
						</tr>
						<tr>
							<td>
								<div id="chartdivpie2" ></div>
								<div id="legenddivpie2" style="border: 2px dotted #3f3; margin: 5px 0 20px 0;position: relative;"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="chartdivpie3" ></div>
								<div id="legenddivpie3" style="border: 2px dotted #3f3; margin: 5px 0 20px 0;position: relative;"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="chartdivpie4" ></div>
								<div id="legenddivpie4" style="border: 2px dotted #3f3; margin: 5px 0 20px 0;position: relative;"></div>
							</td>
						</tr>
						
						<tr>
							<td>
							<div id="chartdiv2" ></div>
							</td>
							
						</tr>
						
						
						</table>
						
						
						<table id="tabletrends" width="100%">
						
						
						<tr>
							<td>
								<div id="trenddiv1" ></div>
							</td>
						</tr>
						
						
						
					 	</table>
					
			
			</div>
			
			
			
		</div>
		
	</div>


</br><br/>

</body>

</html>