package com.lowlist.dto.mapleapi;

import lombok.Data;

@Data
public class Propensity {
	public String date;
	public String character_name;
	public Integer charisma_level;
	public Integer sensibility_level;
	public Integer insight_level;
	public Integer willingness_level;
	public Integer handicraft_level;
	public Integer charm_level;
}