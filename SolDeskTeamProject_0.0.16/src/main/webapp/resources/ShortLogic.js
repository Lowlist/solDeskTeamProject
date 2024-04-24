let latlng;
let jsonData;
let message;
let contentString;
let returnXY;
let map;
let areaCoord;
let clickBoolean = false;
let mapImgBoolean = false;
let mapBtnResult = 0;
let infowindow;
let addressData;
let countAddress = 0;
let countData = 0;
// 최저,최고기온 초기값
let WeatherData={
    dataTMN: "",
    dataTMX: "",
    dataTMP: ""
};
var areas = [
    { name: "서울", coordinates: new naver.maps.LatLng(37.5650477,126.9790563) },
    { name: "수원", coordinates: new naver.maps.LatLng(37.2623618,127.0291814) },
    { name: "춘천", coordinates: new naver.maps.LatLng(37.8842593,127.7300748) },
    { name: "강릉", coordinates: new naver.maps.LatLng(37.7517044,128.8760003) },
    { name: "대전", coordinates: new naver.maps.LatLng(36.3501703,127.3851213) },
    { name: "청주", coordinates: new naver.maps.LatLng(36.6358372,127.4915513) },
    { name: "전주", coordinates: new naver.maps.LatLng(35.8197508,127.1085748) },
    { name: "광주", coordinates: new naver.maps.LatLng(35.1596238,126.8515119) },
    { name: "대구", coordinates: new naver.maps.LatLng(35.8706793,128.6020288) },
    { name: "부산", coordinates: new naver.maps.LatLng(35.1796902,129.0751275) },
    { name: "태백", coordinates: new naver.maps.LatLng(37.1632469,128.9861211) },
    { name: "진주", coordinates: new naver.maps.LatLng(35.2127259,128.1219777) },
    { name: "제주", coordinates: new naver.maps.LatLng(33.4986998,126.5317497) }
];
areaCoord ={
    //상주(센터용)
    sangju: new naver.maps.LatLng(36.4089077,127.9678258),
};

$(document).ready(function(){

    $('.short-top-icon').css({
        'cursor' : 'pointer'
    });
    $('.short-header-line').css({
        'cursor' : 'pointer'
    });

    clearVar();
    areaCoordRun();
    getPageWord();
    infowindow = new naver.maps.InfoWindow({
        content: contentString
    });


    // 헤더메뉴 link로직 & 여기 바꿔야함 
    $('.short-header-menu').click(function(){
        let headerId = $(this).attr('id');
		//홈
        if(headerId=="homeHeaderMenu0"){
        	window.location.href = '/spring/';
        //중기기상정보
        }else if(headerId=="homeHeaderMenu1"){
            window.location.href = '/spring/Weather/MediumWeather';
        //단기기상정보
        }else if(headerId=="homeHeaderMenu2"){
            window.location.href = '/spring/Weather/ShortWeather';
        //전국미세먼지
        }else if(headerId=="homeHeaderMenu3"){
            window.location.href = '/spring/Weather/DustWeather';
        //생활기상지수
        //과거날씨정보(ASOS)
        }else if(headerId=="homeHeaderMenu4"){
            window.location.href = '/spring/Weather/LivingWeather';
        }
    });

    $('.short-top-icon').click(function(){
        let clickId = $(this).attr('id');
		//홈
        if(clickId=="shortTopIconImg"){
        	window.location.href = '/spring/';
        //중기기상정보
        }else if(clickId=="shortTopIconWord"){
            window.location.href = '/spring/';
        }
    });

    $('.short-header-line').click(function(){
        window.location.href = '/spring/';
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
        let mapBtnId = $(this).attr('id');

        if(mapBtnId =="mapBtn0"){
            mapBtnResult = 0;
        }else if(mapBtnId == "mapBtn1"){
            mapBtnResult = 1;
        }else if(mapBtnId == "mapBtn2"){
            mapBtnResult = 2;
        }
        if(infowindow.getPosition() != null){
            let info = changeInfo();
            infowindow.close();
            infoRun(latlng,info.message,info.contentString);
        }
        if($('.mini-weather-info').text().trim() !== ''){
            console.log(mapBtnResult);
            $('.mini-weather-info').text("");
            areaCoordRun();
        }
    });

    $("#switchBtn1").css('background-color', 'blue');
    $("#switchBtn1").css('color', 'white');
    //맵 버튼 로직
    $('.switch-btn').click(function (){
        let switchId = $(this).attr('id');
        clearVar();
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
            $('.short-center-right-map').text('');
            areaCoordRun();
            cssForMap();
        // 버튼 액션 상세지도 선택시 작동
        }else if(switchId=="switchBtn2"){
            $('.short-center-right-map').text('');
            createMap();
            naverMapRun();
        }

    });

    //메뉴호버 로직
    $('.main-home-popup-line').hide();
    $('.home-header-menu, .main-home-popup-line').hover(function () {
        let popupId = $(this).attr('id');
        $('.main-home-popup-line').show();
    }, function () {
        $('.main-home-popup-line').hide();
    });
    //우상당 글씨색깔 변경로직
    $('.home-top-menu-word').hover(function(){
        let wordId = $(this).attr('id');
        if(wordId=="homeTopMenuWord0"){
            $(this).css('color', 'blue');
        }else if(wordId=="homeTopMenuWord1"){
            $(this).css('color', 'blue');
        }else if(wordId=="homeTopMenuWord2"){
            $(this).css('color', 'blue');
        }
    }, function () {
        $(this).css('color', 'black');
    });

});

// 네이버 맵 클릭이벤트 시작기준 로직
function naverMapRun(){
    clearVar();
    // 클릭 이벤트 리스너에서 호출할 함수 정의
    function handleClickEvent(e) {
        latlng = e.latlng;
        clickBoolean = true;
        changeAddress(latlng);
        ajaxRequest(latlng);
    }
    naver.maps.Event.addListener(map, 'click', handleClickEvent);
};

// 메인 img 날씨 실행로직
function mapImgRun(latlng){
    clearVar();
    mapImgBoolean = true;
    ajaxRequest(latlng);
}

//맵 생성 로직
function createMap(){
    let mapId = $('.short-center-right-map').attr('id');
    // 맵 생성
    map = new naver.maps.Map(mapId, {
        center: areaCoord.sangju,
        position: areaCoord.sangju,
        zoom: 6
    });
    window.navermap_authFailure = function () {
        console.log("인증실패했음");
    }
}

// 좌표 반환 함수
function returnLatLng(latlng) {
    return returnXY = dfs_xy_conv("toXY", latlng._lat, latlng._lng);
}

// 에이젝스 호출을 담당하는 함수 정의
function ajaxRequest(latlng) {
    returnXY = returnLatLng(latlng);
    // AJAX 호출
    $.ajax({
        url: '/spring/Weather/Home',
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
function infoRun(latlng, message , contentString) {
    $('#homeCenterBigBox0').text(message);
    infowindow.setContent(contentString);
    infowindow.open(map, latlng);
}

// jsondata 처리로직(공용으로 둘 생각)
function jsonDataLogic(jsonData) {
    if(jsonData.response.header.resultCode != "10"){
        for (let i = 0; i < jsonData.response.body.items.item.length; i++) {
            //최저기온
            if (jsonData.response.body.items.item[i].category == "TMN") {
                if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
                    WeatherData.dataTMN = jsonData.response.body.items.item[i].fcstValue;
                }
            }
            //최고기온
            if (jsonData.response.body.items.item[i].category == "TMX") {
                if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
                    WeatherData.dataTMX = jsonData.response.body.items.item[i].fcstValue;
                }
            }
            //현재시간
            if (jsonData.response.body.items.item[i].category == "TMP") {
                if (jsonData.response.body.items.item[i].fcstDate == nowDate()) {
                    if(jsonData.response.body.items.item[i].fcstTime == nowTime()){
                        WeatherData.dataTMP = jsonData.response.body.items.item[i].fcstValue;
                    }
                }
            }
        }
        changeInfo();
    }
}

// function extractWeatherData(item) {
//     const category = item.category;
//     const fcstDate = item.fcstDate;
//     const fcstTime = item.fcstTime;
//     const fcstValue = item.fcstValue;

//     switch (category) {
//         case "TMN":
//             if (fcstDate === nowDate()) {
//                 WeatherData.dataTMN = fcstValue;
//             }
//             break;
//         case "TMX":
//             if (fcstDate === nowDate()) {
//                 WeatherData.dataTMX = fcstValue;
//             }
//             break;
//         case "TMP":
//             if (fcstDate === nowDate() && fcstTime === nowTime()) {
//                 WeatherData.dataTMP = fcstValue;
//             }
//             break;
//         default:
//             break;
//     }
// }

// function jsonDataLogic(jsonData) {
//     if (jsonData.response.header.resultCode === "10") {
//         return;
//     }
//     jsonData.response.body.items.item.forEach(extractWeatherData);

//     changeInfo();
// }

function changeInfo(){
    let intTMN = Math.round(parseFloat(WeatherData.dataTMN));
    let intTMX = Math.round(parseFloat(WeatherData.dataTMX))

    if (clickBoolean) {
        if (intTMN >= -200 && intTMX >= -200) {
            if(mapBtnResult == 0){
                message = "현재기온 : " + WeatherData.dataTMP ;
                contentString = [
                    '<div class="area-info" id="areaInfoAddress">',
                    addressData.area1 + " " + addressData.area2 + " " +addressData.area3,
                    '</div>',
                    '<div class="area-info" id="areaInfoTemp">',
                    '현재기온 : '+WeatherData.dataTMP + " °C ",
                    '</div>'
                ].join('');
            }else if(mapBtnResult == 1){
                message = "오전최저기온 : " + WeatherData.dataTMN ;
                contentString = [
                    '<div class="area-info" id="areaInfoAddress">',
                    addressData.area1 + " " + addressData.area2 + " " +intTMN,
                    '</div>',
                    '<div class="area-info" id="areaInfoTemp">',
                    '오전최저기온 : '+WeatherData.dataTMN + " °C ",
                    '</div>'
                ].join('');
            }else if(mapBtnResult == 2){
                message = "오후최고기온 : " + WeatherData.dataTMX ;
                contentString = [
                    '<div class="area-info" id="areaInfoAddress">',
                    addressData.area1 + " " + addressData.area2 + " " +intTMX,
                    '</div>',
                    '<div class="area-info" id="areaInfoTemp">',
                    '오후최고기온 : '+WeatherData.dataTMX + " °C ",
                    '</div>'
                ].join('');
            }
        } else {
            message = "정확하지 않은 위치 정보입니다!";
            contentString = [
                '<div class="area-info">',
                "정확하지 않은 위치 정보입니다!",
                '</div>'
            ].join('');
        }
        infoRun(latlng, message, contentString);
        return {
            message: message,
            contentString: contentString
        };
    } else if (mapImgBoolean){
        let areaValues = Object.values(areas);
        if (intTMN >= -200 && intTMX >= -200) {
            if (mapBtnResult == 0) {
                $('#miniWeather' + countData).text(areaValues[countData].name + WeatherData.dataTMP);
            } else if (mapBtnResult == 1) {
                $('#miniWeather' + countData).text(areaValues[countData].name + intTMN);
            } else if (mapBtnResult == 2) {
                $('#miniWeather' + countData).text(areaValues[countData].name + intTMX);
            }
            console.log(WeatherData.dataTMN);
            countData++;
            if(countData==areaValues.length){
                countData=0;
            }
        }
    }
}

// function clearDiv(){
//     let areaValues = Object.values(areas);
//     for(let i = 0 ;i<areaValues.length;i++){
//         $('#miniWeather' + i).text("");
//     }
// }


//좌표 주소변환 펑션
function changeAddress(latlng) {
    addressData= {
        area1: "",
        area2: "",
        area3: "",
        area4: "",
        area5: ""
    };
    naver.maps.Service.reverseGeocode({
        coords: latlng,
    }, function (status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }
        //변환된 주소데이터 저장
        if (response.v2.address.jibunAddress !== "") {
            addressData = {
                area1: response.v2.results[0].region.area1.name,
                area2: response.v2.results[0].region.area2.name,
                area3: response.v2.results[0].region.area3.name,
                area4: response.v2.results[0].region.area4.name
            }
        }
    });
}

function getPageWord(){
    cssForMap();
    $('.short-center-right-map').css('background-image', 'url("/spring/resources/img/map.jpg")');
    $('#homeTopMenuWord0').text("기상정보공유사이트 소개");
    $('#homeTopMenuWord1').text("로그인");
    $('#homeTopMenuWord2').text("사이트맵");
    $('#homeHeaderMenu0').text("홈");
    $('#homeHeaderMenu1').text("중기기상정보");
    $('#homeHeaderMenu2').text("단기기상정보");
    $('#homeHeaderMenu3').text("전국미세먼지");
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

function nowTime() {
    let now = new Date();
    let hours = now.getHours();
    let minutes = "00";

    // 시간과 분을 문자열로 변환하여 두 자리로 만듭니다.
    hours = String(hours).padStart(2, '0');

    // 현재 시간을 문자열로 합칩니다.
    let currentTime = hours + minutes;

    return currentTime;
}

// 맵 백그라운드 css 지정 로직
function cssForMap(){
    $('.short-center-right-map').css({
        'background-image': 'url("/spring/resources/img/map.jpg")',
        'filter': 'saturate(1.9) brightness(1)',
        'background-size': 'contain', 
        'background-position': 'center',
        'background-repeat': 'no-repeat'
    });
    for(i = 0;i<=12;i++){
        $('.short-center-right-map').append("<div class=mini-weather-info id=miniWeather"+i+"></div>");
    }
    $('.mini-weather-info').css({
        'font-family': '"SKY-BORI", sans-serif',
        'font-size': '15px',
        'background-color': 'rgba(128, 128, 128, 0.8)',
        'display':'flex',
        'position': 'absolute',
        'text-shadow': '-0.5px -0.5px 0 black, 0.5px -0.5px 0 black, -0.5px 0.5px 0 black, 0.5px 0.5px 0 black',
        'color':'white',
        //이거 나중에 없애서 글자 수만큼 하게 할꺼임
        'padding-left': '2px',
        'padding-right': '2px',
        'height': '17px',
        'border': '1px solid black',
        'border-radius': '7px'
    });
    //서울
    $('#miniWeather0').css({
        'top': '57px',
        'left': '170px'
    });
    //수원
    $('#miniWeather1').css({
        'top': '89px',
        'left': '180px'
    });
    //춘천
    $('#miniWeather2').css({
        'top': '50px',
        'left': '230px'
    });
    //강릉
    $('#miniWeather3').css({
        'top': '63px',
        'left': '290px'
    });
    //대전
    $('#miniWeather4').css({
        'top': '150px',
        'left': '185px'
    });
    //충주
    $('#miniWeather5').css({
        'top': '120px',
        'left': '195px'
    });
    //전주
    $('#miniWeather6').css({
        'top': '188px',
        'left': '167px'
    });
    //광주
    $('#miniWeather7').css({
        'top': '235px',
        'left': '160px'
    });
    //대구
    $('#miniWeather8').css({
        'top': '178px',
        'left': '263px'
    });
    //부산
    $('#miniWeather9').css({
        'top': '233px',
        'left': '283px'
    });
    //태백
    $('#miniWeather10').css({
        'top': '123px',
        'left': '283px'
    });
    //진주
    $('#miniWeather11').css({
        'top': '213px',
        'left': '223px'
    });
    //제주
    $('#miniWeather12').css({
        'top': '343px',
        'left': '133px'
    });
}

// 변수 초기화
function clearVar(){
    latlng;
    message;
    contentString;
    returnXY;
    map;
    clickBoolean = false;
    mapImgBoolean = false;
    infowindow;
    addressData;
    WeatherData;
}

function areaCoordRun(){
    let areaValues = Object.values(areas);
    for(let i = 0 ;i<areaValues.length;i++){
        mapImgRun(areaValues[i].coordinates);
    }
}

function clearAddress(){
    addressData= {
        area1: "",
        area2: "",
        area3: "",
        area4: "",
        area5: ""
    };
}