package com.lowlist.dto.mapleapi;

import java.util.List;

import lombok.Data;

@Data
public class StatData {

	public String date;
	public String character_class;
	public List<StatCalc> final_stat;
	public Integer remain_ap;
	public String character_name;
	public String stat_name;
	public String stat_value;
	
}