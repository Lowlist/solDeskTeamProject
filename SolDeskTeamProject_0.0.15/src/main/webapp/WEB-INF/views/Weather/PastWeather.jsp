<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${cp}/resources/PastWeather.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons.min.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons-wind.css">
<title>Insert title here</title>
</head>
<body>

	<!-- 과거 페이지 큰틀 -->
	<div class="past-weather">

		<!-- 과거 페이지 탑 -->
		<div class="past-weather-top-line">
			<div class="past-weather-icon-line">
				<div class="past-weather-icons">
					<a href="${cp}/Weather/Main?area=서울"><img alt="메인로고"src="${cp}/resources/img/main_logo.png"></a>
				</div>
			</div>
		</div>
		<!-- 과거 페이지 끝 -->

		<!-- 과거 페이지 시작 -->
		<div class="past-weather-high-line">
			<div class="past-weather-high-icon-line">
				<h1>대충 사이트내 기능들</h1>
			</div>
			<div class="past-weather-serach-line">
				<div class="past-high-left-serach-line"></div>
				<div class="past-high-right-serach-line"></div>
			</div>
		</div>
		<!-- 과거 페이지 끝 -->

		<!-- 과거 페이지 헤더 시작 -->
		<!-- <div class="main-home-header-line">

        </div> -->
		<!-- 과거 페이지 헤더 끝 -->

		<!-- 과거 페이지 시작 -->
		<div class="past-center-line">
			<div class="past-left-line">
				<div id="past-page-name"><h2>과거날씨정보</h2></div>
				<div class="item-date-info" id="wf3">
					${date} 기준정보
				</div>
				<div class="item-weather-info" id="wf4">
					<div></div>
					<div></div>
					<div></div>
					<div></div>
					<div></div>
					<div><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt4Am}%</div>
				</div>
				<div class="item-weather-info" id="wf5">
					<div>${MediumData.get(2).date}</div>
					<div>${MediumData.get(2).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf5Am}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin5}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax5}</div>
					<div><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt5Am}%</div>
				</div>
				<div class="item-weather-info" id="wf6">
					<div>${MediumData.get(3).date}</div>
					<div>${MediumData.get(3).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf6Am}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin6}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax6}</div>
					<div><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt6Am}%</div>
				</div>
				<div class="item-weather-info" id="wf7">
					<div>${MediumData.get(4).date}</div>
					<div>${MediumData.get(4).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf7Am}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin7}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax7}</div>
					<div><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt7Am}%</div>
				</div>
				<div class="item-weather-info" id="wf8">
					<div>${MediumData.get(5).date}</div>
					<div>${MediumData.get(5).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf8}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin8}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax8}</div>
					<div><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt8}%</div>
				</div>
				<div class="item-weather-info" id="wf9">
					<div>${MediumData.get(6).date}</div>
					<div>${MediumData.get(6).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf9}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin9}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax9}</div>
					<div class="rain" ><i class="wi wi-raindrop" id="rain-rate"></i>${weather.response.body.items.item.get(0).rnSt9}%</div>
				</div>
				<div class="item-weather-info" id="wf10">
					<div>${MediumData.get(7).date}</div>
					<div>${MediumData.get(7).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf10}</div>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin10}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax10}</div>
					<div class="rain"><i class="wi wi-raindrop" id="rain-rate"></i> ${weather.response.body.items.item.get(0).rnSt10}%</div>
				</div>
			</div>
				<div class="home-center-left-bottom-line"></div>
			<div class="medium-center-right-line"></div>
		</div>
		<!-- 중기예보 센터 끝 -->

		<!-- 중기예보 바텀 시작 -->
		<div class="medium-bottom-line">
		</div>
		<!-- 중기예보 바텀 끝 -->
</div>

		<!-- 중기예보 끝 -->
</body>
</html>