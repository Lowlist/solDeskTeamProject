package com.lowlist.dto.mapleapi;

import java.util.List;

import lombok.Data;

@Data
public class Ability {
	public String date;
	public String ability_grade;
	public String character_name;
	public List<AbilityInfo> ability_info;
	public Integer remain_fame;
	public Integer preset_no;
	public AbilityPreset ability_preset_1;
	public AbilityPreset ability_preset_2;
	public AbilityPreset ability_preset_3;
	public String ability_preset_appoint_no;
	public String ability_preset;
	public String ability_preset_no;
	public String ability_preset_value;
	public String ability_preset_grade;
}
