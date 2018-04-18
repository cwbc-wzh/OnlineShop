package com.atwzh.store.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.atwzh.store.service.ShangpinService;

/**
 * Servlet implementation class FileUpload
 */
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShangpinService bookService = new ShangpinService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String id = request.getParameter("id");
		String name = null;
		String filePath = null;
		
	
		
		
		
		 // ����Ƿ�Ϊ��ý���ϴ�
       if (!ServletFileUpload.isMultipartContent(request)) {
           // ���������ֹͣ
           PrintWriter writer = response.getWriter();
           writer.println("Error: ��������� enctype=multipart/form-data");
           writer.flush();
           return;
       }
 
       // �����ϴ�����
       DiskFileItemFactory factory = new DiskFileItemFactory();
       // �����ڴ��ٽ�ֵ - �����󽫲�����ʱ�ļ����洢����ʱĿ¼��
       factory.setSizeThreshold(1024 * 1024 * 50);
       // ������ʱ�洢Ŀ¼
       factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
       ServletFileUpload upload = new ServletFileUpload(factory);
         
       // ��������ļ��ϴ�ֵ
       upload.setFileSizeMax(1024 * 1024 * 50);
         
       // �����������ֵ (�����ļ��ͱ�����)
       upload.setSizeMax(1024 * 1024 * 50);
 
       // ������ʱ·�����洢�ϴ����ļ�
       // ���·����Ե�ǰӦ�õ�Ŀ¼
      // String uploadPath = getServletContext().getRealPath("./") + File.separator + upload;
       //getServletContext().getRealPath("image");���·������Tomcat�±�����Ǹ����̵�image�ļ�·��
       //������±�����Ǹ����̵����·��
       String uploadPath = getServletContext().getRealPath("image");
        System.out.println("-->"+uploadPath); 
       // ���Ŀ¼�������򴴽�
       File uploadDir = new File(uploadPath);
       if (!uploadDir.exists()) {
           uploadDir.mkdir();
       }
       
       try {
           // ���������������ȡ�ļ�����
           @SuppressWarnings("unchecked")
           List<FileItem> formItems = upload.parseRequest(request);
 
           if (formItems != null && formItems.size() > 0) {
               // ����������
               for (FileItem item : formItems) {
                   // �����ڱ��е��ֶ�
            	   if("name".equals(item.getFieldName())){
            		   name = item.getString();
            		   System.out.println(name);
            	   }
                   if (!item.isFormField()) {
                       //String fileName = new File(item.getName()).getName();
                       //filePath = uploadPath + File.separator + fileName;
                	   String fileName = "shangpin_" + name + ".jpg";
                	   //filePath = request.getContextPath().getRealPath("./")+"image/"+fileName;
                       //��Ҫ���������ͼƬ��haul��ֱ��getServletContext().getRealPath("image")+��/��ͼƬ��;
                	   filePath = uploadPath+"/"+fileName;
                	   File storeFile = new File(filePath);
                       // �ڿ���̨����ļ����ϴ�·��
                       System.out.println(filePath);
                       // �����ļ���Ӳ��
                       item.write(storeFile);
                       //request.setAttribute("message",
                       //    "�ļ��ϴ��ɹ�!");
                   }else{
                	   //else
                	  
                	  
               		
                   }
               }
           }
       } catch (Exception ex) {
    	   ex.printStackTrace();
       }
       StringBuffer errors = new StringBuffer("");
       if(name == null || name.trim().equals("")){
			errors.append("��Ų���Ϊ��");			
		}
       if(!errors.toString().equals("")){
			
    	   response.sendRedirect("http://localhost:8080/OnlineShop/home/insertpicture.jsp");
		}
		else {
			errors.append("�����ƷͼƬ�ɹ�");
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/home/insertpicture.jsp").forward(request, response);
		}
		return;
       
       
       
       //bookService.insertpicture(name, filePath);
       
   	
	}

}
