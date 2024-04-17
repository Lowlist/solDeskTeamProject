package com.team.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.team.dto.shortwthr.Item;
import com.team.dto.sql.SqlData;

@Repository
public interface WeatherMapper {
	
	//해당테이블에 인서트
	public void insertSqlData(SqlData sqlcountdata);
	//해당되는 테이블 참조 후 카운트 반환문
	public int getCountSqlData(SqlData sqlcountdata);
	//해당되는 테이블 참조 후 json 데이터 반환
	public String selectJsonData(SqlData sqlcountdata);
	
	public void weatherInsert(Item weatherEntiy);
	
	//전체 리스트 가져오기 
	public List<Item> weatherList(String area);

//	public List<Item> nowWeatherList(String area ,String fcstDate, String fcstTime);

	//현재 리스트 가져오기
	public List<Item> nowWeatherList(Map<String, Object> map);
	
	//검색어 리스트 가져오기
	public List<Item> searchWeather(Map<String, Object> map);
	
	//검색어 리스트 가져오기
	public List<Item> searchTomorrowWeather(Map<String, Object> map);
	
	//현재 검색어 리스트 가져오기
	public List<Item> searchNowWeather(Map<String, Object> map);
	
}
