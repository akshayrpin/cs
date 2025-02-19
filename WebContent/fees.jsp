<%@page import="java.util.ArrayList"%>
<%@page import="cs.search.GlobalSearch"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.vo.finance.FeesGroupVO"%>
<%@page import="csshared.vo.finance.FeeVO"%>
<%@page import="csshared.vo.finance.FinanceVO"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="cs.common.ApiHandler"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%


	Cartographer map = new Cartographer(request,response);
	RequestVO req = RequestMapper.getRequest(map);
	RequestVO nav = req.duplicate();
	nav.setAction(map.getString(RequestMapper.action));
	nav.setRequest("fees");
	
	
	if(!Operator.hasValue(map.token())){
		map.logout();
		map.redirect("index.jsp");
	}
	int userid = GlobalSearch.userId(map.token(), map.getRemoteIp());
	
	boolean allowuser = false;
	ArrayList<Integer> ua = new ArrayList<Integer>();
	ua.add(890);//Developer
	ua.add(341); //Jesse De Anda
	ua.add(691); //Tessie Edolmo
	ua.add(959); //Michael George
	ua.add(967); //Felix Landaverde
	ua.add(899); //Stephanie Murillo
	ua.add(904); //Evelin Welch
	ua.add(829); //Mark Brower
	ua.add(705); //Zuzanna Sinai
	ua.add(493476);//Haley Bartosik
	ua.add(258); //Magdalena Davis 
	ua.add(504120); //Gabor Fabian
	ua.add(338); //Ivette Velasco
	ua.add(512007); // Falguni Desai
	ua.add(504540); //Josephina	Lee
	
	
	for(int u :ua){
		if(u==userid){
			allowuser=true;
			break;
		}
	}

	TypeVO o = ApiHandler.getType(nav);
	String title = o.getTitle();
	String subtitle = o.getSubtitle();
	String alert = o.getAlert();
	DecimalFormat fa = new DecimalFormat("#,##0.00"); 
	//data.toLocaleString()
	
	String cartId = ""; 
	
	if(nav.getType().equalsIgnoreCase("project")){
		cartId = "P"+nav.getTypeid();
	}else {
		cartId = ""+nav.getTypeid();
	}
	
	 boolean check = true;
	
	if (!o.isUpdate()) {
		check = false;
	}
	//else if (!ow.isAdmin() && Operator.hasValue(ow.getHold())) {
	else if (Operator.hasValue(o.getHold())) {
		check = false;
	} 
	String manualurl ="feesmanual.jsp?_ent="+nav.getEntity()+"&_type="+nav.getType()+"&_typeid="+nav.getTypeid()+"&_grpid=0&_grp=finance&_grptype=finance";

%><html>
<head>
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link href='<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
   	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert.css">
   

	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/jquery.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.tools.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/alain/cs.form.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/chosen/chosen.jquery.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/toggleswitch/tinytools.toggleswitch.js"></script>
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/alain/cs.autogrow.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/jquery.tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/inputmask.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/inputmask/dist/inputmask/jquery.inputmask.js"></script>
	
 	<script language="javascript" type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script language="javascript" type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
    <script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
    	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>
    	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sticky/jquery.sticky.js"></script>
    
    

	<style>
		td[stid] {
			cursor: pointer;
			background: url(<%=Config.fullcontexturl() %>/images/arrow-down-black.png) center no-repeat #fff;
			width: 15px;
		}
		td[stid].stactive {
			background: url(<%=Config.fullcontexturl() %>/images/arrow-up-white.png) center no-repeat #336699 !important;
			width: 15px !important;
		}
		.csui_header.pymnt {
			color: #ffffff !important;
			background-color: #336699 !important;
		}
		.csui.pymnt {
			background-color: #eeeeee !important;
		}
		.csui.stactive {
			background-color: #d7e1eb !important;
		}
		
		.w3-button.w3-amber{background-color: #ffc107;
		border: 1px solid #cccccc;
		font-family: Oswald, Arial, Helvetica;
		text-transform: uppercase;
		padding: 10px;
		padding-left: 20px;
		padding-right: 20px;
		margin: 10px;
		font-size: 16px;
		font-weight: bold;
		border-radius: 5px;
		color: #000000;
		cursor: pointer;
		text-decoration: none;}
		
		.w3-button.w3-amber:hover{color:#ffffff!important;background-color:#4CAF50!important}
		
		.w3-button.w3-amberlock{background-color: #e8e2d3;
		border: 1px solid #cccccc;
		font-family: Oswald, Arial, Helvetica;
		text-transform: uppercase;
		padding: 10px;
		padding-left: 20px;
		padding-right: 20px;
		margin: 10px;
		font-size: 16px;
		font-weight: bold;
		border-radius: 5px;
		color: #000000;
		cursor: pointer;
		text-decoration: none;}
		
		.w3-button.w3-amberlock:hover{color:#ffffff!important;background-color:#6d132b!important}
		
	</style> 

	<script>
	var manurl = "<%=manualurl%>";
		$(document).ready(function() {
			$('#csform').csform({
				
			});
			$('input[itype=datetime]').datetimepicker({
				formatTime:'g:i A',
				step: 1
			});
			$('input[itype=date]').datetimepicker({
				timepicker:false,
				format:'Y/m/d'
			});
			$('select:not([itype=boolean]):not([required=true])').chosen({
				width:'100%',
				disable_search_threshold: 10,
				allow_single_deselect: true
			});
			$('select:not([itype=boolean])[required=true]').chosen({
				width:'100%',
				disable_search_threshold: 10
			});
			$('input[itype=boolean]').toggleSwitch({
				onLabel: 'YES',
				offLabel: 'NO',
				height: '30px'
			});
			$('input[itype=active]').toggleSwitch({
				onLabel: 'ACTIVE',
				offLabel: 'INACTIVE',
				height: '30px',
				width: '140px'
			});
			$('input[itype=enable]').toggleSwitch({
				onLabel: 'ENABLED',
				offLabel: 'DISABLED',
				height: '30px',
				width: '140px'
			});
			$('textarea[itype!=richtext]').autoGrow();
			tinymce.init({
            	selector: "textarea[itype=richtext]"
	        });
			$('input[itype=phone]').inputmask({
				"mask":"(999) 999-9999"
			});
			$('.paymentSelector').click(function() {
				var stid = $(this).attr('stid');
				if ($(this).hasClass('stactive')) {
					$(this).removeClass('stactive');
					$('[rel='+stid+']').removeClass('stactive');
				}
				else {
					$(this).addClass('stactive');
					$('[rel='+stid+']').addClass('stactive');
				}
				showpayment(stid);
			});
			
			$('.manact').bind('keypress', function(e) {
			    e.stopPropagation(); 
			});
			
			//$('.float').bind('keypress', function(e) {
			   // e.stopPropagation(); 
			//});
			
			//$('.float').blur(function() {
			//	calculateFees('feecalculate');
			//});
			
			
			$('input[name=groupfeeids]').each(function(){
				var v = $(this).val();
				var act = $(this).attr("act");
				 if (act=="N") {
				      
				   //   console.warn('Duplicate ID #'+v);
						$('.csui[dp="'+v+'"]').each(function(){
							$('.csui[dp="'+v+'"]').css("background-color","#E1AB78");	
							
						});
				    }
				    //vs[v] = 1;
				
			});
			
			
			
		});
		
		function manactnoentry(e){
			 e.preventDefault(); 
		}
		
		function addAccount(id,ui,acc){
			$('#'+ui).val(id);
			$('#'+ui).attr("fname",acc);
		}
		
		function addFees(groupid,json,date,fname){
			$('#addfee'+groupid).append(json);
			var data = "";
			data = JSON.parse(json);
			//alert("UII"+fname);
			
			var h = '<tr class="csui" id="'+groupid+'_'+data.feeid+'">';
			h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="text" itype="textarea">'+fname+'';
			
			//alert(data.inputeditable1);
			
			h += '</td>';
			h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="String" itype="String">';
			//TODO LOGIC 
			
			
			
			if(data.accountnumber == 'Y'){
				h += ' MANUAL ACCOUNT <br/> <input type="text" id="'+groupid+'_'+data.feeid+'_MANUAL_ACCOUNT" name="'+groupid+'_'+data.feeid+'_MANUAL_ACCOUNT" onkeypress="manactnoentry(event);"  class="manact" value="'+0+'" fname="" valrequired="true"> BROWSE  <a target="lightbox-iframe" href="'+manurl+'&ui='+groupid+'_'+data.feeid+'_MANUAL_ACCOUNT" ><img src="/cs/images/icons/controls/black/edit.png" border="0"> </a><br/>';
			}else {
				h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_MANUAL_ACCOUNT" name="'+groupid+'_'+data.feeid+'_MANUAL_ACCOUNT" value="'+0+'" fname="" >';
			}
			
			if(data.inputeditable1 == 'Y'){ h += data.inputtypelabel1+' <br/><input type="text" id="'+groupid+'_'+data.feeid+'_input1" name="'+groupid+'_'+data.feeid+'_input1" value="'+data.input1+'" class="float" > <br/>'; }else { h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_input1" name="'+groupid+'_'+data.feeid+'_input1" value="'+data.input1+'" class="float" >'; }
			if(data.inputeditable2 == 'Y'){ h += data.inputtypelabel2+' <br/><input type="text" id="'+groupid+'_'+data.feeid+'_input2" name="'+groupid+'_'+data.feeid+'_input2" value="'+data.input2+'" class="float" > <br/>';}else { h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_input2" name="'+groupid+'_'+data.feeid+'_input2" value="'+data.input2+'" class="float" >'; }
			if(data.inputeditable3 == 'Y'){ h += data.inputtypelabel3+' <br/><input type="text" id="'+groupid+'_'+data.feeid+'_input3" name="'+groupid+'_'+data.feeid+'_input3" value="'+data.input3+'" class="float" > <br/>';}else { h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_input3" name="'+groupid+'_'+data.feeid+'_input3" value="'+data.input3+'" class="float" >'; }
			if(data.inputeditable4 == 'Y'){ h += data.inputtypelabel4+' <br/><input type="text" id="'+groupid+'_'+data.feeid+'_input4" name="'+groupid+'_'+data.feeid+'_input4" value="'+data.input4+'" class="float" > <br/>';}else { h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_input4" name="'+groupid+'_'+data.feeid+'_input4" value="'+data.input4+'" class="float" >'; }
			if(data.inputeditable5 == 'Y'){ h += data.inputtypelabel5+' <br/><input type="text" id="'+groupid+'_'+data.feeid+'_input5" name="'+groupid+'_'+data.feeid+'_input5" value="'+data.input5+'" class="float" > <br/>';}else { h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_input5" name="'+groupid+'_'+data.feeid+'_input5" value="'+data.input5+'" class="float" >'; }
			
			h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_factor" name="'+groupid+'_'+data.feeid+'_factor" value="'+data.factor+'" class="float" >';
			h += '</td>';
			
			h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="String" itype="String">'+date+'';
			h += '<input type="hidden" id="'+groupid+'_'+data.feeid+'_feedate" name="'+groupid+'_'+data.feeid+'_feedate" value='+date +' >';
			h += '</td>';
			//if(data.formula=="o=amount"){
				//h += '<td class="csui" type="String" itype="String" id="amt_'+groupid+'_'+data.feeid+'">$<input type="text" id="'+groupid+'_'+data.feeid+'_amount" name="'+groupid+'_'+data.feeid+'_amount" value="0.00"></td>';
			//}else {
				h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="String" itype="String" id="amt_'+groupid+'_'+data.feeid+'">$0.00</td>';
			//}
			h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="String" itype="String">$0.00</td>';
			h += '<td class="csui" dp="'+groupid+'_'+data.feeid+'" type="String" itype="String">$0.00';
			
			h += '<input type="hidden" class="groupfeeids" name="groupfeeids" value="'+groupid+'_'+data.feeid+'" reffeeformulaid="'+data.reffeeformulaid+'" feeId="'+data.feeid+'"  feeName="'+data.name+'" grpId="'+groupid+'" formula="'+data.formula+'"  > ';
			//h += '<input type="hidden" class="feeprejson" name="feeprejson_'+data.feeid+'" value='+json +' > ';
			h += '</td>';
			
			
			h += '<td class="csui"><a href="javascript:void(0);" onclick="deletefee1('+groupid+','+data.feeid+');" > <img src="<%=Config.fullcontexturl() %>/images/icons/controls/gray/delete.png" width="20" height="20" border="0"/></a></td>';
			h += '<td class="csui">&nbsp;</td></tr>';
			//alert(h);
			$('#gid_'+groupid).append(h);
			
			showduplicates();
			
			//calculateFees('feecalculate');
		}
		
		
		function deletefee1(gid,id){
			//alert(gid+"--"+id);
			$("#"+gid+"_"+id).remove();
		}
		
		function resetFees(){
			document.location.href = "fees.jsp?_ent=<%=req.getEntity()%>&_type=<%=req.getType()%>&_typeid=<%=req.getTypeid()%>&_grptype=finance&_grpid=0";
			
		}
		
		function deletefee2(gid,sid){
			//alert(gid+"--"+id);
			
			swal({   title: "Are you sure?",   type: "warning",   showCancelButton: true,   confirmButtonColor: "#DD6B55",   confirmButtonText: "Yes, delete it!",   cancelButtonText: "No, cancel plx!",   closeOnConfirm: false,   closeOnCancel: false }, 
					function(isConfirm){   
						if (isConfirm) {   
							var method = "deletefee"
								var type ={};
								$.ajax({
						   			  type: "POST",
						   			  url: "action.jsp?_action="+method,
						   			  dataType: 'json',		  
						   			  data: { 
						   				// feesjson : type,
						   			      _grptype : "finance",
						   			   	  _ent : "<%=nav.getEntity()%>",
						   			   	_type : "<%=nav.getType()%>",
						   				  _reference : sid,
						   				 _typeid : <%=nav.getTypeid()%>
						   			      //mode : mode
						   			    },
						   			    success: function(output) {
						   			    	$("#"+gid+"_"+sid).remove();  
											swal("Deleted!", "Fee has been deleted.", "success"); 
						   			    		
						   			    },
						   		    error: function(data) {
						   		        alert('Session Invalid Re-login to delete it.');
						   		     	swal("Cancelled", "error"); 
						   		    }
					   			});
							  
						} else {     swal("Cancelled", "error");   } });
			
			
			
		}
		
		
		function calculateFees(method){
			var feegroup= [];
			var statements= [];
			var type = {};
			//var method = "feecalculate";
			var token = "<%=nav.getToken()%>";
            var ip = "<%=nav.getIp()%>";
            var ent = "<%=nav.getEntity()%>";
            var type = "<%=nav.getType()%>";
            var typeid = "<%=nav.getTypeid()%>";
            var grptype = "<%=nav.getGrouptype()%>";
          
           	try{
	            $('.manact').each(function(){
	            	var manact = $(this).val();
	            	
	            	if(manact=='' || manact==0){
	            		swal("Manual account is required. Click browse to select it.");
	            		throw manact;
	            		
	            	}
	        	});
           	} catch(e) {
           	  
           		return false;
           	  
           	}
            
		
			$('.groups').each(function(){
				var gpid = $(this).val();
				var gpname = $(this).attr("grpname");
				//alert(gpid);
				var g ="";
  		  		g += "{";
      		  	g += "\"groupid\":"+gpid+",";
      		  	g += '\"group\":"'+gpname+'",';
      		 	g += '\"fees\":[';
      		 	var data= [];
      		 	$('.groupfeeids').each(function(){
      		 		var groupid = $(this).attr("grpId");
      		 		if(gpid== groupid){
	      		 		var grpfeeid = $(this).val();
	          		 	var id = $(this).attr("feeId");
	          		 	var manualaccount = $("#"+grpfeeid+"_MANUAL_ACCOUNT").val();
	          		 	var manualname = $("#"+grpfeeid+"_MANUAL_ACCOUNT").attr("fname");
	          		 	var input1 = $("#"+grpfeeid+"_input1").val();
	          		 	var input2 = $("#"+grpfeeid+"_input2").val();
	          		 	var input3 = $("#"+grpfeeid+"_input3").val();
	          		 	var input4 = $("#"+grpfeeid+"_input4").val();
	          		 	var input5 = $("#"+grpfeeid+"_input5").val();
	          		 	var factor = $("#"+grpfeeid+"_factor").val();
	          		 	var feedate = $("#"+grpfeeid+"_feedate").val();
	          		 	
	          		 	
	          		 	
	          		 	var id = $(this).attr("feeId");
	          		 	var rid = $(this).attr("reffeeformulaid");
	          		 	
	          		 	var formula =  $(this).attr("formula");
	          		 	
	          		 	
	          			var grpname = $('#groupidname_'+groupid).val();
	          			var feename = $(this).attr("feeName");
	          		 	
	          			
	          		  	
	     		  		var d = "{";
	     		  	    d += "\"feeid\":"+id+",";
	     		  		d += "\"reffeeformulaid\":"+rid+",";
	     		  	 	d += "\"financemapid\":"+manualaccount+",";
	     		  		d += '\"account\":"'+manualname+'",';
	     		 	    d += "\"input1\":"+input1+",";
	     		 	 	d += "\"input2\":"+input2+",";
	     		 		d += "\"input3\":"+input3+",";
	     		 		d += "\"input4\":"+input4+",";
	     		 		d += "\"input5\":"+input5+",";
	     		 		d += "\"factor\":"+factor+",";
	     		 		d += '\"feedate\":"'+feedate+'",';
	     		 		d += '\"formula\":"'+formula+'",';
	     		 		d += '\"group\":"'+grpname+'",';
	     		 		d += '\"name\":"'+feename+'",';
	     		 		//d += "\"amount\":"+amount+",";
	     		 	
	     		 		d += "\"groupid\":"+groupid+"";
	     		 		d += "}";
	          		  	data.push(d);
      		 		}
         		});
      		 	
      		    g += data;
      		 	g += ']';
      		  	g += '}';
      		    feegroup.push(g);
      		
			});
            
		    
    		  var s = '{';
            s += '\"activityid\":"'+typeid+'",';
           // s += '\"token\":"'+token+'",';
           // s += '\"ip\":"'+ip+'",';
			s += '\"groups\":[';
			s += feegroup;
			s += ']';
			s += '}';
			statements.push(s);
            
            var d = '{';
            d += '\"entity\":"'+ent+'",';
            d += '\"type\":"'+type+'",';
            d += '\"typeid\":"'+typeid+'",';
            d += '\"token\":"'+token+'",';
            d += '\"_grptype\":"'+grptype+'",';
            d += '\"_grp\":"'+grptype+'",';
            
            d += '\"ip\":"'+ip+'",';
	            d += '\"statements\":[';
	            d += statements;
	            d += ']';
            d += '}';
            type = d;
            //alert(JSON.stringify(feegroup));
        // console.log(type);
            //alert("data+"+JSON.stringify(type));
       
         		$.ajax({
         			  type: "POST",
         			  url: "action.jsp?_action="+method,
         			  dataType: 'json',		  
         			  data: { 
         				 feesjson : type,
         				_grptype :"<%=nav.getGrouptype()%>"
         			     // valuation : valuation,
         			      //mode : mode
         			    },
         			
         			    success: function(output) {
         			    	 
         			    		if(method=="feesave"){
         			    			resetFees();
         			    		}
         			    		output = JSON.stringify(output);
         			    		//alert(output);
         			    		output = JSON.parse(output);
         			    		//var statements = output['statements'];
         			    	//	var tamt = 0;
         			    		//var tpaid = 0;
         			    	//	var tbal = 0;
         			    		$.each(output['statements'], function(m,l) {
         			    			var groups = l.groups;
         			    		//	tamt = l.amount;
         			    		//	tpaid = l.paidamount;
         			    		//	tbal = l.balancedue;
         			    			$.each(groups, function(k,v) {
	         							var fees = v.fees;
	         							$.each(fees, function(f,a) {
	              							if(a.feeid>0){
	              								$("#amt_"+a.groupid+"_"+a.feeid).html("$"+a.amount.toFixed(2));
	              							}
	              						});
	         							//$("#subtotalamount_"+v.groupid).html("$"+v.amount.toFixed(2));
         							});
         			    		});	
         			    		
         			    		//$('#totalallfees').html("$"+tamt.toFixed(2)); 
         					//	$('#totalpaidfees').html("$"+tpaid.toFixed(2)) ;
         						//$('#totalbalancedue').html("$"+tbal.toFixed(2)) ;
         			    		
         			    	
         			    },
         		    error: function(data) {
         		        alert('Your request was not processed. Please check your input data.');
         		    }
         		});
         		
      
            
            
			
		}
		
		
		function showpayment(id){
			if($('#show_bottom_'+id).val()=="1"){
				$("#show_payment_"+id).hide();
				$('#show_bottom_'+id).val("0");
				return false;
			}
			var method = "showstatementpayment"
			var type ={};
			$.ajax({
	   			  type: "POST",
	   			  url: "action.jsp?_action="+method,
	   			  dataType: 'json',		  
	   			  data: { 
	   				// feesjson : type,
	   			      _grptype : "finance",
	   			   	  _ent : "<%=nav.getEntity()%>",
	   			   	_type : "<%=nav.getType()%>",
	   				  STATEMENT_DETAIL_ID : id,
	   				 _typeid : <%=nav.getTypeid()%>
	   			      //mode : mode
	   			    },
	   			    success: function(output) {
	   			    		showpaymentui(id,output);
	   			    		//output = JSON.parse(output);
	   			    		
	   			    },
	   		    error: function(data) {
	   		        alert('Your request was not processed. Please check your input data.');
	   		    }
   			});
		}
		
		
		function showpaymentui(id,output){
			
			
			output = JSON.stringify(output);
	 		//alert(output);
	 		//console.log(output);
	 		output = JSON.parse(output);
	 		//alert(output['statements'].length);
	 		var c = '';
	 		c += '<tr id="show_payment_"'+id+' >';
	 		c += '<td class="csui_header pymnt" width="1%" nowrap>TRANSACTION</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>DATE</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>METHOD</td>';
			c += '<td class="csui_header pymnt">PAYEE</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>PAID</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>REVERSE AMOUNT</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>REVERSE METHOD</td>';
			c += '<td class="csui_header pymnt" width="1%" nowrap>COMMENT</td>';
			c += '<td class="csui_header pymnt">&nbsp;</td>';
			c += '</tr>';
			//c += '<table class="sortable">';
	 		var t = 0;	
	 		$.each(output['payment'], function(k,v) {
	 			
					
					c+= '<tr class="csui"  style="cursor:pointer;" >';
					c += '<td class="csui pymnt" type="String"  itype="String" width="1%" nowrap>'+v.revpaymentid+'</td>';
			 		c += '<td class="csui pymnt" type="String"  itype="String" width="1%" nowrap>'+v.paymentdate+'</td>';
			 		c += '<td class="csui pymnt" type="String" itype="String" width="1%" nowrap>'+v.methodname+'</td>';
			 		c += '<td class="csui pymnt" type="String" itype="String">'+v.otherpayeename+'</td>';

			 		c += '<td class="csui pymnt" type="String" itype="String" width="1%" nowrap>$'+v.amount.toFixed(2)+'</td>';
			 		
			 		if(v.revamount>0){
			 			c += '<td class="csui pymnt" type="String" itype="String" width="1%" nowrap><input type="text" id="statement_reverse_'+v.paymentid+'" name="statement_reverse_'+v.paymentid+'" value="-'+v.revamount.toFixed(2)+'" class="statmentreverse" amt="-'+v.revamount.toFixed(2)+'" pdid="'+v.paymentid+'"  ></td>';
				 		
				 		var m = v.methods;
				 		c += '<td class="csui pymnt" type="String" itype="String" width="1%" nowrap>';
				 		c += '<select name="reversemethod_'+v.paymentid+'" id="reversemethod_'+v.paymentid+'" >';
				 		c += '<option value="">Please select </option>';
				 		$.each(m, function(f,a) {
				 			c += '<option value="'+a.id+'">'+a.text+' </option>';
  						});
				 		c += '</select>';
						c += '<td class="csui pymnt" type="String" itype="String"><textarea id="reversecomment_'+v.paymentid+'" name="reversecomment_'+v.paymentid+'" ></textarea>';
						c += '<input type="hidden" id="reversepayee_id_'+v.paymentid+'" name="reversepayee_id_'+v.paymentid+'" value="'+v.payeeid+'" ></td>';

				 		c += '<td class="csui pymnt" type="text" itype="textarea" width="1%" nowrap><input type="submit" name="action" value="Reverse" class="csui_button" onclick="reversePayment('+v.paymentid+','+v.revpaymentid+','+id+');"></td>';
			 		}else{
						c += '<td class="csui pymnt" type="String" itype="String">&nbsp;</td>';
						c += '<td class="csui pymnt" type="String" itype="String">&nbsp;</td>';
				 		c += '<td class="csui pymnt" type="text" itype="textarea">&nbsp;</td>';
			 		}
			 		c += '</tr>';
			 	//	console.log(c);
			 		
					
	 		});
	 		//c += '</table>';
	 		
	 		//alert(t);
	 		
	 		
	 		
	 		$("#show_payment_table_"+id).html(c);
	 		$("#show_payment_"+id).show();
	 		$('#show_bottom_'+id).val("1");
		}
		
		function reversePayment(pdid,pid,sdid){
			//alert('came here');
		
			var v = parseFloat($('#statement_reverse_'+pdid).val());
			var amt = parseFloat($('#statement_reverse_'+pdid).attr('amt'));
			var rm = $('#reversemethod_'+pdid).val();
			var rcm = $('#reversecomment_'+pdid).val();
			var rcp = $('#reversepayee_id_'+pdid).val();
			
			//swal("This feature is coming soon.");
			//return false;
			
			if($('#reversemethod_'+pdid).val()==""){
				alert("Please select the reversal method");
				$('#reversemethod_'+pdid).focus();
				return false;
			}
			
			if(confirm("Are you sure you want to reverse this transaction?")){
				if(v<amt || v>0){
					alert("Entered amount can't be less than the amount");
					$('#statement_reverse_'+transid).val(amt);
					return false;
				}else {
					
					var method = "partialreverse"
						var type ={};
						$.ajax({
				   			  type: "POST",
				   			  url: "action.jsp?_action="+method,
				   			  dataType: 'json',		  
				   			  data: { 
				   				// feesjson : type,
				   			      _grptype : "finance",
				   			   	  _ent : "<%=nav.getEntity()%>",
				   			   	_type : "<%=nav.getType()%>",
				   				_typeid : <%=nav.getTypeid()%>,
				   				  STATEMENT_DETAIL_ID : sdid,
				   				PD_ID : pdid,
				   				P_ID : pid,
				   				P_METHOD :rm, 
				   				AMOUNT : v,
				   				P_COMMENT : rcm,
				   				PAYEE_ID : rcp,
				   				 _typeid : <%=nav.getTypeid()%>
				   			      //mode : mode
				   			    },
				   			    success: function(output) {
				   			    	if(method=="partialreverse"){
	         			    			resetFees();
	         			    		}
				   			    		
				   			    		
				   			    },
				   		    error: function(data) {
				   		        alert('Your request was not processed. Please check your input data.');
				   		    }
			   			});
					}
			}
			
		}
		
		
		function paymentlist(){
			document.forms[0].action = "ledger.jsp?_ent=<%=nav.getEntity()%>&_id=<%=nav.getId()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=finance";
			document.forms[0].submit();
		}
		
		function depositlist(){
			document.forms[0].action = "depositledger.jsp?_ent=<%=nav.getEntity()%>&_id=<%=nav.getId()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=deposit";
			document.forms[0].submit();
		}
		
		function showAll(){
			
			document.location.href = "fees.jsp?_ent=<%=req.getEntity()%>&_type=<%=req.getType()%>&_typeid=<%=req.getTypeid()%>&_grptype=finance&_grpid=0&_act=showall";
		}
		
		
		
		function addfee(groupid){
			
			
			$(' <a title="Add Fee"  href="<%=Config.fullcontexturl() %>/feespick.jsp?_ent=<%=nav.getEntity()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=finance&_grpid='+groupid+'" >Friendly description</a>').fancybox({
		       		'width'				: '75%',
						'height'			: '75%',
						'autoScale'			: false,
						'transitionIn'		: 'none',
						'transitionOut'		: 'none',
						'type'				: 'iframe'
		          }).click();
		}
		
	function updateValuation(){
			
			
			$(' <a title="Add Fee"  href="<%=Config.fullcontexturl() %>/updateValuation.jsp?_ent=lso&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grptype=finance" >Friendly description</a>').fancybox({
		       		'width'				: '75%',
						'height'			: '75%',
						'autoScale'			: false,
						'transitionIn'		: 'none',
						'transitionOut'		: 'none',
						'type'				: 'iframe'
		          }).click();
		}
		
		
		
		
		function showduplicates(){
			var vs = {};
			var found = false;
			$('input[name=groupfeeids]').each(function(){
				var v = $(this).val();
				 if (v && vs[v]) {
				      found = true;
				   //   console.warn('Duplicate ID #'+v);
						$('.csui[dp="'+v+'"]').each(function(){
							$('.csui[dp="'+v+'"]').css("background-color","#CCDE59");	
							
						});
				    }
				    vs[v] = 1;
				
			});
		}
		
		function addtocart(){
			var method = "scantocart";
			
			var ty ="{}";
			
			var id = "<%=cartId%>";
			
			$.ajax({
				  type: "POST",
				  url: "action.jsp?_action="+method,
				  dataType: 'json',		  
				  data: { 
					  _reference : "<%= subtitle %>",
					  _ent : "<%=nav.getEntity()%>",
		   			   	_type : "<%=nav.getType()%>",
		   				_typeid : <%=nav.getTypeid()%>
				     // valuation : valuation,
				      //mode : mode
				    },
				    success: function(output) {
				    	swal({   title: "<%= subtitle %>",   text: "Added to Cart!",   timer: 2000,   showConfirmButton: false });
				    },
			    error: function(data) {
			    	swal('Your request was not processed. Please check your input data.');
			    }
			});
		
		}
		
		function unlockfee(){
			document.location.href = "fees.jsp?_ent=<%=req.getEntity()%>&_type=<%=req.getType()%>&_typeid=<%=req.getTypeid()%>&_grptype=finance&_grpid=0&_act=unlockfee";
		}
		
		function lockfee(){
			document.location.href = "fees.jsp?_ent=<%=req.getEntity()%>&_type=<%=req.getType()%>&_typeid=<%=req.getTypeid()%>&_grptype=finance&_grpid=0&_act=lockfee";
		}

	</script>

</head>
<body>
	
	<div id="csuibody">
		<div id="csuimain">
			<div class="csuicontrol <%= alert %>">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
				<!-- 					<td align="left" class="csuicontrol">FEE<a href="depositpayment.jsp?_ent=lso&_type=activity&_typeid=<%=nav.getTypeid() %>&_grptype=deposit&_grpid=0" class="csuicontrol">DEPOSIT</a>
					</td>
					 -->
					 <td class="csui_tools">
						<a href="<%=Config.fullcontexturl() %>/summary.jsp?_ent=<%=nav.getEntity() %>&_type=<%=nav.getType() %>&_typeid=<%=nav.getTypeid() %>&_id=<%=nav.getId() %>"><img src="/cs/images/icons/controls/white/back.png" height="25" width="25" border="0"/></a>
						</td>
					 
					
					<td align="right"><a href="<%=Config.fullcontexturl() %>/depositpayment.jsp?_ent=<%=nav.getEntity() %>&_type=<%=nav.getType() %>&_typeid=<%=nav.getTypeid() %>&_id=<%=nav.getId() %>&_grptype=deposit&_act=depositpayment"><img src="/cs/images/icons/controls/white/deposit.png" height="25" width="25" border="0"/></a>
					</td>
				</tr>
			</table></div>
			
			<div class="csuicontent">
				<table cellpadding="10" cellspacing="0" border="0" width="100%">
					<tr>
						<td align="left" id="title"><%= title %></td>
						<td align="right" id="subtitle"><%= subtitle %></td>
					</tr>
				</table>
				
				
						<table class="csui_title" >
							<tr>
								<td class="csui_title">INFO</td>
							</tr>
							
						</table>
						
						<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">Groups</td>
							<td class="csui_header">ACTIVITY</td>
							<td class="csui_header">REVIEW</td>
							<td class="csui_header">PAID</td>
							<td class="csui_header">BALANCE DUE</td>
									
						</tr>
						<%
						if(o.getStatements().length>0){
						
							
							for(int i=0;i<o.getStatements()[0].getGroups().length;i++){ 
							FeesGroupVO g = o.getStatements()[0].getGroups()[i];
							String groupname = g.getGroup();
							int groupid = g.getGroupid();
							double reviewAmount = g.getReviewAmount();
							double amount = g.getAmount();
							double paid = g.getPaidamount();
							double balance = g.getBalancedue();
							%>
								<tr class="csui" >
									<td class="csui" type="text" itype="textarea" ><%=groupname %></td>
									<td class="csui" type="text" itype="textarea" id="subtotalamount_<%=groupid%>">$<%=fa.format(amount) %></td>
									<td class="csui" type="text" itype="textarea" id="subtotalreviewamount_<%=groupid%>">$<%=fa.format(reviewAmount) %></td>
									<td class="csui" type="text" itype="textarea" id="subtotalpaid_<%=groupid%>">$<%=fa.format(paid) %></td>
									<td class="csui" type="text" itype="textarea" id="subtotalbalancedue_<%=groupid%>">$<%=fa.format(balance) %></td>
								</tr>
								
							<%}%>
						
						
						<tr class="csui" >
								<td style="font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 16px; font-weight:bold; background-color: #eeeeee; text-transform: uppercase " >
								TOTAL </td>
								<td style="font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 16px; font-weight:bold; background-color: #eeeeee; text-transform: uppercase " id="totalallfees">$<%=fa.format(o.getStatements()[0].getAmount()) %></td>
								<td style="font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 16px; font-weight:bold; background-color: #eeeeee; text-transform: uppercase "  id="totalallreviewfees">$<%=fa.format(o.getStatements()[0].getReviewAmount()) %></td>
								<td style="font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 16px; font-weight:bold; background-color: #eeeeee; text-transform: uppercase "  id="totalpaidfees">
								
								$<%=fa.format(o.getStatements()[0].getPaidamount()) %></td>
								<td style="font-family: Roboto Condensed, Arial, Helvetica, sans-serif; font-size: 16px; font-weight:bold; background-color: #eeeeee; text-transform: uppercase " id="totalbalancedue">$<%=fa.format(o.getStatements()[0].getBalancedue()) %></td>
							</tr>
							
						<% } %>	
						</table>
						
						<div class="csui_divider"></div>
						
				
				<form id="csform" action="action.jsp" method="post">
				<input type="hidden" name="_act" value="calculate" >
				<input type="hidden" name="_grptype" value="finance" >
				
						<div class="csui_divider"></div>
						<div class="csui_buttons sticky" style="background-color:#fff;">
						<!-- 	<input type="submit" name="action" value="View Statements" class="csui_button" onclick="calculateFees('feesave');"> -->
							<%if(o.getMessagecode().equals("Y")){ %>
						 	 <button class="w3-button w3-amber" onclick="unlockfee();" title="Click to unlock">UN-LOCK FEE</button>
						 	 
							<%} else { %>
							 <button class="w3-button w3-amberlock" onclick="lockfee();" title="Click to lock">LOCK FEE</button>
							<%}  %>
							<input type="submit" name="action" value="Show All" class="csui_button" onclick="showAll();">
							<%if(!o.getMessagecode().equals("Y")){ %>
							<%if(check){ %>
							<input type="submit" name="action" value="Add To Cart" class="csui_button" onclick="addtocart();">
							<%} } %>
							<input type="submit" name="action" value="View Ledger" class="csui_button" onclick="paymentlist();">
							<input type="submit" name="action" value="View Deposit Ledger" class="csui_button" onclick="depositlist();">
							<input type="submit" name="add" value="VALUATION" class="csui_button" onclick="updateValuation();">
							<input type="submit" name="reset" value="reset" class="csui_button" onclick="resetFees();">
					 		<input type="submit" name="calculate" value="preview" class="csui_button" onclick="calculateFees('feecalculate');"> 
							<input type="submit" name="action" value="save" class="csui_button" onclick="calculateFees('feesave');">
						</div>
						
						<%if(o.getMessagecode().equals("Y")){ %>
						 	<div style="padding: 5px; width: 100%; font-family: Oswald, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: 700; color: red; vertical-align: top; text-transform: uppercase" >FEE LOCKED BY :  <%=o.getMessage() %></div>
						 <%} %>
					<%
					if(o.getStatements().length>0){
						for(int i=0;i<o.getStatements()[0].getGroups().length;i++){ 
							FeesGroupVO g = o.getStatements()[0].getGroups()[i];
							String groupname = g.getGroup();
							int groupid = g.getGroupid();
						%>
							<table class="csui_title" >
								<tr>
									<td class="csui_title"><%=groupname %>
									<input type="hidden" name="groupid_<%=groupid %>" id="groupid_<%=groupid %>" class="groups" grpname="<%=groupname %>" value="<%=groupid %>">
									<input type="hidden" name="groupidname_<%=groupid %>" id="groupidname_<%=groupid %>"  value="<%=groupname %>">
									</td>
									<%if(groupid>4) { %>
									<td class="csui_title"><input type="submit" name="add" value="Add" class="csui_button" onclick="addfee(<%=groupid %>);"></td>
									<%} %>
								</tr>
								
							</table>
							<table class="csui" type="horizontal" id="gid_<%=groupid %>">
								<tr>
									<td class="csui_header">FEE NAME</td>
									<td class="csui_header">INPUT</td>
									<td class="csui_header">FEE DATE</td>
									<td class="csui_header">AMOUNT</td>
									<td class="csui_header">PAID</td>
									<td class="csui_header">BALANCE DUE</td>
									<td class="csui_header" width="1%">&nbsp;</td>
									<td class="csui_header" width="1%">&nbsp;</td>
								</tr>
								
								<%for(int j=0;j<g.getFees().length;j++){ 
									FeeVO f = g.getFees()[j];
									String name = f.getName();
									//String input = f.getInput1();
									double amount = f.getAmount();
									double paid = f.getPaidamount();
									double balance = f.getBalancedue();
									int statementdetailid = f.getStatementdetailid();
									boolean active = f.isActive();
									
									boolean edit = Operator.s2b(f.getEdit());
								%>
								
								
								<tr  class="csui" id="<%=f.getGroupid() %>_<%=statementdetailid %>" > 
									 <td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>"  type="text" itype="textarea" rel="<%=statementdetailid %>" ><%=name %></td> 
									 <td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>"  type="String" itype="String" rel="<%=statementdetailid %>" align="right"> 
									 	<%

									 		boolean empty = true;
									 		if (f.getInputtype1() > 0) {
									 			out.print("<font class=\"input_label\">"+f.getInputtypelabel1()+":</font> "+f.getInput1());
									 			empty = false;
									 		}
									 		if (f.getInputtype2() > 0) {
									 			if (!empty) { out.print("<br/>"); }
									 			out.print("<font class=\"input_label\">"+f.getInputtypelabel2()+":</font> "+f.getInput2());
									 			empty = false;
									 		}
									 		if (f.getInputtype3() > 0) {
									 			if (!empty) { out.print("<br/>"); }
									 			out.print("<font class=\"input_label\">"+f.getInputtypelabel3()+":</font> "+f.getInput3());
									 			empty = false;
									 		}
									 		if (f.getInputtype4() > 0) {
									 			if (!empty) { out.print("<br/>"); }
									 			out.print("<font class=\"input_label\">"+f.getInputtypelabel4()+":</font> "+f.getInput4());
									 			empty = false;
									 		}
									 		if (f.getInputtype5() > 0) {
									 			if (!empty) { out.print("<br/>"); }
									 			out.print("<font class=\"input_label\">"+f.getInputtypelabel5()+":</font> "+f.getInput5());
									 			empty = false;
									 		}
									 		if (f.getFinancemapid() > 0) {
									 			if (!empty) { out.print("<br/>"); }
									 			out.print("<font class=\"input_label\">MANUAL ACCOUNT:</font> "+f.getAccount());
									 			empty = false;
									 		}

									 	%>
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput1() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput1() %>" value="<%=f.getInput1() %>" class="float" >
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput2() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput2() %>" value="<%=f.getInput2() %>" class="float" >
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput3() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput3() %>" value="<%=f.getInput3() %>" class="float" >
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput4() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput4() %>" value="<%=f.getInput3() %>" class="float" >
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput5() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getInput5() %>" value="<%=f.getInput5() %>" class="float" >
									 	<input type="hidden" id="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getFactor() %>" name="<%=f.getGroupid() %>_<%=statementdetailid %>_<%=f.getFactor() %>" value="<%=f.getFactor() %>" class="float" >
									 </td> 
		
									<td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>" type="String" itype="String" rel="<%=statementdetailid %>" align="right"><%=f.getFeedate() %></td> 
								
									<td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>" type="String" itype="String" rel="<%=statementdetailid %>" id="amt_'<%=groupid %>'_'<%=statementdetailid %>'" align="right">
									 	<%
									 		if (amount > 0) {
									 			out.print("$"+fa.format(amount));
									 		}
									 		else {
									 			out.print("&nbsp;");
									 		}
									 	%>
									 </td> 
								
									 <td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>" type="String" itype="String" rel="<%=statementdetailid %>" align="right">
									 	<%
									 		if (paid > 0) {
									 			out.print("$"+fa.format(paid));
									 		}
									 		else {
									 			out.print("&nbsp;");
									 		}
									 	%>
									 </td> 
									 <td class="csui" dp="<%=f.getGroupid()%>_<%=f.getFeeid()%>" type="String" itype="String" rel="<%=statementdetailid %>" align="right">
									 	<%
									 		if (balance > 0 || balance <0) {
									 			out.print("$"+fa.format(balance));
									 		}
									 		else {
									 			out.print("&nbsp;");
									 		}
									 	%>
										<input type="hidden" id="show_bottom_<%=statementdetailid %>" name="show_bottom_<%=statementdetailid %>" value="0">
										<input type="hidden" class="groupfeeids" name="groupfeeids" value="<%=f.getGroupid()%>_<%=f.getFeeid()%>" feeId="'+data.feeid+'"  feeName="'+data.name+'" grpId="'+groupid+'" formula="'+data.formula+'" act="<%=f.getActive() %>" >  
									 </td>

									 	<%
									 		if (paid > 0 || !active) {
									 			
									 			if(allowuser){
									 				out.print("<td class=\"csui paymentSelector\" stid=\""+statementdetailid+"\">&nbsp;</td>");
									 			}else {
									 				out.print("<td class=\"csui\">&nbsp;</td>");
									 			}
									 			
									 		}
									 		else {
									 			//out.print("<td class=\"csui\">&nbsp;</td>");
									 			out.print("<td class=\"csui\"><a href=\"javascript:void(0);\" onclick=\"deletefee2("+f.getGroupid()+","+statementdetailid+");\" > <img src=\""+Config.fullcontexturl()+"/images/icons/controls/gray/delete.png\" width=\"20\" height=\"20\" border=\"0\"/></a></td>");

									 		}
									 	%>
									 
								 	<td class="csui" width="1%">
								 		<%if(edit){ %>
											<a target="lightbox-iframe" href="statementdetail.jsp?_id=<%=statementdetailid %>&_ent=<%=nav.getEntity()%>&_type=<%=nav.getType()%>&_typeid=<%=nav.getTypeid()%>&_grpid=0&_grp=finance&_grptype=finance" ><img src="/cs/images/icons/controls/black/edit.png" border="0"></a>
										<%}else { %>
											&nbsp;
										<%} %>
									</td>
									  
								 </tr>
								 
								 <tr style="display:none;" id="show_payment_<%=statementdetailid %>">
									 <td  align="right" colspan="7">
									 <table class="csui" type="horizontal" id="show_payment_table_<%=statementdetailid %>" width="100%">
									 
									 </table>
									 </td>
								 </tr>
								
								<%} %>
							</table>
							<div class="csui_divider"></div>
						
						<%} 
					
					}%>
				</form>
				
				<table class="csui_title" >
							<tr>
								<td class="csui_title">DEPOSITS / CREDITS</td>
								<td class="csui_title">	<% if(o.getDepositcredits().length>0){%><input type="submit" name="action" value="View Deposit Ledger" class="csui_button" onclick="depositlist();"><% }%></td>
							</tr>
							
						</table>
						
						<table class="csui" type="horizontal">
						<tr>
							<td class="csui_header">LEVEL/USER</td>
							<td class="csui_header">AMOUNT</td>
						</tr>
						<%for(int i=0;i<o.getDepositcredits().length;i++){ 
						String level = o.getDepositcredits()[i].getLevel();
						double amount = o.getDepositcredits()[i].getAmount();
					
						%>
							<tr class="csui" >
								<td class="csui" type="text" itype="textarea" ><%=level %></td>
								<td class="csui" type="text" itype="textarea" >$<%=fa.format(amount) %></td>
							</tr>
							
							
						<%} %>
					</table>
					 
			</div>
		</div>
	</div>

<br/>
<br/>
<br/>
<br/>
<br/>


</body>
</html>

