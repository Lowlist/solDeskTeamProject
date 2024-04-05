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


$(document).ready(function() {
    var PM10 = [];
    var PM25 = [];
    var currentImageIndex = 0;
    var currentArray = PM10;

    $('.item').each(function() {
        var imageUrl1 = $(this).data('image-url1');
        var imageUrl2 = $(this).data('image-url2');
        var imageUrl3 = $(this).data('image-url3');
        var imageUrl4 = $(this).data('image-url4');
        var imageUrl5 = $(this).data('image-url5');
        var imageUrl6 = $(this).data('image-url6');
        var informData = $(this).data('inform-data'); // 속성 이름 수정
        var dataTime = $(this).data('data-time'); // 속성 이름 수정
        var informGrade = $(this).data('inform-grade'); // 속성 이름 수정

        if (imageUrl1.includes("PM10") || imageUrl2.includes("PM10") || imageUrl3.includes("PM10")) {
            PM10.push(imageUrl1, imageUrl2, imageUrl3);
        }

        if (imageUrl4.includes("PM2P5") || imageUrl5.includes("PM2P5") || imageUrl6.includes("PM2P5")) {
            PM25.push(imageUrl4, imageUrl5, imageUrl6);
        }

        
    });

    // 이미지를 표시하는 함수
    function showImage() {
        var imageUrlToShow = currentArray[currentImageIndex];
        // imageUrlToShow를 사용하여 이미지를 표시하거나 다른 동작을 수행
        console.log(imageUrlToShow);
    
        // 이미지를 표시할 div 선택
        var imageContainer = $('.dust-center-content-main-area');
    
        // 이미지를 추가 또는 교체
        imageContainer.empty(); // 기존의 내용을 비워줍니다.
        imageContainer.append('<img src="' + imageUrlToShow + '" alt="Image">');
        
        // currentImageIndex를 증가시키고 배열의 길이로 나눈 나머지를 새로운 인덱스로 설정하여 순환하도록 구현
        currentImageIndex = (currentImageIndex + 1) % currentArray.length;
    }

    // dust-center-left-content-button 클릭 시
    $('.dust-center-left-content-button').click(function() {
        showImage(); // 다음 이미지 표시
    });

    // 미세먼지 클릭 시
    $('#dustCenterLeftHeaderIcon0').click(function() {
        currentArray = PM10; // 현재 배열을 PM10으로 설정
        currentImageIndex = 0; // 이미지 인덱스 초기화
        showImage(); // 첫 번째 이미지 표시
    });

    // 초미세먼지 클릭 시
    $('#dustCenterLeftHeaderIcon1').click(function() {
        currentArray = PM25; // 현재 배열을 PM25로 설정
        currentImageIndex = 0; // 이미지 인덱스 초기화
        showImage(); // 첫 번째 이미지 표시
    });

    // 초기에는 미세먼지 탭이 활성화되어 있으므로 PM10의 첫 번째 이미지를 표시
    $('#dustCenterLeftHeaderIcon0').trigger('click');
});


function getPageWord(){
    $('#dustTopMenuWord0').text("기상정보공유사이트 소개");
    $('#dustTopMenuWord1').text("로그인");
    $('#dustTopMenuWord2').text("사이트맵");
    $('#dustCenterLeftHeaderIcon0').text("미세먼지");
    $('#dustCenterLeftHeaderIcon1').text("초미세먼지");
    $('#dustCenterLeftHeaderIcon2').text("동네별");
    $('#dustCenterLeftHeaderIcon3').text("전국");
    $('#dustCenterLeftHeaderIcon4').text("기타");
   
};