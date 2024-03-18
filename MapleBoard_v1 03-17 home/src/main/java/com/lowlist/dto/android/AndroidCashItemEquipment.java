package com.lowlist.dto.android;

import java.util.ArrayList;

import com.lowlist.dto.item.CashItemColoringPrism;

import lombok.Data;

@Data
public class AndroidCashItemEquipment{
    public String cash_item_equipment_part;
    public String cash_item_equipment_slot;
    public String cash_item_name;
    public String cash_item_icon;
    public String cash_item_description;
    public ArrayList<Object> cash_item_option;
    public Object date_expire;
    public Object date_option_expire;
    public String cash_item_label;
    public CashItemColoringPrism cash_item_coloring_prism;
    public String android_item_gender;
}