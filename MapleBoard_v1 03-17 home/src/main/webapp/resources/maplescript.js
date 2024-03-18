$(document).ready(function() {
    $('.item').hover(function() {
        let starForceData = $(this).data('starforce');
        let equip_level = $(this).data('equip_level');
        let dataName = String($(this).data('name'));
        let dataPotential = String($(this).data('potential'));
        let itemIcon = $(this).find('img').attr('src');
        starForceRun(starForceData, equip_level,dataName);
        $('#item_name_popup').text(dataName);
        //? 을 사용해서 있으면 true 없으면 false 반환
        $('#potential_popup').text(dataPotential ? "(" + dataPotential + " 아이템)" : "");
        $('#item_icon_popup').attr('src', itemIcon).attr('class', dataPotential);
        $('.item_popup_main').show();
        $('.starforce_line_popup').show();
    }, function() {
        $('.item_popup_main').hide();
        $('.starforce_line_popup').hide();
    });
});

function starForceRun(starforce, equipLevel,dataName) {
    let maxStarForce;
    let starimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-yellow.png";
    let starblackimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-default.png";
    let container = $("#starforce_popup");
    container.empty();
    let equipLevelCheck = parseInt(equipLevel);
    if(dataName.includes("타일런트") || dataName.includes("노바")||dataName.includes("헬리시움")){
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
