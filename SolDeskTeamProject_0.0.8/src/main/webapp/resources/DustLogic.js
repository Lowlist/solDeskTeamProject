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


// $(document).ready(function(){
//     var jsonStr = $('#dustCenterContentMain').attr('data-jsondata');
//     var jsonData = JSON.parse(jsonStr);
    
//     var imageUrls = jsonData.imageurls;

//     var totalCount = imageUrls.length;
//     var currentIndex = 0;

//     function showImage() {
//         var currentArray = imageUrls[currentIndex % imageUrls.length];

//         while (!currentArray || currentArray.every(url => url === null)) {
//             currentIndex++;
//             currentArray = imageUrls[currentIndex % imageUrls.length];
//         }

//         var imageUrl = Object.values(currentArray).find(url => url !== null);
//         $('.dustCenterContentMain').empty().append($('<img>').attr('src', imageUrl));
//         console.log('Selected image URL:', imageUrl);
//     }

//     $('#dustCenterLeftContentButton').click(function(){
//         currentIndex++;
//         showImage();
//     });

//     showImage();
// });
// 이미지를 표시하는 함수
function showImage(ids) {
    // 현재 이미지 URL 가져오기
    var imageUrlIndex = currentTabIndex - 1;
    var imageUrl;
    if(ids=="dustCenterLeftHeaderIcon1"){
        imageUrl = imageUrlsPm10[currentIndex][imageUrlIndex]
    }else if(ids=="dustCenterLeftHeaderIcon2"){
        imageUrl = imageUrlsPm25[currentIndex][imageUrlIndex]
    }
    // 이미지 출력
    if (imageUrl && imageUrl.trim() !== "") {
        $('.dustCenterContentMain').empty().append($('<img>').attr('src', imageUrl));
    }
}

// 버튼 클릭 시 다음 이미지 표시
$('#dustCenterLeftContentButton').click(function(){
    currentIndex++; // 다음 이미지로 이동
    
    // 이미지 인덱스가 totalCount를 초과하면 0으로 초기화
    if (currentIndex >= totalCount) {
        currentIndex = 0;
    }

    showImage(); // 변경된 이미지 표시
});

// 미세먼지 탭 클릭 시
$('#dustCenterLeftHeaderIcon1').click(function(){
    var ids = $('#dustCenterLeftHeaderIcon1').attr('id');
    currentTabIndex = 1; // 탭 인덱스 설정
    currentIndex = 0; // 첫 번째 이미지부터 시작
    showImage(ids); // 변경된 이미지 표시
});

// 초미세먼지 탭 클릭 시
$('#dustCenterLeftHeaderIcon2').click(function(){
    var ids = $('#dustCenterLeftHeaderIcon2').attr('id');
    currentTabIndex = 2; // 탭 인덱스 설정
    currentIndex = 0; // 첫 번째 이미지부터 시작
    showImage(ids); // 변경된 이미지 표시
});