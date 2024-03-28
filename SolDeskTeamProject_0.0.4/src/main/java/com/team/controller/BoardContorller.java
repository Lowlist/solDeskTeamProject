package com.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team.service.WeatherService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/Weather/*")
@AllArgsConstructor
@Controller
public class BoardContorller {
	@Autowired
	private WeatherService service;
	
	@GetMapping("/Main")
	public void test(@RequestParam("area") String area,Model model){
		log.info("컨트롤러테스트");
		System.out.println("컨트롤러테스트");
		model.addAttribute("living",service.livingWeatherRun(area));
		model.addAttribute("asos",service.asosDalyInfoRun(area));
	}
	
	@GetMapping("/MediumWeather")
	public void Medium(@RequestParam("area") String area,Model model) {
		System.out.println("미디움테스트");
		model.addAttribute("temper",service.mediumWeatherRun(area));
	}
}
