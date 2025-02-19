package cs.agent;

import alain.core.security.Token;
import alain.core.utils.Logger;
import alain.core.utils.MapSet;
import cs.common.ApiHandler;
import csshared.utils.CsApi;
import csshared.utils.CsConfig;
import csshared.vo.ResponseVO;

public class UiAgent {

	public static String menu(String token, String ip) {
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		Token u = CsApi.getToken(token, ip);
		String[] e = CsConfig.getEntities();
		Logger.info("e-----length"+e.length);
		for (int i=0; i<e.length; i++) {
			MapSet map = CsConfig.getEntity(e[i]);
			String admin = map.getString("admin");
			String title = map.getString("title");
			Logger.info(title+"came here admin"+admin +" link"+map.getString("link"));
			if (!admin.equalsIgnoreCase("true")) {
				
				boolean  rt = tabAccess(map.getString("entity"), token, ip);
				Logger.info(rt+"-----------tab------------"+map.getString("entity")+"----staff"+u.isStaff());
				//Verify with Alain this logic
				if(map.getString("entity").equalsIgnoreCase("search") || map.getString("entity").equalsIgnoreCase("mapgallery")){
					rt=true;
					
				}
				if( map.getString("entity").equalsIgnoreCase("search")   && u.isStaff()){
					rt=false;
				}	
				
				if (rt) {
					if (!empty) { sb.append(",\n"); }

					sb.append(" {\n");
					sb.append("    \"entity\": \"").append(map.getString("entity")).append("\"");
					sb.append(",\n");
					sb.append("    \"type\": \"").append(map.getString("entity")).append("\"");
					sb.append(",\n");
					sb.append("    \"dataid\": \"").append(map.getString("menuid")).append("\"");
					sb.append(",\n");
					sb.append("    \"title\": \"").append(title).append("\"");
					sb.append(",\n");
					sb.append("    \"image\": \"").append(map.getString("image")).append("\"");

					if (map.hasString("main")) {
						sb.append(",\n");
						sb.append("    \"main\": \"").append(map.getString("main")).append("\"");
					}
					if (map.hasString("sub")) {
						sb.append(",\n");
						sb.append("    \"sub\": \"").append(map.getString("sub")).append("\"");
					}
					if(map.hasString("link") && map.getString("entity").equalsIgnoreCase("gis") && CsConfig.isPublic() && u.isStaff()){
						Logger.info(" ALL CONDITION MATCH ");
						sb.append(",\n");
						sb.append("    \"link\": \"").append( CsConfig.getString("tools.mapsearch")).append("\"");
					}else 
						if (map.hasString("link")) {
						sb.append(",\n");
						sb.append("    \"link\": \"").append(map.getString("link")).append("\"");
					}

					sb.append(" }");
					empty = false;
				}
			}
		}
		sb.append("\n");
		return sb.toString();

	}


	public static String admin() {
		boolean empty = true;
		StringBuilder sb = new StringBuilder();
		String[] e = CsConfig.getEntities();
		for (int i=0; i<e.length; i++) {
			MapSet map = CsConfig.getEntity(e[i]);
			String admin = map.getString("admin");

			if (admin.equalsIgnoreCase("true")) {
				if (!empty) { sb.append(",\n"); }

				sb.append(" {\n");
				sb.append("    \"entity\": \"").append(map.getString("entity")).append("\"");
				sb.append(",\n");
				sb.append("    \"type\": \"").append(map.getString("entity")).append("\"");
				sb.append(",\n");
				sb.append("    \"dataid\": \"").append(map.getString("menuid")).append("\"");
				sb.append(",\n");
				sb.append("    \"title\": \"").append(map.getString("title")).append("\"");
				sb.append(",\n");
				sb.append("    \"image\": \"").append(map.getString("image")).append("\"");
			/*	sb.append(",\n");
				sb.append("    \"_token\": \"").append(token).append("\"");*/

				if (map.hasString("main")) {
					sb.append(",\n");
					sb.append("    \"main\": \"").append(map.getString("main")).append("\"");
				}
				if (map.hasString("sub")) {
					sb.append(",\n");
					sb.append("    \"sub\": \"").append(map.getString("sub")).append("\"");
				}
				if (map.hasString("link")) {
					sb.append(",\n");
					sb.append("    \"link\": \"").append(map.getString("link")).append("\"");
				}

				sb.append(" }");
				empty = false;
			}
		}
		sb.append("\n");
		Logger.info(sb.toString());
		return sb.toString();

	}

	public static boolean tabAccess(String entity, String token, String ip) {
		ResponseVO vo = ApiHandler.checkTabAccess(entity, token, ip);
		return vo.isValid();
	}





}
