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
	
	//단기예보 mapper
	public List<Item> weatherList(String area);

//	public List<Item> nowWeatherList(String area ,String fcstDate, String fcstTime);

	public List<Item> nowWeatherList(Map<String, Object> map);
	
}
