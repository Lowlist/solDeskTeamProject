package com.lowlist.dto.item;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ItemInfo {
	public String date;
	public String character_gender;
	public String character_name;
	public String character_class;
	public String json_data;
	public int preset_no;
	public ArrayList<ItemEquipment> item_equipment;
	public ArrayList<ItemEquipmentPreset> item_equipment_preset_1;
	public ArrayList<ItemEquipmentPreset> item_equipment_preset_2;
	public ArrayList<ItemEquipmentPreset> item_equipment_preset_3;
	public Title title;
	public ArrayList<Object> dragon_equipment;
	public ArrayList<Object> mechanic_equipment;
}