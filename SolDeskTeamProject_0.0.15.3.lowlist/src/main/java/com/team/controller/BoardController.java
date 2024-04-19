package com.team.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	//홈 네이버Map API 관련 컨트롤러(단기)
	@ResponseBody
	@PostMapping("/Home")
	public String homeShort(@RequestParam("gridx") String gridx,@RequestParam("gridy") String gridy , Model model) {
		System.out.println("홈컨트롤러임");
		String jsonData = homeService.getJsonData(gridx,gridy);
		return jsonData;
	}
	
	//생황기상지수 컨트롤러
	@ResponseBody
	@PostMapping("/LivingWeather")
	public String livingWeather(@RequestParam("area") String area,@RequestParam("type") String type , Model model) {
		String jsonData = "";
		if(type.equals("UV")) {
			jsonData = livingService.getUVJsonData(area);
		}else if(type.equals("Air")) {
			jsonData = livingService.getAirJsonData(area);
		}
		return jsonData;
	}
	@GetMapping("/LivingWeather")
	public void livingWeather() {
		
	}
	//asos종관 컨트롤러
	@GetMapping("/PastWeather")
    public void pastWeather(@RequestParam("area") String area,@RequestParam(value="date",defaultValue = "") String date,Model model) {
    	 if (date.isEmpty()) {
    	     date = publicWork.nowDateAsos();
    	 }
    	System.out.println("과거페이지테스트");
    	model.addAttribute("asos",asosService.asosRun(area,date));
    	model.addAttribute("date",publicWork.nowDate());
    }

	// 중기 컨트롤러
	@GetMapping("/MediumWeather")
	public void Medium(@RequestParam(value = "area", defaultValue = "") String area, Model model,
			HttpServletRequest request) {
		if (area.isEmpty()) {
			area = "서울";
		}
		System.out.println("미디움테스트");
		request.setAttribute("morningWeatherMap", mediumService.morningWeatherMap());
		request.setAttribute("nightWeatherMap", mediumService.nightWeatherMap());
		model.addAttribute("temper", mediumService.mediumTempRun(area));
		model.addAttribute("weather", mediumService.mediumWeatherRun(area));
		model.addAttribute("forecast", mediumService.mediumForecastRun(area));
		model.addAttribute("MediumDate1", mediumService.getDates());
		model.addAttribute("Area", area);
		model.addAttribute("error", mediumService.mediumWeatherArea(area));
		model.addAttribute("areaBox", mediumService.areaBox());
	}

	//미세먼지 컨트롤러
    @GetMapping("/DustWeather")
    public void Dust(Model model) {
        System.out.println("미세먼지테스트");
        model.addAttribute("dust",dustService.weatherDustRun());
        /* model.addAttribute("jsonImageData",dustService.getImageUrls()); */
    }
    
 	@GetMapping("/ShortWeather")
 	public void Short(@RequestParam(value = "area", defaultValue = "") String area, Model model,
 			HttpServletRequest request) {
 		if (area.isEmpty()) {
 			area = "서울";
 		}
 		request.setAttribute("morningWeatherMap", mediumService.morningWeatherMap());
 		System.out.println("확인하기 :" + mediumService.morningWeatherMap());
 		request.setAttribute("nightWeatherMap", mediumService.nightWeatherMap());
 		model.addAttribute("temper", mediumService.mediumTempRun(area));
 		model.addAttribute("weather", mediumService.mediumWeatherRun(area));
 		model.addAttribute("MediumData", mediumService.getDates());
 		model.addAttribute("Area", area);
 		model.addAttribute("nowWeather", shortService.nowWeatherList());
 		model.addAttribute("searchTmpWeather", shortService.searchTmpWeather(area));
 		model.addAttribute("searchRehWeather", shortService.searchRehWeather(area));
 		model.addAttribute("searchPcpWeather", shortService.searchPcpWeather(area));
 		model.addAttribute("searchPopWeather", shortService.searchPopWeather(area));
 		model.addAttribute("searchSkyWeather", shortService.searchSkyWeather(area));
 	}

 	// 단기 검색어 & 현재 시간데이터들을 가져오기
 	@PostMapping("/searchWeather")
 	public String searchWeather(@RequestParam("area") String area, Model model,HttpServletRequest request) {
 		if (area == null || area.isEmpty()) {
 	        // 기본적으로 설정된 지역 정보를 가져오거나 사용자의 위치를 기준으로 설정합니다.
 	        area ="서울"; // 이 부분은 기본 지역을 가져오는 메서드 또는 사용자 위치를 가져오는 메서드로 대체되어야 합니다.
 	    }
 		model.addAttribute("searchweather", shortService.searchWeather(area));
 		request.setAttribute("morningWeatherMap", mediumService.morningWeatherMap());
 		request.setAttribute("nightWeatherMap", mediumService.nightWeatherMap());
 		model.addAttribute("temper", mediumService.mediumTempRun(area));
 		model.addAttribute("weather", mediumService.mediumWeatherRun(area));
 		model.addAttribute("MediumData", mediumService.getDates());
 		model.addAttribute("Area", area);
 		model.addAttribute("searchTmpWeather", shortService.searchTmpWeather(area));
 		model.addAttribute("searchRehWeather", shortService.searchRehWeather(area));
 		model.addAttribute("searchPcpWeather", shortService.searchPcpWeather(area));
 		model.addAttribute("searchPopWeather", shortService.searchPopWeather(area));
 		model.addAttribute("searchSkyWeather", shortService.searchSkyWeather(area));
 		model.addAttribute("searchNowWeather", shortService.searchNowWeather(area));
 		System.out.println("확인하기 : " + shortService.searchNowWeather(area));
 		return "Weather/ShortWeather";
 	}
 	// 단기 삽입 (완성)
 	@PostMapping("/NewInsert")
 	public String newInsert() {
 		System.out.println("단기불러오기");
 		shortService.ShortWeatherInfoApi();
 		return "redirect:/Weather/ShortWeather";
 	}
 	@PostMapping("/delete")
    public String shortWeatherDelete() {
 	   shortService.shortWeatherDelete();
 	   return "redirect:/Weather/ShortWeather";
    }
    
}
