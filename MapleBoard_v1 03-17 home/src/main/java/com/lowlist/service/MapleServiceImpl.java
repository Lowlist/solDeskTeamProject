package com.lowlist.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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
	
	//중요함수 이걸로 어제 날짜 자동으로 계산해서 가져옴
	@Override
	public String yesterDay() {
		LocalDate currentDate = LocalDate.now();
    	LocalDate yesterday = currentDate.minusDays(1);
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	String formattedYesterday = yesterday.format(formatter);
    	return formattedYesterday;
	}
	
	//중요함수 이걸로 해당 테이블 내의 데이터가 있는지 없는지 확인함.
	@Override
	public boolean SqlCheckData(SqlCountData countdata) {
		if (mapper.getCountSqlData(countdata) == 0) {
			// 값이 sql에 없으면 트루반환
			return true;
		} else {
			// 값이 sql에 있으면 실패반환
			return false;
		}
	}

	//중요함수 ocid 정보 불러오기 이게 기준점임
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
	
	//베이직데이터 셀렉트문 sql 참조해서 있으면 sql에서 불러옴
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
	
	//JSON화 시킴
	@Override
	public StatData selectStatData(String id) {
		StatData in = new StatData();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("StatData");
		if (SqlCheckData(check)) {
			insertStatData(id);
			System.out.println("아이템 api들립");
		}
		return JsonStatData(in);
	}
	
	//JSON화 시킴
	@Override
	public Ability selectAbility(String id){
		Ability in = new Ability();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("ability");
		if (SqlCheckData(check)) {
			insertAbility(id);
		}
		return JsonAbility(in);
	}
	
	//JSON화 시킴
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
	
	//JSON화 시킴
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
	
	//JSON화 시킴
	@Override
	public HyperStat selectHyperStat(String id) {
		HyperStat in = new HyperStat();
		SqlCountData check = new SqlCountData();
		in.setCharacter_name(id);
		check.setCharacter_name(id);
		check.setTable_name("hyperStat");
		if (SqlCheckData(check)) {
			insertHyperStat(id);
			System.out.println("하이퍼스탯 들림");
		} 
		return JsonHyperStat(in);
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
	
	public Ability JsonAbility(Ability in) {
		Ability info = new Ability();
		String jsondata = mapper.selectAbility(in);
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata,Ability.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
	}
	
	public HyperStat JsonHyperStat(HyperStat in) {
		HyperStat info = new HyperStat();
		String jsondata = mapper.selectHyperStatData(in);
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata,HyperStat.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
	}
	
	public StatData JsonStatData(StatData in) {
		StatData info = new StatData();
		String jsondata = mapper.selectStatData(in);
		try {
            // JSON 문자열을 해당 객체로 변환
            info = objectMapper.readValue(jsondata,StatData.class);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
		return info;
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
		URI uri = null; 
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
	
	public void insertStatData(String id) {
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
		ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		statdata.setCharacter_name(id);
		statdata.setJson_data(roots.getBody());
		mapper.insertStatData(statdata);
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
		ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		hyper.setCharacter_name(id);
		hyper.setJson_data(roots.getBody());
		mapper.insertHyperStat(hyper);
		System.out.println("하이퍼스탯 api 들렸음");
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
		ResponseEntity<String> roots = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		ability.setCharacter_name(id);
		ability.setJson_data(roots.getBody());
		mapper.insertAbility(ability);
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
		System.out.println("장착아이템 api 들렸음");
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
		System.out.println("안드로이드 정보 api 들렸음");
	}
	
	
}