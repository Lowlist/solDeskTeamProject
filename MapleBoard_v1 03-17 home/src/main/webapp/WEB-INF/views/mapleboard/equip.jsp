<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/equipStyles.css">
<script src="${cp}/resources/maplescript.js"></script>
<meta charset="UTF-8">
<title>메이플스토리 장비창</title>
<style>
  .item_popup_main { position: absolute; /* Adjust as needed */ }
  .star_force_line { /* Add styles as needed */ }
</style>
</head>
<body>

<div class="item_popup_main">
    <div id="starforce" class="star_force_line"></div>
    <div class="item_top_line">
        <div id="item_name"></div><br>
        <div class="item_potential_line" id="item_potential"></div>
    </div>
    <div class="item_icon_line">
        <img id="img_icon">
    </div>
</div>

<div id="main">
    <div id="eqip">
        <div id="eqipline" class="item-line">
            <c:forEach var="i" begin="0" end="23">
                <div class="item" id="item_${i}"
                    data-starforce="${item.item_equipment.get(i).starforce}"
                    data-equip_level="${item.item_equipment.get(i).item_base_option.base_equipment_level}"
                    data-name="${item.item_equipment.get(i).item_name}"
                    data-potential="${item.item_equipment.get(i).potential_option_grade}"
                    data-total_str="${item.item_equipment.get(i).item_total_option.str}"
	                data-total_dex="${item.item_equipment.get(i).item_total_option.dex}"
	                data-total_int="${item.item_equipment.get(i).item_total_option.myint}"
	                data-total_luk="${item.item_equipment.get(i).item_total_option.luk}"
	                data-total_max_hp="${item.item_equipment.get(i).item_total_option.max_hp}"
	                data-total_max_mp="${item.item_equipment.get(i).item_total_option.max_mp}"
	                data-total_attack_power="${item.item_equipment.get(i).item_total_option.attack_power}"
	                data-total_magic_power="${item.item_equipment.get(i).item_total_option.magic_power}"
	                data-total_armor="${item.item_equipment.get(i).item_total_option.armor}"
	                data-total_speed="${item.item_equipment.get(i).item_total_option.speed}"
	                data-total_jump="${item.item_equipment.get(i).item_total_option.jump}"
	                data-total_boss_damage="${item.item_equipment.get(i).item_total_option.boss_damage}"
	                data-total_ignore_monster_armor="${item.item_equipment.get(i).item_total_option.ignore_monster_armor}"
	                data-total_ignore_all_stat="${item.item_equipment.get(i).item_total_option.all_stat}"
	                data-total_ignore_damage="${item.item_equipment.get(i).item_total_option.damage}"
	                data-total_equipment_level_decrease="${item.item_equipment.get(i).item_total_option.equipment_level_decrease}"
	                data-total_max_hp_rate="${item.item_equipment.get(i).item_total_option.max_hp_rate}"
	                data-total_max_mp_rate="${item.item_equipment.get(i).item_total_option.max_mp_rate}">
                    <img class="itemimg" id="item_${i}_img" src="${item.item_equipment.get(i).item_shape_icon}" alt="${item.item_equipment.get(i).item_name}">
                </div>
                <c:if test="${i % 5 == 4}">
				    <div class="block" id="block_${Math.floor((i / 5)) + 1}"></div>
				</c:if>
            </c:forEach>
                <fmt:parseNumber var="test" value="${Math.floor((i / 5)) + 1}" integerOnly="true"/>
        </div>
    </div>

    <div id="pet">
        <c:forEach var="i" begin="1" end="3">
            <div class="pet-line" id="petline_${i}">
                <div class="item" id="pet_${i}"></div>
                <div class="item" id="petacc_${i}"></div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
