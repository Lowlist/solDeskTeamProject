package com.lowlist.mapper;

import org.springframework.stereotype.Repository;

import com.lowlist.dto.android.AndroidInfo;
import com.lowlist.dto.item.ItemInfo;
import com.lowlist.dto.mapleapi.Ability;
import com.lowlist.dto.mapleapi.BasicData;
import com.lowlist.dto.mapleapi.HyperStat;
import com.lowlist.dto.mapleapi.Ocid;
import com.lowlist.dto.mapleapi.Propensity;
import com.lowlist.dto.mapleapi.SqlCountData;
import com.lowlist.dto.mapleapi.StatData;

@Repository
public interface MapleMapper {
	//인서트문
		public void insertOcid(Ocid ocidvalue);
		public void insertBasicData(BasicData basicdata);
		public void insertStatData(StatData statdata);
		public void insertHyperStat(HyperStat hyperstat);
		public void insertPropensity(Propensity propensity);
		public void insertAbility(Ability ability);
		public void insertItemEquip(ItemInfo itemInfo);
		public void insertAndroid(AndroidInfo androidInfo);
		//카운트문 1개로 됌
		public int getCountSqlData(SqlCountData sqlcountdata);
		//셀렉트문
		public String selectOcid(Ocid name);
		public BasicData selectBasicData(BasicData name);
		public Propensity selectPropensity(Propensity propensity);
		public String selectStatData(StatData statdata);
		public String selectAbility(Ability ability);
		public String selectHyperStatData(HyperStat hyperstat);
		public String selectItemEquip(ItemInfo itemInfo);
		public String selectAndroid(AndroidInfo androidInfo);
}	
