package com.team.service;

import com.team.dto.asosdalyinfo.AsosDalyInfo;
import com.team.dto.livingwthr.LivingWeather;
import com.team.dto.mediumwthr.temperature.MediumWeather;
import com.team.dto.mediumwthr.weather.WeatherInfo;

public interface WeatherService {
	public LivingWeather livingWeatherRun(String area); 
	public AsosDalyInfo asosDalyInfoRun(String area);
	// 형주
	public MediumWeather mediumTemperatureRun(String area);
	public WeatherInfo mediumWeatherRun(String area);
}
