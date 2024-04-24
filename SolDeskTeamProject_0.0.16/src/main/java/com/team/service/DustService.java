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

import com.team.dto.dustdto.DustInfo;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class DustService {
   
    @Autowired
    private WeatherMapper mapper;
    @Autowired
    private PublicWork work;
    private final String API_KEY = "JY7Vm0WbF6JwPpyiYSKp5J73J3EEk2yZ9yHXoU7CA%2F5yPmxlt5AyBXaTBvRMKhQcsKjCWRujJ4oRYSy03OTh8A%3D%3D";
    private final String DUST_URL = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/";
    
  //생활기상지수 미세먼지 api 로직
    public void weatherDustApi(SqlData sql) {
        String API_URI = 
                DUST_URL + "getMinuDustFrcstDspth?serviceKey=" +
            API_KEY + "&returnType=JSON&numOfRows=100&pageNo=1&searchDate=" + work.nowDate();
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
        }
        ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
        sql.setJsonData(response.getBody());
        mapper.insertSqlData(sql);
    }

    // 오브젝트 맵퍼 jsonData로 반환
    public DustInfo weatherDustRun(SqlData data) {
        DustInfo response = new DustInfo();
        String jsonData = mapper.selectJsonData(data);
        try {
            response = work.objectMapper.readValue(jsonData, DustInfo.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }
   
    // sql 접속
    public DustInfo dustRun() {
        SqlData in = new SqlData();
        in.setTableName("dust_table");
        in.setStandardName("dust");
        in.setNowDate(work.nowDate());
        if (work.SqlCheckData(in)) {
            weatherDustApi(in);
            System.out.println("API 들렸음");
        } 
        return weatherDustRun(in);
    }
}
