package com.lowlist.dto.android;

import lombok.Data;

@Data
public class AndroidPreset{
    public String android_name;
    public String android_nickname;
    public String android_icon;
    public String android_description;
    public String android_gender;
    public String android_grade;
    public String android_skin_name;
    public AndroidHair android_hair;
    public AndroidFace android_face;
    public String android_ear_sensor_clip_flag;
    public String android_non_humanoid_flag;
    public String android_shop_usable_flag;
}