package com.team.service;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.dto.shortwthr.Item;
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
	public void ShortWeatherInfoApi() {
		List<String> areaList = new ArrayList<>();
        areaList.add("서울");
        areaList.add("부산");
        areaList.add("인천");
        areaList.add("수원");
        areaList.add("파주");
        areaList.add("춘천");
        
        //        List<String> weatherInfoList = new ArrayList<>();

        for (String area : areaList) {
            List<String> list = shortWeatherArea(area);
            String nx = list.get(0);
//            System.out.println("nx 확인 : " + nx);
            String ny = list.get(1);
//            System.out.println("ny 확인 : " + ny);
            
			String API_URI = 
				SHORT_DALY_INFO_URL + "getVilageFcst?serviceKey=" +
				API_KEY + "&pageNo=1&numOfRows=1000&dataType=json&base_date="+work.nowDateShortToday()+"&base_time=0500&nx="+nx+"&ny="+ny;
			
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
				continue;
			}
			
	        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
	        String weatherInfo = response.getBody(); // 날씨 정보 가져오기
//	        System.out.println("확인2"+weatherInfo);
	        shortWeatherInsert(weatherInfo ,area);
//	        weatherInfoList.add(weatherInfo); // 리스트에 추가
        }
	}
	//insert문
	public void shortWeatherInsert(String weatherInfo , String area) {
	    JSONObject jsonObject = new JSONObject(weatherInfo);
//	    System.out.println("확인" +jsonObject);
	    JSONArray items = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");
	    //Json 데이터 파싱 [직렬화] 
	    ObjectMapper mapper = new ObjectMapper();
	    for (int i = 0; i < items.length(); i++) {
	        JSONObject itemJson = items.getJSONObject(i);
	        Item weatherData = null;
			try {
				weatherData = mapper.readValue(itemJson.toString(), Item.class);
			} catch (JsonParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			System.out.println(weatherData);
			Item weatherEntity = new Item();
	        weatherEntity.setBaseDate(weatherData.getBaseDate());
//	        weatherEntity.setBaseTime(weatherData.getBaseTime());
	        weatherEntity.setCategory(weatherData.getCategory());
	        weatherEntity.setFcstDate(weatherData.getFcstDate());
	        weatherEntity.setFcstTime(weatherData.getFcstTime());
	        weatherEntity.setFcstValue(weatherData.getFcstValue());
	        weatherEntity.setNx(weatherData.getNx());
	        weatherEntity.setNy(weatherData.getNy());
	        weatherEntity.setArea(area);
//	        System.out.println("[확인]  : " +weatherEntity);

	        weatherMapper.weatherInsert(weatherEntity); // 등록성공
	    }
	}
	//Json 데이터 가져오기
	public List<Item> weatherList(String area){
		List<Item> list=weatherMapper.weatherList(area);
		return list; // JSON 데이터 형식으로 변환(API)해서 리턴(응답)하겠다.
	}

	//category 가져오기
	public List<String> getCategoryList(String area) {
	    List<Item> list = weatherMapper.weatherList(area);

	    List<String> categoryList = list.stream()
                .map(Item::getCategory)
                .filter(category -> category.equals("TMP"))
                .collect(Collectors.toList());

//	    List<String> categoryList = new ArrayList<>();
//
//	    for (Item item : list) {
//	        categoryList.add(item.getCategory());
//	    }
	    System.out.println("확인 :" + categoryList);

	    return categoryList;
	}
	
	//baseTime 가져오기
	
	//fcstValue 가져오기
	
	//현재 시간 기준 데이터 가져오기
	public List<String> nowWeatherList(){
	      Map<String, Object> map = new LinkedHashMap<String, Object>();
	      String area="서울";
	      String fcstDate = work.nowDateShortToday();
	       String fcstTime = work.nowTimes();
	      map.put("area", area);
	      map.put("fcstDate", fcstDate);
	      map.put("fcstTime", fcstTime);
	      
	       List<Item> list = weatherMapper.nowWeatherList(map);
//	       System.out.println("확인 :" + list);
	       List<String> categoryList = list.stream()
	    		    .filter(item -> {
	    		        String category = item.getCategory();
	    		        return category.equals("POP") || category.equals("PCP") || category.equals("REH") ||
	    		               category.equals("TMP") || category.equals("UUU") || category.equals("VVV") ||
	    		               category.equals("VEC") || category.equals("SKY");
	    		    })
	    		    .map(item -> {
	    	            String category = item.getCategory();
	    	            String fcstValue = item.getFcstValue();
	    	            // "SKY" 카테고리의 값이 0부터 5 사이인 경우 "맑음"으로 변환
	    	            if (category.equals("SKY")) {
	    	                int skyValue = Integer.parseInt(fcstValue);
	    	                if (skyValue >= 0 && skyValue <= 5) {
	    	                    return "맑음";
	    	                }
	    	            }
	    	            return fcstValue;
	    	        })
	    	        .collect(Collectors.toList());

	       return categoryList; // JSON 데이터 형식으로 변환(API)해서 리턴(응답)하겠다.
	   }
	
	//검색어 구현 & 현재 데이터 가져오기  category=tmp
	public List<Item> searchWeather(String area){
		List<Item> resultList = new ArrayList<>();
		
		 List<String> categories = Arrays.asList("TMP", "UUU", "VVV", "VEC", "SKY", "POP", "PCP", "REH");
		
		 String currentTime = work.nowTimes();
		 String currentDate = work.nowDates();
		 String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
		
		 for (int i = 0; i < 24; i++) {
		        String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
		        targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
		        
		 for (String category : categories) {
		        Map<String, Object> map = new LinkedHashMap<String, Object>();
		        map.put("area", area);
		        map.put("category", category);
		        map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
		        map.put("fcstDate", fcstDate);
		      
		        // weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
		        List<Item> list = weatherMapper.searchWeather(map);
		        resultList.addAll(list);
		        
		    }
			 }
		    return resultList;
		}
	
	//내일 날짜 24시간 데이터 불러오기 
	public List<Item> searchTomorrowWeather(String area){
	    List<Item> resultList = new ArrayList<>();
	    
	    List<String> categories = Arrays.asList("TMP", "UUU", "VVV", "VEC", "SKY", "POP", "PCP", "REH");
	    
	    String tomorrowDate = work.tomorrowDate();
	    String fcstDate = String.format("%08d", Integer.parseInt(tomorrowDate)); // 여덟 자리로 포맷팅
	    System.out.println("확인 : " + fcstDate);
	    
	    for (String category : categories) {
	        Map<String, Object> map = new LinkedHashMap<String, Object>();
	        map.put("area", area);
	        map.put("category", category);
	        map.put("fcstDate", fcstDate);
	        
	        List<Item> list = weatherMapper.searchTomorrowWeather(map);
	        resultList.addAll(list);
	      
	    }
	    System.out.println("확인하기 : " + resultList);
	    
	    return resultList;
	}
	
	
	public List<Item> searchNowWeather(String area){
		List<Item> resultList = new ArrayList<>();
		
		List<String> categories = Arrays.asList("TMP", "UUU", "VVV", "VEC", "SKY", "POP", "PCP", "REH");
		
		String fcstTime = work.nowTimes();
		String currentDate = work.nowDates();
		String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
		
		//현재 날짜 정보 불러오기 
		for (String category : categories) {
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("area", area);
			map.put("category", category);
			map.put("fcstTime", fcstTime);
			map.put("fcstDate", fcstDate);
			//		        map.put("fcstTime", fcstTime); // fcstTime 변수가 어디서 오는지 확인 필요
			
			// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
			List<Item> list = weatherMapper.searchNowWeather(map);
			
			if (category.equals("SKY")) {
	            for (Item item : list) {
	                String fcstValue = item.getFcstValue();
	                int skyValue = Integer.parseInt(fcstValue);
	                if (skyValue >= 0 && skyValue <= 5) {
	                    item.setFcstValue("맑음");
	                }
	            }
	        }
			
			resultList.addAll(list);
			
//		        System.out.println("확인하기 : " +list);
		}
//		    System.out.println("확인 : " +resultList);
		// JSON 데이터 형식으로 변환(API)해서 리턴(응답)
		return resultList;
	}
	
	//온도 
	public List<Item> searchTmpWeather(String area){
		List<Item> resultList = new ArrayList<>();
		
		String currentTime = work.nowTimes();
		String currentDate = work.nowDates();
		String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
		
		for (int i = 0; i < 24; i++) {
			String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
			targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
			
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("area", area);
			map.put("category", "TMP");
			map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
			map.put("fcstDate", fcstDate);
			
			// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
			List<Item> list = weatherMapper.searchWeather(map);
			resultList.addAll(list);
		}
		System.out.println("확인하기ㅋ :" + resultList);
		return resultList;
	}

	//습도 
		public List<Item> searchRehWeather(String area){
			List<Item> resultList = new ArrayList<>();
			
			String currentTime = work.nowTimes();
			String currentDate = work.nowDates();
			String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
			
			for (int i = 0; i < 24; i++) {
				String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
				targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
				
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("area", area);
				map.put("category", "REH");
				map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
				map.put("fcstDate", fcstDate);
				
				// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
				List<Item> list = weatherMapper.searchWeather(map);
				resultList.addAll(list);
			}
			System.out.println("확인하기ㅋ :" + resultList);
			return resultList;
		}
	
		//강수 확률 
		public List<Item> searchPopWeather(String area){
			List<Item> resultList = new ArrayList<>();
			
			String currentTime = work.nowTimes();
			String currentDate = work.nowDates();
			String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
			
			for (int i = 0; i < 24; i++) {
				String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
				targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
				
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("area", area);
				map.put("category", "POP");
				map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
				map.put("fcstDate", fcstDate);
				
				// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
				List<Item> list = weatherMapper.searchWeather(map);
				resultList.addAll(list);
			}
			System.out.println("확인하기ㅋ :" + resultList);
			return resultList;
		}
	
		//강수량
		public List<Item> searchPcpWeather(String area){
			List<Item> resultList = new ArrayList<>();
			
			String currentTime = work.nowTimes();
			String currentDate = work.nowDates();
			String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
			
			for (int i = 0; i < 24; i++) {
				String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
				targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
				
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("area", area);
				map.put("category", "PCP");
				map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
				map.put("fcstDate", fcstDate);
				
				// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
				List<Item> list = weatherMapper.searchWeather(map);
				resultList.addAll(list);
			}
			System.out.println("확인하기ㅋ :" + resultList);
			return resultList;
		}
	
		//맑음 상태 보기
		public List<Item> searchSkyWeather(String area){
			List<Item> resultList = new ArrayList<>();
			
			String currentTime = work.nowTimes();
			String currentDate = work.nowDates();
			String fcstDate = String.format("%08d", Integer.parseInt(currentDate)); // 여덟 자리로 포맷팅
			
			for (int i = 0; i < 24; i++) {
				String targetTime = String.valueOf(Integer.parseInt(currentTime) + (i * 100)); // 현재 시간에서 i시간 뒤의 시간을 구함
				targetTime = String.format("%04d", Integer.parseInt(targetTime)); // 네 자리로 포맷팅
				
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("area", area);
				map.put("category", "SKY");
				map.put("fcstTime", targetTime); // fcstTime 변수가 어디서 오는지 확인 필요
				map.put("fcstDate", fcstDate);
				
				// weatherMapper.searchWeather(area, category)를 호출하여 결과를 받아온다고 가정하고, resultList에 추가
				List<Item> list = weatherMapper.searchWeather(map);
				resultList.addAll(list);
			}
			System.out.println("확인하기ㅋ :" + resultList);
			return resultList;
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