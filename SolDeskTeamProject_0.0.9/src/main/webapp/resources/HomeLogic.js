//맵 관련 로직
$(document).ready(function(){
    let mapId = $('.home-center-right-map').attr('id');
    // var mapOptions = {
    //     center: new naver.maps.LatLng(37.3595704, 127.105399),
    //     zoom: 10
    // }
    // var marker = new naver.maps.Marker(mapId,{
    //     position: new naver.maps.LatLng(37.3595704, 127.105399),
    //     map: map
    // });
    // 맵 불러오는 기본로직
    // var map = new naver.maps.Map(mapId,{
    //     center: new naver.maps.LatLng(37.3595704, 127.105399),
    //     zoom: 6
    // });
    var cityhall = new naver.maps.LatLng(37.5666805, 127.105399);

    var map = new naver.maps.Map(mapId, {
            center: cityhall,
            zoom: 6
        });
    var marker = new naver.maps.Marker({
            map: map,
            position: cityhall
        });
    let asf = $('#homeCenterBigBox0').data('ssd');;
    var contentString = [
            '<div class="">',
            asf,
            '</div>'
        ].join('');

    var infowindow = new naver.maps.InfoWindow({
        content: contentString
    });
    infowindow.open(map, marker);

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
            window.location.href = 'Weather/ShortWeather?area=서울';
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

// $(document).ready(function () {
//     $('.main-home-popup-line').hide();
//     $('.home-header-menu').hover(function () {
//         let popupId = $(this).attr('id');
//         $('.main-home-popup-line').show();
//         $('.starforce_line_popup').show();
//     }, function () {
//         $('.main-home-popup-line').hide();
//         $('.starforce_line_popup').hide();
//         // 마우스 hover 종료시 자동으로 div 내용 초기화
//         clearDiv();
//     });
// });

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