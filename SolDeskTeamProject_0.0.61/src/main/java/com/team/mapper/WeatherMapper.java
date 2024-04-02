package com.team.mapper;

import org.springframework.stereotype.Repository;

import com.team.dto.asosdalyinfo.AsosDalyInfo;
import com.team.dto.sql.SqlData;

@Repository
public interface WeatherMapper {
	
	public void insertSqlData(SqlData sqlcountdata);
	//해당되는 테이블 참조 후 카운트 반환문
	public int getCountSqlData(SqlData sqlcountdata);
	//해당되는 테이블 참조 후 json 데이터 반환
	public String selectJsonData(SqlData sqlcountdata);
	
}
