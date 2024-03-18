package com.lowlist.dto.mapleapi;

import java.util.List;

import lombok.Data;
@Data
public class HyperStat {
	public String date;
	public String character_class;
	public String character_name;
	public String use_preset_no;
	public Integer use_available_hyper_stat;
	public Integer hyper_stat_preset_no;
	public List<HyperStatPreset> hyper_stat_preset_1;
	public Integer hyper_stat_preset_1_remain_point;
	public List<HyperStatPreset> hyper_stat_preset_2;
	public Integer hyper_stat_preset_2_remain_point;
	public List<HyperStatPreset> hyper_stat_preset_3;
	public Integer hyper_stat_preset_3_remain_point;
	public String stat_type;
	public Integer stat_point;
	public Integer stat_level;
	public String stat_increase;

}
