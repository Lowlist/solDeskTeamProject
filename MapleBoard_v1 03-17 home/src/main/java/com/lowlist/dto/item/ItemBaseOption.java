package com.lowlist.dto.item;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class ItemBaseOption {
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
	    public String ignore_monster_armor;
	    public String all_stat;
	    public String max_hp_rate;
	    public String max_mp_rate;
	    public int base_equipment_level;
}
