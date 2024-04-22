package com.team.dto.mediumwthr.forecast;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown =true)
public class Item{
    public String wfSv;
}
