package com.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team.service.AsosService;
import com.team.service.DustService;
import com.team.service.LivingService;
import com.team.service.MediumService;
import com.team.service.ShortService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/Weather/*")
@AllArgsConstructor
@Controller
public class BoardContorller {
	
	@Autowired
	private MediumService mediumService;
	private LivingService livingService;
	private AsosService asosService;
	private ShortService shortService;
	private DustService dustService;
	
	//메인 컨트롤러
	@GetMapping("/Main")
	public void test(@RequestParam("area") String area,Model model){
		log.info("컨트롤러테스트");
		System.out.println("컨트롤러테스트");
		model.addAttribute("air",livingService.livingAirRun(area));
		model.addAttribute("uv",livingService.livingUVRun(area));
		model.addAttribute("asos",asosService.asosRun(area));
	}
	
	//중기 컨트롤러
	@GetMapping("/MediumWeather")
	public void Medium(@RequestParam("area") String area,Model model) {
		System.out.println("미디움테스트");
		model.addAttribute("temper",mediumService.mediumTempRun(area));
		model.addAttribute("weather",mediumService.mediumWeatherRun(area));
	}
	
	//단기 컨트론러
	@GetMapping("/ShortWeather")
	public void Shrot(@RequestParam("area") String area, Model model) {
		System.out.println("미디움테스트");
		model.addAttribute("shortweather",shortService.shortWeatherRun(area));
	}
	
	//미세먼지 컨트롤러
    @GetMapping("/Dust")
    public void Dust(Model model) {
        System.out.println("미세먼지테스트");
        model.addAttribute("dust",dustService.weatherDustRun());
    }
}
