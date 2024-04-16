<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Arrays" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${cp}/resources/Home.css">
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=cb3o2kyqsj"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="${cp}/resources/button.css" rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${cp}/resources/HomeLogic.js"></script>
<!-- shortWeather css -->
<link href="${cp}/resources/ShortWeather.css" rel="stylesheet" type="text/css" />

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
$(document).ready(function(){ 
    var serviceKey = "fpqEuKWzMPUU0PhKfNijGVZnZjweMezdxekVC6Y71Yb3Ki1h1WzMmnLZnqDioAGcwkbtEcRBa36OJrG6TABKHg%3D%3D"; // 서비스 키
    var apiUrl = "http://apis.data.go.kr/1360000/SatlitImgInfoService/getInsightSatlit";
    
    var currentDate = new Date();
    var currentTime = currentDate.toISOString().slice(0, 10).replace(/-/g, ''); // YYYYMMDD 형식으로 변환
    
    // Ajax 요청 설정
    $.ajax({
        url: apiUrl + "?serviceKey=" + serviceKey + "&numOfRows=10&pageNo=1&dataType=json&sat=g2&data=ir105&area=ko&time=" + currentTime,
        type: "GET",
        dataType: "json",
        success: function(response) { 
            // 이미지를 담은 배열 추출
            var imageUrls = response.response.body.items.item[0]['satImgC-file'].split(', ');
            
            // 이미지를 표시할 div 요소
            var $satelliteDiv = $('#satellight');
            var currentIndex = 0; // 현재 이미지 인덱스
            
            // 첫 번째 이미지 표시
            var $img = $('<img>').attr('src', imageUrls[currentIndex].trim());
            $satelliteDiv.empty().append($img);
            
            // 일정 시간마다 다음 이미지로 전환하는 타이머 설정
            setInterval(function() {
                currentIndex = (currentIndex + 1) % imageUrls.length; // 다음 이미지 인덱스 계산
                $img.attr('src', imageUrls[currentIndex].trim()); // 다음 이미지 표시
            }, 1000); // 1초마다 이미지 변경
        },
        error: function(xhr, status, error) {
            // 오류 발생 시 처리할 코드
            console.error("Error:", error);
        }
    });
});
</script>



</head>

<body>
<div class="short-weather">
<!-- 위쪽 헤더 -->
<div class="short-top-line">
			<div class="short-top-icon-line">
				<div class="short-top-icon" id="shortTopIconImg"></div>
				<div class="short-top-icon" id="shortTopIconWord">기상정보공유사이트</div>
			</div>
			<div class="dust-top-menu-line">
				<!-- 좌측부터 1번으로 시작함 -->
				<c:forEach var="i" begin="0" end="2">
					<div class="short-top-menu-word" id="shortTopMenuWord${i}"></div>
				</c:forEach>
			</div>
			<!-- 이곳에 메인 메뉴 배너의 내용을 넣어주세요 -->
		</div>
<!-- 안쪽 헤더 -->
<div class="inner_header">
  <div><!-- 메인 로고 -->
  <h1 class="logo">
  <svg 
    xmlns="http://www.w3.org/2000/svg"
    width="24"
    height="24"
    viewBox="0 0 576 512"
  >
  <path d="M575.8 255.5c0 18-15 32.1-32 32.1h-32l.7 160.2c0 2.7-.2 5.4-.5 8.1V472c0 22.1-17.9 40-40 40H456c-1.1 0-2.2 0-3.3-.1c-1.4 .1-2.8 .1-4.2 .1H416 392c-22.1 0-40-17.9-40-40V448 384c0-17.7-14.3-32-32-32H256c-17.7 0-32 14.3-32 32v64 24c0 22.1-17.9 40-40 40H160 128.1c-1.5 0-3-.1-4.5-.2c-1.2 .1-2.4 .2-3.6 .2H104c-22.1 0-40-17.9-40-40V360c0-.9 0-1.9 .1-2.8V287.6H32c-18 0-32-14-32-32.1c0-9 3-17 10-24L266.4 8c7-7 15-8 22-8s15 2 21 7L564.8 231.5c8 7 12 15 11 24z"/></svg>
  <a>날씨</a>
  </h1>
  </div>
  <!-- 메뉴 -->
  <div class="menu">
    <!-- role은 태그의 구조 및 동작에 대한 정보(역할)을 전달하기 위한 목적일 뿐 -->
     <!--  <div id="a"><a href="#">홈</a></div>
      <div><a href="#">중기예보</a></div>
      <div><a href="#">단기예보</a></div>
      <div><a href="#">미세먼지</a></div> -->
  </div>
</div>

<!-- 내용 -->
<div class="main">
  <!-- 왼쪽 구역 -->
  <div class="content-left">
    <!-- 왼쪽 구역1 -->
    <div class="content-left-1">
      <button>기상정보</button>
      <select>
        <option value="">지역선택</option>
        <option value="">서울</option>
        <option value="">인천</option>
        <option value="">부산</option>
      </select>
    </div>
    <!-- 왼쪽 구역 검색부분(1과 2사이) -->
    <div class="content-search">
    	
    	<c:forEach var="item" items="${searchNowWeather}">
       	   <c:if test="${item.category eq 'TMP'}">
	           ${item.area}
	       </c:if>
       	</c:forEach>
       	
       	<!-- 검색 부분 -->
       	<div class="search">
    	<form action="${cp}/Weather/searchWeather" method="post">
			<input type="text" placeholder="지역을 검색하세요" onfocus="placeholder=''" onblur="placeholder='지역을 검색하세요'" id="area" name="area">
            <button type="submit" class="btn-gradient blue small" value="검색">검색</button>
        </form>
        </div>
        
        <!-- 새로고침 부분(api 데이터 삽입) -->
        <div class="refresh">
   		<form action="NewInsert" method="post">
   			<button type="submit" class="btn-gradient yellow mini">새로고침</button>		
     	</form>
     	</div>
        
    </div>
	
	<!-- 왼쪽 구역2 -->
	<div class="content-left-2">
		<div class="content-left-2-left">
			<!-- 현재 시간 정보 (서울) 메인에 박아둘 정보 -->	
			<c:forEach var="item" items="${searchNowWeather}">
				<div class="temperature">
					<c:if test="${item.category eq 'TMP'}">
				       ${item.fcstValue}°
			       	</c:if>
				</div>
				<div class="state">
					<c:if test="${item.category eq 'SKY'}">
				          ${item.fcstValue}
			        
			        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
					fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" class="feather feather-moon">
					<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
					</svg>
			        </c:if>	        
				</div>
			</c:forEach>
			
			<c:forEach var="value" items="${nowWeather}" varStatus="loop">
			    <c:if test="${loop.index == 0}">
			        ${value}°
			    </c:if>
			    <c:if test="${loop.index == 4}">
			        ${value}
			    </c:if>
			</c:forEach>
		</div>   
    	<div class="content-left-2-right">
    		<!-- 오른쪽 첫번쨰 -->
	    	<div class="content-left-2-right-1">
	    	<c:forEach var="item" items="${searchNowWeather}">
				       	   <c:if test="${item.category eq 'UUU'}">
					           현재 풍속(동서) ${item.fcstValue}
					       </c:if>
					       <c:if test="${item.category eq 'VVV'}">
					          현재 풍속(남북) ${item.fcstValue}
					       </c:if>
					       <c:if test="${item.category eq 'VEC'}">
					          현재 풍향 ${item.fcstValue}
					       </c:if>
			</c:forEach>
				       
	    	<c:forEach var="value" items="${nowWeather}" varStatus="loop">
			    <c:if test="${loop.index == 1}">
			       현재 풍속(동서) ${value}
			    </c:if>
			    <c:if test="${loop.index == 2}">
			       현재 풍속(남북) ${value}
			    </c:if>
			    <c:if test="${loop.index == 3}">
			       현재 풍향 ${value}
			    </c:if>
			</c:forEach>
	    	</div>
	    	<!-- 오른쪽 두번쨰 -->
	    	<div class="content-left-2-right-2">
	    	<c:forEach var="item" items="${searchNowWeather}">
				       	   <c:if test="${item.category eq 'POP'}">
					          강수 확률  ${item.fcstValue}%
					       </c:if>
					       <c:if test="${item.category eq 'PCP'}">
					          강수량 ${item.fcstValue}
					       </c:if>
					       <c:if test="${item.category eq 'REH'}">
					          습도 ${item.fcstValue}%
					       </c:if>
				       </c:forEach>
	    	<c:forEach var="value" items="${nowWeather}" varStatus="loop">
			    <c:if test="${loop.index == 5}">
			       강수 확률 ${value}%
			    </c:if>
				<c:if test="${loop.index == 6}">
			       강수량 ${value}
			    </c:if>		
				<c:if test="${loop.index == 7}">
			       습도 ${value}%
			    </c:if>
			</c:forEach>
    		</div>
    	</div>
    </div>
    
    <!-- 왼쪽 구역3 -->
    <div class="content-left-3">
    	
        
        <div class="" style="width: 800px;">
        	<div class="" style="width: 800px; max-width: 600px; overflow-x: scroll; border-radius: 10px; border: solid 3px rgba(54, 162, 235, 1);">
		        <div class="lineChart" style="height: 400px">
			        <canvas id="temperatureChart"></canvas>    
		        
			        <div>
				    	<c:forEach var="item" items="${searchTomorrowWeather}">
				       	   <c:if test="${item.category eq 'TMP'}">
					           온도 ${item.fcstValue}
					       </c:if>
				       	</c:forEach>
				    </div>
		        </div>
			    			
			
			</div>
        </div>
<table>
    <tr>
    	<c:forEach var="item" items="${searchSkyWeather}">
            <td>${item.fcstValue}</td>
        </c:forEach>
    </tr>
		<!-- 기온 --> <!-- 그래프로 나타내는 구조로 부탁해 -->
    <tr>
        <c:forEach var="item" items="${searchTmpWeather}">
            <td>${item.fcstValue}</td>
        </c:forEach>
    </tr>
    	<!-- 강수 확률 -->
    <tr>
    	<c:forEach var="item" items="${searchPopWeather}">
            <td>${item.fcstValue}%</td>
        </c:forEach>
    </tr>
    	<!-- 습도 -->
    <tr>
    	<c:forEach var="item" items="${searchRehWeather}">
            <td>${item.fcstValue}%</td>
        </c:forEach>
    </tr>
    	<!-- 강수량 -->
    <tr>
    	<c:forEach var="item" items="${searchPcpWeather}">
            <td>${item.fcstValue}</td>
        </c:forEach>
    </tr>
    	<!-- 맑음 상태 -->
</table>




<%-- <table border="1">
	<c:forEach items="${searchTmpWeather}" var="item"> 
		<tr>
			<td>${item.fcstValue}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${searchPopWeather}" var="item"> 
		<tr>
			<td>${item.fcstValue}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${searchPcpWeather}" var="item"> 
		<tr>
			<td>${item.fcstValue}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${searchSkyWeather}" var="item"> 
		<tr>
			<td>${item.fcstValue}</td>
		</tr>
	</c:forEach>
</table> --%>

<!--        <table> -->
<!--         표 본문글 -->
<!--         <tbody> -->
<!--         시간별로 반복 -->
<!--     	시간 -->
<!--         <tr>  -->
<!--         	각 카테고리의 값 출력	 -->
<!--          <tr> -->
<%-- 	       	 <c:forEach var="item" items="${searchTomorrowWeather}"> --%>
<%-- 	       	 	<c:if test="${item.category eq 'TMP'}"> --%>
<%-- 		           온도 ${item.fcstValue} --%>
<%-- 		        </c:if> --%>
<%-- 	       	 </c:forEach> --%>
<!--        	 </tr> -->
<!--        	 <tr> -->
<%-- 	         <c:forEach var="item" items="${searchTomorrowWeather}"> --%>
<%-- 	       	 	<c:if test="${item.category eq 'VEC'}"> --%>
<%-- 		           VEC ${item.fcstValue} --%>
<%-- 		        </c:if> --%>
<%-- 	       	 </c:forEach> --%>
<!--          </tr>	 -->
        	
        	
<%--          <c:forEach var="item" items="${searchTomorrowWeather}"> --%>
<!--       	 	TMP 카테고리  -->
<!--       	 	<tr> -->
<!-- 			    <td> -->
<%-- 			        <c:if test="${item.category eq 'TMP'}"> --%>
<%-- 			            온도 ${item.fcstValue} --%>
<%-- 			        </c:if> --%>
<!-- 			    </td> -->
<!-- 			    <td> -->
<%-- 			        <c:if test="${item.category eq 'VEC'}"> --%>
<%-- 			            VEC ${item.fcstValue} --%>
<%-- 			        </c:if> --%>
<!-- 			    </td> -->
<!-- 			    <td> -->
<%-- 			        <c:if test="${item.category eq 'PCP'}"> --%>
<%-- 			            PCP ${item.fcstValue} --%>
<%-- 			        </c:if> --%>
<!-- 			    </td> -->
<!-- 			</tr> -->
<!--              추가 카테고리에 대한 처리 -->
<%--          </c:forEach> --%>
<!--         </tr>  -->
<!--         </tbody>               -->
<!--       </table> -->
    </div> 
    
    <!-- 왼쪽 구역4 -->
    <div class="content-left-4">
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
    </div>
    <!-- 왼쪽 구역5 (임시코드) -->
    <div class="content-left-5">왼5
        <%
        // 기상청 API를 통해 현재 시간대의 기온 데이터를 가져온다고 가정
        // 실제로는 해당 API에 맞게 요청 및 응답 처리 필요
        double[] temperatureData = {20, 22, 23, 24, 25, 26, 24, 22, 21, 20, 22, 23, 24, 25, 26, 24, 22, 21,
        		20, 22, 23, 24, 25, 26, 24, 22, 21, 20, 22, 23, 24, 25, 26, 24, 22, 21}; // 예시 기온 데이터
        double[] timeLabels = {9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 00, 01, 02,
        		03, 04, 05, 06, 07, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}; // 예시 시간 라벨
        
        String temperatureDataJson = Arrays.toString(temperatureData);
        String timeLabelsJson = Arrays.toString(timeLabels);
    	%>
    	    	
    	<script>
        var ctx = document.getElementById('temperatureChart').getContext('2d');
        var temperatureData = <%= temperatureDataJson %>;
        var timeLabels = <%= timeLabelsJson %>;

        //config
        const config = {
                type: 'line',
                data: {
                    labels: timeLabels,
                    datasets: [{
                        label: '',
                        data: temperatureData,
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                    	x: {
                    		grid: {
                    			color: 'transparent',
                    		},
                    		display:false,
                    	},
                        y: {
                        	grid: {
                        		color: 'transparent',
                        	},
                        	beginAtZero:true,
                        	display: false,
                        }
                    }
                }
            }
        
        const myChart = new Chart(ctx, config);
        
        //x-scroll
        const lineChart = document.querySelector('.lineChart');
        const totalLabels = myChart.data.labels.length;
        if (totalLabels > 12) {
        	lineChart.style.width = '800px'
//         	const newWith = 800 + ((totalLabels - 12) * 30);
//         	lineChart.style.width = `${newWidth}px`;
        }
    	</script>
  	</div>
  </div>
  <!-- 오른쪽 구역 -->
  <div class="content_right">
    <!-- 오른쪽 구역1 -->
    <div class="content_right_1">
    <div class="home-center-right-map-btn">
                		<div class="switch-btn" id="switchBtn1"></div>
                		<div class="switch-btn" id="switchBtn2"></div>
                	</div>
                	<div class="home-center-right-map" id="homeCenterMap">
                	</div>
                	<div class="home-center-right-map-btn">
                		<div class="map-btn" id="mapBtn0"></div>
                		<div class="map-btn" id="mapBtn1"></div>
                		<div class="map-btn" id="mapBtn2"></div>
                	</div>
    </div>
    <!-- 오른쪽 구역2 -->
    <div class="content_right_2">
    </div>
    <!-- 오른쪽 구역3 -->
    <div class="content_right_3">
    	<div id="satellight"></div>
    </div>
  </div>
</div>
</div>
</body>
</html>
