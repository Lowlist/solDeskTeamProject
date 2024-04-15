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
    
    $('#dustHighIcon').click(function(){
        let logoImg = $(this).attr('id');
        if(logoImg=="dustHighIcon"){
            window.location.href = '/spring';
        }
    });
    $('.dust-top-icon').click(function(){
        let iconWord = $(this).attr('id');
        if(iconWord=="dustTopIconWord"){
            window.location.href = '/spring';
        } else if (iconWord=="dustTopIconImg"){
        	window.location.href = '/spring';
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
        var informCode = $(this).data('inform-code');

        // imageUrl1, imageUrl2, imageUrl3, imageUrl4, imageUrl5, imageUrl6 가 null이 아닌 경우에만 처리 //O3 예외 처리
        if (imageUrl1 && imageUrl2 && imageUrl3 && imageUrl4 && imageUrl5 && imageUrl6 && informCode !== "O3") {
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

    // 집가서 할것
    function nationInfo() {
        let informDataShow = informDataTime[0];
        let nationData = informDataShow.informGrade.split(',');
    
        // for 루프를 사용하여 각 miniDust 요소의 위치를 설정합니다.
        for (let i = 0; i < nationData.length; i++) {
            // 각 miniDust 요소에 대한 ID를 동적으로 생성합니다.
            let miniDustId = 'miniDust' + i;
            // 각 miniDust 요소의 위치를 설정합니다.
            $('#' + miniDustId).css({
                'top': ((i + 1) * 20) + 'px', // top 위치 계산
                'left': '70px' // left 위치 고정값 설정
            });
        }
    }
        

    // 이미지를 표시하는 함수
    function showImage() {
        var imageUrlToShow = currentArray[currentImageIndex];
        // imageUrlToShow를 사용하여 이미지를 표시하거나 다른 동작을 수행
        console.log(imageUrlToShow);
    
        // 이미지를 표시할 div 선택
        var imageContainer = $('.dust-center-content-main-area');
        $('.span-left').show();
        $('.span-right').show();
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
        $('.span-left').hide();
        $('.span-right').hide();
        var national_image = $('.dust-area-view').attr('src', nationalWeatherImage);
        national_image.css({
            'filter': 'saturate(1.9) brightness(1)',
       	'background-size': 'contain', 
       	'background-position': 'center',
        'background-repeat': 'no-repeat',
            width:'626px'
        }); // css적용
         // 이미지를 이미지 컨테이너에 추가합니다.
        imageContainer.empty();
        $(imageContainer).append(national_image);
        informDatas();
        for(i = 0;i<=18;i++){
            $(national_image).append("<div class=mini-dust-info id=miniDust"+i+"></div>");
        }
        $('.mini-dust-info').css({
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
            'width' : '20px',
            'height': '17px',
            'border': '1px solid black',
            'border-radius': '7px'
        });
         $('.mini-dust-info').text('ㅋㅋㅋ');
        nationInfo();
    // //서울
    // $('#miniDust0').css({
    //     'top': '57px',
    //     'left': '70px'
    // });
    // //수원
    // $('#miniDust1').css({
    //     'top': '89px',
    //     'left': '80px'
    // });
    // //춘천
    // $('#miniDust2').css({
    //     'top': '50px',
    //     'left': '130px'
    // });
    // //영동
    // $('#miniDust3').css({
    //     'top': '63px',
    //     'left': '190px'
    // });
    // //대전
    // $('#miniDust4').css({
    //     'top': '150px',
    //     'left': '85px'
    // });
    // //충주
    // $('#miniDust5').css({
    //     'top': '120px',
    //     'left': '95px'
    // });
    // //전주
    // $('#miniDust6').css({
    //     'top': '188px',
    //     'left': '67px'
    // });
    // //광주
    // $('#miniDust7').css({
    //     'top': '235px',
    //     'left': '60px'
    // });
    // //대구
    // $('#miniDust8').css({
    //     'top': '178px',
    //     'left': '163px'
    // });
    // //부산
    // $('#miniDust9').css({
    //     'top': '233px',
    //     'left': '183px'
    // });
    // //태백
    // $('#miniDust10').css({
    //     'top': '123px',
    //     'left': '183px'
    // });
    // //진주
    // $('#miniDust11').css({
    //     'top': '213px',
    //     'left': '123px'
    // });
    // //제주
    // $('#miniDust12').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust13').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust14').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust15').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust16').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust17').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
    
    // $('#miniDust18').css({
    //     'top': '343px',
    //     'left': '33px'
    // });
}

    // 정보 제공 시간
    function informDatas () {
        let informDataShow = informDataTime[currentImageIndex];
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
    
    // next 클릭 시
    $('.span-right').click(function() {
        informDatas();
        showImage(); // 다음 이미지 표시
    });
   
   //prev 클릭시
    $('.span-left').click(function() {
        currentImageIndex = (currentImageIndex - 2 + informDataTime.length) % informDataTime.length;
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