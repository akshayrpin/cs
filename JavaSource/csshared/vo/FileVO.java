 package csshared.vo;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

import alain.core.utils.Operator;

public class FileVO {

	public int id =-1;
	public String filename = "";
	public String fullpath = "";
	public String extension = "";
	public String base64 = "";
	public String path = "";
	public String contenttype = "";
	public long filesize = 0;
	public boolean showbrowser = false;
	public boolean ispublic = false;
	
	public FileVO() {
		
	}

	public boolean set(FileItem item) {
		boolean r = false;
		try {
			if (!item.isFormField()) {
				this.filesize = item.getSize();
				this.extension = FilenameUtils.getExtension(item.getName());
				if (filesize > 0) {
					this.filename = cleanFilename(FilenameUtils.getName(item.getName()));
					this.base64 = new String(Base64.encodeBase64(item.get()));
					r = true;
				}
			}
		}
		catch (Exception e) {
			
		}
		return r;
	}

    public static String cleanFilename(String filename) {
    	filename = Operator.replace(filename, " ", "");
    	filename = Operator.replace(filename, "=", "");
    	filename = Operator.replace(filename, "\\", "");
    	filename = Operator.replace(filename, "/", "");
    	filename = Operator.replace(filename, "%", "");
    	filename = Operator.replace(filename, "#", "");
    	filename = Operator.replace(filename, "?", "");
    	filename = Operator.replace(filename, "&", "");
    	filename = Operator.replace(filename, ";", "");
    	return filename;
    }

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFullpath() {
		return fullpath;
	}

	public void setFullpath(String fullpath) {
		this.fullpath = fullpath;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public String getBase64() {
		return base64;
	}

	public void setBase64(String base64) {
		this.base64 = base64;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	

	public String getContenttype() {
		return contenttype;
	}

	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isShowbrowser() {
		return showbrowser;
	}

	public void setShowbrowser(boolean showbrowser) {
		this.showbrowser = showbrowser;
	}

	public boolean isPublic() {
		return ispublic;
	}

	public boolean isIspublic() {
		return ispublic;
	}

	public void setIspublic(boolean ispublic) {
		this.ispublic = ispublic;
	}
    
	
	
    

}
