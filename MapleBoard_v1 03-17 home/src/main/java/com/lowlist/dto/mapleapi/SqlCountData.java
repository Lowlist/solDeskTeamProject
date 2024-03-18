package com.lowlist.dto.mapleapi;

import lombok.Data;

@Data
public class SqlCountData {
	public String character_name; // 이걸 기준으로 받아와 값를 전부다
	public String table_name; //테이블네임 << 테이블이 항상 바뀌잖아
}
