<%@page import="alain.core.security.Token"%>
<%@page import="csshared.utils.CsApi"%>
<%@page import="csshared.vo.ResponseVO"%>
<%@page import="alain.core.utils.Operator"%>
<%@page import="alain.core.utils.Timekeeper"%>
<%@page import="alain.core.utils.Logger"%>
<%@page import="csshared.utils.ObjMapper"%>
<%@page import="csshared.vo.ObjVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="csshared.vo.SubObjVO"%>
<%@page import="csshared.utils.CsConfig"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="cs.utils.RequestMapper"%>
<%@page import="cs.utils.ObjUi"%>
<%@page import="csshared.vo.ObjGroupVO"%>
<%@page import="csshared.vo.TypeVO"%>
<%@page import="csshared.vo.RequestVO"%>
<%@page import="alain.core.utils.Cartographer"%>
<%

	boolean add = true;
	Cartographer map = new Cartographer(request,response);
 	Token d = CsApi.getToken(map.token(), map.getRemoteIp());
 	if (CsConfig.isPublic() && !d.isStaff()) {
// 		map.redirect("/cs/jsp/lsohowto.jsp");
 	}


%><html>
<head>
	<link href='https://fonts.googleapis.com/css?family=Oswald:300,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Armata' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
</head>
<body>
<div style="padding: 5px; font-family: 'Roboto Condensed', Arial">
<table cellpadding="5" cellspacing="0" border="0" width="100%">
	<tr>
		<td valign="top">
		<table cellpadding="10" cellspacing="0" border="0">
			<tr>
				<td><img src="/cs/images/cslogonews.png" border="0"></td>
			</tr>
		</table>
		<br/>
		<b>Release Notes: 03/06/2019</b>
		<br/><br/>
		<b>New Modules</b>
		<ul>
			<li>Archived Documents - Displays documents that have been scanned into Documentum/AppXtender</li>
			<li>LSO Activities - New module added to the LSO summary that lists all activities associated with the chosen LSO</li>
		</ul>
		
		<b>Activity</b>
		<ul>
			<li>Move Activity</li>
			<li>Added ability to automatically void activities not issued after specified number of days</li>
			<li>Added final dates to closed activities</li>
		</ul>
		
		<b>Security</b>
		<ul>
			<li>Enabled tighter security access in preparation for CitySmart deployment online</li>
			<li>Provided detailed control of access to roles</li>
			<li>Enabled ssl (https)</li>
		</ul>
		
		<b>Fees</b>
		<ul>
			<li>Established the autocalculate fees for planning activities and the following permits: Building, Demolition, Grading, Electrical, Mechanical, and Plumbing permits.</li>
			<li>Student Filming & Photography fees added to Greystone Events</li>
		</ul>
		
		<b>Inspection</b>
		<ul>
			<li>Corrected inspection cancellation cutoffs</li>
			<li>Inspection scheduled from IVR/Online are now sending notification emails</li>
		</ul>
		
		<b>Parking</b>
		<ul>
			<li>Modified one time exemption activities to ensure connection to address</li>
			<li>One time exemption report</li>
			<li>Soft holds report</li>
			<li>Daytime exemption report</li>
		</ul>
		
		<b>Shopping Cart</b>
		<ul>
			<li>Automatically updates online shopping cart based on real time status of items</li>
		</ul>
		
		<b>Divisions</b>
		<ul>
			<li>Corrected issues affecting structure and occupancy inheritance from land level</li>
		</ul>
		
		<b>Custom Fields</b>
		<ul>
			<li>Corrected issue affecting drop downs</li>
		</ul>
		
		<b>Templates</b>
		<ul>
			<li>Corrected logo urls on templates</li>
		</ul>
		
		<b>Migration</b>
		<ul>
			<li>Added final dates to data migrated from the OBC</li>
		</ul>
		
		<br/>
		<br/>
		<hr style="border: 1px dashed #cccccc"/>
		
		<br/>
		<b>Release Notes: 12/11/2018</b>
		<br/><br/>
		<b>Divisions</b>
		<ul>
			<li>Enhanced divisions module to reflect derived values on Land, Structure and Occupancy<br/>
			VIDEO: <a href="http://cswiki01/csmanual/17propertyinformation#what-are-divisions" target="_blank">http://cswiki01/csmanual/17propertyinformation#what-are-divisions</a><br/><br/></li>
			<li>Allowable project and activity types are now associated with derived divisions</li>
		</ul>
		
		<b>Activity</b>
		<ul>
			<li>Copy Activity<br/>
			VIDEO: <a href="http://cswiki01/csmanual/6buildingpermits#6-2-0-copy-an-activity" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-2-0-copy-an-activity</a><br/><br/></li>
			<li>Final Date added to permits and application details<br/>
			VIDEO: <a href="http://cswiki01/csmanual/6buildingpermits#6-2-2-change-final-date" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-2-2-change-final-date</a><br/><br/></li>
			<li>Changed description form field to textarea for easier viewing</li>
		</ul>
		
		<b>LSO Browser</b>
		<ul>
			<li>Display LSO description<br/>
			VIDEO: <a href="http://cswiki01/csmanual/2generalnavigation#2-2-1-lso-browser-search-by-project-description" target="_blank">http://cswiki01/csmanual/2generalnavigation#2-2-1-lso-browser-search-by-project-description</a></li>
		</ul>
		
		<b>Online</b>
		<ul>
			<li>Corrected case sensitivity problems on some logins</li>
		</ul>
		
		<b>Parking</b>
		<ul>
			<li>Added email function to exemptions tab</li>
		</ul>
		
		<b>Search</b>
		<ul>
			<li>Corrected problems displaying spaces in the division facet</li>
		</ul>

		<b>Field Inspection Report</b>
		<ul>
			<li>Corrected inspection dates in print out</li>
		</ul>

		<b>New activity/permit types:</b>
		<ul>
		<li>View Restoration Application</li>
		<li>Seismic Investigation Fee</li>
		<li>Public Records Request</li>
		<li>Annual Encroachment</li>
		</ul>
		
		<b>New Processes:</b>
		<ul>
		<li>Refund Request</li>
		<li>Permit Extensions</li>
		<li>Application/PC Extensions</li>
		<li>Public Records Request</li>
		<li>Habitability Standards</li>
		<li>Reduction In Services</li>
		<li>Registration</li>
		<li>Complaint Manager</li>
		<li>Relocation Fees</li>
		<li>Evictions</li>
		<li>Referral</li>
		<li>Rent Increases</li>
		<li>Electrical Meter Release</li>
		<li>Gas Meter Release</li>
		<li>Certificate of Occupancy</li>
		<li>Water efficient Landscape Permits</li>
		<li>Wood Roof Tracking</li>
	
		</ul>
		<b>New Custom Field Forms:</b>
		<ul>
		<li>Water Efficient Landscape Details</li>
		<li>View Restoration Information</li>
		<li>Demolition Details</li>
		<li>Utility Meter Release-Gas</li>
		
		</ul>
	
		
		<br/>
		<br/>
		<hr style="border: 1px dashed #cccccc"/>
		
		<br/>
		<b>Release Notes: 09/18/2018</b>
		<br/><br/>
		<b>System</b>
		<ul>
		<li>Marked CitySmart to version 1.0</li>
		</ul>
		
		<b>Wiki Tutorials</b>
		<ul>
		<li>Update Change Permit Fee: <a href="http://cswiki01/csmanual/6buildingpermits#6-5-2-change-fee" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-5-2-change-fee</a></li>
		<li>Change Valuation by Project (Multiple Activities): <a href="http://cswiki01/csmanual/6buildingpermits#6-5-3-change-valuation-by-project" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-5-3-change-valuation-by-project</a></li>
		<li>Change Valuation by Permit (Single Activity): <a href="http://cswiki01/csmanual/6buildingpermits#6-5-3-1-change-permit-valuation" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-5-3-1-change-permit-valuation</a></li>
		<li>See Fee Changes and History: <a href="http://cswiki01/csmanual/6buildingpermits#6-5-3-3-see-fee-changes-and-history" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-5-3-3-see-fee-changes-and-history</a></li>
		<li>See Transaction Ledger and Deposit Ledger: <a href="http://cswiki01/csmanual/6buildingpermits#6-5-3-2-see-transaction-ledger-and-deposit-ledger" target="_blank">http://cswiki01/csmanual/6buildingpermits#6-5-3-2-see-transaction-ledger-and-deposit-ledger</a></li>
		</ul>
		
		<b>LSO</b>
		<ul>
		<li>Search activities in an address from the LSO summary</li>
		</ul>
		
		<b>Project</b>
		<ul>
		<li>Add multiple activities to a project</li>
		<li>Edit valuation of multiple activities and update fees and payments that are affected by the change</li>
		</ul>
		
		<b>Activity</b>
		<ul>
		<li>Edit valuation of an activity and update fees and payments that are affected by the change</li>
		</ul>
		
		<b>Finance</b>
		<ul>
		<li>Added ability to edit fee units</li>
		<li>Fixed issue with lockbox so that missing account numbers are handled gracefully</li>
		</ul>
		
		<b>Custom Fields</b>
		<ul>
		<li>Corrected checkbox issue that resulted in multi-line display</li>
		</ul>
		
		<b>Parking</b>
		<ul>
		<li>Renew multiple permits and multiple permit types</li>
		<li>"Save and add to cart" when adding renewals</li>
		<li>Add multiple permits and multiple permit types</li>
		<li>"Save and add to cart" when adding permits</li>
		<li>Include transfer preferential to renewal preferential permit count</li>
		<li>Include transfer overnight to renewal overnight count</li>
		</ul>
		
		<b>Exemption</b>
		<ul>
		<li>Fixed issue that resulted in a permit number having XXX as their count</li>
		</ul>


		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>

		<br/>
		<b>Release Notes: 08/14/2018</b>
		<br/><br/>
		Enhancement<br/><br/>
		<blockquote>
		
		Images
		<ul>
		<li>Display attached images in horizontal gallery</li>
		</ul>
		</blockquote>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<br/>
		<b>Release Notes: 08/10/2018</b>
		<br/><br/>
		Enhancement<br/><br/>
		<blockquote>
		
		Parking
		<ul>
		<li>Overnight Exemption new code to generate after 5.00 AM.</li>
		<li>Daytime Exemption new code to generate after 2.30 AM.</li>
		<li>Reports: Provide accounts and other information which has a partial payment</li>
		<li>Renewal Print on individual account to print only next year stickers </li>
		</ul>
		Finance
		<ul>
		<li>Lockbox validate accounts before processing</li>
		<li>Lockbox handle over payment and  partial payment</li>
		<li>Lockbox over payments credit to payee's deposit account </li>
		<li>Lockbox single transaction submit </li>
		<li>Lockbox search based on the batch number </li>
	
		<li>Finance manual account is mandatory </li>
		<li>Finance correct the key codes and budget unit </li>
		<li>Finance Upload to munis extract modified</li>
		</ul>
		Inspection
		<ul>
		<li>Email auto select on reschedule and update</li>
		</ul>
		
		</blockquote>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<br/>
		<b>Release Notes: 08/04/2018</b>
		<br/><br/>
		Enhancement<br/><br/>
		<blockquote>
		Images
		<ul>
		<li>Display image gallery in project</li>
		<li>Display image gallery in activity</li>
		<li>Display image gallery in lso</li>
		</ul>
		Finance
		<ul>
		<li>Import Wells Fargo lockbox to automatically create prepaid permits</li>
		</ul>
		</blockquote>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 07/28/2018</b>
		<br/><br/>
		Enhancement<br/><br/>
		<blockquote>
		Email Notifications
		<ul>
		<li>Send email to associated people when updating an activity</li>
		<li>Send email to associated people when adding a new note (choose note type, "External Communication")</li>
		<li>Send email to associated people when updating a review</li>
		<li>Send email to associated appointment collaborators when rescheduling an inspection</li>
		<li>Send email to associated people types when editing multiple activities</li>
		</ul>
		Communications
		<ul>
		<li>Communications is a new module that can be viewed in the activity and project summary page</li>
		<li>This module displays all emails that has been sent through the application</li>
		<li>An icon link found on the right column of the record can be clicked to view the content of the email as it was sent</li>
		</ul>
		</blockquote>
		Online
		<ul>
			<li>Fixed issue where users were receiving a blank screen while attempting to pay using a firefox browser</li>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 07/26/2018</b>
		<br/><br/>
		Review/Inspection
		<ul>
			<li>View past email notifications</li>
		</ul>
		Inspections
		<ul>
			<li>Fixed issue where staff override of cut off times were not taking effect resulting in a disabled time slot in the afternoon of the next day.</li>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 07/25/2018</b>
		<br/><br/>
		Review/Inspection
		<ul>
			<li>Send email notifications</li>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 07/24/2018</b>
		<br/><br/>
		Enhancement - Edit multiple activities in a project
		<ul>
			<li>This feature is found on the project screen</li>
			<li>Click the edit icon found on the right side of the "Activities" module.</li>
			<li>Only the fields that have values will be updated. Leave the field blank if you do not want to affect that specific field</li>
			<li>You can choose which activities to apply your action to by clicking on the checkbox at the left column of the record</li>
			<li>Status</li>
			<ul>
				<li>Activity status options are populated only once an activity is selected</li>
				<li>If you are modifying multiple activities, only the statuses that are common to your selection will be available in the options</li>
				<li>All activities in the project are listed in the table, however, the "Select All" checkbox will only auto-select active records</li>
			</ul>
			<li>Currently, the values that can be edited using this feature are:</li>
			<ul>
				<li>Applied Date</li>
				<li>Start Date</li>
				<li>Issued Date</li>
				<li>Application Expiration Date</li>
				<li>Permit Expiration Date</li>
				<li>Activity Status</li>
				<li>Valuation Declared</li>
				<li>Plan Check Required</li>
				<li>Inherit</li>
				<li>Sensitive</li>
			</ul>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<br/>

		<b>Release Notes: 07/22/2018</b>
		<br/><br/>
		Project
		<ul>
			<li>Add "Move Project" function</li>
		</ul>
		Project Browser
		<ul>
			<li>Add "Sub" and "Sub All" options. These options will display the projects and activities that reside in the sublevels (L, S, O) of the selected LSO tree.</li>
			<ul>
				<li>Active: Displays active projects in the selected LSO tree</li>
				<li>All: Displays all projects (active or inactive) in the selected LSO tree</li>
				<li>Sub: Displays active projects in the selected LSO tree and active projects in the sublevels</li>
				<li>Sub All: Displays all projects in the selected LSO tree and all projects in the sublevels</li>
			</ul>
		</ul>
		Activity
		<ul>
			<li>Auto-populate issued date, permit expiration date, and application expiration date</li>
			<ul>
				<li>Note: This is a configurable function. If you are not seeing this feature happen on your permit type, contact a configuration administrator</li>
			</ul>
			<li>Auto-issue fully paid activities</li>
			<ul>
				<li>Note: This is a configurable function. If you are not seeing this feature happen on your permit type, contact a configuration administrator</li>
			</ul>
		</ul>
		People
		<ul>
			<li>Add "Copy as Applicant" function</li>
			<li>Email and Username are no longer required</li>
			<ul>
				<li>Note: A username must be entered if the customer wants to access their records online</li>
			</ul>
			<li>First Name is now a required field</li>
			<li>Added description to the username field to explain what type of values should be entered</li>
			<li>Fixed issue where the add button disappears from the module after adding or updating an existing people record</li>
			<li>Fixed issue that prevented a newly added user to appear in the selection page</li>
		</ul>
		Print
		<ul>
			<li>Allow users to access project templates from the activity level</li>
		</ul>
		Parking
		<ul>
			<li>Added permit number search</li>
		</ul>
		Search
		<ul>
			<li>Sort new searches by updated date</li>
		</ul>
		New Configurations
		<ul>
			<li>Setup print template named "Temporary Parking Permit" to Preferential and Overnight permits</li>
			<ul>
				<li>Note: Please make sure to enter a value in the "Temporary Permit Expiration Date" or the "Application Expiration Date" field. This will be considered as the expiration date of the temporary permit. There will be no need to create a separate temporary parking permit activity.</li>
			</ul>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<br/>
		<b>Release Notes: 07/09/2018</b>
		<br/><br/>
		Inspections
		<ul>
		<li>Automatically assign last added inspector of the activity or project to new inspection requests</li>
		<li>Correct the comparator in cutoff time which marked availability closed when cutoff time is less than current time</li>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<br/>
		<b>Release Notes: 07/08/2018</b>
		<br/><br/>
		People
		<ul>
		<li>Added green color to icon to distinguish customers who already have an existing online account</li>
		</ul>
		Inspections
		<ul>
		<li>Correct the data that is displayed on the inspections statistics screen</li>
		</ul>
		Online
		<ul>
		<li>Disable cancellation of inspections within one day of appointment</li>
		</ul>
		Finance
		<ul>
		<li>Correct the activity data that is displayed on the projects screen</li>
		<li>Enable partial reversal</li>
		<li>Enable activity deposit</li>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 07/01/2018</b>
		<br/><br/>

		Enhancement
		<ul>
		<li>Create or reset a customer's online account</li>
			<ul>
				<li>From the people module in the summary or parking screen click on the   icon located on the left-most column of the table row.</li>
				<li>This function will verify if the customer already possesses an online account.</li>
				<li>If the customer already possesses an online account, the function will email them a password reset link.</li>
				<li>If the customer is new, the function will create a new online account and email them a password reset link.</li>
				<li>This function will also clean user data, in case the problem with accessing the online account involves data issues.</li>
				<li>Note: This feature is only usable for customers with a valid email address</li>
				<li>Solutions: If you click on the icon and receive no dialog, please clear your browser cache and try again</li>
			</ul>
		<li>Added view only versions of "Notes" and "Attachments" to the parking screen</li>
		</ul>
		
		Online
		<ul>
		<li>Fix profile view issues that resulted in conflicts because of empty field values on older data</li>
		<li>Enable payment processing</li>
		</ul>
		
		Cashier
		<ul>
		<li>Use ajax calls to prevent browser parsing issues that resulted in a blank screen</li>
		</ul>
		
		Attachment
		<ul>
		<li>Corrected the URL links that was being displayed in some screens</li>
		</ul>
		
		Print
		<ul>
		<li>Added permit type to the exemption template</li>
		<li>Updated dates displayed in the code enforcement template to use created date instead of the updated date</li>
		</ul>


		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>




		<b>Release Notes: 06/27/2018</b>
		<br/><br/>
		Inspections
		<ul>
		<li>Same day rescheduling of inspections for staff</li>
		<li>Updated auto-disabling logic of the buttons displayed in the inspections screen</li>
		<li>Added reddish color to table rows to notify users when configuration issues will affect functions</li>
		</ul>
		Finance
		<ul>
		<li>Corrected "Add to Cart" feature in finance module</li>
		<li>Ensure correct accounting of fees that have been added to the activity but disabled in configuration</li>
		</ul>
		Reports
		<ul>
		<li>Lapsed inspection report</li>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 06/26/2018</b>
		<br/><br/>
		Inspections
		<ul>
		<li>Corrected status check that increased the count and marked a time slot full prematurely</li>
		<li>Corrected validation check that prevented staff from leveraging rights to reschedule without limitation</li>
		<li>Corrected route sorting appointment time</li>
		<li>Corrected date filters in the route sorting</li>
		</ul>
		Twillio (IVR)
		<ul>
		<li>Provided friendlier responses to unavailable dates consequently rerouting to the main menu</li>
		</ul>
		Parking
		<ul>
		<li>Ensured that Caregiver Permits are printed on the batch</li>
		<li>Added color to replacement overnight permits</li>
		<li>Ensured that lost permits are not added to the batch</li>
		</ul>
		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes: 06/22/2018 - 06/24/2018</b>
		<br/><br/>
		Enhancements
		<ul>
		<li>View and edit land divisions from mapped project and activity screens</li>
		<li>View, add and edit land, structure, and occupancy site data from mapped project and activity screens</li>
		<li>"Save and create new project" button can be chosen when expiring or closing an existing project</li>
		</ul>
		
		LSO Browser
		<ul>
		<li>Optimized query used on the project browser to enhance performance</li>
		</ul>
		
		Site Data
		<ul>
		<li>Corrected issue that prevented some users from adding or editing site data</li>
		</ul>
		
		Print
		<ul>
		<li>Updated print logic so that an error in a segment of the template does not affect the entire print</li>
		</ul>
		
		Parking
		<ul>
		<li>Adjusted measurements in the template so the print out fits better when printed in the custom paper</li>
		<li>Cleared accounts in the approval screen where approvals became unnecessary after data from OBC was cleaned</li>
		<li>Renamed the approve and merge buttons in the approval screen to better describe its intended function</li>
		</ul>
		
		Online
		<ul>
		<li>Temporarily disabled the payment feature for non-parking permits due to a calculation error on permits that have undergone multiple fee adjustments. Resolution ETA: within one week.</li>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes - 06/21/2018</b>
		<br/><br/>
		System
		<ul>
		<li>Disabled server caching</li>
		<li>Increased session timeout allowing users to be logged in for a longer period of time</li>
		<li>Details have been added to 500 errors providing additional information about the error</li>
		<li>Threaded SOLR indexes to improve performance</li>
		</ul>
		
		Project
		<ul>
		<li>Description is no longer required</li>
		</ul>
		
		Activity
		<ul>
		<li>Description is no longer required</li>
		</ul>
		
		Notes
		<ul>
		<li>Set "Internal Note" as default note type when adding a new note</li>
		</ul>
		
		Fees
		<ul>
		<li>Corrected code to ensure that multiple variations of a fee resulting from many changes calculate only the most current one</li>
		</ul>
		
		Inspections
		<ul>
		<li>Removed seat limitation allowing staff to schedule an inspection even though the slot is full</li>
		</ul>
		
		FIR
		<ul>
		<li>Updated template administration to allow adding the "updated by" value</li>
		<li>Updated template administration to allow adding the "updated date" value</li>
		<li>Corrected filtering of people function in the template administration </li>
		</ul>
		
		Finance
		<ul>
		<li>Add "All" to drop down options on (Munis) extract</li>
		</ul>
		
		Parking
		<ul>
		<li>Description is no longer required to create exemption and a permit</li>
		<li>Set "Issued" as default status when creating new exemptions</li>
		<li>Removed voided permits from being included in "Print" and "Reprint" functions</li>
		</ul>
		
		Online
		<ul>
		<li>Merged multiple duplicate user records retrieved from the OBC which was preventing users from accessing their correct accounts because of conflicting records</li>
		</ul>
		
		Twillio (IVR)
		<ul>
		<li>Corrected code validating for inspection disabled dates</li>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes - 06/20/2018</b>
		<br/><br/>

		Parking
		<ul>
			<li>Added address fraction in the displayed results after searching an account number</li>
			<li>Added address fraction to print out</li>
			<li>Added address fraction to the info tab</li>
			<li>Added the word "None" to zones without any entered value</li>
			<li>Changed links in approval page to open in a new tab</li>
			<li>Configured Overnight Permits to limit maximum equal to the number of approved spaces</li>
			<li>Configured limitations to the number of exemptions that can be requested basing the limitation on the number of purchased preferential permits</li>
			<li>Updated size of permit to 8 1/2 x 14</li>
			<li>Added zone information to print out</li>
			<li>Configured exemption codes to change daily</li>
			<li>Created report of exemption codes. Report can be found in DOT -> Other Reports -> Is Exemption Report</li>
		</ul>
		Online
		<ul>
			<li>Added ability for users to select people type when adding themselves into a permit</li>
			<li>Added confirmation box to add permit to ensure that users understand that they will be added to the public record if they add themselves to a permit</li>
		</ul>
		Review
		<ul>
			<li>Configured reviews to inspection types</li>
		</ul>

		<br/>
		<br/>
<hr style="border: 1px dashed #cccccc"/>
		<br/>
		<br/>
		<b>Release Notes - 06/19/2018</b>
		<br/><br/>

		Inspections
		<ul>
		<li>Corrected the link to the inspection</li>
		<li>Added a link to the project by clicking on the project number that is displayed in the table</li>
		<li>Added a link to the activity by clicking on the activity number that is displayed in the table</li>
		
		</ul>
		
		Parking
		<ul>
		<li>Corrected the search for address with fractions</li>
		<li>Corrected quantity selection for parking permits with no allowable maximum</li>
		<li>Configured "Print Permits" and "Reprint Permits" templates to be used in the parking tab and the batch printing</li>
		<li>Configured maximum count of allowable overnight permits</li>
		<li>Added a link to the LSO by clicking on the address in the account approvals page</li>
		<li>Added a link to the account/project by clicking on the account number in the account approvals page</li>
		<li>Added a link to the LSO by clicking on the address in the batch print page</li>
		<li>Added a link to the account/project by clicking on the account number in the batch print page</li>
		<li>Added a link to forgot password by clicking on the icon in the parking search results page<br/>This is a temporary function that will be replaced with a more feature filled enhancement</li>
		</ul>
		
		Online
		<ul>
		<li>Migrated old OBC users to the new system<br/>Addresses issues where users were not able to log in using old OBC username/password</li>
		</ul>
		
		Fees
		<ul>
		<li>Corrected issue where fees are not being subtracted when removing fees</li>
		</ul>
		
		Twillio (IVR)
		<ul>
		<li>Placed solr indexing on a separate thread to increase the speed of system responses.<br/>This is to address the situation where customers were hanging up before the system can respond with scheduling confirmation.</li>
		</ul>
		
				
		</td>
	</tr>
</table>
</div>
</body>
</html>
