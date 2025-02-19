package cs.common;



import alain.core.utils.Logger;
import cs.address.Address;
import cs.projects.Projects;

public class CommonNavigator {

	
	public static String getDetails(String type,int id) {
		String s = "";
		try {
			Logger.info("**************************"+type);
			if(type.equalsIgnoreCase("P")){
				s =	Projects.getDetails(type, id);
			} else if(type.equalsIgnoreCase("A")){
				s =	Projects.getDetails(type, id);
			} else {  
				s =	Address.getDetails(type, id);
				
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
		
	}
	
	public static String getFormDetails(String type,int id,String formgroup) {
		String s = "";
		try {
			Logger.info("**************************"+type);
			if(type.equalsIgnoreCase("P")){
				s =	Projects.getDetails(type, id, formgroup);
			} else if(type.equalsIgnoreCase("A")){
				s =	Projects.getDetails(type, id, formgroup);
			} else {  
				s =	Address.getDetails(type, id, formgroup);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
		
	}
}
