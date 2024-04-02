$(document).ready(function(){
    getPageWord();
    $('.dust-top-menu-word').click(function(){
        let wordId = $(this).attr('id');
        if(wordId=="dustTopMenuWord0"){
            window.location.href = 'https://www.naver.com/';
        }else if(wordId=="dustTopMenuWord1"){
            window.location.href = 'https://www.google.com/';
        }else if(wordId=="dustTopMenuWord2"){
            window.location.href = 'https://www.accuweather.com/';
        }
    });
});

function getPageWord(){
    $('#dustTopMenuWord0').text("기상정보공유사이트 소개");
    $('#dustTopMenuWord1').text("로그인");
    $('#dustTopMenuWord2').text("사이트맵");
}

