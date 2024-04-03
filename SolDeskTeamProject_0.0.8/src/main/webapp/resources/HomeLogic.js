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
    // 헤더메뉴 link로직
    $('.home-header-menu').click(function(){
        let headerId = $(this).attr('id');
        //중기기상정보
        if(headerId=="homeHeaderMenu0"){
            window.location.href = 'MediumWeather?area=서울';
        //단기기상정보
        }else if(headerId=="homeHeaderMenu1"){
            window.location.href = 'ShortWeather?area=서울';
        //전국미세먼지
        }else if(headerId=="homeHeaderMenu2"){
            window.location.href = 'https://www.naver.com/';
        //생활기상지수
        }else if(headerId=="homeHeaderMenu3"){
            window.location.href = 'https://www.google.com/';
        //과거날씨정보(ASOS)
        }else if(headerId=="homeHeaderMenu4"){
            window.location.href = 'PastWeather?area=서울&date=20240402';
        }
    });
});

$(document).ready(function () {
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

$(document).ready(function () {
    $('.home-header-menu').hover(function () {
        let popupId = $(this).attr('id');
        $('.item_popup_main').show();
        $('.starforce_line_popup').show();
    }, function () {
        $('.item_popup_main').hide();
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
}