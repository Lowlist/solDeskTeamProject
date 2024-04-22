package com.team.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.team.dto.mediumwthr.date.MediumDate;
import com.team.dto.mediumwthr.forecast.MediumForecast;
import com.team.dto.mediumwthr.temperature.MediumTemperature;
import com.team.dto.mediumwthr.weather.MediumWeather;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class MediumService {
	
	@Autowired
	private WeatherMapper mapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String MEDIUM_WEATHER_URL = "http://apis.data.go.kr/1360000/MidFcstInfoService/";
    
	public ArrayList<MediumDate> getDates() {
	    ArrayList<MediumDate> dateList = new ArrayList<>();
	    Calendar cal = Calendar.getInstance();
	    
	    // 현재 날짜에서 3일을 더함
	    cal.add(Calendar.DATE, 3);
	    
	    // 3일 후부터 10일 후까지의 날짜를 계산하여 ArrayList에 추가
	    for (int i = 0; i < 8; i++) { // 3일 후부터 10일 후까지 총 8일
	        // 날짜 포맷 지정
	        SimpleDateFormat dateFormat = new SimpleDateFormat("MM월 dd일");
	        SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("E");
	        // 날짜와 요일 정보를 가져옴
	        String dateStr = dateFormat.format(cal.getTime());
	        String dayOfWeekStr = dayOfWeekFormat.format(cal.getTime());
	        
	        // MediumDate 객체를 생성하고 날짜와 요일 설정
	        MediumDate DateData = new MediumDate();
	        DateData.setDate(dateStr);
	        System.out.println(dateStr);
	        DateData.setDayOfWeek(dayOfWeekStr);
	        
	        // ArrayList에 추가
	        dateList.add(DateData);
	        
	        // 다음 날짜로 이동
	        cal.add(Calendar.DATE, 1);
	    }
	    
	    return dateList;
	}
	
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
	//형주 중기기상전망 api로직
	public void mediumWeatherInfo(String area,SqlData sql) {
		System.out.println("로직에 들어옴");
		String API_URL =
				MEDIUM_WEATHER_URL + "getMidFcst?serviceKey=" + 
						API_KEY + "&numOfRows=10&pageNo=1&stnId=" + 
						mediumWeatherArea2(area) + "&tmFc=" + 
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
	// 오브젝트 맵퍼 json 정렬화 후 반환문
	public MediumForecast mediumForecastJson(SqlData data) {
		MediumForecast response = new MediumForecast();
		String jsonData = mapper.selectJsonData(data);
		System.out.println(jsonData);
		try {
			response = work.objectMapper.readValue(jsonData, MediumForecast.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}

	// 컨트롤러에서 직접적으로 실행로직 (중기온도)
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
	
	// 컨트롤러에서 직접적으로 실행로직 (중기날씨)
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
	
	// 컨트롤러에서 직접적으로 실행로직 (중기기상전망)
	public MediumForecast mediumForecastRun(String area) {
		SqlData in = new SqlData();
		in.setTableName("medium_table");
		in.setStandardName("Forecast"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			mediumWeatherInfo(area, in);
			System.out.println("api로데이터불러왔음");
		}
		return mediumForecastJson(in);
	}
	public String areaBox() {
        String[] areaBox = {"서울", "인천", "수원", "파주", "춘천", "원주", "대전", "서산", "세종", "청주", "서귀포", "광주", "제주", "목포", "여수", "전주", "군산", "부산", "울산", "창원", "대구", "안동", "포항", "강릉"};
        Gson gson = new Gson();
        String json = gson.toJson(areaBox);
		return json;
		
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
//		else {
//			area="오류";
//		}
		return area;
	}
	
	// 파라미터 값 변환 로직(날씨)
	public String mediumWeatherArea(String area) {
		//지역변환
		if(area.equals("수원") || area.equals("파주")) {
			area="경기도";
		}
		else if(area.equals("춘천") || area.equals("원주")) {
			area="강원도영서";
		}
		else if(area.equals("강릉")) {
			area="강원도영동";
		}
		else if(area.equals("서산")) {
			area="충청남도";
		}
		else if(area.equals("청주")) {
			area="충청북도";
		}
		else if(area.equals("여수") || area.equals("목포")) {
			area="전라남도";
		}
		else if(area.equals("전주")  || area.equals("군산")) {
			area="전라북도";
		}
		else if(area.equals("안동") || area.equals("포항")) {
			area="경상북도";
		}
		else if(area.equals("창원")) {
			area="경상남도";
		}
		
		
		//지역코드변환
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
		else if(area.equals("제주") || area.equals("서귀포")) {
			area="11G00000";
		}
		else {
			area="오류";
		}
		return area;
	}
	// 파라미터 값 변환 로직(중기기상전망)
	public String mediumWeatherArea2(String area) {
		//지역변환
		if(area.equals("수원") || area.equals("파주")) {
			area="경기도";
		}
		else if(area.equals("춘천") || area.equals("원주")) {
			area="강원도영서";
		}
		else if(area.equals("강릉")) {
			area="강원도영동";
		}
		else if(area.equals("서산")) {
			area="충청남도";
		}
		else if(area.equals("청주")) {
			area="충청북도";
		}
		else if(area.equals("여수") || area.equals("목포")) {
			area="전라남도";
		}
		else if(area.equals("전주") || area.equals("군산")) {
			area="전라북도";
		}
		else if(area.equals("안동") || area.equals("포항")) {
			area="경상북도";
		}
		else if(area.equals("창원")) {
			area="경상남도";
		}
		//지역코드변환
		if(area.equals("서울") || area.equals("인천") || area.equals("경기도")) {
			area="109";
		}
		else if(area.equals("강원도영서")) {
			area="105";
		}
		else if(area.equals("강원도영동")) {
			area="105";
		}
		else if(area.equals("대전") || area.equals("세종") || area.equals("충청남도")) {
			area="133";
		}
		else if(area.equals("충청북도")) {
			area="131";
		}
		else if(area.equals("광주") || area.equals("전라남도")) {
			area="156";
		}
		else if(area.equals("전라북도")) {
			area="146";
		}
		else if(area.equals("대구") || area.equals("경상북도")) {
			area="143";
		}
		else if(area.equals("부산") || area.equals("울산") || area.equals("경상남도")) {
			area="159";
		}
		else if(area.equals("제주") || area.equals("서귀포")) {
			area="184";
		}
//		else {
//			area="오류";
//		}
		return area;
	}
	public Map<String,String> morningWeatherMap(){
		Map<String, String> weatherMap = new HashMap<>();
		
		weatherMap.put("맑음", "wi-day-sunny");
		weatherMap.put("구름많음", "wi-day-cloudy");
		weatherMap.put("구름많고 비", "wi-day-rain");
		weatherMap.put("구름많고 눈", "wi-day-snow");
		weatherMap.put("구름많고 비/눈", "wi-day-rain-mix");
		weatherMap.put("구름많고 소나기", "wi-day-showers");
		weatherMap.put("흐림", "wi-cloudy");
		weatherMap.put("흐리고 비", "wi-rain");
		weatherMap.put("흐리고 눈", "wi-snow");
		weatherMap.put("흐리고 비/눈", "wi-rain-mix");
		weatherMap.put("흐리고 소나기", "wi-showers");
		return weatherMap;
	}
	public Map<String,String> nightWeatherMap(){
		Map<String, String> weatherMap = new HashMap<>();
		
		weatherMap.put("맑음", "wi-night-clear");
		weatherMap.put("구름많음", "wi-night-alt-cloudy");
		weatherMap.put("구름많고 비", "wi-night-alt-rain");
		weatherMap.put("구름많고 눈", "wi-night-alt-snow");
		weatherMap.put("구름많고 비/눈", "wi-night-alt-rain-mix");
		weatherMap.put("구름많고 소나기", "wi-night-alt-showers");
		weatherMap.put("흐림", "wi-cloudy");
		weatherMap.put("흐리고 비", "wi-rain");
		weatherMap.put("흐리고 눈", "wi-snow");
		weatherMap.put("흐리고 비/눈", "wi-rain-mix");
		weatherMap.put("흐리고 소나기", "wi-showers");
		return weatherMap;
	}
}