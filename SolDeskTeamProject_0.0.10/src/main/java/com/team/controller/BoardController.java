package com.team.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.dto.shortwthr.ShortWeather;
import com.team.service.AsosService;
import com.team.service.DustService;
import com.team.service.HomeService;
import com.team.service.LivingService;
import com.team.service.MediumService;
import com.team.service.PublicWork;
import com.team.service.ShortService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/Weather/*")
@AllArgsConstructor
@Controller
public class BoardController {
	@Autowired
	private MediumService mediumService;
	private LivingService livingService;
	private AsosService asosService;
	private ShortService shortService;
	private DustService dustService;
	private HomeService homeService;
	//0.0.8에서 컨트롤러에 날짜 실으려고 만듬 by.형주
	private PublicWork publicWork;
	//asos종관 컨트롤러
	@ResponseBody
	@PostMapping("/Home")
	public String homeShort(@RequestParam("gridx") String gridx,@RequestParam("gridy") String gridy , Model model) {
		System.out.println("홈컨트롤러임");
		model.addAttribute("home",homeService.homeRun(gridx,gridy));
		String jsonData = homeService.jsoncontrol(gridx,gridy);
		return jsonData;
	}
	@GetMapping("/PastWeather")
    public void pastWeather(@RequestParam("area") String area,@RequestParam(value="date",defaultValue = "") String date,Model model) {
    	 if (date.isEmpty()) {
    	     date = publicWork.nowDateAsos();
    	 }
    	System.out.println("과거페이지테스트");
    	model.addAttribute("asos",asosService.asosRun(area,date));
    	model.addAttribute("date",publicWork.nowDate());
    }
	
	//생황기상지수 컨트롤러
	@GetMapping("/Living")
	public void living(@RequestParam(value = "area", defaultValue = "서울") String area, Model model) {
		System.out.println("컨트롤러테스트");
		model.addAttribute("air", livingService.livingAirRun(area));
		model.addAttribute("uv", livingService.livingUVRun(area));
	}
	
	//중기 컨트롤러
	@GetMapping("/MediumWeather")
	public void Medium(@RequestParam(value = "area", defaultValue = "서울") String area,Model model) {
		System.out.println("미디움테스트");
		model.addAttribute("temper",mediumService.mediumTempRun(area));
		model.addAttribute("weather",mediumService.mediumWeatherRun(area));
		model.addAttribute("MediumData",mediumService.getDates());
		model.addAttribute("Area",area);
	}
	
	// 단기 컨트론러
	@GetMapping("/ShortWeather")
	public void Short() {
//			System.out.println("미디움테스트");
//			model.addAttribute("shortweather",shortService.shortWeatherRun());
	}
	
	//단기 삽입 
	@PostMapping("/NewInsert")
	public void newInsert() {
		System.out.println("단기불러오기");
		shortService.shortWeatherRun();
		// model.addAttribute("shortInsert",shortService.shortWeatherRun());
	}

	//미세먼지 컨트롤러
    @GetMapping("/DustWeather")
    public void Dust(Model model) {
        System.out.println("미세먼지테스트");
        model.addAttribute("dust",dustService.weatherDustRun());
        /* model.addAttribute("jsonImageData",dustService.getImageUrls()); */
    }
}
