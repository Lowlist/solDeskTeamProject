package com.lowlist.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowlist.dto.android.AndroidInfo;
import com.lowlist.dto.item.ItemInfo;
import com.lowlist.dto.mapleapi.Ability;
import com.lowlist.dto.mapleapi.BasicData;
import com.lowlist.dto.mapleapi.HyperStat;
import com.lowlist.dto.mapleapi.Ocid;
import com.lowlist.dto.mapleapi.Propensity;
import com.lowlist.dto.mapleapi.SqlCountData;
import com.lowlist.dto.mapleapi.StatData;
import com.lowlist.mapper.MapleMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MapleServiceImpl implements MapleService {
	@Autowired
	private MapleMapper mapper;	
	private final String MAPLE_KEY = "test_bb301ec87cdd0f23c3b9151ba7bee6ada5754628363ed763264e5f46dd75d43bfd7cd03c20f295fdbee74677d98ea643";
	private final String MAPLE_URL = "https://open.api.nexon.com/maplestory/v1/";
	private final String API_KEYNAME ="x-nxopen-api-key";
	private final String METHOD ="accept";
	private final String FORM ="application/json";
	ObjectMapper objectMapper = new ObjectMapper();
	@Override
	public String yesterDay() {
		// 현재 날짜를 가져오기
		LocalDate currentDate = LocalDate.now();
		// 날짜를 하루 전으로 변경
    	LocalDate yesterday = currentDate.minusDays(1);
    	// 날짜 형식을 지정
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	// 형식에 맞게 날짜를 문자열로 변환
    	String formattedYesterday = yesterday.format(formatter);
    	return formattedYesterday;
	}
	
	public String insertOcid(String id) {
		String ocidValue = "";
		String characterName = URLEncoder.encode(id, StandardCharsets.UTF_8);
		String API_URL = MAPLE_URL + "id?character_name=" + characterName;
		
		//https 접속을 위한 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);
		
		RestTemplate restTemplate = new RestTemplate();
		// 얘는 key값을 통해 받아온 uri 정보를 json방식으로 uri를 압축함
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null; // java.net.URI 임포트 하셈
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		Ocid ocidData = restTemplate.exchange(uri,HttpMethod.GET, entity, Ocid.class).getBody();
		ocidValue = ocidData.getOcid();
		ocidData.setCharacter_name(id);
		System.out.println("ocid api 들림");
		mapper.insertOcid(ocidData);
		return ocidValue;
	}
	
	public BasicData insertBasic(String id) {
		BasicData basic = new BasicData();
		String API_URL = MAPLE_URL + "character/basic?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);

		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		basic = restTemplate.exchange(uri, HttpMethod.GET, entity, BasicData.class).getBody();
		System.out.println("베이직api 들림");
		mapper.insertBasicData(basic);
		return basic;
	}
	
	public void insertStat(String id) {
		StatData statdata = new StatData();
		String API_URL = MAPLE_URL + "character/stat?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);
		// 헤더 끝
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		statdata = restTemplate.exchange(uri, HttpMethod.GET, entity, StatData.class).getBody();
		statdata.setCharacter_name(id);
		System.out.println("확인용 클래스" + statdata.getCharacter_class());
		for (int i = 0; i < statdata.getFinal_stat().size(); i++) {
			statdata.setStat_name(statdata.getFinal_stat().get(i).stat_name);
			statdata.setStat_value(statdata.getFinal_stat().get(i).stat_value);
			mapper.insertStatData(statdata);
		}
		System.out.println("스탯api 들림");
	}
	
	public void insertHyperStat(String id) {
		HyperStat hyper = new HyperStat();
		String API_URL = MAPLE_URL + "character/hyper-stat?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		hyper = restTemplate.exchange(uri, HttpMethod.GET, entity, HyperStat.class).getBody();
		hyper.setCharacter_name(id);
		for(int i = 0;i<hyper.getHyper_stat_preset_1().size();i++) {
			hyper.setHyper_stat_preset_no(1);
			hyper.setStat_type(hyper.getHyper_stat_preset_1().get(i).stat_type);
			hyper.setStat_point(hyper.getHyper_stat_preset_1().get(i).stat_point);
			hyper.setStat_level(hyper.getHyper_stat_preset_1().get(i).stat_level);
			hyper.setStat_increase(hyper.getHyper_stat_preset_1().get(i).stat_increase);
			mapper.insertHyperStat(hyper);
		}
		
		for(int i = 0;i<hyper.getHyper_stat_preset_2().size();i++) {
			hyper.setHyper_stat_preset_no(2);
			hyper.setStat_type(hyper.getHyper_stat_preset_2().get(i).stat_type);
			hyper.setStat_point(hyper.getHyper_stat_preset_2().get(i).stat_point);
			hyper.setStat_level(hyper.getHyper_stat_preset_2().get(i).stat_level);
			hyper.setStat_increase(hyper.getHyper_stat_preset_2().get(i).stat_increase);
			mapper.insertHyperStat(hyper);
		}
		
		for(int i = 0;i<hyper.getHyper_stat_preset_3().size();i++) {
			hyper.setHyper_stat_preset_no(3);
			hyper.setStat_type(hyper.getHyper_stat_preset_3().get(i).stat_type);
			hyper.setStat_point(hyper.getHyper_stat_preset_3().get(i).stat_point);
			hyper.setStat_level(hyper.getHyper_stat_preset_3().get(i).stat_level);
			hyper.setStat_increase(hyper.getHyper_stat_preset_3().get(i).stat_increase);
			mapper.insertHyperStat(hyper);
		}
		System.out.println(hyper);
		System.out.println("하이퍼스탯 api 들림");
	}
	
	public Propensity insertPropensity(String id) {
		Propensity propensity = new Propensity();
		String API_URL = MAPLE_URL + "character/propensity?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);

		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		propensity = restTemplate.exchange(uri, HttpMethod.GET, entity, Propensity.class).getBody();
		propensity.setCharacter_name(id);
		mapper.insertPropensity(propensity);
		System.out.println("성향 api들림");
		return propensity;
	}
	
	public void insertAbility(String id) {
		Ability ability = new Ability();
		String API_URL = MAPLE_URL + "character/ability?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);

		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		ability = restTemplate.exchange(uri, HttpMethod.GET, entity, Ability.class).getBody();
		ability.setCharacter_name(id);
		for(int i = 0;i<ability.ability_info.size();i++){
			ability.setAbility_preset_appoint_no("0");
			ability.setAbility_preset_no(ability.ability_info.get(i).ability_no);
			ability.setAbility_preset_grade(ability.ability_info.get(i).ability_grade);
			ability.setAbility_preset_value(ability.ability_info.get(i).ability_value);
			mapper.insertAbility(ability);
		}
		for(int i = 0;i<ability.ability_preset_1.ability_info.size();i++){
			ability.setAbility_preset_appoint_no("1");
			ability.setAbility_preset_no(ability.ability_preset_1.ability_info.get(i).ability_no);
			ability.setAbility_preset_grade(ability.ability_preset_1.ability_info.get(i).ability_grade);
			ability.setAbility_preset_value(ability.ability_preset_1.ability_info.get(i).ability_value);
			mapper.insertAbility(ability);
		}
		for(int i = 0;i<ability.ability_preset_2.ability_info.size();i++){
			ability.setAbility_preset_appoint_no("2");
			ability.setAbility_preset_no(ability.ability_preset_2.ability_info.get(i).ability_no);
			ability.setAbility_preset_grade(ability.ability_preset_2.ability_info.get(i).ability_grade);
			ability.setAbility_preset_value(ability.ability_preset_2.ability_info.get(i).ability_value);
			mapper.insertAbility(ability);
		}
		for(int i = 0;i<ability.ability_preset_3.ability_info.size();i++){
			ability.setAbility_preset_appoint_no("3");
			ability.setAbility_preset_no(ability.ability_preset_3.ability_info.get(i).ability_no);
			ability.setAbility_preset_grade(ability.ability_preset_3.ability_info.get(i).ability_grade);
			ability.setAbility_preset_value(ability.ability_preset_3.ability_info.get(i).ability_value);
			mapper.insertAbility(ability);
		}
		System.out.println("어빌리티 api들림");
	}
	
	public void insertItemEquip(String id) {
		ItemInfo itemInfo = new ItemInfo();
		String API_URL = MAPLE_URL + "character/item-equipment?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);

		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		itemInfo.setCharacter_name(id);
		ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		itemInfo.setJson_data(roots.getBody());
		mapper.insertItemEquip(itemInfo);
	}
	
	public void insertAndroidEquip(String id) {
		AndroidInfo android_info = new AndroidInfo();
		String API_URL = MAPLE_URL + "character/android-equipment?ocid=" + selectOcid(id) + "&date=" + yesterDay();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set(API_KEYNAME, MAPLE_KEY);
		headers.set(METHOD, FORM);

		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<String>(headers);
		URI uri = null;
		try {
			uri = new URI(API_URL);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		android_info.setCharacter_name(id);
		ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		android_info.setJson_data(roots.getBody());
		mapper.insertAndroid(android_info);
	}
	
	public ItemInfo JsonItemEquip(ItemInfo in) {
		ItemInfo info = new ItemInfo();
		String jsondata = mapper.selectItemEquip(in);
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata, ItemInfo.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
	}
	
	public AndroidInfo JsonAndroid(AndroidInfo in) {
		AndroidInfo info = new AndroidInfo();
		String jsondata = mapper.selectAndroid(in);
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata,AndroidInfo.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
	}
	
	//중요함수 이걸로 해당 테이블 내의 데이터가 있는지 없는지 확인함.
	@Override
	public boolean SqlCheckData(SqlCountData countdata) {
		if(mapper.getCountSqlData(countdata) == 0) {
			//값이 sql에 없으면 트루반환
			return true;
		} else {
			//값이 sql에 있으면 실패반환
			return false;
		}
	}
	
	public String selectOcid(String id) {
		Ocid in = new Ocid();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("ocidData");
		if(SqlCheckData(check)) {
			//만약에 ocid가 sql에 없으면 api 데이터 삽입후 리턴
			return insertOcid(id);
		} else {
			//sql에 있으면 sql에서 리턴
			return mapper.selectOcid(in);
		}
	}
	
	@Override
	public BasicData selectBasic(String id) {
		BasicData in = new BasicData();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("basicData");
		if (SqlCheckData(check)) {
			return insertBasic(id);
		} else {
			return mapper.selectBasicData(in);
		}
	}
	
	@Override
	public List<HyperStat> selectHyperStat(String id,int preset) {
		HyperStat in = new HyperStat();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		in.setHyper_stat_preset_no(preset);
		check.setCharacter_name(id);
		check.setTable_name("hyperStat");
		if (SqlCheckData(check)) {
			insertHyperStat(id);
			System.out.println("하이퍼스탯 들림");
		} 
		return mapper.selectHyperStatData(in);
	}
	
	@Override
	public List<StatData> selectStatData(String id) {
		StatData in = new StatData();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("statData");
		if (SqlCheckData(check)) {
			insertStat(id);
		}
		return mapper.selectStatData(in);
	}
	
	@Override
	public Propensity selectPropensity(String id) {
		Propensity in = new Propensity();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("propensity");
		if (SqlCheckData(check)) {
			return insertPropensity(id);
		} else {
			return mapper.selectPropensity(in);
		}
	}
	@Override
	public List<Ability> selectAbility(String id){
		Ability in = new Ability();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("ability");
		if (SqlCheckData(check)) {
			insertAbility(id);
		}
		return mapper.selectAbility(in);
	}

	@Override
	public ItemInfo selectItemEquip(String id) {
		ItemInfo in = new ItemInfo();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("itemEquip");
		if (SqlCheckData(check)) {
			insertItemEquip(id);
			System.out.println("아이템 api들립");
		} 
		return JsonItemEquip(in);
	}
	@Override
	public AndroidInfo selectAndroid(String id) {
		AndroidInfo in = new AndroidInfo();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("android");
		if (SqlCheckData(check)) {
			insertAndroidEquip(id);
			System.out.println("아이템 api들립");
		} 
		return JsonAndroid(in);
	}
	
}