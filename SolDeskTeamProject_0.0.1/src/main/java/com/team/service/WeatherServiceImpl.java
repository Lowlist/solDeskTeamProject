package com.team.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.mapper.WeatherMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class WeatherServiceImpl implements WeatherService {

	@Autowired
	private WeatherMapper weatherMapper;
	
	@Override
	public void earthquakeInfo() {
	LocalDate startDate = LocalDate.now();
	String start = startDate.toString();
	LocalDate endDate = LocalDate.now().minusDays(3);
	String end = endDate.toString();
	String apiKey = "7LWzTf_8Tae1s03__L2nfw";
	String apiUrl = "https://apihub.kma.go.kr/api/typ02/openApi/EqkInfoService/getEqkMsg?pageNo=1&numOfRows=10&dataType=JSON&fromTmFc=20171101&toTmFc=20171129&authKey="+ apiKey +"";
	
		
	}
	
}