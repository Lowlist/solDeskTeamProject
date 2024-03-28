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
import com.team.mapper.WeatherMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class WeatherServiceImpl implements WeatherService {

	@Autowired
	private WeatherMapper weatherMapper;
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String LIVING_WEATHER_URL = "https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/";
	private final String METHOD ="accept";
	private final String FORM ="application/json";
	private ObjectMapper objectMapper = new ObjectMapper();
	
	public String nowTime() {
		LocalDate today = LocalDate.now();
        // 시각을 오전 6시로 고정합니다.
        LocalTime fixedTime = LocalTime.of(6, 0);
        // 현재 날짜에는 해당하는 오전 6시의 LocalDateTime 객체를 생성합니다.
        LocalDateTime dateTime = LocalDateTime.of(today, fixedTime);
        // 날짜와 시간을 원하는 형식으로 포맷합니다.
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
        String formattedDateTime = dateTime.format(formatter);
        // 결과를 출력합니다.
        System.out.println("현재 날짜의 오전 6시: " + formattedDateTime);
    	return formattedDateTime;
	}
	
	public String asdf(String area) {
			area="1100000000";
//			String characterName = URLEncoder.encode(id, StandardCharsets.UTF_8);
			String API_URL = 
					LIVING_WEATHER_URL + "getAirDiffusionIdxV4?serviceKey=" +
					API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
					area +"&time="+ nowTime();
			HttpHeaders headers = new HttpHeaders();
			System.out.println(API_URL);
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
			ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
			return roots.getBody();
	}
	
	@Override
	public LivingWeather jsonRun(String jsondata) {
		LivingWeather info = new LivingWeather();
		jsondata = asdf("a");
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata,LivingWeather.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
	}
	
}