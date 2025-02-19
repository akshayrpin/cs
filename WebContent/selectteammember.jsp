<!-- @author: sunil vijayakumar sunvoyage -->
<%@page import="cs.ui.CsUiTools"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="org.json.JSONArray"%>
<%@page import="cs.address.AddressTest"%>
<%@page import="org.json.JSONObject"%>
<%@page import="alain.core.utils.Cartographer"%>
<%@include file="search/gsteamfacet.jsp"%>

<% 

Cartographer map = new Cartographer(request,response,true);
String fieldid = map.getString("fieldid");
String entity = map.getString(RequestMapper.entity);
int entityid = map.getInt(RequestMapper.entityid);
String type = map.getString(RequestMapper.type);
int typeid = map.getInt(RequestMapper.typeid);
String grp = map.getString(RequestMapper.group);
String grpid = map.getString(RequestMapper.groupid);
String grptype = map.getString(RequestMapper.grouptype);
RequestVO req = RequestMapper.getRequest(map);


SubObjVO[] res = new SubObjVO[0];
/* if (map.hasValue("q")) {
	RequestVO sreq = new RequestVO();
	sreq.setEntity(entity);
	sreq.setEntityid(entityid);
	sreq.setType(type);
	sreq.setTypeid(typeid);
	sreq.setGrouptype(grptype);
	sreq.setRequest("search");
	sreq.setSearch(map.getString("q"));
	sreq.setOption(map.getString("t"));

	res = ApiHandler.searchPeople(sreq);
} */
int l = res.length;


String solrurl = CsConfig.getString("search.team");

String q = map.getString("sq");
String query = q;
q = Operator.toText(q);
//System.out.println(solrurl+""+q);

String imgsrc = Config.rooturl() +""+ CsConfig.getImage("black", "add");
String imgsrcdel = Config.rooturl() +""+ CsConfig.getImage("black", "delete");

//System.out.println(imgsrc);
%>

<!DOCTYPE html>
<html>
<head>
<title>City Smart- V1</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
		
		<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/simplepagination/jquery.simplePagination.js"></script>
		<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
	
	
<!-- 	<script type="text/javascript" src="/search/search.js"></script> -->
<style>

</style>
	
	<script language="JavaScript">
	var q = "<%=query%>";
	var facets = "<%=facets%>";
	
	var facetvalues = new Array();
	var dt = "";
	var pr = "";
	//alert(facets);
	var stored_selected =[];
	
	
	$(document).ready(function() {
		
		$('#loader').hide();
		$('#csuisub').hide();
		$('#cssearch_results').hide();
		$('#sq').focus();
		
		$('#peoplesubmit').submit(function(e) {
	    	e.preventDefault();
	    	var nchoice = $('#PEOPLE').val();
	    	try { parent.addTeam(nchoice, '<%=fieldid%>'); } catch(e) { }
			try { parent.$.fancybox.close(); } catch(e) { }
		});

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
		
		 $('#peoplesearch').submit(function(e) {
		    	e.preventDefault();
		    	doSearch(facets,"","");
		}); 
		
		$('input[itype="date"]').keypress(function(e) {
		    if(e.which == 13) {
		    	if($(this).val()!=""){
			    	$('#startresult').val(0);
					$('.selector').pagination('drawPage', 1);
					faceting();
		    	}
		    }
		});
		
		$('input[itype="currency"]').keypress(function(e) {
		    if(e.which == 13) {
		    	if($(this).val()!=""){
			    	$('#startresult').val(0);
					$('.selector').pagination('drawPage', 1);
					faceting();
		    	}
		    }
		});
	
		 $('.mapadd').hide();
		 $("#gis").click(function(){
			    $(".mapadd").toggle();
		 });
		 
		 
		  $("#tablechart").hide();
		 $("#charts").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").hide();
			  $("#tablechart").show();
		 });
		 
		 $("#viewrow").click(function(){
			  $("#tablesort").hide();
			  $("#tablerow").show();
			  $("#tablechart").hide();
			  $("#view").val("viewrow");
			  doSearch(facets,$('#sffq').val(), $('#sfq').val());
		 });
		 
		
		 
		 $("#def").click(function(){
			  $("#tablesort").show();
			  $("#tablerow").hide();
			  $("#tablechart").hide();
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
	
		 
	});

	function selectPeople(pid) {
	 	var ht = $('#people_result_'+pid).html();
	 	var pname = $('#people_name_'+pid).html();
	 	var pemail = $('#people_email_'+pid).html();
	 	var pgroup = $('#people_group_'+pid).html();
	 	var paddress = $('#people_address_'+pid).html();
	 	var plic = $('#people_lic_'+pid).html();
	 	var ptype = $('#people_type_'+pid).html();
		var nchoice = pid+'::'+pname+'::'+ptype;

    	try { parent.addTeamMember(nchoice, '<%=fieldid%>'); } catch(e) { }
		try { parent.$.fancybox.close(); } catch(e) { }

	}

	function setPrimary(pid) {
		var currpri = $('#SET_PRIMARY_CONTACT');
		var allpri = $('span[primary]');
		allpri.attr('primary','false');
		allpri.html('Not Primary');
		if (hasValue(pid)) {
			var newpri = $('span[prival='+pid+']');
			newpri.attr('primary','true');
			newpri.html('Primary');
			currpri.val(pid);
		}
		else {
			currpri.val('');
		}
	}

	function unselectPeople(pid) {
	 	var tr = $('[selrel='+pid+']');
	 	removeChoice(pid);
		var currpri = $('#SET_PRIMARY_CONTACT');
		if (currpri.val() == pid) {
			setPrimary('');
		}
	 	tr.remove();
	 	$('#people_result_'+pid).show();
	}

	function addChoice(pid) {
	 	var pname = $('#people_name_'+pid).html();
	 	var ptype = $('#people_type_'+pid).html();
		var ppl = $('#PEOPLE');
		var pchoice = ppl.val();
		var nchoice = pchoice;
		if (hasValue(pchoice)) {
			nchoice += '|';
		}
		nchoice += pid+'::'+pname+'::'+ptype;
		ppl.val(nchoice);
	}

	function containsChoice(pid) {
		var ppl = $('#PEOPLE');
		var pchoice = ppl.val();
		var parray = pchoice.split('|');
		for (i = 0; i < parray.length; i++) { 
			var pvals = parray[i];
			var pvalarr = pvals.split('::');
			var pval = pvalarr[0];
			if (pval == pid) {
				return true;
			}
		}
		return false;
	}

	function removeChoice(pid) {
		var ppl = $('#PEOPLE');
		var pchoice = ppl.val();
		var parray = pchoice.split('|');
		var nchoice = '';
		var pbool = false;
		for (i = 0; i < parray.length; i++) { 
			var pvals = parray[i];
			var pvalarr = pvals.split('::');
			var pval = pvalarr[0];
			if (pval != pid) {
				if (pbool) { nchoice += '|'; }
				nchoice += pvals;
				pbool = true;
			}
		}
		if (nchoice == '') {
			$('#newselections').hide();
		}
		ppl.val(nchoice);
	}

	function openexport(){
		 var url = "actionsearch.jsp?method=csv&q=";
	 	 url += q;	 url += "&wt=csv"; url += "&defType=edismax"; url += "&mm=100"; url += "&_facet="+facets; url += "&start=0"; url += "&rows=100000"; 
	 	 url += "&_fq="+$('#sffq').val();
	 	 url += "&_filters="+$('#sfq').val();  url += "&_dt="+dt; url += "&_price="+pr; url += "&_sort="+$('#_sort').val();  url += "&_view="+$('#view').val(); url += "&_url="+"<%=solrurl%>"; 
	 var n = url;
	 window.open(n,"_blank");
		 	
		 } 
	function show_more(t){
		// alert(t);
		//$("#"+t).show();
		$(".extra_facet_"+t).toggle();
	}
	
	function doSearch(facets,fq,filters){
		
		var st = $('#startresult').val();
		var rows = $('#endresult').val();
		q = $('#sq').val();
		
		if($('#facetdates').val()=="Y"){
			dt = dodates();
			pr = doprice();
		}
		
		var imgsrc = "<%=imgsrcdel %>";
		
		var strd1 =  $("#store_selected").val();
		console.log("sub before search-->"+strd1);
		
		var _sort = $('#_sort').val();
		var view = $('#view').val();
		
		$.ajax({
			  type: "POST",
			
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
			        $("#store_selected").val(strd1);
			     },
			     complete: function(){
					$('#loader').hide();
					$('#store_selected').val(strd1);
					$(".childshow").click(function (e) {
						e.stopPropagation();
						var idk = $(this).attr("id");
						$(".extra_facet_"+idk).toggle();
						jQuery(this).children('.childshow').toggle();
				    });
			        
			        
			        
			   	 	$('.addpeople').click(function () {
					 	var pid = $(this).attr("id");
					 	selectPeople(pid);
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
					});
			     },
			    success: function(output) {
			    
			    		displayresults(output);
			    		displayfacets(output);
			    	
			    	$('#facetdates').val("Y");
			    
			    	console.log("sub- after search->"+$('#store_selected').val());
			    	//$('#people_choices').append($('#store_selected').val());
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
		
		  $('#sffq').val("");
		     $('#sfq').val("");
		var chkIds = $("input:checkbox:checked").map(function(){
	    	
			return $(this).val();
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
		
		
		q = $('#sq').val();
		//alert(q);
		if(q!=''){
			//doSearch(facets,"","");
		}
		
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
 		
 		var resp = output['response'];
 		
 		var c = '';
 		//
 		var hd = "About ";
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
 		var t =0;
 		var imgsrc = "<%=imgsrc %>";
		
 		$.each(resp['docs'], function(k,v) {
 			var l = u + v.title;
 			t++;
 			if(v.id!=''){
					c+= '<tr id="people_result_'+v.id+'">';
 					c+= '<td width="1%" valign="top" nowrap>';
					c+= '<img src="'+imgsrc+'" style="cursor:pointer;" class="addpeople" id="'+v.id+'">';
 					c+= '</td>';
 					c+= '<td>';
					c+= '<div class="people_result">';

					var ph = v.phonework; if(ph==undefined){ ph = "";}
					var address = v.address; if(address==undefined){ address = "";}
					var licnum = v.licnum; if(licnum==undefined){ licnum = "";}
					var usergroup = v.usergroup; if(usergroup==undefined){ usergroup = "";}
					
					c += '<span class="people_result people_name" id="people_name_'+v.id+'">'+v.name+'</span>';
					c += '<span class="people_result people_email" id="people_email_'+v.id+'">'+v.email+'</span>';
					c += '<span class="people_result people_address" id="people_address_'+v.id+'">'+address+'</span>';
					
					c += '<span class="people_result people_group" id="people_group_'+v.id+'">'+usergroup+'</span>';
					c += '<span class="people_result people_type" id="people_type_'+v.id+'">'+v.type+'</span>';
					c += '<span class="people_result people_lic" id="people_lic_'+v.id+'">'+licnum+'</span>';
			 		c += '</div>';
 					c+= '</td>';
 					c+= '</tr>';
			}	
 		});

		$("#resultsadd").html(c);
		$('#cssearch_results').show();
 		
	}
	
	/* function selectPeople(value, text) {
		var d = $('#div_choices');
		d.show();
		var f = $('#people_choices');
		var c = $('<input/>');
		c.attr('type','checkbox');
		c.attr('name','PEOPLE');
		c.attr('value',value);
		c.prop('checked', true);
		var tr = $('<tr/>');
		var ctd = $('<td/>');
		ctd.attr('width','1%');
		ctd.append(c);
		tr.append(ctd);
		var ttd = $('<td/>');
		ttd.attr('width','99%');
		ttd.html(text);
		tr.append(ttd);
		f.append(tr);
//		parent.$.fancybox.close();
	} */
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
	 					//c +=' <div id="c" class="csuisub_label extra_facet extra_facet_'+k+'" ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 					//if(!ext){
		 					//c +='<tr > <td width="1%" class="csui_header" style="cursor:pointer;"  colspan="2"><a class="csui" href="javascript:void(0);" title="Show more" onclick="show_more(&quot;'+k+'&quot;);" >Show More/Less ('+k+')</a></td></tr>';
						//	c +='<div class="csuisub_label"><a class="csui" href="javascript:void(0);" title="Show more" onclick="show_more(&quot;'+k+'&quot;);" >Show More/Less ('+k+')</a></div>';		 					ext = true;
	 					//}
	 					c +=' <div id="c" class="childshow csuisub_label extra_facet extra_facet_'+k+'" ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}else {
	 					//c +='<tr> <td class="csui" width="1%"><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > </td> 	<td class="csui">'+j.val+' ('+j.count+')</td>	</tr>';
	 					c +=' <div id="c" class="childshow csuisub_label " ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
	 				}
	 				//c +=' <div id="c" class="childshow csuisub_label " ><input type="checkbox" class="'+k+'" name="'+j.val+'" id=\"'+k+'_'+j.val+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+j.val+'\" > '+j.val+' ('+j.count+')	</div>';
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
 	 					 c += '<div id="'+k+'" class="childshow csuisub_label" style="cursor:pointer;" title="Show/Hide" >'+p+'';
						 
 						 for(var i=0;i<arr.length;i++){
 							 var mlv = arr[i];
 							
 							 if(mlv.startsWith(p)){
 								 var spl = mlv.replace(p,"");
 								
 								var ot =  spl.split("|")
 								var org = mlv.split("|");
 			 					c +=' <div id="c" class="childshow csuisub_label" style="display:none"><input type="checkbox" class="'+k+'" name="'+org[0]+'" id=\"'+k+'_'+org[0]+'\" filtertype="'+k+'" onclick="faceting();" value=\"'+k+'|'+org[0]+'\" > '+ot[0]+' ('+ot[1]+')	</div>';
 								
 							 }
 						 }
 						c += '</div>';
 					 }
 				 } 
 				
 				
 				
 				
 				
 				
 				c += '</div>';   
 		 	    
 				
 				
 			}
 			
 		});
 		
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
 		
		$('#csuisub').show();
	}
	
	
	
	
	if (!String.prototype.startsWith) {
		String.prototype.startsWith = function(searchString, position) {
	    position = position || 0;
	    return this.indexOf(searchString, position) === position;
	};

}
	
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


.shls { cursor:pointer; padding: 6px; font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 11px; background-color: #eeeeee; 
}




.plus:after {
    content:" +";
}
.minus:after {
    content:" -";
}
	</style>
</head>

<body>

	<div id="loader"></div>

	<div id="csuibody">

		<div id="csuimain">
			<div>
				<div id="csuibody">
					<div id="csuisub">
						<div class="csuisub_divider"></div>
						<div class="csuisubcontent">
							<div class="csuisub_title" alert="warning" id="filtershtml">
							</div>
							<table class="csuisub sortable" type="horizontal" id="itemsadd" >
							</table>
						</div>
					</div>
					<div id="csuimain">
						<div class="csuicontent">
							<br/>
							<form id="peoplesearch">
								<input type="hidden" id="facettypes" name="facettypes" value="">
								<input type="hidden" id="facetvalues" name="facetvalues" value="">
								<input type="hidden" id="facetdates" name="facetdates" value="N">
								<input type="hidden" id="startresult" name="startresult" value="0">
								<input type="hidden" id="endresult" name="endresult" value="30">
								<input type="hidden" id="sffq" name="sffq" value="">
								<input type="hidden" id="sfq" name="sfq" value="">
								<input type="hidden" id="_sort" name="_sort" value="">
								<input type="hidden" id="view" name="view" value="def">
								<input type="hidden" id="store_selected" name="store_selected" value="">
								<input type="hidden" name="<%= RequestMapper.entity %>" value="<%= entity %>"/>
								<input type="hidden" name="<%= RequestMapper.entityid %>" value="<%= entityid %>"/>
								<input type="hidden" name="<%= RequestMapper.type %>" value="<%= type %>"/>
								<input type="hidden" name="<%= RequestMapper.typeid %>" value="<%= typeid %>"/>
								<input type="hidden" name="<%= RequestMapper.groupid %>" value="<%= grpid %>"/>
								<input type="hidden" name="<%= RequestMapper.group %>" value="<%= grp %>"/>
								<input type="hidden" name="<%= RequestMapper.grouptype %>" value="<%= grptype %>"/>
							
								<table  width="100%" cellpadding="6" cellspacing="0" border="0" align="center">
									<tr>
										<td class="csui" width="1%" nowrap>Search</td>
										<td><input class="cs_search" type="text" name="sq"  id="sq" value='<%=q %>'  style="width: 100%"/></td>
									</tr>
								</table>
							</form>

							<div id="cssearch_results">
								<div class="csui_divider"></div>
								<div class="selector" style="align:right;display:none;"></div>
								<div class="csui_divider"></div>
	
								<table class="csui" type="horizontal">
									<tr>
										<td class="csui_title csuialert" id="headmsg" alert=""> </td>
									</tr>
								</table>	
								<table class="csui_title csuialert" alert="">
									<tr>
										<td class="csui_title">RESULTS</td>
										<td class="csui_controls">&nbsp;</td>
									</tr>
								</table>
								
								<table cellpadding="0" cellspacing="0" border="0" align="center" width="100%">
									<tr>
										<td class="csui">		
											<table cellpadding="5" cellspacing="0" border="0" align="center" width="90%" id="resultsadd">
											</table>
				 						</td>
	 								</tr>
								</table>	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




</body>

</html>




















