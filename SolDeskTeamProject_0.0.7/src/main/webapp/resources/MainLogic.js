$(document).ready(function(){
    getPageWord();
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
});

function getPageWord(){
    $('#homeTopMenuWord0').text("기상정보공유사이트 소개");
    $('#homeTopMenuWord1').text("로그인");
    $('#homeTopMenuWord2').text("사이트맵");
}