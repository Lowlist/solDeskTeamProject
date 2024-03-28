package com.team.dto.livingwthr;

import lombok.Data;

@Data
public class Body{
    public String dataType;
    public Items items;
    public int pageNo;
    public int numOfRows;
    public int totalCount;
}