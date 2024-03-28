package com.team.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.dto.livingwthr.LivingWeather;
import com.team.dto.mediumwthr.temperature.MediumWeather;
import com.team.mapper.WeatherMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class WeatherServiceImpl implements WeatherService {

	@Autowired
	private WeatherMapper weatherMapper;
	
	private ObjectMapper objectMapper = new ObjectMapper();
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String LIVING_WEATHER_URL = "https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/";
	private final String MEDIUM_WEATHER_URL = "http://apis.data.go.kr/1360000/MidFcstInfoService/";
	private final String METHOD ="accept";
	private final String FORM ="application/json";
	
	public String nowTime() {
		LocalDate today = LocalDate.now();
        LocalTime fixedTime = LocalTime.of(6, 0);
        LocalDateTime dateTime = LocalDateTime.of(today, fixedTime);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
        String nowTime = dateTime.format(formatter);
        System.out.println("나우타임에서...."+nowTime);
    	return nowTime;
	}
	
	public String livingWeatherApi(String area) {
		String API_URL = 
				LIVING_WEATHER_URL + "getAirDiffusionIdxV4?serviceKey=" +
				API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
				returnLivingAreaNum(area) +"&time="+ nowTime();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(METHOD, FORM);
		// 헤더 끝
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		return response.getBody();
	}
	public String MediumTemperaturesApi(String area) {
		String API_URL = 
				MEDIUM_WEATHER_URL + "getMidTa?serviceKey=" +
				API_KEY + "&numOfRows=10&pageNo=1&regId="+ returnMediumAreaNum(area) +"&tmFc="+ nowTime() +"&dataType=JSON" ;
		System.out.println(API_URL);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(METHOD, FORM);
		// 헤더 끝
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		return response.getBody();
	}
	
	@Override
	public LivingWeather livingWeatherRun(String area) {
		LivingWeather response = new LivingWeather();
		String jsonData = livingWeatherApi(area);
		try {
            // JSON 문자열을 해당 객체로 변환
			response = objectMapper.readValue(jsonData,LivingWeather.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return response;
	}
	@Override
	public MediumWeather mediumWeatherRun(String area) {
		MediumWeather response = new MediumWeather();
		String jsonData = MediumTemperaturesApi(area);
		try {
			// JSON 문자열을 해당 객체로 변환
			response = objectMapper.readValue(jsonData,MediumWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
			// 예외 처리 로직 추가
		}
		return response;
	}

	public String returnLivingAreaNum(String area) {
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
	public String returnMediumAreaNum(String area) {
		if(area.equals("서울")) {
			area="11B10101";
		}
		else if(area.equals("인천")) {
			area="11B20201";
		}
		else if(area.equals("수원")) {
			area="11B20601";
		}
		else if(area.equals("파주")) {
			area="11B20305";
		}
		else if(area.equals("춘천")) {
			area="11D10301";
		}
		else if(area.equals("원주")) {
			area="11D10401";
		}
		else if(area.equals("강릉")) {
			area="11D20501";
		}
		else if(area.equals("대전")) {
			area="11C20401";
		}
		else if(area.equals("서산")) {
			area="11C20101";
		}
		else if(area.equals("세종")) {
			area="11C20404";
		}
		else if(area.equals("청주")) {
			area="11C10301";
		}
		else if(area.equals("제주")) {
			area="11G00201";
		}
		else if(area.equals("서귀포")) {
			area="11G00401";
		}
		else if(area.equals("광주")) {
			area="11F20501";
		}
		else if(area.equals("목포")) {
			area="21F20801";
		}
		else if(area.equals("여수")) {
			area="11F20401";
		}
		else if(area.equals("전주")) {
			area="11F10201";
		}
		else if(area.equals("군산")) {
			area="21F10501";
		}
		else if(area.equals("부산")) {
			area="11H20201";
		}
		else if(area.equals("울산")) {
			area="11H20101";
		}
		else if(area.equals("창원")) {
			area="11H20301";
		}
		else if(area.equals("대구")) {
			area="11H10701";
		}
		else if(area.equals("안동")) {
			area="11H10501";
		}
		else if(area.equals("포항")) {
			area="11H10201";
		}
		return area;
	} 
}