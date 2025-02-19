package cs.address;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import alain.core.db.Sage;
import alain.core.utils.Config;
import alain.core.utils.FileUtil;
import alain.core.utils.ImageUtil;
import alain.core.utils.Logger;
import alain.core.utils.Operator;

import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;

public class MergeDocs {

	public static  ByteArrayOutputStream mergeDocuments(String ids) {
		// TODO Auto-generated method stub
		ByteArrayOutputStream o = new ByteArrayOutputStream();
		try {
		    //Prepare input pdf file list as list of input stream.
		    List<InputStream> inputPdfList = new ArrayList<InputStream>();
		    List<String> fileList = new ArrayList<String>();
		    if(Operator.hasValue(ids)){
			    Sage db = new Sage();
			    
			    db.query("select * from attachments where ID in ("+Operator.sqlEscape(ids)+")");
			    while(db.next()){
			    	inputPdfList.add(new FileInputStream(Config.getString("files.storage_path")+db.getString("PATH")));
			    	fileList.add(Config.getString("files.storage_path")+db.getString("PATH"));
			    }
			    db.clear();
			    //Prepare output stream for merged pdf file.
			    // o =  mergePdfFiles(inputPdfList, o);
			    
			    o =  mergePdf(fileList, o);
		     
		    }
		    
		    
		    
		   } catch (Exception e) {
			e.printStackTrace();
		  }
		return o;
	}
	
	static ByteArrayOutputStream mergePdf(List<String> files, ByteArrayOutputStream outputStream) throws Exception{
		try{
			Document document = new Document();
			PdfCopy copy = new PdfCopy(document, outputStream);
			document.open();
			PdfReader reader;
			int n;
			for (int i = 0; i < files.size(); i++) {
			  String filename = files.get(i);
			   String ext = Operator.getExt(files.get(i));
				if(Operator.equalsIgnoreCase(ext, "jpg") || Operator.equalsIgnoreCase(ext, "jpeg") || Operator.equalsIgnoreCase(ext, "png") || Operator.equalsIgnoreCase(ext, "tiff") || Operator.equalsIgnoreCase(ext, "tif") || Operator.equalsIgnoreCase(ext, "bmp") || Operator.equalsIgnoreCase(ext, "gif")){
					filename= 	doImage(filename, "");
				}
					reader = new PdfReader(filename);
				    n = reader.getNumberOfPages();
				    for (int page = 0; page < n; ) {
				        copy.addPage(copy.getImportedPage(reader, ++page));
				    }
				    copy.freeReader(reader);
				    reader.close();
				
			}
			document.close();
			
			outputStream.close();
		 } catch (Exception e) {
				e.printStackTrace();
			}
	     return outputStream;
	}
	
	
	public static String doImage(String input, String output) {
	  
		Document document = new Document();
	   // String input = "c:/temp/capture.png"; // .gif and .jpg are ok too!
		 //String output = "c:/temp/capture.pdf";
	    try {
	    	//document.setPageSize(PageSize.LETTER.rotate());
	      File f = new File(input);
	      output = "c:/temp/"+f.getName()+".pdf";
	     
	      String outpath = "c:/temp/"+f.getName();
	      ImageUtil.resize(input, outpath, 525, 800);	
	      
	      
	      FileOutputStream fos = new FileOutputStream(output);
	      PdfWriter writer = PdfWriter.getInstance(document, fos);
	      writer.open();
	      document.open();
	      document.add(Image.getInstance(outpath));
	      document.close();
	      writer.close();
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
	    return output;
	}
	
	static ByteArrayOutputStream mergePdfFiles(List<InputStream> inputPdfList, ByteArrayOutputStream outputStream) throws Exception{
 
        //Create document and pdfReader objects.
	Document document = new Document();
        List<PdfReader> readers = 
        		new ArrayList<PdfReader>();
        int totalPages = 0;
 
        //Create pdf Iterator object using inputPdfList.
        Iterator<InputStream> pdfIterator = 
        		inputPdfList.iterator();
 
        // Create reader list for the input pdf files.
        while (pdfIterator.hasNext()) {
                InputStream pdf = pdfIterator.next();
                PdfReader pdfReader = new PdfReader(pdf);
                readers.add(pdfReader);
                totalPages = totalPages + pdfReader.getNumberOfPages();
        }
 
        // Create writer for the outputStream
        PdfWriter writer = PdfWriter.getInstance(document, outputStream);
 
        //Open document.
        document.open();
 
        //Contain the pdf data.
        PdfContentByte pageContentByte = writer.getDirectContent();
 
        PdfImportedPage pdfImportedPage;
        int currentPdfReaderPage = 1;
        Iterator<PdfReader> iteratorPDFReader = readers.iterator();
 
        // Iterate and process the reader list.
        while (iteratorPDFReader.hasNext()) {
          PdfReader pdfReader = iteratorPDFReader.next();
          //Create page and add content.
          while (currentPdfReaderPage <= pdfReader.getNumberOfPages()) {
                      document.newPage();
                      pdfImportedPage = writer.getImportedPage(
                    		  pdfReader,currentPdfReaderPage);
                      pageContentByte.addTemplate(pdfImportedPage, 0, 0);
                      currentPdfReaderPage++;
          }
          currentPdfReaderPage = 1;
        }
 
        //Close document and outputStream.
        outputStream.flush();
        document.close();
        outputStream.close();
        System.out.println("Pdf files merged successfully.");
        return outputStream;
        
	}
	
	
	public static  ByteArrayOutputStream zipDocuments(String ids) {
		// TODO Auto-generated method stub
		ByteArrayOutputStream o = new ByteArrayOutputStream();
		try {
		    //Prepare input pdf file list as list of input stream.
			
			
		    List<String> inputPdfList = new ArrayList<String>();
		    if(Operator.hasValue(ids)){
			    Sage db = new Sage();
			    
			    db.query("select * from attachments where ID in ("+Operator.sqlEscape(ids)+")");
			    while(db.next()){
			    	inputPdfList.add((Config.getString("files.storage_path")+db.getString("PATH")));
			    }
			    db.clear();
			    //Prepare output stream for merged pdf file.
			     o =  writeToZipFile(inputPdfList, o);  
		     
		    }
		    
		    
		    
		   } catch (Exception e) {
			e.printStackTrace();
		  }
		return o;
	}
	
	
	public static ByteArrayOutputStream writeToZipFile(List<String> inputPdfList,ByteArrayOutputStream fos) throws FileNotFoundException, IOException {
		
		try{
			
			//FileOutputStream fos = new FileOutputStream("sample.zip"); 
			ZipOutputStream zipOS = new ZipOutputStream(fos); 
			
			 
			 for(String f : inputPdfList){
				 writeToZipFile(f, zipOS);
			 }
			
			
			zipOS.close(); 
			fos.close(); 
		}
		catch(Exception e){
			Logger.error(e.getMessage());
		}
		return fos;
	} 
	
	public static void writeToZipFile(String path, ZipOutputStream zipStream) throws FileNotFoundException, IOException {
		System.out.println("Writing file : '" + path + "' to zip file");
		try{
			File aFile = new File(path); 
			FileInputStream fis = new FileInputStream(aFile); 
			ZipEntry zipEntry = new ZipEntry(aFile.getName()); 
			zipStream.putNextEntry(zipEntry); 
			
			byte[] bytes = new byte[1024]; 
			int length; 
			while ((length = fis.read(bytes)) >= 0) { 
				zipStream.write(bytes, 0, length);
			} 
			zipStream.closeEntry(); 
			fis.close(); 
		}
		catch(Exception e){
			Logger.error(e.getMessage());
		}
	} 
	
	
}
