package com.lowlist.dto.item;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class ItemAddOption {
	    public String str;
	    public String dex;
	    @JsonProperty("int") 
	    public String myint;
	    public String luk;
	    public String max_hp;
	    public String max_mp;
	    public String attack_power;
	    public String magic_power;
	    public String armor;
	    public String speed;
	    public String jump;
	    public String boss_damage;
	    public String all_stat;
	    public String damage;
	    public int equipment_level_decrease;
}
