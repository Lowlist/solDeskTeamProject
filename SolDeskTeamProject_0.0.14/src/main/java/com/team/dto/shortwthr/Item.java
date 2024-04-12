package com.team.dto.shortwthr;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Item{
	public int seq;
    public String baseDate;
//    public String baseTime;
    public String category;
    public String fcstDate;
    public String fcstTime;
    public String fcstValue;
    public int nx;
    public int ny;
    public int updated;
    public String area;
}

