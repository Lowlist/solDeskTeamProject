package com.team.service;

import com.team.dto.livingwthr.LivingWeather;
import com.team.dto.mediumwthr.temperature.MediumWeather;

public interface WeatherService {
	public LivingWeather livingWeatherRun(String area); 
	public MediumWeather mediumWeatherRun(String area);
}
