package timepill.kakao.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import org.springframework.stereotype.Service;

@Service
public class HttpCallService {

	/** HTTP 요청을 보내고 응답을 받는 메소드 */
	public String Call(String method, String reqURL, String header, String param) {
		
		String result = "";
		int responseCode = 0;
		
		try {
			
			String response = "";
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // 요청 URL
			
			System.out.println("HTTP 요청 시작: " + reqURL);
			
			conn.setRequestMethod(method); // 요청 method 타입
			conn.setRequestProperty("Authorization", header); // 인증 방식 ex)액세스 토큰으로 인증 요청
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			
			if (param != null) {
				System.out.println("파라미터 존재: " + param);
				conn.setDoOutput(true);
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(param);
				bw.flush();
			}
			
			// HTTP 응답 코드 반환
			responseCode = conn.getResponseCode();
			System.out.println("HTTP 응답 코드: " + responseCode);
	        System.out.println("요청 URL: " + reqURL);
	        System.out.println("요청 메서드: " + method);
	        System.out.println("Authorization 헤더: " + header);

			// 에러 체크
			InputStream stream = conn.getErrorStream();
			if (stream != null) {
				try (Scanner scanner = new Scanner(stream)) {
					scanner.useDelimiter("\\Z");
					response = scanner.next();
				}
				System.out.println("에러 응답: " + response);
			}

			// HTTP 응답 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("HTTP 응답 본문: " + result);
			br.close();
			
		} catch (IOException e) {
			System.out.println("예외 발생: " + e.getMessage());
			if (responseCode == 401) {
				return Integer.toString(responseCode);
			}
			return e.getMessage();
			
		}
		
		return result;
	}

	/** 액세스 토큰을 포함하여 HTTP 요청을 보내는 메소드 */
	public String CallwithToken(String method, String reqURL, String access_Token) {
		return CallwithToken(method, reqURL, access_Token, null);
	}

	/** 액세스 토큰과 파라미터를 포함하여 HTTP 요청을 보내는 메소드 */
	public String CallwithToken(String method, String reqURL, String access_Token, String param) {
		String header = "Bearer " + access_Token;
		return Call(method, reqURL, header, param);
	}
}
