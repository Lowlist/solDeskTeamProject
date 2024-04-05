<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${cp}/resources/MediumLogic.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7"></script>
<link rel="stylesheet" href="${cp}/resources/MediumFc.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons.min.css">
<link rel="stylesheet"
	href="${cp}/resources/weather-icons-master/css/weather-icons-wind.css">
<title>Insert title here</title>
</head>
<body>
<script>
    $(document).ready(function(){
        $('#areaSelect').change(function(){
            var selectedArea = $(this).val();
            $.ajax({
                type: 'GET',
                url: '${cp}/Weather/MediumWeather',
                data: { area: selectedArea },
                success: function(response) {
                    console.log('Success:', response);
                    // body의 내용을 변경
                    $('body').html(response);
                    
                    // 선택된 옵션을 첫 번째 옵션으로 이동
                    $('#areaSelect').prepend($('#areaSelect option:selected'));
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });
</script>
	<!-- 중기예보 페이지 큰틀 -->
	<div class="medium-forecast">

		<!-- 중기예보 페이지 탑 -->
		<div class="medium-forecast-top-line">
			<div class="medium-top-icon-line">
				<div class="mediumIcons">
					<a href="${cp}/"> <img alt="메인로고"
						src="${cp}/resources/img/main_logo.png"></a>
				</div>
			</div>
		</div>
		<!-- 중기예보 페이지 끝 -->

		<!-- 중기예보 하이 페이지 시작 -->
		<div class="medium-high-line">
			<div class="medium-high-icon-line">
				<div class="goMain">

					<h1>
						<a href="${cp}/">메인 홈</a>
					</h1>
				</div>
				<div class="goMain">

					<h1>
						<a href="${cp}/Weather/ShortWeather?area=서울">단기기상정보</a>
					</h1>
				</div>
				<div class="goMain">

					<h1>
						<a href="${cp}/Weather/DustWeather">전국미세먼지</a>
					</h1>
				</div>
				<div class="goMain">

					<h1>
						<a href="${cp}/Weather/PastWeather?area=서울">과거날씨정보</a>
					</h1>
				</div>
				<div class="goMain">

					<h1>
						<a href="${cp}/Weather/Main?area=서울">생활기상지수</a>
					</h1>
				</div>
			</div>
			<div class="medium-high-serach-line">
				<div class="medium-high-left-serach-line"></div>
				<div class="medium-high-right-serach-line"></div>
			</div>
		</div>
		<!-- 중기예보 하이 페이지 끝 -->

		<!-- 메인 홈 헤더 시작 -->
		<!-- <div class="main-home-header-line">

        </div> -->
		<!-- 메인 홈 헤더 끝 -->

		<!-- 중기예보 센터 시작 -->
		<div class="medium-center-line">
			<div class="medium-left-line">
				<div id="area-name">
					<h1>${Area}중기기상예보</h1>
				</div>
				<div class="item-weather-info" id="wf3">
					<div>${MediumData.get(0).date}</div>
					<div>${MediumData.get(0).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf3Am}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf3Am eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin3}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax3}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt3Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf4">
					<div>${MediumData.get(1).date}</div>
					<div>${MediumData.get(1).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf4Am}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf4Am eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>
					<div>최저기온:${temper.response.body.items.item.get(0).taMin4}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax4}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt4Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf5">
					<div>${MediumData.get(2).date}</div>
					<div>${MediumData.get(2).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf5Am}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf5Am eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin5}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax5}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt5Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf6">
					<div>${MediumData.get(3).date}</div>
					<div>${MediumData.get(3).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf6Am}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf6Am eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin6}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax6}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt6Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf7">
					<div>${MediumData.get(4).date}</div>
					<div>${MediumData.get(4).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf7Am}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf7Am eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin7}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax7}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt7Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf8">
					<div>${MediumData.get(5).date}</div>
					<div>${MediumData.get(5).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf8}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf8 eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin8}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax8}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt8}%
					</div>
				</div>
				<div class="item-weather-info" id="wf9">
					<div>${MediumData.get(6).date}</div>
					<div>${MediumData.get(6).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf9}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf9 eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin9}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax9}</div>
					<div class="rain">
						<i class="wi wi-raindrop" id="rain-rate"></i>${weather.response.body.items.item.get(0).rnSt9}%</div>
				</div>
				<div class="item-weather-info" id="wf10">
					<div>${MediumData.get(7).date}</div>
					<div>${MediumData.get(7).dayOfWeek}요일</div>
					<div>${weather.response.body.items.item.get(0).wf10}</div>
					<c:choose>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '맑음'}">
							<i class="wi wi-day-sunny"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '구름많음'}">
							<i class="wi wi-day-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '구름많고 비'}">
							<i class="wi wi-day-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '구름많고 눈'}">
							<i class="wi wi-day-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '구름많고 비/눈'}">
							<i class="wi wi-day-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '구름많고 소나기'}">
							<i class="wi wi-day-showers"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '흐림'}">
							<i class="wi wi-cloudy"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '흐리고 비'}">
							<i class="wi wi-rain"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '흐리고 눈'}">
							<i class="wi wi-snow"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '흐리고 비/눈'}">
							<i class="wi wi-rain-mix"></i>
						</c:when>
						<c:when
							test="${weather.response.body.items.item.get(0).wf10 eq '흐리고 소나기'}">
							<i class="wi wi-showers"></i>
						</c:when>
					</c:choose>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin10}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax10}</div>
					<div class="rain">
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt10}%
					</div>
				</div>
			</div>
			<div class="medium-center-right-line">
				<div class="medium-center-right-top">
					<div class="medium-center-right-map-line">
						<div class="medium-center-right-map" id="mediumCenterMap">
							<div class="map-btn" id=mapBtn0></div>
							<div class="map-btn" id=mapBtn1></div>
							<div class="map-btn" id=mapBtn2></div>
						</div>
					</div>
				</div>
				<div class="medium-center-right-bottom">
					<div id="week-forecast">
						<h2>주간예보</h2>
					</div>
					<div id="week-forecast-textbox">
						<h3>${forecast.response.body.items.item.get(0).wfSv}</h3>
					</div>
					<select id="areaSelect">
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="대전">대전</option>
						<!-- 원하는 지역 옵션을 추가하세요 -->
					</select>
				</div>
			</div>
		</div>
		<!-- 중기예보 센터 끝 -->

		<!-- 중기예보 바텀 시작 -->
		<div class="medium-bottom-line"></div>
		<!-- 중기예보 바텀 끝 -->
	</div>

	<!-- 중기예보 끝 -->
</body>
</html>