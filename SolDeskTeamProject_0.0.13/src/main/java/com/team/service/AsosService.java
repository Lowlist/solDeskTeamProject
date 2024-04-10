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
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class AsosService {
	
	@Autowired
	private WeatherMapper mapper;
	@Autowired
	private PublicWork work;
	
	private final String API_KEY = "6Qg%2BHDGcsOCmPG7E4s4yFIrV2SIqLYL0gh4b7S6AJNTt9a3pkJ5379Lvcn1PmhBrSYZVdIKs6SmGDUSzB3R6Nw%3D%3D";
	private final String ASOS_DALY_INFO_URL = "https://apis.data.go.kr/1360000/AsosDalyInfoService/";
	
	// asos종관 기상정보 api
	public void asosDalyInfoApi(String area,SqlData sql,String date) {
		String API_URI = 
			ASOS_DALY_INFO_URL + "getWthrDataList?serviceKey=" +
			API_KEY + "&pageNo=1&numOfRows=10&dataType=json&dataCd=ASOS&dateCd=DAY" +
			"&startDt=" + date + 
			"&endDt=" + date +
			"&stnIds=" + asosDalyArea(area);
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
	public AsosDalyInfo asosJson(SqlData data) {
		AsosDalyInfo response = new AsosDalyInfo();
		String jsonData = mapper.selectJsonData(data);
		try {
			response = work.objectMapper.readValue(jsonData,AsosDalyInfo.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}
	
	// 컨트롤러에서 직접적으로 실행로직
	public AsosDalyInfo asosRun(String area,String date) {
		SqlData in = new SqlData();
		in.setTableName("asos_table");
		in.setStandardName("asos"+area);
		in.setNowDate(work.nowDate());
		if (work.SqlCheckData(in)) {
			asosDalyInfoApi(area,in,date);
			System.out.println("API 들렸음");
		} 
		return asosJson(in);
	}
	
	// 파라미터 값 변환 로직
	public String asosDalyArea(String area) {
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
}