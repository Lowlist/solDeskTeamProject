<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${cp}/resources/MediumLogic.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
        // 초기에는 오전 버튼이 선택되어 있음
        showMorning();

        // 오전 버튼 클릭 시
        $('#morning-btn').click(function() {
            showMorning();
        });

        // 오후 버튼 클릭 시
        $('#evening-btn').click(function() {
            showNight();
        });

        // 오전을 표시하는 함수
        function showMorning() {
            $('.morning').show();
            $('.night').hide();
        }

        // 오후를 표시하는 함수
        function showNight() {
            $('.morning').hide();
            $('.night').show();
        }
        $("#button-addon2").click(function(event) {
            // 기본 동작 방지 (페이지 새로고침 방지)
            event.preventDefault();

            // 입력된 값을 가져와 변수에 할당
            var inputValue = $("#search-input").val();

            // 이제 변수 inputValue에 사용자가 입력한 값이 들어 있습니다.
            // 여기에서 변수 inputValue를 원하는 방식으로 사용할 수 있습니다.

            // 예를 들어, 콘솔에 로그로 출력할 수 있습니다.
            console.log("사용자가 입력한 값:", inputValue);

            var selectedArea = inputValue;
            var areaBoxJson = '${areaBox}';
            var areaBox = JSON.parse(areaBoxJson);
            if ($.inArray(selectedArea,areaBox) == -1) {
                console.log("잘못 입력했습니다.");
                alert('선택한 지역이 유효하지 않습니다.');
                // 여기에 서울을 입력했을 때 수행할 동작을 추가합니다.
            } else {
                console.log("제대로 입력했습니다.");
                // 여기에 서울 이외의 값을 입력했을 때 수행할 동작을 추가합니다.
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
            }
        });
        // 입력값이 지역인지 확인하는 함수
        function isLocation(input) {

            return input.trim().length > 0;
        }
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
				<div id="area-search" class="d-flex">
					<h3>지역검색:</h3>
					    <form action="${cp}/Weather/MediumWeather">
						    <div class="input-group pb-4">
	  							<input type="text" id="search-input" name="area" class="form-control" placeholder="지역을 입력하세요..." aria-describedby="basic-addon2">
	  							 <button class="btn btn-outline-secondary" type="submit" id="button-addon2" data-error="${error}">검색</button>
							</div>
    					</form>
					<div class="btn-group" role="group" aria-label="Basic outlined example">
					    <button type="button" class="btn btn-outline-secondary" id="morning-btn">오전</button>
					    <button type="button" class="btn btn-outline-secondary" id="evening-btn">오후</button>
					</div>
				</div>
				<div class="item-weather-info" id="wf3">
					<div>${MediumData.get(0).date}</div>
					<div>${MediumData.get(0).dayOfWeek}요일</div>
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Pm}
					</div>
					
					<div>최저기온:${temper.response.body.items.item.get(0).taMin3}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax3}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt3Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf3">
					<div>${MediumData.get(0).date}</div>
					<div>${MediumData.get(0).dayOfWeek}요일</div>
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Pm}
					</div>
					
					<div>최저기온:${temper.response.body.items.item.get(0).taMin3}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax3}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt3Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf3">
					<div>${MediumData.get(0).date}</div>
					<div>${MediumData.get(0).dayOfWeek}요일</div>
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Pm}
					</div>
					
					<div>최저기온:${temper.response.body.items.item.get(0).taMin3}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax3}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt3Am}%
					</div>
				</div>
				<div class="item-weather-info" id="wf3">
					<div>${MediumData.get(0).date}</div>
					<div>${MediumData.get(0).dayOfWeek}요일</div>
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf3Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf3Pm}
					</div>
					
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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf4Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf4Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf4Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf4Pm}
					</div>
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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf5Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf5Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf5Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf5Pm}
					</div>

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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf6Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf6Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf6Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf6Pm}
					</div>

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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Pm}
					</div>

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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Pm}
					</div>

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
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Am eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Am}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf7Pm eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf7Pm}
					</div>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin9}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax9}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt9}%
					</div>
				</div>
				<div class="item-weather-info" id="wf10">
					<div>${MediumData.get(7).date}</div>
					<div>${MediumData.get(7).dayOfWeek}요일</div>
					<div class="morning" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${morningWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf10 eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf10}
					</div>
					<div class="night" style="display: none;">
					<div class="weathers">
						<c:forEach var="entry" items="${nightWeatherMap}">
	    					<c:if test="${weather.response.body.items.item.get(0).wf10 eq entry.key}">
	        					<i class="wi ${entry.value}"></i>
	    					</c:if>
						</c:forEach>
					</div>
					${weather.response.body.items.item.get(0).wf10}
					</div>

					<div>최저기온:${temper.response.body.items.item.get(0).taMin10}</div>
					<div>최고기온:${temper.response.body.items.item.get(0).taMax10}</div>
					<div>
						<i class="wi wi-raindrop" id="rain-rate"></i>
						${weather.response.body.items.item.get(0).rnSt10}%
					</div>
				</div>

				

			</div>
			<div class="medium-center-right-line">
				<div class="medium-center-right-top">
					<div id="Areas">
					<select class="form-select" aria-label="Default select example" id="areaSelect">
						<option value="">-----------------지역선택-----------------</option>
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="수원">수원</option>
						<option value="파주">파주</option>
						<option value="춘천">춘천</option>
						<option value="원주">원주</option>
						<option value="강릉">강릉</option>
						<option value="대전">대전</option>
						<option value="서산">서산</option>
						<option value="세종">세종</option>
						<option value="청주">청주</option>
						<option value="제주">제주</option>
						<option value="서귀포">서귀포</option>
						<option value="광주">광주</option>
						<option value="목포">목포</option>
						<option value="여수">여수</option>
						<option value="전주">전주</option>
						<option value="군산">군산</option>
						<option value="부산">부산</option>
						<option value="울산">울산</option>
						<option value="창원">창원</option>
						<option value="대구">대구</option>
						<option value="안동">안동</option>
						<option value="포항">포항</option>
						<!-- 원하는 지역 옵션을 추가하세요 -->
					</select>
					</div>
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
						<h4>${forecast.response.body.items.item.get(0).wfSv}</h4>
					</div>					
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