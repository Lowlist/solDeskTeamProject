<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>간단한 지도 표시하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${cp}/resources/style.css">
<script src="${cp}/resources/WeatherDust.js"></script>
<!-- <script type="text/javascript" -->
<!-- 	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eidrzi1ypl"></script> -->
</head>
<body>
	<!-- <div id="map" style="width: 100%; height: 400px;"></div>
	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.3595704, 127.105399),
			zoom : 10
		};

		var map = new naver.maps.Map('map', mapOptions);
	</script> -->

	<!-- 큰 틀 화면을 담을 div -->
	<div class="dust-main">
		<!-- 메인 메뉴 배너를 담을 div -->
		<div class="dust-top-line">
			<div id="dustTopIcon1">
				<a href="http://localhost:8080/spring/Weather/Dust/"> 
				<img src="${cp}/resources/3팀로고.PNG" alt="3팀로고"
					style="width: 80px; height: 80px;">
				</a>
			</div>
			<!-- 이곳에 메인 메뉴 배너의 내용을 넣어주세요 -->
		</div>

		<div class="dust-high-line"></div>

		<div class="dust-header-line"></div>
		<!-- 메인 콘텐츠를 담을 div -->
		<div class="dust-center-line">
			<!-- 이곳에 메인 콘텐츠의 내용을 넣어주세요 -->
			<div id="dustCenterContentLeft">
				<!-- <script>
					var mapOptions = {
						center : new naver.maps.LatLng(37.3595704, 127.105399),
						zoom : 10
					};

					var map = new naver.maps.Map('dust_center_content_left',mapOptions);
				</script> -->
				
				<!-- <script>
				var xhr = new XMLHttpRequest();
				var url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMinuDustFrcstDspth'; /*URL*/
				var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'JY7Vm0WbF6JwPpyiYSKp5J73J3EEk2yZ9yHXoU7CA%2F5yPmxlt5AyBXaTBvRMKhQcsKjCWRujJ4oRYSy03OTh8A%3D%3D'; /*Service Key*/
				queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('json'); /**/
				queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('100'); /**/
				queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
				queryParams += '&' + encodeURIComponent('searchDate') + '=' + encodeURIComponent('2024-03-28'); /**/
				queryParams += '&' + encodeURIComponent('InformCode') + '=' + encodeURIComponent('PM10'); /**/
				xhr.open('GET', url + queryParams);
				xhr.onreadystatechange = function () {
				    if (this.readyState == 4) {
				        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
				    }
				};
				
				</script> -->
			</div>
			<div id="dustCenterContentRight"></div>
		</div>

	</div>
</body>
</html>