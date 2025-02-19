
$(document).ready(function() {

	$('select[itype=prjtype]').change(function() {
		var ptid = $('select[itype=prjtype]').val();
		jsonAutoActivities(ptid);
	});






});




function jsonAutoActivities(projecttypeid) {
	var aatable = $('#autoactivities');
	var aadiv = $('#autoactivitiesdiv');
	aatable.empty();
	aadiv.hide();
	var u = '';
	u = fullcontexturl+'/json/choices.jsp';
	u += '?_ent='+entity+'&_type='+type+'&_typeid='+typeid+'&_request=autoactivities&_grptype=project&';
	u += '_id='+projecttypeid;

	if (hasValue(u)) {
		var a = $.ajax({
			url: u,
			async: false,
			dataType: 'json',
			success: function(result) {
				var items = result['choices'];
				if (hasValue(items)) {

					var htr = $('<tr/>');

					var haddtd = $('<td/>');
					haddtd.css({
						'width':'1%',
						'white-space':'nowrap',
						'cursor': 'pointer'
					});
					haddtd.addClass('csui_label');
					haddtd.html('Add');
					haddtd.click(function() {
						var ach = $('input[name=ACTIVITY_ARRAY]');
						var achl = ach.not(":checked").length;
						var inpts = $('input[rel=act]');
						var tds = $('td[rel=act]');
						if (achl <= 0) {
							ach.prop('checked', false);
							tds.css( {'background-color': '#f5f5f5'} );
							inpts.prop('disabled', true);
						}
						else {
							ach.prop('checked', true);
							tds.css( {'background-color': '#ffffff'} );
							inpts.prop('disabled', false);
						}
					});
					htr.append(haddtd);

					var htd = $('<td/>');
					htd.addClass('csui_label');
					htd.html('Activity Type');
					htr.append(htd);

					var hpctd = $('<td/>');
					hpctd.css({
						'width':'1%',
						'white-space':'nowrap',
						'cursor': 'pointer'
					});
					hpctd.addClass('csui_label');
					hpctd.html('PC Req');
					hpctd.click(function() {
						var inpts = $('input[name=PLAN_CHK_REQ_ARRAY]');
						var eninpts = inpts.not(":disabled");
						var ckinptsl = eninpts.not(':checked').length;
						if (ckinptsl <= 0) {
							eninpts.prop('checked', false);
						}
						else {
							eninpts.prop('checked', true);
						}
					});

					htr.append(hpctd);

					var hintd = $('<td/>');
					hintd.css({
						'width':'1%',
						'white-space':'nowrap',
						'cursor': 'pointer'
					});
					hintd.addClass('csui_label');
					hintd.html('Inherit');
					hintd.click(function() {
						var inpts = $('input[name=INHERIT_ARRAY]');
						var eninpts = inpts.not(":disabled");
						var ckinptsl = eninpts.not(':checked').length;
						if (ckinptsl <= 0) {
							eninpts.prop('checked', false);
						}
						else {
							eninpts.prop('checked', true);
						}
					});
					htr.append(hintd);

					aatable.append(htr);

					$.each(items, function(k,item){
						var i = item['id'];
						var v = item['value'];
						var t = item['text'];
						var desc = item['description'];
						var s = item['selected'];
						var d = item['addldata'];
						var inhchk = '';
						if (d) {
							inhchk = d['INHERIT'];
						}
						if (!hasValue(t)) { t = v; }
						var tr = $('<tr/>');
						tr.attr('id','tr_'+v);

						var addtd = $('<td/>');
						addtd.css({
							'width':'1%',
							'white-space':'nowrap'
						});
						addtd.addClass('csui');
						var addin = $('<input/>');
						addin.attr('type', 'checkbox');
						addin.attr('name', 'ACTIVITY_ARRAY')
						addin.attr('value', v);
						addin.attr('rel', v);
						addtd.append(addin);
						tr.append(addtd);

						var td = $('<td/>');
						td.css({
							'width':'93%'
						});
						td.addClass('csui');
						td.attr('rel', 'act');
						td.html(t);
						td.css( {'background-color': '#f5f5f5'} );
						tr.append(td);

						var pctd = $('<td/>');
						pctd.addClass('csui');
						pctd.attr('rel', 'act');
						var pcin = $('<input/>');
						pcin.attr('type', 'checkbox');
						pcin.attr('name', 'PLAN_CHK_REQ_ARRAY')
						pcin.attr('value', v);
						pcin.attr('rel', 'act');
						pcin.prop('disabled', true);

						pctd.append(pcin);
						pctd.css( {'background-color': '#f5f5f5'} );
						tr.append(pctd);

						var inhtd = $('<td/>');
						inhtd.addClass('csui');
						inhtd.attr('rel', 'act');
						var inhin = $('<input/>');
						inhin.attr('type', 'checkbox');
						inhin.attr('name', 'INHERIT_ARRAY')
						inhin.attr('value', v);
						inhin.attr('rel', 'act');
						inhin.prop('disabled', true);
						if (inhchk == 'Y') {
							inhin.prop('checked', true);
							inhin.attr('dfltchk', 'Y');
						}

						inhtd.append(inhin);
						inhtd.css( {'background-color': '#f5f5f5'} );
						tr.append(inhtd);

						addin.click(function() {
							if (addin.is(':checked')) {
								td.css( {'background-color': '#ffffff'} );
								pctd.css( {'background-color': '#ffffff'} );
								inhtd.css( {'background-color': '#ffffff'} );
								pcin.prop('disabled', false);
								inhin.prop('disabled', false);
							}
							else {
								td.css( {'background-color': '#f5f5f5'} );
								pctd.css( {'background-color': '#f5f5f5'} );
								inhtd.css( {'background-color': '#f5f5f5'} );
								pcin.prop('checked', false);
								pcin.prop('disabled', true);
//								inhin.prop('checked', false);
								inhin.prop('disabled', true);
							}
						});

						aatable.append(tr);
						aadiv.show();
					});
				}
			},
			error: function(xhr,status,error) {
			}
		});
	}
}



