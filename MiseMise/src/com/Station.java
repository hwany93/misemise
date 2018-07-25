package com;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class station
 */
@WebServlet("/station")
public class Station extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Station() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//공공DB 주소
		String addr = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getMsrstnList?serviceKey=nSkUSRtsYG6iVXy1Vyr%2BLtmIfdoWCGnSooLtoInLZZapljVbYZTizmyZ9gqVaRriE2jWKYOkTvN0fMbF8s2eEA%3D%3D&numOfRows=375&pageSize=375&pageNo=1&startPage=1&_returnType=json";
		
		PrintWriter out = response.getWriter();

		//Json 읽어오는 과정
		URL url = new URL(addr);
		InputStream in = url.openStream(); 
		ByteArrayOutputStream  bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();
	    
		//Json 인코딩에 맞게 변환하는 과정
		String mbos = bos1.toString("UTF-8");
		System.out.println("mbos: "+mbos);
		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);
		
		//json 프린트창에 찍어보기
		JSONObject json = new JSONObject();
		json.put("data", s);
		System.out.println("json: "+json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
