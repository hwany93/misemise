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
 * Servlet implementation class Mise
 */
@WebServlet("/Mise")
public class Mise extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Mise() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//공공DB 주소 아래 부분은 파라미터입니다.
		String addr = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
				+ "?numOfRows=10&pageSize=10&pageNo=1&startPage=1&dataTerm=DAILY&ver=1.3&_returnType=json";
		//인증키
		String serviceKey = "&serviceKey=nSkUSRtsYG6iVXy1Vyr%2BLtmIfdoWCGnSooLtoInLZZapljVbYZTizmyZ9gqVaRriE2jWKYOkTvN0fMbF8s2eEA%3D%3D";
		//지역구
		String location = request.getQueryString();
		//지역구 파라미터
		String parameter = "&stationName=" + location;
		
		PrintWriter out = response.getWriter();

		//Json 읽어오는 과정
		addr = addr + serviceKey + parameter;
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
