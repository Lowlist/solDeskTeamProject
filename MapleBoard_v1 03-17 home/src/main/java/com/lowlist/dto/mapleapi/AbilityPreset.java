package com.lowlist.dto.mapleapi;

import java.util.List;

import lombok.Data;

@Data
public class AbilityPreset {
	public String ability_preset_grade;
	public List<AbilityInfo> ability_info;
}
