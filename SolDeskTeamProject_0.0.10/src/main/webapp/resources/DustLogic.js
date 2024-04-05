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


function getPageWord(){
    $('#dustTopMenuWord0').text("기상정보공유사이트 소개");
    $('#dustTopMenuWord1').text("로그인");
    $('#dustTopMenuWord2').text("사이트맵");
    $('#dustCenterLeftHeaderIcon0').text("미세먼지");
    $('#dustCenterLeftHeaderIcon1').text("초미세먼지");
    $('#dustCenterLeftHeaderIcon2').text("동네별");
    $('#dustCenterLeftHeaderIcon3').text("전국");
    $('#dustCenterLeftHeaderIcon4').text("기타");
   
}