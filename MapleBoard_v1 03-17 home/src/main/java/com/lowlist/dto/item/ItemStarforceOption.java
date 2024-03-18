package com.lowlist.dto.item;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class ItemStarforceOption {
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
}