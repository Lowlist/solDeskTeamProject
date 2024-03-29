package com.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team.service.WeatherAsosService;
import com.team.service.WeatherLivingService;
import com.team.service.WeatherMediumService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/Weather/*")
@AllArgsConstructor
@Controller
public class BoardContorller {
	
	@Autowired
	private WeatherMediumService mediumService;
	private WeatherLivingService livingService;
	private WeatherAsosService asosService;
	
	//메인 컨트롤러
	@GetMapping("/Main")
	public void test(@RequestParam("area") String area,Model model){
		log.info("컨트롤러테스트");
		System.out.println("컨트롤러테스트");
		model.addAttribute("air",livingService.livingWeatherRun(area));
		model.addAttribute("uv",livingService.livingWeatherUVRun(area));
		model.addAttribute("asos",asosService.asosDalyInfoRun(area));
	}
	
	//중기 컨트롤러
	@GetMapping("/MediumWeather")
	public void Medium(@RequestParam("area") String area,Model model) {
		System.out.println("미디움테스트");
//		model.addAttribute("temper",mediumService.mediumTemperatureRun(area));
//		model.addAttribute("weather",mediumService.mediumWeatherRun(area));
	}
}
