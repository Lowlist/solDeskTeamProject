package com.team.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.dto.sql.SqlData;
import com.team.mapper.WeatherMapper;

@Service
public class PublicWork {
	
	@Autowired
	private WeatherMapper mapper;
	// 공용함수(헤더)
	public final String METHOD = "accept";
	public final String FORM = "application/json";
	// 공용함수(오브젝트맵퍼)
	public ObjectMapper objectMapper = new ObjectMapper();
	// 공용함수 (MySql table 참조용 boolean 반환문)
	public boolean SqlCheckData(SqlData countdata) {
		if (mapper.getCountSqlData(countdata) == 0) {
			// 값이 sql에 없으면 트루반환
			return true;
		} else {
			// 값이 sql에 있으면 실패반환
			return false;
		}
	}
	
	// 공용함수(오늘) ex)2024032806
	public String nowTime() {
		LocalDate today = LocalDate.now();
        LocalTime fixedTime = LocalTime.of(6, 0);
        LocalDateTime dateTime = LocalDateTime.of(today, fixedTime);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
        String nowTime = dateTime.format(formatter);
    	return nowTime;
	}
	
	// 공용함수(어제,어제기준 일주일전) ex)20240327
	public String oneWeekCalc(int check) {
        LocalDate today = LocalDate.now();
        LocalDate oneDayAgo = today.minusDays(1);
        LocalDate oneWeekAgo = oneDayAgo.minusWeeks(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		if(check == 1) {
			// 매개변수가 1이면 어제날짜 반환
			return oneDayAgo.format(formatter);
		} else {
			// 매개변수가 1이 아닐경우엔 어제날짜 기준으로 일주일 전 반환
			return oneWeekAgo.format(formatter);
		}
	}
	
	// 공용함수(오늘) sql 참조 and dust용 ex)2024-03-28
	public String nowDate() {
		LocalDate today = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String nowTime = today.format(formatter);
	   	return nowTime;
	}
	
	// 공용함수(어제) 단기정보용 날짜
	public String nowDateShort() {
		LocalDate today = LocalDate.now();
		LocalDate oneDayAgo = today.minusDays(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String nowTime = oneDayAgo.format(formatter);
		return nowTime;
	}
	
	// 공용함수(어제) 단기정보용 날짜
	public String nowDateShortToday() {
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String nowTime = today.format(formatter);
		return nowTime;
	}
	
	//pastweather에 String date에 기본 value값으로 보낼거임
	public String nowDateAsos() {
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String nowTime = today.format(formatter);
		return nowTime;
	}
	
	public String nowTimes() {
	    LocalTime now = LocalTime.now();
	    int minute = now.getMinute();
	    if (minute <= 59) {
	        minute = 00;
	    }
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");
	    String nowTimes = now.withMinute(minute).format(formatter);
	    return nowTimes;
	}
	public String nowDates() {
		LocalDate today = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	    String nowDate = today.format(formatter);
	   	return nowDate;
	}
	public String tomorrowDate() {
		 LocalDate today = LocalDate.now();
		 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		 LocalDate tomorrow = today.plusDays(1);
		 String tomorrowDate = tomorrow.format(formatter);
		 return tomorrowDate;
	 }
	
}