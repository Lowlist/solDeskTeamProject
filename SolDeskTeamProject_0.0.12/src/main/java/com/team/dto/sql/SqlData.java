package com.team.dto.sql;

import lombok.Data;

@Data
public class SqlData {
	public String standardName; // 이걸 기준으로 받아와 값를 전부다
	public String tableName; //테이블네임 << 테이블이 항상 바뀌잖아
	public String nowDate; //오늘 날짜
	public String jsonData; // jsondata
}