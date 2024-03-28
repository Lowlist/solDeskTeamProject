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
import com.team.dto.asosdalyinfo.AsosDalyInfo;
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
	private final String METHOD ="accept";
	private final String FORM ="application/json";
	private final String LIVING_WEATHER_URL = "https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/";
	private final String ASOS_DALY_INFO_URL = "https://apis.data.go.kr/1360000/AsosDalyInfoService/";
	// 형주
	private final String MEDIUM_WEATHER_URL = "http://apis.data.go.kr/1360000/MidFcstInfoService/";
	
	public String nowTime() {
		LocalDate today = LocalDate.now();
        LocalTime fixedTime = LocalTime.of(6, 0);
        LocalDateTime dateTime = LocalDateTime.of(today, fixedTime);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
        String nowTime = dateTime.format(formatter);
    	return nowTime;
	}
	
	// 어제 날짜부터 일주일
	public String oneWeekCalc(int check) {
        LocalDate today = LocalDate.now();
        LocalDate oneDayAgo = today.minusDays(1);
        LocalDate oneWeekAgo = oneDayAgo.minusWeeks(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		if(check == 1) {
			return oneDayAgo.format(formatter);
		} else {
			return oneWeekAgo.format(formatter);
		}
	}
	
	// 형주
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
	
	public String asosDalyInfoApi(String area) {
		String API_URI = 
				ASOS_DALY_INFO_URL + "getWthrDataList?serviceKey=" +
				API_KEY + "&pageNo=1&numOfRows=10&dataType=json&dataCd=ASOS&dateCd=DAY" +
				"&startDt=" + oneWeekCalc(0) + "&endDt=" + oneWeekCalc(1) +
				"&stnIds=" + returnAsosDalyAreaNum(area);
		System.out.println(API_URI);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(METHOD, FORM);
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
	
	public String livingWeatherAirApi(String area) {
		String API_URI = 
				LIVING_WEATHER_URL + "getAirDiffusionIdxV4?serviceKey=" +
				API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
				returnLivingAreaNum(area) +"&time="+ nowTime();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(METHOD, FORM);
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
	
	public String livingWeatherUVApi(String area) {
		String API_URI = 
				LIVING_WEATHER_URL + "getUVIdxV4?serviceKey=" +
				API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
				returnLivingAreaNum(area) +"&time="+ nowTime();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(METHOD, FORM);
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
	
	@Override
	public LivingWeather livingWeatherRun(String area) {
		LivingWeather response = new LivingWeather();
		String jsonData = livingWeatherAirApi(area);
		try {
			response = objectMapper.readValue(jsonData,LivingWeather.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
		return response;
	}
	
	@Override
	public AsosDalyInfo asosDalyInfoRun(String area) {
		AsosDalyInfo response = new AsosDalyInfo();
		String jsonData = asosDalyInfoApi(area);
		try {
			response = objectMapper.readValue(jsonData,AsosDalyInfo.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	// 형주
	@Override
	public MediumWeather mediumWeatherRun(String area) {
		MediumWeather response = new MediumWeather();
		String jsonData = MediumTemperaturesApi(area);
		try {
			response = objectMapper.readValue(jsonData,MediumWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	public String returnLivingAreaNum(String area) {
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
	
	public String returnAsosDalyAreaNum(String area) {
//		만약 UTF-8 필요하면 사용해서 바꾸면 됩니다.
//		String characterName = URLEncoder.encode(id, StandardCharsets.UTF_8);
		if(area.equals("서울")) {
			area="108";
		}
		else if(area.equals("인천")) {
			area="112";
		}
		else if(area.equals("수원")) {
			area="119";
		}
		else if(area.equals("파주")) {
			area="99";
		}
		else if(area.equals("춘천")) {
			area="101";
		}
		else if(area.equals("원주")) {
			area="114";
		}
		else if(area.equals("강릉")) {
			area="105";
		}
		else if(area.equals("대전")) {
			area="133";
		}
		else if(area.equals("서산")) {
			area="129";
		}
		else if(area.equals("세종")) {
			area="239";
		}
		else if(area.equals("청주")) {
			area="131";
		}
		else if(area.equals("제주")) {
			area="184";
		}
		else if(area.equals("서귀포")) {
			area="189";
		}
		else if(area.equals("광주")) {
			area="156";
		}
		else if(area.equals("목포")) {
			area="165";
		}
		else if(area.equals("여수")) {
			area="168";
		}
		else if(area.equals("전주")) {
			area="146";
		}
		else if(area.equals("군산")) {
			area="140";
		}
		else if(area.equals("부산")) {
			area="159";
		}
		else if(area.equals("울산")) {
			area="152";
		}
		else if(area.equals("경남")) {
			area="155";
		}
		else if(area.equals("대구")) {
			area="143";
		}
		else if(area.equals("안동")) {
			area="136";
		}
		else if(area.equals("포항")) {
			area="138";
		}
		return area;
	} 
	
	// 형주
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