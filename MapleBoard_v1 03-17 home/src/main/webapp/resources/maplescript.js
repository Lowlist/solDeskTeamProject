$(document).ready(function() {
    $('.item').hover(function() {
        let starForceData = $(this).data('starforce');
        let equip_level = $(this).data('equip_level');
        starForceRun(starForceData, equip_level);
        let dataName = String($(this).data('name'));
        let dataPotential = String($(this).data('potential'));
        let itemIcon = $(this).find('img').attr('src');
        $('#item_name').text(dataName);
        //? 을 사용해서 있으면 true 없으면 false 반환
        $('#item_potential').text(dataPotential ? "(" + dataPotential + " 아이템)" : "");
        $('#img_icon').attr('src', itemIcon).attr('class', dataPotential);
        $('.item_popup_main').show();
        $('.star_force_line').show();
    }, function() {
        $('.item_popup_main').hide();
        $('.star_force_line').hide();
    });
});

function starForceRun(starforce, equipLevel) {
    let maxStarForce;
    let starimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-yellow.png";
    let starblackimg = "https://cdn.dak.gg/maple/images/tooltip/item/ico-starforce-default.png";
    let container = $("#starforce");
    container.empty();
    let equipLevelCheck = parseInt(equipLevel);
    
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
