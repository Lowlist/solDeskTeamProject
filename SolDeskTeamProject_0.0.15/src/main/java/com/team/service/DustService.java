package com.team.service;

import java.net.URI;
import java.net.URISyntaxException;

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

import com.team.dto.dustdto.DustInfo;
import com.team.dto.dustdto.Item;
import com.team.mapper.WeatherMapper;

@Service
public class DustService {
   
    @Autowired
    private WeatherMapper weatherMapper;
    @Autowired
    private PublicWork work;
    private final String API_KEY = "JY7Vm0WbF6JwPpyiYSKp5J73J3EEk2yZ9yHXoU7CA%2F5yPmxlt5AyBXaTBvRMKhQcsKjCWRujJ4oRYSy03OTh8A%3D%3D";
    private final String DUST_URL = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/";
    
  //생활기상지수 미세먼지 api 로직
    public String weatherDustApi() {
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
        System.out.println(response.getBody());
        return response.getBody();
    }

    // 컨트롤러로 이동 후 구현하는 로직
    public DustInfo weatherDustRun() {
        DustInfo response = new DustInfo();
        String jsonData = weatherDustApi();
        try {
            response = work.objectMapper.readValue(jsonData, DustInfo.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }
    
    // Url 사진 데이터 받아와서 null인지 비교후에 스트링으로 파싱해서 넣기
    public String getImageUrls() {
        JSONObject responseData = new JSONObject();
        JSONArray imageUrls = new JSONArray();

        DustInfo dustInfo = this.weatherDustRun();

        for (int i = 0; i < dustInfo.getResponse().getBody().getTotalCount(); i++) {
            JSONObject urls = new JSONObject();
            Item currentItem = dustInfo.getResponse().getBody().getItems().get(i);

            // 이미지 URL이 null이 아닌 경우에만 추가
            if (currentItem.getImageUrl1() != null) {
                urls.put("imageUrl1", currentItem.getImageUrl1());
            }
            if (currentItem.getImageUrl2() != null) {
                urls.put("imageUrl2", currentItem.getImageUrl2());
            }
            if (currentItem.getImageUrl3() != null) {
                urls.put("imageUrl3", currentItem.getImageUrl3());
            }
            if (currentItem.getImageUrl4() != null) {
                urls.put("imageUrl4", currentItem.getImageUrl4());
            }
            if (currentItem.getImageUrl5() != null) {
                urls.put("imageUrl5", currentItem.getImageUrl5());
            }
            if (currentItem.getImageUrl6() != null) {
                urls.put("imageUrl6", currentItem.getImageUrl6());
            }

            imageUrls.put(urls);
        }

        responseData.put("imageUrls", imageUrls);

        return responseData.toString();
    }
}
