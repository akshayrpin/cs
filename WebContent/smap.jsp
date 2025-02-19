<%@page import="cs.ui.CsUiTools"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="alain.core.utils.Config"%>
<%@page import="alain.core.utils.Cartographer"%>
<%
 Cartographer map = new Cartographer(request,response);
String locations= map.getString("_LOCATIONS");

locations = StringEscapeUtils.escapeJava(locations.toString());
System.out.println(locations);
%>

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Marker Clustering</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>

	<%= CsUiTools.getHTMLImports() %>
    <script language="JavaScript" src="<%=Config.fullcontexturl()%>/tools/jq/json2.js"></script>
     <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7xtGshY7YvvmMXrxKJ9CGzgW_2ezyrLs&callback=initMap">
    </script>
    <script>
    
    var loc = "<%=locations%>";
	
    console.log(loc);
    
    loc = JSON.parse(loc);
    
      function initMap(loc) {

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 34.08665, lng: -118.446795}
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
       
        var markers = locations.map(function(location, i) {
          	console.log(location,i);
        	return new google.maps.Marker({
              position: location,
              label: labels[i % labels.length]
            });
          });
        
        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
      
      var locations =   loc;
      
     
    </script>
   
  </head>
  <body>
    <div id="map"></div>
    
  </body>
</html>