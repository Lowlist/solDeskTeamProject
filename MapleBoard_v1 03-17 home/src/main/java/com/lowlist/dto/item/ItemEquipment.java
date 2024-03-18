package com.lowlist.dto.item;

import lombok.Data;

@Data
public class ItemEquipment {
	    public String item_equipment_part;
	    public String item_equipment_slot;
	    public String item_name;
	    public String item_icon;
	    public String item_description;
	    public String item_shape_name;
	    public String item_shape_icon;
	    public Object item_gender;
	    public ItemTotalOption item_total_option;
	    public ItemBaseOption item_base_option;
	    public String potential_option_grade;
	    public String additional_potential_option_grade;
	    public String potential_option_1;
	    public String potential_option_2;
	    public String potential_option_3;
	    public String additional_potential_option_1;
	    public String additional_potential_option_2;
	    public String additional_potential_option_3;
	    public int equipment_level_increase;
	    public ItemExceptionalOption item_exceptional_option;
	    public ItemAddOption item_add_option;
	    public int growth_exp;
	    public int growth_level;
	    public String scroll_upgrade;
	    public String cuttable_count;
	    public String golden_hammer_flag;
	    public String scroll_resilience_count;
	    public String scroll_upgradeable_count;
	    public String soul_name;
	    public String soul_option;
	    public ItemEtcOption item_etc_option;
	    public String starforce;
	    public String starforce_scroll_flag;
	    public ItemStarforceOption item_starforce_option;
	    public int special_ring_level;
	    public Object date_expire;
	    public String maxstarforce;
	    public String maxobject;
}
