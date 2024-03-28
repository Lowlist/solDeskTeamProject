var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth';
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'JY7Vm0WbF6JwPpyiYSKp5J73J3EEk2yZ9yHXoU7CA%2F5yPmxlt5AyBXaTBvRMKhQcsKjCWRujJ4oRYSy03OTh8A%3D%3D';
queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('json');
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('100');
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');

// 현재 날짜를 가져오는 부분
var now = new Date();
var year = now.getFullYear();
var month = now.getMonth() + 1;
var day = now.getDate();
// 한 자리 숫자일 때 앞에 0을 붙이기
month = (month < 10) ? '0' + month : month;

// 날짜 문자열 생성
var dateString = year + '-' + month + '-' + day;
// encodeURIComponent() 함수에 전달하여 인코딩
var encodedDateString = encodeURIComponent(dateString);

// 수정된 쿼리 파라미터
queryParams += '&' + encodeURIComponent('searchDate') + '=' + encodedDateString;

queryParams += '&' + encodeURIComponent('InformCode') + '=' + encodeURIComponent('PM10');
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: ' + this.status + '\nHeaders: ' + JSON.stringify(this.getAllResponseHeaders()) + '\nBody: ' + this.responseText);
    }
};
xhr.send();

