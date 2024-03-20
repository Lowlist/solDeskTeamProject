package com.lowlist.service;

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
	public boolean SqlCheckData(SqlCountData countdata);
	public BasicData selectBasic(String id);
	public StatData selectStatData(String id);
	public HyperStat selectHyperStat(String id);
	public Propensity selectPropensity(String id);
	public Ability selectAbility(String id);
	public ItemInfo selectItemEquip(String id);
	public AndroidInfo selectAndroid(String id);

}
