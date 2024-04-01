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
import com.team.dto.mediumwthr.temperature.MediumTemperature;
import com.team.dto.mediumwthr.weather.MediumWeather;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class WeatherMediumService {
	
	@Autowired
	private WeatherMapper mapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String MEDIUM_WEATHER_URL = "http://apis.data.go.kr/1360000/MidFcstInfoService/";
	
	// 형주 중기기상(온도) api로직 
	public void mediumTemperaturesApi(String area,SqlData sql) {
		String API_URL = 
			MEDIUM_WEATHER_URL + "getMidTa?serviceKey=" +
			API_KEY + "&numOfRows=10&pageNo=1&regId=" +
			mediumTemperatureArea(area) + "&tmFc=" +
			work.nowTime() +"&dataType=JSON";
		System.out.println(API_URL);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(work.METHOD, work.FORM);
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		sql.setJsonData(response.getBody());
		mapper.insertSqlData(sql);
	}
	
	// 형주 중기기상(날씨) api로직
	public void mediumWeatherApi(String area,SqlData sql) {
		String API_URL =
			MEDIUM_WEATHER_URL + "getMidLandFcst?serviceKey=" + 
			API_KEY + "&numOfRows=10&pageNo=1&regId=" + 
			mediumWeatherArea(area) + "&tmFc=" + 
			work.nowTime() + "&dataType=JSON";
		System.out.println(API_URL);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(work.METHOD,work.FORM);
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		sql.setJsonData(response.getBody());
		mapper.insertSqlData(sql);
	}
	
	// 오브젝트 맵퍼 json 정렬화 후 반환문
	public MediumTemperature mediumTemperatureJson(SqlData data) {
		MediumTemperature response = new MediumTemperature();
		String jsonData = mapper.selectJsonData(data);
		System.out.println(jsonData);
		try {
			response = work.objectMapper.readValue(jsonData, MediumTemperature.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}

	// 오브젝트 맵퍼 json 정렬화 후 반환문
	public MediumWeather mediumWeatherJson(SqlData data) {
		MediumWeather response = new MediumWeather();
		String jsonData = mapper.selectJsonData(data);
		System.out.println(jsonData);
		try {
			response = work.objectMapper.readValue(jsonData, MediumWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}

	// 컨트롤러에서 직접적으로 실행로직 (대기질)
	public MediumTemperature mediumTempRun(String area) {
		SqlData in = new SqlData();
		in.setTableName("medium_table");
		in.setStandardName("temperature"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			mediumTemperaturesApi(area,in);
			System.out.println("api로데이터불러왔음");
		}
		return mediumTemperatureJson(in);
	}
	
	// 컨트롤러에서 직접적으로 실행로직 (대기질)
	public MediumWeather mediumWeatherRun(String area) {
		SqlData in = new SqlData();
		in.setTableName("medium_table");
		in.setStandardName("weather"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			mediumWeatherApi(area, in);
			System.out.println("api로데이터불러왔음");
		}
		return mediumWeatherJson(in);
	}
	
	// 파라미터 값 변환 로직
	public String mediumTemperatureArea(String area) {
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
	
	// 파라미터 값 변환 로직(날씨)
	public String mediumWeatherArea(String area) {
		if(area.equals("서울") || area.equals("인천") || area.equals("경기도")) {
			area="11B00000";
		}
		else if(area.equals("강원도영서")) {
			area="11D10000";
		}
		else if(area.equals("강원도영동")) {
			area="11D20000";
		}
		else if(area.equals("대전") || area.equals("세종") || area.equals("충청남도")) {
			area="11C20000";
		}
		else if(area.equals("충청북도")) {
			area="11C10000";
		}
		else if(area.equals("광주") || area.equals("전라남도")) {
			area="11F20000";
		}
		else if(area.equals("전라북도")) {
			area="11F10000";
		}
		else if(area.equals("대구") || area.equals("경상북도")) {
			area="11H10000";
		}
		else if(area.equals("부산") || area.equals("울산") || area.equals("경상남도")) {
			area="11H20000";
		}
		else if(area.equals("제주도")) {
			area="11G00000";
		}
		return area;
	} 
}