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
		
	
		
		
		
		 // 检测是否为多媒体上传
       if (!ServletFileUpload.isMultipartContent(request)) {
           // 如果不是则停止
           PrintWriter writer = response.getWriter();
           writer.println("Error: 表单必须包含 enctype=multipart/form-data");
           writer.flush();
           return;
       }
 
       // 配置上传参数
       DiskFileItemFactory factory = new DiskFileItemFactory();
       // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
       factory.setSizeThreshold(1024 * 1024 * 50);
       // 设置临时存储目录
       factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
       ServletFileUpload upload = new ServletFileUpload(factory);
         
       // 设置最大文件上传值
       upload.setFileSizeMax(1024 * 1024 * 50);
         
       // 设置最大请求值 (包含文件和表单数据)
       upload.setSizeMax(1024 * 1024 * 50);
 
       // 构造临时路径来存储上传的文件
       // 这个路径相对当前应用的目录
      // String uploadPath = getServletContext().getRealPath("./") + File.separator + upload;
       //getServletContext().getRealPath("image");这个路径就是Tomcat下编译的那个工程的image文件路径
       //这个是下编译的那个工程的相对路径
       String uploadPath = getServletContext().getRealPath("image");
        System.out.println("-->"+uploadPath); 
       // 如果目录不存在则创建
       File uploadDir = new File(uploadPath);
       if (!uploadDir.exists()) {
           uploadDir.mkdir();
       }
       
       try {
           // 解析请求的内容提取文件数据
           @SuppressWarnings("unchecked")
           List<FileItem> formItems = upload.parseRequest(request);
 
           if (formItems != null && formItems.size() > 0) {
               // 迭代表单数据
               for (FileItem item : formItems) {
                   // 处理不在表单中的字段
            	   if("name".equals(item.getFieldName())){
            		   name = item.getString();
            		   System.out.println(name);
            	   }
                   if (!item.isFormField()) {
                       //String fileName = new File(item.getName()).getName();
                       //filePath = uploadPath + File.separator + fileName;
                	   String fileName = "shangpin_" + name + ".jpg";
                	   //filePath = request.getContextPath().getRealPath("./")+"image/"+fileName;
                       //你要是想想访问图片的haul就直接getServletContext().getRealPath("image")+“/”图片名;
                	   filePath = uploadPath+"/"+fileName;
                	   File storeFile = new File(filePath);
                       // 在控制台输出文件的上传路径
                       System.out.println(filePath);
                       // 保存文件到硬盘
                       item.write(storeFile);
                       //request.setAttribute("message",
                       //    "文件上传成功!");
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
			errors.append("编号不能为空");			
		}
       if(!errors.toString().equals("")){
			
    	   response.sendRedirect("http://localhost:8080/OnlineShop/home/insertpicture.jsp");
		}
		else {
			errors.append("添加商品图片成功");
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/home/insertpicture.jsp").forward(request, response);
		}
		return;
       
       
       
       //bookService.insertpicture(name, filePath);
       
   	
	}

}
