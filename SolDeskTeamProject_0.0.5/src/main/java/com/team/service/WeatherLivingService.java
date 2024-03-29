package com.team.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.team.dto.livingwthr.LivingWeather;
import com.team.mapper.WeatherMapper;

@Service
public class WeatherLivingService {

	@Autowired
	private WeatherMapper weatherMapper;
	@Autowired
	private PublicWork time;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String LIVING_WEATHER_URL = "https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/";
	
	//생활기상지수 대기 api 로직
	public String livingWeatherAirApi(String area) {
		String API_URI = 
			LIVING_WEATHER_URL + "getAirDiffusionIdxV4?serviceKey=" +
			API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
			livingArea(area) +"&time="+ time.nowTime();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(time.METHOD, time.FORM);
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
	
	//생활기상지수 자외선 api 로직
	public String livingWeatherUVApi(String area) {
		String API_URI = 
			LIVING_WEATHER_URL + "getUVIdxV4?serviceKey=" +
			API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
			livingArea(area) + "&time=" + time.nowTime();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(time.METHOD, time.FORM);
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
	public LivingWeather livingWeatherRun(String area) {
		LivingWeather response = new LivingWeather();
		String jsonData = livingWeatherAirApi(area);
		try {
			response = time.objectMapper.readValue(jsonData,LivingWeather.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
		return response;
	}
	
	// 컨트롤러로 이동 후 구현하는 로직
	public LivingWeather livingWeatherUVRun(String area) {
		LivingWeather response = new LivingWeather();
		String jsonData = livingWeatherUVApi(area);
		try {
			response = time.objectMapper.readValue(jsonData,LivingWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	// 파라미터 값 변환 로직
	public String livingArea(String area) {
//		만약 UTF-8 필요하면 사용해서 바꾸면 됩니다.
//		String characterName = URLEncoder.encode(id, StandardCharsets.UTF_8);
		if(area.equals("서울")) {
			area="1100000000";
		}
		else if(area.equals("인천")) {
			area="2800000000";
		}
		else if(area.equals("수원")) {
			area="4111000000";
		}
		else if(area.equals("파주")) {
			area="4148000000";
		}
		else if(area.equals("춘천")) {
			area="5111000000";
		}
		else if(area.equals("원주")) {
			area="5113000000";
		}
		else if(area.equals("강릉")) {
			area="5115000000";
		}
		else if(area.equals("대전")) {
			area="3000000000";
		}
		else if(area.equals("서산")) {
			area="4421000000";
		}
		else if(area.equals("세종")) {
			area="3600000000";
		}
		else if(area.equals("청주")) {
			area="4311100000";
		}
		else if(area.equals("제주")) {
			area="5000000000";
		}
		else if(area.equals("서귀포")) {
			area="5013000000";
		}
		else if(area.equals("광주")) {
			area="2900000000";
		}
		else if(area.equals("목포")) {
			area="4611000000";
		}
		else if(area.equals("여수")) {
			area="4613000000";
		}
		else if(area.equals("전주")) {
			area="4511100000";
		}
		else if(area.equals("군산")) {
			area="4513000000";
		}
		else if(area.equals("부산")) {
			area="2600000000";
		}
		else if(area.equals("울산")) {
			area="3100000000";
		}
		else if(area.equals("경남")) {
			area="4800000000";
		}
		else if(area.equals("대구")) {
			area="2700000000";
		}
		else if(area.equals("안동")) {
			area="4717000000";
		}
		else if(area.equals("포항")) {
			area="4711100000";
		}
		return area;
	} 
}