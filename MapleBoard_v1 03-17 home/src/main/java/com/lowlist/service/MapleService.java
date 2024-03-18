package com.lowlist.service;

import java.util.List;

import com.lowlist.dto.android.AndroidInfo;
import com.lowlist.dto.item.ItemInfo;
import com.lowlist.dto.mapleapi.Ability;
import com.lowlist.dto.mapleapi.BasicData;
import com.lowlist.dto.mapleapi.HyperStat;
import com.lowlist.dto.mapleapi.Propensity;
import com.lowlist.dto.mapleapi.SqlCountData;
import com.lowlist.dto.mapleapi.StatData;

public interface MapleService {

	public String yesterDay();
	public BasicData selectBasic(String id);
	public List<StatData> selectStatData(String id);
	public List<HyperStat> selectHyperStat(String id,int preset);
	public boolean SqlCheckData(SqlCountData countdata);
	public Propensity selectPropensity(String id);
	public List<Ability> selectAbility(String id);
	public ItemInfo selectItemEquip(String id);
	public AndroidInfo selectAndroid(String id);

}
