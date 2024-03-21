$(document).ready(function () {
    $('.item').hover(function () {
        let starForceData = $(this).data('starforce');
        let equip_level = $(this).data('equip_level');
        let dataName = String($(this).data('name'));
        let item = $(this);
        starForceRun(starForceData, equip_level, dataName);
        optionPopupRun(item);
        potentialLinePopup(item);
        $('.item_popup_main').show();
        $('.starforce_line_popup').show();
    }, function () {
        $('.item_popup_main').hide();
        $('.starforce_line_popup').hide();
        // 마우스 hover 종료시 자동으로 div 내용 초기화
        clearDiv();
    });
});

function displayBasicPopup(item) {
    let dataName = String(item.data('name'));
    let dataPotential = String(item.data('potential'));
    let itemIcon = item.find('img').attr('src');
    //? 을 사용해서 있으면 true 없으면 false 반환
    $('#item_name_popup').text(dataName);
    $('#potential_popup').text(dataPotential !=="" ? "(" + dataPotential + " 아이템)" : "");
    $('#item_icon_popup').attr('src', itemIcon).attr('class', dataPotential);
}

function potentialLinePopup(item){
    let potential = String(item.data('potential'));
    let potentialOption_1 = String(item.data('potential_option_1'));
    let potentialOption_2 = String(item.data('potential_option_2'));
    let potentialOption_3 = String(item.data('potential_option_3'));
    
    let additionalPotential = String(item.data('additional_potential'));
    let additionalPotentialOption_1 = String(item.data('additional_potential_option_1'));
    let additionalPotentialOption_2 = String(item.data('additional_potential_option_2'));
    let additionalPotentialOption_3 = String(item.data('additional_potential_option_3'));

    //윗잠재
    if(potential !== "undefined" && potential !== ""){
        $('#item_potential_popup_0').text(potential ? " "+ potential :"");
        $('#item_potential_option_1_0').text(potentialOption_1 !== "undefined" ? " "+ potentialOption_1 :"");
        $('#item_potential_option_2_0').text(potentialOption_2 !== "undefined" ? " "+ potentialOption_2 :"");
        $('#item_potential_option_3_0').text(potentialOption_3 !== "undefined" ? " "+ potentialOption_3 :"");
    }
    //아랫잠재
    if(additionalPotential !== "undefined" && additionalPotential !== ""){
        $('#item_potential_popup_1').text(additionalPotential !== "undefined" ? " "+ additionalPotential :"");
        $('#item_potential_option_1_1').text(additionalPotentialOption_1 !== "undefined" ? " "+ additionalPotentialOption_1 :"");
        $('#item_potential_option_2_1').text(additionalPotentialOption_2 !== "undefined" ? " "+ additionalPotentialOption_2 :"");
        $('#item_potential_option_3_1').text(additionalPotentialOption_3 !== "undefined" ? " "+ additionalPotentialOption_3 :"");
    }
}


function starForceRun(starforce, equipLevel, dataName) {
    let maxStarForce;
    let starimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-yellow.png";
    let starblackimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-default.png";
    let container = $("#starforce_popup");
    container.empty();
    let equipLevelCheck = parseInt(equipLevel);
    //아이템 이름에 따라 최대 별 갯수 변경 로직
    if (dataName.includes("타일런트") || dataName.includes("노바") || dataName.includes("헬리시움")) {
        //아이템 레벨에 따라 최대 별 갯수 변경 로직
        if (equipLevelCheck <= 94) {
            maxStarForce = 3;
        } else if (equipLevelCheck <= 107) {
            maxStarForce = 5;
        } else if (equipLevelCheck <= 117) {
            maxStarForce = 8;
        } else if (equipLevelCheck <= 127) {
            maxStarForce = 10;
        } else if (equipLevelCheck <= 137) {
            maxStarForce = 12;
        } else if (equipLevelCheck >= 138) {
            maxStarForce = 15;
        }
    } else {
        //아이템 레벨에 따라 최대 별 갯수 변경 로직
        if (equipLevelCheck <= 94) {
            maxStarForce = 5;
        } else if (equipLevelCheck <= 107) {
            maxStarForce = 7;
        } else if (equipLevelCheck <= 117) {
            maxStarForce = 10;
        } else if (equipLevelCheck <= 127) {
            maxStarForce = 15;
        } else if (equipLevelCheck <= 137) {
            maxStarForce = 20;
        } else if (equipLevelCheck >= 138) {
            maxStarForce = 25;
        }
    }

    // 별 생성 로직
    if (starforce != 0) {
        for (let i = 1; i <= starforce; i++) {
            let image = $("<img>").attr({
                src: starimg,
                alt: "별 이미지",
                class: "starforceimg"
            });
            container.append(image);
            // 5배수 마다 빈칸 추가
            if (i % 5 === 0) {
                container.append(" ");
            }
        }
    // 빈 별 생성 로직
        if (starforce < maxStarForce) {
            for (let i = starforce + 1; i <= maxStarForce; i++) {
                let image = $("<img>").attr({
                    src: starblackimg,
                    alt: "별 이미지",
                    class: "starforce_black_img"
                });
                container.append(image);
                // 5배수 마다 빈칸 추가
                if (i % 5 === 0) {
                    container.append(" ");
                }
            }
        }
    }
}

function displayStrPopup(item) {
    let total = String(item.data('total_str'));
    let base = String(item.data('base_str'));
    let add = String(item.data('add_str'));
    let starforce = String(item.data('starforce_str'));
    let etc = String(item.data('etc_str'));

    //totaldata가 undefined가 아니거나 0이 아닐경우에만 div에 text로 보냄
    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_0').text(total ? "STR : + " + total : "");
        // 만약 나머지가 0이고 베이스만 0이 아닐경우 total만 표기
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_0').text('');
            $('#item_option_line_0').text(total !== "0" ? '' : "");
        // else문으로 예외처리
        }else{
            $('#item_option_bace_popup_0').text(base ? "(" + base : "");
            $('#item_option_line_0').text(total !== "0" ? ")" : "");
        }
        // 나머지는 !== "0" 으로 조건을 주었기때문에 잘 나옴
        $('#item_option_add_popup_0').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_0').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_0').text(starforce !== "0" ? "+" + starforce : "");
    } 
}

function displayDexPopup(item) {
    let total = String(item.data('total_dex'));
    let base = String(item.data('base_dex'));
    let add = String(item.data('add_dex'));
    let starforce = String(item.data('starforce_dex'));
    let etc = String(item.data('etc_dex'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_1').text(total ? "DEX : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_1').text('');
            $('#item_option_line_1').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_1').text(base ? "(" + base : "");
            $('#item_option_line_1').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_1').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_1').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_1').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayIntPopup(item) {
    let total = String(item.data('total_int'));
    let base = String(item.data('base_int'));
    let add = String(item.data('add_int'));
    let starforce = String(item.data('starforce_int'));
    let etc = String(item.data('etc_int'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_2').text(total ? "INT : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_2').text('');
            $('#item_option_line_2').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_2').text(base ? "(" + base : "");
            $('#item_option_line_2').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_2').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_2').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_2').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayLukPopup(item) {
    let total = String(item.data('total_luk'));
    let base = String(item.data('base_luk'));
    let add = String(item.data('add_luk'));
    let starforce = String(item.data('starforce_luk'));
    let etc = String(item.data('etc_luk'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_3').text(total ? "LUK : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_3').text('');
            $('#item_option_line_3').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_3').text(base ? "(" + base : "");
            $('#item_option_line_3').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_3').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_3').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_3').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayMaxHpPopup(item) {
    let total = String(item.data('total_max_hp'));
    let base = String(item.data('base_max_hp'));
    let add = String(item.data('add_max_hp'));
    let starforce = String(item.data('starforce_max_hp'));
    let etc = String(item.data('etc_max_hp'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_4').text(total ? "최대 HP : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_4').text('');
            $('#item_option_line_4').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_4').text(base ? "(" + base : "");
            $('#item_option_line_4').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_4').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_4').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_4').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayMaxMpPopup(item) {
    let total = String(item.data('total_max_mp'));
    let base = String(item.data('base_max_mp'));
    let add = String(item.data('add_max_mp'));
    let starforce = String(item.data('starforce_max_mp'));
    let etc = String(item.data('etc_max_mp'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_5').text(total ? "최대 MP : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_5').text('');
            $('#item_option_line_5').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_5').text(base ? "(" + base : "");
            $('#item_option_line_5').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_5').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_5').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_5').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayMaxHpRatePopup(item) {
    let total = String(item.data('total_max_hp_rate'));
    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_6').text(total ? "최대 HP : + " + total + "%" : "");
    }
}

function displayMaxMpRatePopup(item) {
    let total = String(item.data('total_max_mp_rate'));
    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_7').text(total ? "최대 MP : + " + total + "%" : "");
    }
}

function displayAttackPowerPopup(item) {
    let total = String(item.data('total_attack_power'));
    let base = String(item.data('base_attack_power'));
    let add = String(item.data('add_attack_power'));
    let starforce = String(item.data('starforce_attack_power'));
    let etc = String(item.data('etc_attack_power'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_8').text(total ? "공격력 : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_8').text('');
            $('#item_option_line_8').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_8').text(base ? "(" + base : "");
            $('#item_option_line_8').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_8').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_8').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_8').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayMagicPowerPopup(item) {
    let total = String(item.data('total_magic_power'));
    let base = String(item.data('base_magic_power'));
    let add = String(item.data('add_magic_power'));
    let starforce = String(item.data('starforce_magic_power'));
    let etc = String(item.data('etc_magic_power'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_9').text(total ? "마력 : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_9').text('');
            $('#item_option_line_9').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_9').text(base ? "(" + base : "");
            $('#item_option_line_9').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_9').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_9').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_9').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayArmorPopup(item) {
    let total = String(item.data('total_armor'));
    let base = String(item.data('base_armor'));
    let add = String(item.data('add_armor'));
    let starforce = String(item.data('starforce_armor'));
    let etc = String(item.data('etc_armor'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_10').text(total ? "방어력 : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_10').text('');
            $('#item_option_line_10').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_10').text(base ? "(" + base : "");
            $('#item_option_line_10').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_10').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_10').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_10').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displaySpeedPopup(item) {
    let total = String(item.data('total_armor'));
    let base = String(item.data('base_armor'));
    let add = String(item.data('add_armor'));
    let starforce = String(item.data('starforce_armor'));
    let etc = String(item.data('etc_armor'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_10').text(total ? "이동속도 : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_10').text('');
            $('#item_option_line_10').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_10').text(base ? "(" + base : "");
            $('#item_option_line_10').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_10').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_10').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_10').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayJumpPopup(item) {
    let total = String(item.data('total_jump'));
    let base = String(item.data('base_jump'));
    let add = String(item.data('add_jump'));
    let starforce = String(item.data('starforce_jump'));
    let etc = String(item.data('etc_jump'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_11').text(total ? "점프력 : + " + total : "");
        if(add == "0" && starforce == "0" && etc == "0" && base !=="0"){
            $('#item_option_bace_popup_11').text('');
            $('#item_option_line_11').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_11').text(base ? "(" + base : "");
            $('#item_option_line_11').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_11').text(add !== "0" ? "+" + add : "");
        $('#item_option_etc_popup_11').text(etc !== "0" ? "+" + etc  : "");
        $('#item_option_starforce_popup_11').text(starforce !== "0" ? "+" + starforce : "");
    }
}

function displayBossDamagePopup(item) {
    let total = String(item.data('total_boss_damage'));
    let base = String(item.data('base_boss_damage'));
    let add = String(item.data('add_boss_damage'));
    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_12').text(total ? "보스 몬스터 데미지 : + " + total + "%" : "");
        if(add == "0" && base !=="0"){
            $('#item_option_bace_popup_12').text('');
            $('#item_option_line_12').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_12').text(base ? "(" + base + "%" : "");
            $('#item_option_line_12').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_12').text(add !== "0" ? "+" + add + "%" : "");
    }
}

function displayIgnoreMonsterArmorPopup(item) {
    let total = String(item.data('total_ignore_monster_armor'));
    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_13').text(total ? "몬스터 방어율 무시 : + " + total + "%": "");
    }
}

function displayAllStatPopup(item) {
    let total = String(item.data('total_all_stat'));
    let base = String(item.data('base_all_stat'));
    let add = String(item.data('add_all_stat'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_14').text(total ? "올스탯 : + " + total + "%" : "");
        if(add == "0" && base !=="0"){
            $('#item_option_bace_popup_14').text('');
            $('#item_option_line_14').text(total !== "0" ? '' : "");
        }else{
            $('#item_option_bace_popup_14').text(base ? "(" + base + "%" : "");
            $('#item_option_line_14').text(total !== "0" ? ")" : "");
        }
        $('#item_option_add_popup_14').text(add !== "0" ? "+" + add + "%" : "");
    }
}

function displayDamagePopup(item) {
    let total = String(item.data('total_damage'));
    let base = String(item.data('base_damage'));
    let add = String(item.data('add_damage'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_15').text(total ? "데미지 : + " + total + "%" : "");
            if(add == "0" && base !=="0"){
                $('#item_option_bace_popup_15').text('');
                $('#item_option_line_15').text(total !== "0" ? '' : "");
            }else{
                $('#item_option_bace_popup_15').text(base !== "undefined" ? "(" + base + "%" : "");
                $('#item_option_line_15').text(total !== "0" ? ")" : "");
                if(base == "undefined" && add !== "0"){
                    $('#item_option_bace_popup_15').text(base ? "(" : "");
                    $('#item_option_add_popup_15').text(add !== "0" ? "+" + add + "%" : "");
                }else{
                    $('#item_option_add_popup_15').text(add !== "0" ? "+" + add + "%" : "");    
                }
            }
    }
}

function displayEquipmentLevelDecreasePopup(item) {
    let total = String(item.data('total_equipment_level_decrease'));
    let add = String(item.data('add_equipment_level_decrease'));
    if (total !== "undefined" && total !== "0") {
        $('#item_option_add_popup_16').text(add !== "0" ? "착용 레벨 감소 : + " + add : "");
    }
}

function clearDiv(){
    for(let i = 0 ;i<17 ;i++){
        $('#item_option_total_popup_'+i).text('');
        $('#item_option_add_popup_'+i).text('');
        $('#item_option_bace_popup_'+i).text('');
        $('#item_option_etc_popup_'+i).text('');
        $('#item_option_starforce_popup_'+i).text('');
        $('#item_option_line_'+i).text('');
    }
    $('#item_potential_popup_0').text('');
    $('#item_potential_option_1_0').text('');
    $('#item_potential_option_2_0').text('');
    $('#item_potential_option_3_0').text('');
    $('#item_potential_popup_1').text('');
    $('#item_potential_option_1_1').text('');
    $('#item_potential_option_2_1').text('');
    $('#item_potential_option_3_1').text('');
}

function optionPopupRun (item){
    displayBasicPopup(item);
    displayStrPopup(item);
    displayDexPopup(item);
    displayIntPopup(item);
    displayLukPopup(item);
    displayMaxHpPopup(item);
    displayMaxMpPopup(item);
    displayAttackPowerPopup(item);
    displayMagicPowerPopup(item);
    displayArmorPopup(item);
    displaySpeedPopup(item);
    displayJumpPopup(item);
    displayBossDamagePopup(item);
    displayIgnoreMonsterArmorPopup(item);
    displayAllStatPopup(item);
    displayDamagePopup(item);
    displayEquipmentLevelDecreasePopup(item);
    displayMaxHpRatePopup(item);
    displayMaxMpRatePopup(item);
}