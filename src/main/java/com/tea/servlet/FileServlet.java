package com.tea.servlet;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tea.Constants;
import com.tea.dto.UploadImageInfo;

@WebServlet("/file/uploadImage")
public class FileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FileServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/xml");// 是xml
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding(Constants.UTF_8);
		String filepath = getServletContext().getRealPath(Constants.SAVE_DIR);// 文件上传的路径，实际开发中一般用相对路径
		String lineContent = "";
		String name = "";
		String filename = "";
		ServletInputStream in = request.getInputStream();
		byte[] buf = new byte[4048];
		int len = in.readLine(buf, 0, buf.length);
		String f = new String(buf, 0, len - 1);
		while ((len = in.readLine(buf, 0, buf.length)) != -1) {
			lineContent = new String(buf, 0, len, Constants.UTF_8);// 解决汉字乱码问题

			int j = lineContent.lastIndexOf("\"");
			int s = lineContent.indexOf("filename");
			name = lineContent.substring(s + 10, j);
			if (lineContent.indexOf("filename") > 0) {
				filename = name;
			}
			lineContent = name;// 通过上述处理可以得到上传的文件名
			System.out.println("filename=" + lineContent);
			DataOutputStream fileStream = new DataOutputStream(
					new BufferedOutputStream(new FileOutputStream(filepath + lineContent)));
			len = in.readLine(buf, 0, buf.length);
			len = in.readLine(buf, 0, buf.length);
			while ((len = in.readLine(buf, 0, buf.length)) != -1) {
				String tempf = new String(buf, 0, len - 1);
				if (tempf.equals(f) || tempf.equals(f + "--")) {
					break;
				} else {
					fileStream.write(buf, 0, len); // 写入
				}
			}
			fileStream.close();
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType(Constants.AJAX_CONTENT_TYPE);
		mapper.setSerializationInclusion(Include.NON_NULL);
		UploadImageInfo info = new UploadImageInfo();
		info.setMessage("图片上传成功！");
		info.setData(Constants.SAVE_DIR + filename);
		mapper.writeValue(response.getOutputStream(), info);
		in.close();
	}

}
