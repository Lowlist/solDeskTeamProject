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

import com.team.dto.shortwthr.ShortWeather;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class HomeService {
	
	@Autowired
	private WeatherMapper mapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String HOME_SHORT_INFO_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/";
	
	// home에서 사용할 단기 기상정보 api
	public void homeShortInfoApi(String gridX,String gridY,SqlData sql) {
		String API_URI = 
				HOME_SHORT_INFO_URL + "getVilageFcst?serviceKey=" +
				API_KEY + "&pageNo=1&numOfRows=1000&dataType=json&base_date="+
				work.nowDateShort()+"&base_time=0500&nx="+gridX+"&ny="+gridY;
		HttpHeaders headers = new HttpHeaders();
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
		sql.setJsonData(response.getBody());
		mapper.insertSqlData(sql);
	}
	
	// 오브젝트 맵퍼 json 정렬화 후 반환문
	public ShortWeather homeJson(SqlData data) {
		ShortWeather response = new ShortWeather();
		String jsonData = mapper.selectJsonData(data);
		try {
			response = work.objectMapper.readValue(jsonData,ShortWeather.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	public String jsonRun(SqlData data) {
		String jsonData = mapper.selectJsonData(data);
		return jsonData;
	}
	public String getJsonData(String gridX,String gridY) {
		SqlData in = new SqlData();
		in.setTableName("short_table");
		in.setStandardName("short"+gridX+"/"+gridY);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			homeShortInfoApi(gridX,gridY,in);
		} 
		String run = jsonRun(in);
		return run;
	}
	// 컨트롤러에서 직접적으로 실행로직
	public ShortWeather homeRun(String gridX,String gridY) {
		SqlData in = new SqlData();
		in.setTableName("short_table");
		in.setStandardName("short"+gridX+"/"+gridY);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			homeShortInfoApi(gridX,gridY,in);
			System.out.println("API 들렸음");
		} 
		return homeJson(in);
	}
	
}