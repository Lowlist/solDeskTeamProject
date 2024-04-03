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

import com.team.dto.asosdalyinfo.AsosDalyInfo;
import com.team.dto.livingwthr.LivingWeather;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class LivingService {
	
	@Autowired
	private WeatherMapper mapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String LIVING_WEATHER_URL = "https://apis.data.go.kr/1360000/LivingWthrIdxServiceV4/";
	
	//생활기상지수 대기 api 로직
	public void livingWeatherAirApi(String area,SqlData sql) {
		String API_URI = 
			LIVING_WEATHER_URL + "getAirDiffusionIdxV4?serviceKey=" +
			API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
			livingArea(area) +"&time="+ work.nowTime();
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
	
	//생활기상지수 자외선 api 로직
	public void livingWeatherUVApi(String area,SqlData sql) {
		String API_URI = 
			LIVING_WEATHER_URL + "getUVIdxV4?serviceKey=" +
			API_KEY + "&pageNo=10&numOfRows=10&dataType=JSON&areaNo=" +
			livingArea(area) + "&time=" + work.nowTime();
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
	public LivingWeather livingJson(SqlData data) {
		LivingWeather response = new LivingWeather();
		String jsonData = mapper.selectJsonData(data);
		try {
			response = work.objectMapper.readValue(jsonData,LivingWeather.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
		return response;
	}

	// 컨트롤러에서 직접적으로 실행로직 (대기질)
	public LivingWeather livingAirRun(String area) {
		SqlData in = new SqlData();
		in.setTableName("living_table");
		in.setStandardName("air"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			livingWeatherAirApi(area,in);
			System.out.println("API 들렸음");
		}
		return livingJson(in);
	}

	// 컨트롤러에서 직접적으로 실행로직 (자외선)
	public LivingWeather livingUVRun(String area) {
		SqlData in = new SqlData();
		in.setTableName("living_table");
		in.setStandardName("UV"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			livingWeatherUVApi(area,in);
			System.out.println("API 들렸음");
		}
		return livingJson(in);
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