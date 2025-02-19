package cs.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;












import jdk.internal.org.xml.sax.InputSource;
import alain.core.utils.Cartographer;
import alain.core.utils.Logger;

import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.fonts.otf.TableHeader;
import com.itextpdf.tool.xml.XMLWorkerHelper;

import cs.common.ApiHandler;
import csshared.vo.RequestVO;

public class PrintPDF {

	
	/*public static void main(String[] args) {
		try{
		  String unsafe = FileUtil.getUrlContent("http://www.beverlyhills.org/admin/formmgr/formEntry.jsp?entryId=4947&CATEGORY_ID=3&FORM_ID=49&view=PRINT");
		  String safe = Jsoup.clean(unsafe, Whitelist.basic());
		  pdfFilename = "abc5.pdf";//args[0].trim();
		  convertHTMLToPDF.createPDF(pdfFilename,safe);
		}catch (Exception e){
			e.printStackTrace();
		}

		 }
*/
		 
	/*private void createPDF (Cartographer map, String s){
		  //path for the PDF file to be generated
		 // String path = "c:/temp/itxtpdf/" + pdfFilename;
		  PdfWriter pdfWriter = null;
		  
		  //create a new document
		  Document document = new Document();
		  
		  try {

			   //get Instance of the PDFWriter
			  // pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
			   
			   //document header attributes
			   document.addAuthor("sunil");
			   document.addCreationDate();
			   document.addProducer();
			   document.addCreator("Beverlyhillscitysmart");
			   document.addTitle("Print");
			   document.setPageSize(PageSize.A4);
	
			   //open document
			   document.open();
			   
			   //To convert a HTML file from the filesystem
			 //  String File_To_Convert = "C:/TEMP/itxtpdf/form5.html";
			   FileInputStream fis = new FileInputStream(File_To_Convert);
			   //URL for HTML page
			   //URL myWebPage = new URL("http://www.beverlyhills.org/admin/formmgr/formEntry.jsp?entryId=4947&CATEGORY_ID=3&FORM_ID=49&view=PRINT");
			   //InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
	
			   //get the XMLWorkerHelper Instance
			   XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
			   //convert to PDF
			   worker.parseXHtml(pdfWriter, document,fis);
			   
			   //close the document
			   document.close();
			   //close the writer
			   pdfWriter.close();

		  }   

		  catch (Exception e) {
			  e.printStackTrace();
		  } 

		 }*/
	
	
	
	public int convert(String htmltext, File file, String status) {
	     int exitcode = 0;        
		 status = "";
		 try {
			    
			    OutputStream pdffilestream = new FileOutputStream(file);
			    Document document = new Document();
			    PdfWriter writer = PdfWriter.getInstance(document, pdffilestream);
			    document.addAuthor("City of Beverly Hills");
			    document.setPageSize(PageSize.LETTER);
			    document.open();
			    InputStream is = new ByteArrayInputStream(htmltext.getBytes());
			    XMLWorkerHelper.getInstance().parseXHtml(writer, document, is);
			    document.close();
			    pdffilestream.close();
			    if (file.exists() && file.length() == 0) {
		            status = "Failed to create pdf file";
		            exitcode = 1;
			    }
			    return exitcode;
		 
		 } 
		 catch (Exception e) {
			    exitcode = 2;
			    status = e.getMessage();
			    return exitcode;
			}
		    
		 
	 }
	 
	 public int convert(String htmltext, ByteArrayOutputStream pdfstream, String status) {
		 int exitcode = 0;        
		 status = "";
		 try {
		    
		
		    Document document = new Document();
		    PdfWriter writer = PdfWriter.getInstance(document, pdfstream);
		    document.addAuthor("City Smart");
		    document.setPageSize(PageSize.LETTER);
		    document.open();
		    InputStream is = new ByteArrayInputStream(htmltext.getBytes());
		    XMLWorkerHelper.getInstance().parseXHtml(writer, document, is);
		    
		    
		    document.close();
		   
		    
		  
		    is = new ByteArrayInputStream(pdfstream.toByteArray());
		    PdfReader pdfReader = new PdfReader(is);
			   
			Logger.info(pdfReader.getNumberOfPages()+"############");
		    
			   PdfStamper pdfStamper =new PdfStamper(pdfReader,pdfstream);
			   pdfStamper.addSignature("sunilllllll", 2, 100f, 500f, 400f, 50f);
		
			      Image image = Image.getInstance("http://localhost:8080/cs/images/watermark/hold.png");

			      for(int i=1; i<= pdfReader.getNumberOfPages(); i++){
			    	  Logger.info("yeee");
			          PdfContentByte content = pdfStamper.getUnderContent(i);

			          image.setAbsolutePosition(100f, 400f);

			          content.addImage(image);
			          
			      }

			      pdfStamper.close();
		    
		    pdfstream.close();
		    return exitcode;
		   
		} 
		 catch (Exception e) {
			exitcode = 2;
		    status = e.getMessage();
		    e.printStackTrace();
		    Logger.error(e.getMessage());
		    return exitcode;
		}
	 

	}
	 
	
	 
	 public void convert(HttpServletRequest request, HttpServletResponse response) {
		 int exitcode = 0;        
		 
		 try {
			 
			//Cartographer map = new Cartographer(request,response); 
			RequestVO nav = new RequestVO();
		/*	nav.setEntity(map.getString("_ent"));
			nav.setToken(map.filetoken());
			nav.setType(map.getString("_type"));
			nav.setTypeid(map.getInt("_typeid"));
			nav.setId(map.getString("_id"));
			nav.setRequest("details");
			nav.setGrouptype("print");*/
			nav.setEntity("lso");
			nav.setToken("3333333");
			nav.setType("activity");
			nav.setTypeid(1774739);
			nav.setId("");
			nav.setRequest("details");
			nav.setGrouptype("print");
				
			String s = "SUNIL";//ApiHandler.post(nav); 
			response.reset();
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment;filename="+1774739+".pdf"); 
			ServletOutputStream out = response.getOutputStream();
			//StringBuilder sb = new StringBuilder();
			//ByteArrayOutputStream stream = new ByteArrayOutputStream();
		   
			Document document = new Document();
		    PdfWriter writer = PdfWriter.getInstance(document, out);
		    document.addAuthor("City of Beverly Hills");
		    document.setPageSize(PageSize.LETTER);
		    document.open();
		    InputStream is = new ByteArrayInputStream(s.getBytes());
		    XMLWorkerHelper.getInstance().parseXHtml(writer, document, is);
		    
		   // out.write(out.toByteArray());
		   // stream.close();
            document.close();
            out.close();
		    
		   /* File f = new File("c:/TEMP/");
		    sb.append("attachment; filename=\"").append("ssss.pdf").append("\"");
		    map.RESPONSE.setContentType("application/pdf");
		    map.RESPONSE.setHeader ("Content-Disposition", sb.toString());
            RandomAccessFile raf = new RandomAccessFile( f, "r" );
            map.RESPONSE.setContentLength( (int) raf.length() );
            out = map.RESPONSE.getOutputStream();
            byte [] loader = new byte [ (int) raf.length() ];
            while ( (raf.read( loader )) > 0 ) {
                  out.write( loader );
            }
		   */
		  
		   // return exitcode;
		} 
		 catch (Exception e) {
			exitcode = 2;
		    //status = e.getMessage();
		   // return exitcode;
			Logger.error(e.getMessage());
		} 
   
	 }
	 

	
		 
		 
		 
}
