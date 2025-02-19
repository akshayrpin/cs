<%@page import="alain.core.utils.Logger"%>
<%@page import="csshared.vo.LibraryVO"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="csshared.vo.ReviewVO"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="csshared.vo.ComboReviewVO"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="cs.utils.ObjTables"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.utils.CsConfig"%>
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

	String entity = map.getString(RequestMapper.entity);
	String type = map.getString(RequestMapper.type);
	int typeid = map.getInt(RequestMapper.typeid);
	String id = map.getString(RequestMapper.id);
	String formid = map.getString("form");
	Logger.highlight(formid);

	RequestVO t = new RequestVO();
	t.setEntity(entity);
	t.setType(type);
	t.setTypeid(typeid);
	t.setId(id);

	LibraryVO[] lib = ApiHandler.getLibraryGroup(t);

%><html>
<head>
	
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
	
	
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/datetimepicker/jquery.datetimepicker.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/chosen/chosen.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/toggleswitch/css/tinytools.toggleswitch.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/alain/cs.ui.css">
	<link rel="stylesheet" type="text/css" media="all" href="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.css"/>
	<link rel="stylesheet" type="text/css" href="<%=Config.fullcontexturl() %>/tools/ioscheckboxes/assets/css/mobileCheckbox.iOS.css">
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
		
	<script type="text/javascript" src="<%= Config.fullcontexturl() %>/tools/ioscheckboxes/assets/js/jquery.mobileCheckbox.js"></script>
	
 	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/fancyapps/source/cms.fancybox.js"></script>
	<script type="text/javascript" src="<%=Config.fullcontexturl() %>/tools/sweetalert/dist/sweetalert-dev.js"></script>

	<style>
		.addlibrary {
			cursor: pointer;
		}
		
		#libraryquery {
		  width: 100%;
		  font-size: 14px;
		  padding: 8px 20px 8px 2px;
		  border: 1px solid #ddd;
		  margin-bottom: 8px;
		}
		
	</style>

	<script>
		var entity = '<%= entity %>';
		var type = '<%= type %>';
		var typeid = '<%= typeid %>';
		var id = '<%= id %>';

		$(document).ready(function() {
			$('.addlibrary1').click(function() {
				var id = $(this).attr('id');
				var content = $('#text_'+id).html();
				var code = $('#code_'+id).html();
				var title = $('#title_'+id).html();
				var insp = $('#inspectable_'+id).html();
				var warn = $('#warning_'+id).html();
				var comp = $('#complete_'+id).html();
				var req = $('#required_'+id).html();
				parent.updateLibrary(content, id, code, title, insp, warn, comp, req, '<%= formid %>');
				parent.$.fancybox.close();
			});
			
			$('#addlibrary').click(function() {
				var selected = "";
				selected = $("input[name=selectlibrary]:checked").map(function () {
				    return this.value;
				  }).get().join(",");
				
				if(selected==''){
					
					
					return false;
				}
				
				if(selected.indexOf(",")>-1){
					//console.log(selected + " Many");
					$('#ref').val(selected);
					
					$.ajax({
						  type: "POST",
						  url: "action.jsp?_action=savemultiple",
						  dataType: 'json',		  
						  data: { 
							 _ent: "<%=entity %>",
							 _type: "<%=type %>",
							 _typeid: "<%=typeid %>",
							 _grpid: "library",
							 _grp: "library",
							 _grptype: "library",
							 _ref: selected,
							 _request: "savemultiple"
						    },
						    success: function(output) {
						    	if(output.messagecode=="cs200"){
						    		
						    		swal({
				 			    	    title: "Successfully Added !!",
				 			    	    text: "Redirecting.. ",
				 			    	    timer: 1000,
				 			    	    showConfirmButton: false
				 			    	  });
				 			    		
						    		
						    		window.top.location.href = "../cs/?_ent=<%=entity%>&_type=<%=type%>&_typeid=<%=typeid%>";
						    	}
						    },
					    error: function(data) {
					        swal('Your request was not processed. Please check your input data.');
					    }
					});
					
				}else {
					//console.log(selected + " One");	
					var id = selected;//$(this).attr('id');
					var content = $('#text_'+id).html();
					var code = $('#code_'+id).html();
					var title = $('#title_'+id).html();
					var insp = $('#inspectable_'+id).html();
					var warn = $('#warning_'+id).html();
					var comp = $('#complete_'+id).html();
					var req = $('#required_'+id).html();
					parent.updateLibrary(content, id, code, title, insp, warn, comp, req, '<%= formid %>');
					parent.$.fancybox.close();
					
				}
				
				
				
			});
			
		});
		
		
		
		function myFunction() {
			  var input, filter, table, tr, td, i, txtValue;
			  input = document.getElementById("libraryquery");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("myTable");
			  tr = table.getElementsByTagName("tr");
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[2];
			    if (td) {
			      txtValue = td.textContent || td.innerText;
			      
			      if (txtValue.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      
			      } else {
			        tr[i].style.display = "none";
			       
			      }
			    }       
			  }
			}
		
		
	</script>

</head>
<body>

	<div id="fullpage">
	<div id="loader"></div>
	<div id="csuibody">
		<div id="csuimain">

			<div class="csuicontent">
			
				<div align="left">
				
				<table cellpadding="10" cellspacing="0" border="0" >
						<tr>
						<td align="left"><div class="csui_buttons" >
							<input type="submit" name="action" value="ADD" class="csui_button" id="addlibrary">
							<!-- <font color="red">* NEW UPDATE Please click on the Add button for adding library conditions (You could now select multiple library conditions)</font> -->
							</div>
							
							</td>
							<td align="right" colspan="4"><input type="text" id="libraryquery" name="libraryquery" onkeyup="myFunction();" placeholder="Search" /></td>
						</tr>
						</table> 
				</div>
				
				
				
				
				<form class="form" action="action.jsp" method="post" >
					<input type="hidden" name="_ent" value="<%=entity %>">
					<input type="hidden" name="_type" value="<%=type %>">
					<input type="hidden" name="_typeid" value="<%=typeid %>">
					<input type="hidden" name="_grpid" value="library">
					<input type="hidden" name="_grp" value="library">
					<input type="hidden" name="_grptype" value="library">
					<input type="hidden" name="ref" id="ref" value="0">
					<input type="hidden" name="_request" value="savemultiple">
				
				
			
			
				
				<table cellpadding="10" cellspacing="0" border="0" class="csui" id="myTable">
					<tr class="header">
						<td width="1%" class="csui_header" valign="top" nowrap>&nbsp;</td>
						<td width="1%" class="csui_header" valign="top" nowrap>Code</td>
						<td width="99%" class="csui_header" valign="top">Content</td>
					</tr>
					<%
						for (int i=0; i<lib.length; i++) {
							LibraryVO vo = lib[i];
					%>
							<tr>
								<td width="1%" class="csui" valign="top" nowrap>
								<!-- <img src="images/icons/controls/black/add.png" class="addlibrary" id="<%= vo.getId() %>"/> -->
								<input type="checkbox" name="selectlibrary" value="<%= vo.getId() %>" >
								</td>
								<td width="1%" class="csui" valign="top" id="code_<%= vo.getId() %>" nowrap><%= vo.getCode() %></td>
								<td width="99%" class="csui" valign="top" id="content_<%= vo.getId() %>">
									<table cellpadding="0" cellspacing="0" border="0" width="100%">
										
										<tr>
											<td class="csui_title_black" valign="top"  id="title_<%= vo.getId() %>"><%= vo.getTitle() %></td>
										</tr>
										<tr>
											<td class="csui" valign="top" id="text_<%= vo.getId() %>"><%= vo.getText() %></td>
										</tr>
									</table>
									<div id="inspectable_<%= vo.getId() %>" style="display: none"><%= vo.getInspectable() %></div>
									<div id="warning_<%= vo.getId() %>" style="display: none"><%= vo.getWarning() %></div>
									<div id="complete_<%= vo.getId() %>" style="display: none"><%= vo.getComplete() %></div>
									<div id="required_<%= vo.getId() %>" style="display: none"><%= vo.getRequired() %></div>
									<div  style="display: none"><%= vo.getCode() %></div>
									
								</td>
							</tr>
					<%
						}
					%>
				</table>
				
				</form>
			</div>

		</div>
	</div>
	</div>




</body>
</html>

