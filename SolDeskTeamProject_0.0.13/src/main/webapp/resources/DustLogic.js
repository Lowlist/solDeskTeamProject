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
    var informDataTime = [];

    $('.item').each(function() {
        var imageUrl1 = $(this).data('image-url1');
        var imageUrl2 = $(this).data('image-url2');
        var imageUrl3 = $(this).data('image-url3');
        var imageUrl4 = $(this).data('image-url4');
        var imageUrl5 = $(this).data('image-url5');
        var imageUrl6 = $(this).data('image-url6');
        var informData = $(this).data('inform-data');
        var dataTime = $(this).data('data-time');
        var informGrade = $(this).data('inform-grade');

        // imageUrl1, imageUrl2, imageUrl3, imageUrl4, imageUrl5, imageUrl6 가 null이 아닌 경우에만 처리
        if (imageUrl1 && imageUrl2 && imageUrl3 && imageUrl4 && imageUrl5 && imageUrl6) {
            // PM10 배열과 PM25 배열에 값 추가
            if (imageUrl1 && imageUrl2 && imageUrl3) {
                PM10.push(imageUrl1, imageUrl2, imageUrl3);
                for (var i = 0; i < 3; i++) {
                    informDataTime.push({ informData: informData, dataTime: dataTime, informGrade: informGrade });
                }
            }
    
            if (imageUrl4 && imageUrl5 && imageUrl6) {
                PM25.push(imageUrl4, imageUrl5, imageUrl6);
            }
    
        }
    });
    // 이미지를 표시하는 함수
    function showImage() {
        var imageUrlToShow = currentArray[currentImageIndex];
        // imageUrlToShow를 사용하여 이미지를 표시하거나 다른 동작을 수행
        console.log(imageUrlToShow);
    
        // 이미지를 표시할 div 선택
        var imageContainer = $('.dust-center-content-main-area');
        $('.dust-center-left-content-button').show();
        // 이미지를 추가 또는 교체
        imageContainer.empty();
        imageContainer.append('<img src="' + imageUrlToShow + '" alt="Image" class="dust-area-view">');
        
        // currentImageIndex를 증가시키고 배열의 길이로 나눈 나머지를 새로운 인덱스로 설정하여 순환하도록 구현
        currentImageIndex = (currentImageIndex + 1) % currentArray.length;
    }
    
    // 전국 미세먼지 출력
    function showNational () {
        var nationalWeatherImage = "../resources/img/map.jpg";
    	var imageContainer = $('.dust-center-content-main-area');
        $('.dust-center-left-content-button').hide();
        var national_image = $('.dust-area-view').attr('src', nationalWeatherImage);
        national_image.css({
            width:'76%'
        }); // css적용
         // 이미지를 이미지 컨테이너에 추가합니다.
         imageContainer.empty();
        $(imageContainer).append(national_image);
        informDatas();
        
    }

    // 정보 제공 시간
    function informDatas () {
        var informDataShow = informDataTime[currentImageIndex];
        var showContainer = $('.dust-center-right-inform');
    
    // 기존의 내용을 비워줍니다.
        showContainer.empty();
    
    // informDataShow를 사용하여 텍스트를 생성합니다.
    var textToShow = informDataShow.dataTime +'한 '+ '<br>'+
                     informDataShow.informData + 
                     '일의 데이터 '
    
    // 생성된 텍스트를 추가합니다.
    showContainer.html(textToShow);
        
    }
    
    // dust-center-left-content-button 클릭 시
    $('.dust-center-left-content-button').click(function() {
        currentImageIndex = (currentImageIndex + 1) % informDataTime.length;
        informDatas();
        showImage(); // 다음 이미지 표시
    });
    
    

    // 미세먼지 클릭 시
    $('#dustCenterLeftHeaderIcon0').click(function() {
        currentArray = PM10; // 현재 배열을 PM10으로 설정
        currentImageIndex = 0; // 이미지 인덱스 초기화
        informDatas();
        showImage(); // 첫 번째 이미지 표시
    });

    // 초미세먼지 클릭 시
    $('#dustCenterLeftHeaderIcon1').click(function() {
        currentArray = PM25; // 현재 배열을 PM25로 설정
        currentImageIndex = 0; // 이미지 인덱스 초기화
        informDatas();
        showImage(); // 첫 번째 이미지 표시
    });

    // 전국 클릭 시
    $('#dustCenterLeftHeaderIcon2').click(showNational);
    
    $('#dustCenterLeftHeaderIcon0').trigger('click');

});


function getPageWord(){
    $('#dustTopMenuWord0').text("기상정보공유사이트 소개");
    $('#dustTopMenuWord1').text("로그인");
    $('#dustTopMenuWord2').text("사이트맵");
    $('#dustCenterLeftHeaderIcon0').text("미세먼지");
    $('#dustCenterLeftHeaderIcon1').text("초미세먼지");
    $('#dustCenterLeftHeaderIcon2').text("전국");
   
};