package com.team.dto.livingwthr;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Body{
    public String dataType;
    public Items items;
    public int pageNo;
    public int numOfRows;
    public int totalCount;
}