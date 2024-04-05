package com.team.dto.dustdto;

import java.util.List;

import lombok.Data;

@Data
public class Body {
	public String dataType;
    public int totalCount;
    public List<Item> items;
    public int pageNo;
    public int numOfRows;
}
