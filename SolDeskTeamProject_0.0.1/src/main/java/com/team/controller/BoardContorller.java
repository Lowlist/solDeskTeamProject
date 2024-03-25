package com.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team.service.WeatherService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/weather/*")
@AllArgsConstructor
@Controller
public class BoardContorller {
	@Autowired
	private WeatherService service;
	
	@GetMapping("/test")
	public void test(){
		log.info("컨트롤러테스트");
		System.out.println("컨트롤러테스트");
	}
	
}
