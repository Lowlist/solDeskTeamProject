let latlng;
let jsonData;
let message;
let contentString;
let returnXY;
let clickBoolean = false;
let map;
let areaCoord;

// 주소데이터 초기값
let addressData= {
    area1: "",
    area2: "",
    area3: "",
    area4: ""
};

// 최저,최고기온 초기값
let WeatherData={
    dataTMN: "",
    dataTMX: ""
};

// 변수 초기화
function clearVar(){
    latlng;
    jsonData;
    message;
    contentString;
    returnXY;
    clickBoolean = false;
    map;
}

//맵 생성 로직
function createMap(){
    let mapId = $('.home-center-right-map').attr('id');
    areaCoord={
        //서울
        seoul: new naver.maps.LatLng(37.5650477,126.9790563),
        //수원(경기)
        suwon: new naver.maps.LatLng(37.2623618,127.0291814),
        //춘천(강(원도)서)
        chuncheon: new naver.maps.LatLng(37.8842593,127.7300748),
        //강릉(강동)
        gangleung: new naver.maps.LatLng(37.7517044,128.8760003),
        //대전(충남)
        daejeon: new naver.maps.LatLng(36.3501703,127.3851213),
        //청주(충북)
        cheongju: new naver.maps.LatLng(36.6358372,127.4915513),
        //전주(전북)
        jeonju: new naver.maps.LatLng(35.8197508,127.1085748),
        //광주(전남)
        gwangju: new naver.maps.LatLng(35.1596238,126.8515119),
        //대구(경북)
        daegu: new naver.maps.LatLng(35.8706793,128.6020288),
        //부산(경남)
        busan: new naver.maps.LatLng(35.1796902,129.0751275),
        //제주도
        jeju: new naver.maps.LatLng(33.4986998,126.5317497)
    };
    // 맵 생성
    map = new naver.maps.Map(mapId, {
        center: areaCoord.seoul,
        position: areaCoord.seoul,
        zoom: 6
    });
    window.navermap_authFailure = function () {
        console.log("인증실패했음");
    }
}

// 좌표->주소 역변환 로직
function searchCoordinateToAddress(latlng) {
    naver.maps.Service.reverseGeocode({
        coords: latlng,
    }, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }
        return response.v2.address.jibunAddress;
    });
}

// 좌표 반환 함수
function returnLatLng(latlng) {
    return returnXY = dfs_xy_conv("toXY", latlng._lat, latlng._lng);
}

//좌표 주소변환 펑션
function changeAddress(latlng) {
    naver.maps.Service.reverseGeocode({
        coords: latlng,
    }, function (status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }
        //변환된 주소데이터 저장
        if (response.v2.address.jibunAddress !== "") {
            return addressData = {
                area1: response.v2.results[0].region.area1.name,
                area2: response.v2.results[0].region.area2.name,
                area3: response.v2.results[0].region.area3.name,
                area4: response.v2.results[0].region.area4.name
            }
        }
    });
}

// 에이젝스 호출을 담당하는 함수 정의
function ajaxRequest(latlng) {
    returnXY = returnLatLng(latlng);
    // AJAX 호출
    $.ajax({
        url: 'Weather/Home',
        type: 'POST',
        data: {
            gridx: returnXY.x,
            gridy: returnXY.y
        },
        success: function (datas) {
            //성공시 ajax 에서 json데이터 호출
            jsonData = JSON.parse(datas);
            jsonDataLogic(jsonData, latlng);
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}

// 정보창 표시 함수 정의
function infoRun(latlng, message, contentString) {
    $('#homeCenterBigBox0').text(message);

    let infowindow = new naver.maps.InfoWindow({
        content: contentString
    });

    infowindow.open(map, latlng);
}

// jsondata 처리로직(공용으로 둘 생각)
function jsonDataLogic(jsonData, latlng) {
    for (let i = 0; i < jsonData.response.body.items.item.length; i++) {
        if (jsonData.response.body.items.item[i].category == "TMN") {
            if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
                WeatherData.dataTMN = jsonData.response.body.items.item[i].fcstValue;
            }
        }
        if (jsonData.response.body.items.item[i].category == "TMX") {
            if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
                WeatherData.dataTMX = jsonData.response.body.items.item[i].fcstValue;
            }
        }
    }
    // 형바주보
    // for (let i = 0; i < jsonData.response.body.items.item.length; i++) {
    //     if (jsonData.response.body.items.item[i].category == "SKY") {
    //         if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
    //             if(jsonData.response.body.items.item[i].fcstTime == "0600"){
    //                 a = parseInt(jsonData.response.body.items.item[i].fcstValue);
    //             }
    //             if(jsonData.response.body.items.item[i].fcstTime == "0700"){
    //                 b = parseInt(jsonData.response.body.items.item[i].fcstValue);
    //             }
    //             if(jsonData.response.body.items.item[i].fcstTime == "0800"){
    //                 c = parseInt(jsonData.response.body.items.item[i].fcstValue);
    //             }
    //             if(jsonData.response.body.items.item[i].fcstTime == "0900"){
    //                 d = parseInt(jsonData.response.body.items.item[i].fcstValue);
    //             }
    //             if(jsonData.response.body.items.item[i].fcstTime == "1000"){
    //                 e = parseInt(jsonData.response.body.items.item[i].fcstValue);
    //             }
    //         }
    //     }
    // }
    // 형바주보

    var intTMN = parseInt(WeatherData.dataTMN);
    var intTMX = parseInt(WeatherData.dataTMX);

    if (clickBoolean) {
        if (intTMN >= -200 && intTMX >= -200) {
            message = "최저기온:" + WeatherData.dataTMN + "최고기온:" + WeatherData.dataTMX;
            contentString = [
                '<div class="area-info" id="areaInfoAddress">',
                addressData.area1 + " " + addressData.area2,
                '</div>',
                '<div class="area-info" id="areaInfoTemp">',
                WeatherData.dataTMN + " °C / ",
                WeatherData.dataTMX + "°C",
                '</div>'
            ].join('');
        } else {
            message = "정확하지 않은 위치 정보입니다!";
            contentString = [
                '<div class="area-info">',
                "정확하지 않은 위치 정보입니다!",
                '</div>'
            ].join('');
        }
        infoRun(latlng, message, contentString);
    }
}

// 네이버 맵 클릭이벤트 시작기준 로직
function naverMapRun(){
    // 클릭 이벤트 리스너에서 호출할 함수 정의
    function handleClickEvent(e) {
        latlng = e.latlng;
        clickBoolean = true;
        changeAddress(latlng);
        ajaxRequest(latlng);
    }
    naver.maps.Event.addListener(map, 'click', handleClickEvent);
};

$(document).ready(function(){
    clearVar();
    getPageWord();
    $('.home-top-menu-word').click(function(){
        let wordId = $(this).attr('id');
        if(wordId=="homeTopMenuWord0"){
            window.location.href = 'https://www.naver.com/';
        }else if(wordId=="homeTopMenuWord1"){
            window.location.href = 'https://www.google.com/';
        }else if(wordId=="homeTopMenuWord2"){
            window.location.href = 'https://youtu.be/dQw4w9WgXcQ';
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
            window.location.href = 'Weather/MediumWeather';
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

    $("#switchBtn1").css('background-color', 'blue');
    $("#switchBtn1").css('color', 'white');
    //맵 버튼 로직
    $('.switch-btn').click(function (){
        let switchId = $(this).attr('id');
        // 모든 버튼에 대한 스타일 초기화
        $('.switch-btn').css({
            'background-color': 'white',
            'color': 'black'
        });
        // 클릭한 버튼의 스타일 변경
        $(this).css({
            'background-color': 'blue',
            'color': 'white'
        });
        
        // 버튼 액션 날씨지도 선택시 작동
        if(switchId=="switchBtn1"){
            $('.home-center-right-map').text('');
            $('#mapBtn0').text("현재");
            $('#mapBtn1').text("오전");
            $('#mapBtn2').text("오후");
            cssForMap();
        // 버튼 액션 상세지도 선택시 작동
        }else if(switchId=="switchBtn2"){
            $('.home-center-right-map').text('');
            $('#mapBtn0').text("현재");
            $('#mapBtn1').text("오전");
            $('#mapBtn2').text("오후");
            createMap();
            naverMapRun();
        }
    });

    //메뉴호버 로직
    $('.main-home-popup-line').hide();
    $('.home-header-menu, .main-home-popup-line').hover(function () {
        let popupId = $(this).attr('id');
        console.log(popupId);
        $('.main-home-popup-line').show();
    }, function () {
        $('.main-home-popup-line').hide();
        clearDiv();
    });

});

function clearDiv(){
    //div 초기화할꺼 여기다가 넣으면 됨

}

function getPageWord(){
    $('.home-center-right-map').css('background-image', 'url("resources/img/map.jpg")');
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
    $('#switchBtn1').text("날씨지도");
    $('#switchBtn2').text("상세지도");
    $('#homeCenterTopBox3').text("사이트 소개");
    $('#homeCenterTopBox5').text("중기기상정보");
    $('#homeCenterTopBox6').text("단기기상정보");
    $('#homeCenterTopBox7').text("전국미세먼지");
    $('#homeCenterTopBox8').text("생활기상지수");
    $('#homeCenterTopBox9').text("과거날씨정보");
    $('#homeCenterTopBox10').text("기상뉴스");
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

function nowDate() {
    const today = new Date();
    const year = today.getFullYear();
    let month = today.getMonth() + 1;
    let day = today.getDate();

    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }
    return `${year}${month}${day}`;
}

// 맵 백그라운드 css 지정 로직
function cssForMap(){
    $('.home-center-right-map').css({
        'background-image': 'url("resources/img/map.jpg")',
        'filter': 'saturate(1.9) brightness(1)',
        'background-size': 'contain', 
        'background-position': 'center',
        'background-repeat': 'no-repeat'
    });
}