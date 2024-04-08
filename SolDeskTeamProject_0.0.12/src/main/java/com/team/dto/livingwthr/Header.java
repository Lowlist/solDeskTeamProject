package com.team.dto.livingwthr;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Header{
    public String resultCode;
    public String resultMsg;
}