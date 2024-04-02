package com.team.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class PublicWork {
	
	//공용함수(헤더)
	public final String METHOD ="accept";
	public final String FORM ="application/json";
	
	//공용함수(오브젝트맵퍼)
	public ObjectMapper objectMapper = new ObjectMapper();
	
	//공용함수(오늘) ex)2024032806
	public String nowTime() {
		LocalDate today = LocalDate.now();
        LocalTime fixedTime = LocalTime.of(6, 0);
        LocalDateTime dateTime = LocalDateTime.of(today, fixedTime);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHH");
        String nowTime = dateTime.format(formatter);
    	return nowTime;
	}
	
	//공용함수(어제,어제기준 일주일전) ex)20240327
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
	 public String nowDate() {
	        LocalDate today = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	        String nowDate = today.format(formatter);
	        return nowDate;
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
}
