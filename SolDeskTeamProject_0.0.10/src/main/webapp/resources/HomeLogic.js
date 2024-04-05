//맵 관련 로직
$(document).ready(function(){
    //맵 넣을div 지정
    let mapId = $('.home-center-right-map').attr('id');
    let seoul = new naver.maps.LatLng(37.5650477, 126.9780263);
    let map = new naver.maps.Map(mapId, {
            center: seoul,
            position: seoul,
            zoom: 6
        });
    
    //중앙좌표 로직
    naver.maps.Event.addListener(map, 'click', function(e) {        
        // 클릭한곳 좌표 전송
        let latlng = e.latlng;
        // 위,경도 격자 변환 함수
        let returnXY = dfs_xy_conv("toXY",latlng._lat,latlng._lng);
        let gridX = returnXY.x;
        let gridY = returnXY.y;
        $.ajax({
            url: 'Weather/Home',  // 엔드포인트 URL
            type: 'POST',
            data: {
                gridx: gridX,
                gridy: gridY
            },
            success: function(datas) {
                let jsonData = JSON.parse(datas);
                let dataTMN;
                let dataTMX;
                let message; 
                let contentString;
                for(i=0;i<jsonData.response.body.items.item.length;i++){
                    if(jsonData.response.body.items.item[i].category == "TMN"){
                        if(jsonData.response.body.items.item[i].fcstDate == "20240405"){
                            dataTMN = jsonData.response.body.items.item[i].fcstValue;
                        }
                    }
                    if(jsonData.response.body.items.item[i].category == "TMX"){
                        if(jsonData.response.body.items.item[i].fcstDate == "20240405"){
                            dataTMX = jsonData.response.body.items.item[i].fcstValue;
                        }
                    }
                }
                if(dataTMN !== "-999.0"|| dataTMX !== "-999.0"){
                    message = "최저기온:"+ dataTMN + "최고기온:"+dataTMX;
                    contentString = [
                        '<div class="">',
                            "최저기온:"+dataTMN,
                            '<br>', 
                            "최고기온:"+dataTMX,
                            '</div>'
                        ].join('');
                }else{
                    message = "정확하지 않은 위치 정보입니다!";
                    contentString = [
                        '<div class="">',
                        "정확하지 않은 위치 정보입니다!",
                            '</div>'
                        ].join('');
                }
                let resultDiv = document.getElementById('result'); 
                resultDiv.innerHTML = message;

                //정보창 팝업
                let infowindow = new naver.maps.InfoWindow({
                    content: contentString
                });
                //정보창 실행
                infowindow.open(map, latlng);
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    });

    window.navermap_authFailure = function () {
        console.log("인증실패했음");
    }
});

$(document).ready(function(){
    // div에 글자 추가
    getPageWord();
    // 탑메뉴 link로직
    $('.home-top-menu-word').click(function(){
        let wordId = $(this).attr('id');
        if(wordId=="homeTopMenuWord0"){
            window.location.href = 'https://www.naver.com/';
        }else if(wordId=="homeTopMenuWord1"){
            window.location.href = 'https://www.google.com/';
        }else if(wordId=="homeTopMenuWord2"){
            window.location.href = 'https://www.accuweather.com/';
        }
    });

    $('.home-top-icon-line').click(function(){
        let iconId = $(this).attr('id');
        if(iconId=="homeTopIconLine"){
            window.location.href = '';
        }
    });

    $('.home-high-icon').click(function(){
        let logoImg = $(this).attr('id');
        if(logoImg=="homeHighIcon"){
            window.location.href = '';
        }
    });

    // 헤더메뉴 link로직
    $('.home-header-menu').click(function(){
        let headerId = $(this).attr('id');
        //중기기상정보
        if(headerId=="homeHeaderMenu0"){
            window.location.href = 'Weather/MediumWeather?area=서울';
        //단기기상정보
        }else if(headerId=="homeHeaderMenu1"){
            window.location.href = 'Weather/ShortWeather';
        //전국미세먼지
        }else if(headerId=="homeHeaderMenu2"){
            window.location.href = 'Weather/DustWeather';
        //생활기상지수
        }else if(headerId=="homeHeaderMenu3"){
            window.location.href = 'https://www.google.com/';
        //과거날씨정보(ASOS)
        }else if(headerId=="homeHeaderMenu4"){
            window.location.href = 'Weather/PastWeather?area=서울';
        }
    });

    $("#mapBtn0").css('background-color', 'blue');
    $("#mapBtn0").css('color', 'white');
    //맵 버튼 로직
    $('.map-btn').click(function (){
        // 모든 버튼에 대한 스타일 초기화
        $('.map-btn').css({
            'background-color': 'white',
            'color': 'black'
        });
        // 클릭한 버튼의 스타일 변경
        $(this).css({
            'background-color': 'blue',
            'color': 'white'
        });
        // 버튼 액션
    });

    //메뉴호버 로직
    $('.main-home-popup-line').hide();
    $('.home-header-menu').hover(function () {
        let popupId = $(this).attr('id');
        $('.main-home-popup-line').show();
        $('.starforce_line_popup').show();
    }, function () {
        $('.main-home-popup-line').hide();
        $('.starforce_line_popup').hide();
        // 마우스 hover 종료시 자동으로 div 내용 초기화
        clearDiv();
    });
});

function clearDiv(){

}

function getPageWord(){
    $('#homeTopMenuWord0').text("기상정보공유사이트 소개");
    $('#homeTopMenuWord1').text("로그인");
    $('#homeTopMenuWord2').text("사이트맵");
    $('#homeHeaderMenu0').text("중기기상정보");
    $('#homeHeaderMenu1').text("단기기상정보");
    $('#homeHeaderMenu2').text("전국미세먼지");
    $('#homeHeaderMenu3').text("생활기상지수");
    $('#homeHeaderMenu4').text("과거날씨정보");
    $('#mapBtn0').text("현재");
    $('#mapBtn1').text("오전");
    $('#mapBtn2').text("오후");
}

// 위,경도에 따라서 격자x 격자y 좌표 반환문

// let rs = dfs_xy_conv("toLL","60","127");
// console.log(rs.lat, rs.lng);
let RE = 6371.00877; // 지구 반경(km)
let GRID = 5.0; // 격자 간격(km)
let SLAT1 = 30.0; // 투영 위도1(degree)
let SLAT2 = 60.0; // 투영 위도2(degree)
let OLON = 126.0; // 기준점 경도(degree)
let OLAT = 38.0; // 기준점 위도(degree)
let XO = 43; // 기준점 X좌표(GRID)
let YO = 136; // 기1준점 Y좌표(GRID)
//
// LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
//

function dfs_xy_conv(code, v1, v2) {
    let DEGRAD = Math.PI / 180.0;
    let RADDEG = 180.0 / Math.PI;

    let re = RE / GRID;
    let slat1 = SLAT1 * DEGRAD;
    let slat2 = SLAT2 * DEGRAD;
    let olon = OLON * DEGRAD;
    let olat = OLAT * DEGRAD;

    let sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    let sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    let ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);
    let rs = {};
    if (code == "toXY") {
        rs['lat'] = v1;
        rs['lng'] = v2;
        let ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);
        let theta = v2 * DEGRAD - olon;
        if (theta > Math.PI) theta -= 2.0 * Math.PI;
        if (theta < -Math.PI) theta += 2.0 * Math.PI;
        theta *= sn;
        rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
        rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
    }
    else {
        rs['x'] = v1;
        rs['y'] = v2;
        let xn = v1 - XO;
        let yn = ro - v2 + YO;
        ra = Math.sqrt(xn * xn + yn * yn);
        if (sn < 0.0) - ra;
        let alat = Math.pow((re * sf / ra), (1.0 / sn));
        alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        if (Math.abs(xn) <= 0.0) {
            theta = 0.0;
        }
        else {
            if (Math.abs(yn) <= 0.0) {
                theta = Math.PI * 0.5;
                if (xn < 0.0) - theta;
            }
            else theta = Math.atan2(xn, yn);
        }
        let alon = theta / sn + olon;
        rs['lat'] = alat * RADDEG;
        rs['lng'] = alon * RADDEG;
    }
    return rs;
}
