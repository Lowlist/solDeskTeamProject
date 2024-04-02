package com.team.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.team.dto.shortwthr.ShortWeather;
import com.team.mapper.WeatherMapper;


@Service
public class ShortService {
	
	@Autowired
	private WeatherMapper weatherMapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "fpqEuKWzMPUU0PhKfNijGVZnZjweMezdxekVC6Y71Yb3Ki1h1WzMmnLZnqDioAGcwkbtEcRBa36OJrG6TABKHg%3D%3D";
	private final String SHORT_DALY_INFO_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/";
	
	// 단기예보 조회 api
	public String ShortWeatherInfoApi(String area ) {
		String nx = shortWeatherArea(area).get(0);
		String ny = shortWeatherArea(area).get(1);
		String API_URI = 
			SHORT_DALY_INFO_URL + "getVilageFcst?serviceKey=" +
			API_KEY + "&pageNo=1&numOfRows=1000&dataType=json&base_date="+work.nowDate()+"&base_time=0500&nx="+nx+"&ny="+ny;
		HttpHeaders headers = new HttpHeaders();
		System.out.println(API_URI);
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(work.METHOD, work.FORM);
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URI);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        return response.getBody();
	}
	
	
	// 컨트롤러로 이동 후 구현하는 로직
	public ShortWeather shortWeatherRun(String area ) {
		ShortWeather response = new ShortWeather();
		String jsonData = ShortWeatherInfoApi(area);
		try {
			response = work.objectMapper.readValue(jsonData,ShortWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return response;
	}
	
	// 파라미터 값 변환 로직
	public List<String> shortWeatherArea(String area) {
//		만약 UTF-8 필요하면 사용해서 바꾸면 됩니다.
//		String characterName = URLEncoder.encode(id, StandardCharsets.UTF_8);
		String nx = null;
		String ny = null;
		
		List<String> list = new ArrayList<>();
		
		if(area.equals("서울")) {
			nx="60";
			ny="127";
		}
		else if(area.equals("인천")) {
			nx="55";
			ny="124";
		}
		else if(area.equals("수원")) {
			nx="60";
			ny="121";	
		}
		else if(area.equals("파주")) {
			nx="56";
			ny="131";
		}
		else if(area.equals("춘천")) {
			nx="73";
			ny="134";
		}
		else if(area.equals("원주")) {
			nx="76";
			ny="122";
		}
		else if(area.equals("강릉")) {
			nx="92";
			ny="131";
		}
		else if(area.equals("대전")) {
			nx="67";
			ny="100";
		}
		else if(area.equals("서산")) {
			nx="51";
			ny="110";
		}
		else if(area.equals("세종")) {
			nx="66";
			ny="103";
		}
		else if(area.equals("청주")) {
			nx="69";
			ny="106";
		}
		else if(area.equals("제주")) {
			nx="52";
			ny="38";
		}
		else if(area.equals("서귀포")) {
			nx="52";
			ny="33";
		}
		else if(area.equals("광주")) {
			nx="58";
			ny="74";
		}
		else if(area.equals("목포")) {
			nx="50";
			ny="67";
		}
		else if(area.equals("여수")) {
			nx="73";
			ny="66";
		}
		else if(area.equals("전주")) {
			nx="63";
			ny="89";
		}
		else if(area.equals("군산")) {
			nx="56";
			ny="92";
		}
		else if(area.equals("부산")) {
			nx="98";
			ny="76";
		}
		else if(area.equals("울산")) {
			nx="102";
			ny="84";
		}
		else if(area.equals("경남")) {
			nx="91";
			ny="77";
		}
		else if(area.equals("대구")) {
			nx="89";
			ny="90";
		}
		else if(area.equals("안동")) {
			nx="91";
			ny="106";
		}
		else if(area.equals("포항")) {
			nx="102";
			ny="94";
		}
		
		list.add(nx);
		list.add(ny);
		
		return list; // [nx, ny]
	} 
}