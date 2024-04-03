<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="${cp}/resources/ShortMain.css">
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=cb3o2kyqsj"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</script>
</head>
<body>
	<div class=whole>
		<div class=top-of-top></div>
		<div class=top></div>
		<div class=whole-mid>
			<div class=mid>
				<div class=mid-left>
					<div class=mid-header>
						<div class=main-header-button>
							<button type="button" class="bt dropdown-toggle"
								data-bs-toggle="dropdown">
								<img src="${cp}/resources/naver.png" alt="button-img"
									style="width: 20px; height: 20px;" /> <span
									style="font-style: italic;">네이버</span>
							</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">기상청</a></li>
							</ul>
						</div>
						<div class=main-header-list>
							<button type="button" class="bt1 dropdown-toggle">
								<img src="${cp}/resources/star.png" alt="button-img"
									style="width: 20px; height: 20px;" /> <span
									style="font-style: italic;">관심구역</span>
							</button>
						</div>
					</div>
					<div class=mid-location-info-area>
						<div class="location-area">지역이름 들어 갈 부분</div>
						<div class="location-search">
							<select id="step1" class="emptyCheck" title="시/도">
								<option id="city" value="">시/도</option>
							</select> <select id="step2">
								<option id="county" value="">시/군/구</option>
							</select> <select id="step3">
								<option id="town" value="">읍/면/동</option>
							</select> <span>날짜 선택: <input type="text" id="datepicker"
								disabled="disabled" class="emptyCheck" title="날짜"></span> <select
								id="time" class="emptyCheck" title="시간">
								<option value="" selected>시간</option>
							</select>
							<button type="button"
								class="btn btn-primary waves-effect waves-light"
								id="search" onclick="getWeather()">
								<span>실행</span>
							</button>
							<div id="weatherDataContainer"></div>
							<div id="a"></div>
   								${shortweather}
						</div>
						<button class="location-button" type="button">현위치</button>
					</div>
				</div>
				<div class=mid-right>
					<div class=mid-right-1>
						<div id="map" style="width: 100%; height: 500px;"></div>
						<script>
							var mapOptions = {
								center : new naver.maps.LatLng(37.3595704,
										127.105399),
								zoom : 20
							};

							var map = new naver.maps.Map('map', {
								scaleControl : false,
								logoControl : false,
								mapDataControl : false,
								zoomControl : true,
								minZoom : 1
							});
						</script>
					</div>
					<div class=mid-right-2></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
