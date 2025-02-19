<%@page import="alain.core.utils.Config"%>

		 html, body { height: 100%; padding: 0px; margin: 0px; overflow: hidden }
		
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
		 #link { width: 100%; height: 100%; background-color: #ffffff; vertical-align: top; overflow; scroll }
		 
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
		
		
		 .label                { background-color: #aaaaaa; font-family: Roboto Condensed, Arial; font-size: 12px; padding-left: 10px; height: 35px; font-weight: 700; text-transform: uppercase; color: #ffffff; line-height: 35px; vertical-align: middle }
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
		
		
		
		
		
		::-webkit-scrollbar {
		    width: 6px;
		}
		 
		/* Track */
		::-webkit-scrollbar-track {
		    -webkit-box-shadow: inset 0 0 1px rgba(0,0,0,0.2); 
		}
		 
		/* Handle */
		::-webkit-scrollbar-thumb {
		    -webkit-border-radius: 10px;
		    border-radius: 10px;
		    background: #80b2e3; 
		    -webkit-box-shadow: inset 0 0 1px rgba(0,0,0,0.2); 
		}
		::-webkit-scrollbar-thumb:window-inactive {
			background: #dddddd; 
		}
		
