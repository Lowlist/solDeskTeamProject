package com.lowlist.dto.android;

import java.util.ArrayList;

import lombok.Data;
@Data
public class AndroidInfo{
    public String date;
    public String character_name;
    public String android_name;
    public String android_nickname;
    public String android_icon;
    public String android_description;
    public AndroidHair android_hair;
    public AndroidFace android_face;
    public String android_skin_name;
    public ArrayList<AndroidCashItemEquipment> android_cash_item_equipment;
    public String android_ear_sensor_clip_flag;
    public String android_gender;
    public String android_grade;
    public String android_non_humanoid_flag;
    public String android_shop_usable_flag;
    public int preset_no;
    public AndroidPreset android_preset_1;
    public AndroidPreset android_preset_2;
    public AndroidPreset android_preset_3;
    public String json_data;
}