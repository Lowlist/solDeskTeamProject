package com.team.dto.mediumwthr.weather;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown =true)
public class WeatherInfo{
    public Response response;
}
