package com.lowlist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lowlist.dto.android.AndroidInfo;
import com.lowlist.dto.item.ItemInfo;
import com.lowlist.dto.mapleapi.Ability;
import com.lowlist.dto.mapleapi.BasicData;
import com.lowlist.dto.mapleapi.HyperStat;
import com.lowlist.dto.mapleapi.Propensity;
import com.lowlist.dto.mapleapi.StatData;
import com.lowlist.service.MapleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/mapleboard/*")
@AllArgsConstructor
@Controller
public class BoardContorller {
	@Autowired
	private MapleService service;
	
	@GetMapping("/test")
	public void test(){
		log.info("컨트롤러테스트");
		System.out.println("컨트롤러테스트");
	}
	
	@GetMapping("/mapleapi")
	public void mapleapis(Model model,@RequestParam("id") String id) throws Exception {
		BasicData mapleapi = service.selectBasic(id);
		StatData selstatdata = service.selectStatData(id);
		HyperStat hyperstat = service.selectHyperStat(id);
		Propensity propensity =service.selectPropensity(id);
		Ability ability = service.selectAbility(id);
		model.addAttribute("hyper",hyperstat);
		model.addAttribute("stat", selstatdata);
		model.addAttribute("maple", mapleapi);
		model.addAttribute("propensity",propensity);
		model.addAttribute("ability",ability);
	}
	
	@GetMapping("/equip")
	public String mapleapisss(Model model,
			@RequestParam("id") String id
			) throws Exception {
		BasicData mapleapi = service.selectBasic(id);
		StatData selstatdata = service.selectStatData(id);
		HyperStat hyperstat = service.selectHyperStat(id);
		Propensity propensity =service.selectPropensity(id);
		Ability ability = service.selectAbility(id);
		ItemInfo itemequipdata = service.selectItemEquip(id);
		AndroidInfo android = service.selectAndroid(id);
		model.addAttribute("item",itemequipdata);
		model.addAttribute("hyper",hyperstat);
		model.addAttribute("stat", selstatdata);
		model.addAttribute("maple", mapleapi);
		model.addAttribute("propensity",propensity);
		model.addAttribute("ability",ability);
		model.addAttribute("android",android);
		return "mapleboard/equip";
	}
	
	@GetMapping("/main")
	public String mainHome(Model model){
		System.out.println("컨트롤러 오긴함?");
		return "html/mapleboard/main";
	}
}
