package com.team.service;

import com.team.dto.asosdalyinfo.AsosDalyInfo;
import com.team.dto.livingwthr.LivingWeather;
import com.team.dto.mediumwthr.temperature.MediumWeather;

public interface WeatherService {
	public LivingWeather livingWeatherRun(String area); 
	public AsosDalyInfo asosDalyInfoRun(String area);
	// 형주
	public MediumWeather mediumWeatherRun(String area);
}
