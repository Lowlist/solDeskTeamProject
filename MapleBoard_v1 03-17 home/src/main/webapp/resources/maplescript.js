$(document).ready(function () {
    $('.item').hover(function () {
        let starForceData = $(this).data('starforce');
        let equip_level = $(this).data('equip_level');
        let dataName = String($(this).data('name'));
        let item = $(this);
        starForceRun(starForceData, equip_level, dataName);
        displayBasicPopup(item);
        displayStrPopup(item);
        displayDexPopup(item);
        displayIntPopup(item);
        //? 을 사용해서 있으면 true 없으면 false 반환
        $('.item_popup_main').show();
        $('.starforce_line_popup').show();
    }, function () {
        $('.item_popup_main').hide();
        $('.starforce_line_popup').hide();
    });
});

function displayBasicPopup(item) {
    let dataName = String(item.data('name'));
    let dataPotential = String(item.data('potential'));
    let itemIcon = item.find('img').attr('src');

    //? 을 사용해서 있으면 true 없으면 false 반환
    $('#item_name_popup').text(dataName);
    $('#potential_popup').text(dataPotential ? "(" + dataPotential + " 아이템)" : "");
    $('#item_icon_popup').attr('src', itemIcon).attr('class', dataPotential);
}

function starForceRun(starforce, equipLevel, dataName) {
    let maxStarForce;
    let starimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-yellow.png";
    let starblackimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-default.png";
    let container = $("#starforce_popup");
    container.empty();
    let equipLevelCheck = parseInt(equipLevel);
    if (dataName.includes("타일런트") || dataName.includes("노바") || dataName.includes("헬리시움")) {
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

    if (starforce != 0) {
        for (let i = 1; i <= starforce; i++) {
            let image = $("<img>").attr({
                src: starimg,
                alt: "별 이미지",
                class: "starforceimg"
            });
            container.append(image);
            if (i % 5 === 0) {
                container.append(" ");
            }
        }

        if (starforce < maxStarForce) {
            for (let i = starforce + 1; i <= maxStarForce; i++) {
                let image = $("<img>").attr({
                    src: starblackimg,
                    alt: "별 이미지",
                    class: "starforceimg"
                });
                container.append(image);
                if (i % 5 === 0) {
                    container.append(" ");
                }
            }
        }
    }
}

function displayStrPopup(item) {
    let total = String(item.data('total_str'));
    let add = String(item.data('add_str'));
    let base = String(item.data('base_str'));
    let starforce = String(item.data('starforce_str'));
    let etc = String(item.data('etc_str'));

        $('#item_option_total_popup_0').text('');
        $('#item_option_add_popup_0').text('');
        $('#item_option_bace_popup_0').text('');
        $('#item_option_etc_popup_0').text('');
        $('#item_option_starforce_popup_0').text('');
        $('#item_option_line').text('');

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_0').text(total ? "STR : + " + total + "(": "");
        $('#item_option_add_popup_0').text(base ? base + "+" : "");
        $('#item_option_bace_popup_0').text(add !== "0" ? add + "+": "");
        $('#item_option_etc_popup_0').text(etc !== "0" ? "+" + etc + "+" : "");
        $('#item_option_starforce_popup_0').text(starforce !== "0" ? + starforce : "");
        $('#item_option_line').text(total !== "0" ? ")" : "");
    } 
}

function displayDexPopup(item) {
    let total = String(item.data('total_dex'));
    let add = String(item.data('add_dex'));
    let base = String(item.data('base_dex'));
    let starforce = String(item.data('starforce_dex'));
    let etc = String(item.data('etc_dex'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_1').text(total ? "DEX : + " + total + "(": "");
        $('#item_option_add_popup_1').text(base ? base + "+" : "");
        $('#item_option_bace_popup_1').text(add !== "0" ? add + "+": "");
        $('#item_option_etc_popup_1').text(etc !== "0" ? "+" + etc + "+" : "");
        $('#item_option_starforce_popup_1').text(starforce !== "0" ? + starforce : "");
        $('#item_option_line').text(total !== "0" ? ")" : "");
    }
}

function displayIntPopup(item) {
    let total = String(item.data('total_int'));
    let add = String(item.data('add_int'));
    let base = String(item.data('base_int'));
    let starforce = String(item.data('starforce_int'));
    let etc = String(item.data('etc_int'));

    if (total !== "undefined" && total !== "0") {
        $('#item_option_total_popup_2').text(total ? "INT : + " + total + "(": "");
        $('#item_option_add_popup_2').text(base ? base + "+" : "");
        $('#item_option_bace_popup_2').text(add !== "0" ? add + "+": "");
        $('#item_option_etc_popup_2').text(etc !== "0" ? "+" + etc + "+" : "");
        $('#item_option_starforce_popup_2').text(starforce !== "0" ? + starforce : "");
        $('#item_option_line').text(total !== "0" ? ")" : "");
    }
}