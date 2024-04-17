<%@ page language="java"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="${cp}/resources/button.css" rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${cp}/resources/ShortLogic.js"></script>
<!-- shortWeather css -->
<link href="${cp}/resources/ShortWeather.css" rel="stylesheet" type="text/css" />
<script src="https://d3js.org/d3.v7.min.js"></script>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7&submodules=geocoder"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

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

function scrollToPrev() {
    const container = document.querySelector('.weather-table');
    container.scrollBy({
        left: -400, // 스크롤할 양을 조절하세요
        behavior: 'smooth'
    });
}

function scrollToNext() {
    const container = document.querySelector('.weather-table');
    container.scrollBy({
        left: 400, // 스크롤할 양을 조절하세요
        behavior: 'smooth'
    });
}

// AJAX 요청 보내기
var xhr = new XMLHttpRequest();
xhr.open('GET', 'MediumWeather', true);
xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
        // 응답에서 필요한 부분 추출하기
        var mediumWeatherHTML = xhr.responseText;
        var mediumWeatherContainer = document.getElementById('mediumWeatherContainer');
        var parser = new DOMParser();
        var doc = parser.parseFromString(mediumWeatherHTML, 'text/html');
        var contentToExtract = doc.querySelector('.item-weather-info'); // 가져올 부분의 클래스명
        
     /*    var dateElement = contentToExtract.querySelector('#a'); // 두 번째 div 요소 선택 (요일 부분)
        var dayText = dateElement.textContent; // 요일 텍스트 가져오기
        var trimmedDayText = dayText.replace(/요일/g, ''); // "요일" 텍스트 삭제
        dateElement.textContent = trimmedDayText; // 가공된 텍스트로 변경
 */
        // 가져온 부분을 새로운 div에 넣기
        mediumWeatherContainer.innerHTML = contentToExtract.outerHTML;
    }
};
xhr.send();

//두 번째 AJAX 요청 보내기
var xhr2 = new XMLHttpRequest();
xhr2.open('GET', 'MediumWeather', true);
xhr2.onreadystatechange = function() {
    if (xhr2.readyState === 4 && xhr2.status === 200) {
        // 응답에서 두 번째 필요한 부분 추출하기
        var mediumWeatherHTML2 = xhr2.responseText;
        var mediumWeatherContainer2 = document.getElementById('mediumWeatherContainer1');
        var parser2 = new DOMParser();
        var doc2 = parser2.parseFromString(mediumWeatherHTML2, 'text/html');
        var contentToExtract2 = doc2.querySelector('#wf4'); // 가져올 부분의 id
        // 가져온 부분을 두 번째 div에 넣기
        mediumWeatherContainer2.innerHTML = contentToExtract2.outerHTML;
    }
};
xhr2.send();

var xhr3 = new XMLHttpRequest();
xhr3.open('GET', 'MediumWeather', true);
xhr3.onreadystatechange = function() {
    if (xhr3.readyState === 4 && xhr3.status === 200) {
        // 응답에서 두 번째 필요한 부분 추출하기
        var mediumWeatherHTML3 = xhr3.responseText;
        var mediumWeatherContainer3 = document.getElementById('mediumWeatherContainer2');
        var parser3 = new DOMParser();
        var doc3 = parser3.parseFromString(mediumWeatherHTML3, 'text/html');
        var contentToExtract3 = doc3.querySelector('#wf5'); // 가져올 부분의 id
        // 가져온 부분을 두 번째 div에 넣기
        mediumWeatherContainer3.innerHTML = contentToExtract3.outerHTML;
    }
};
xhr3.send();

var xhr4 = new XMLHttpRequest();
xhr4.open('GET', 'MediumWeather', true);
xhr4.onreadystatechange = function() {
    if (xhr4.readyState === 4 && xhr4.status === 200) {
        // 응답에서 두 번째 필요한 부분 추출하기
        var mediumWeatherHTML4 = xhr4.responseText;
        var mediumWeatherContainer4 = document.getElementById('mediumWeatherContainer3');
        var parser4 = new DOMParser();
        var doc4 = parser4.parseFromString(mediumWeatherHTML4, 'text/html');
        var contentToExtract4 = doc4.querySelector('#wf6'); // 가져올 부분의 id
        // 가져온 부분을 두 번째 div에 넣기
        mediumWeatherContainer4.innerHTML = contentToExtract4.outerHTML;
    }
};
xhr4.send();

var xhr5 = new XMLHttpRequest();
xhr5.open('GET', 'MediumWeather', true);
xhr5.onreadystatechange = function() {
    if (xhr5.readyState === 4 && xhr5.status === 200) {
        // 응답에서 두 번째 필요한 부분 추출하기
        var mediumWeatherHTML5 = xhr5.responseText;
        var mediumWeatherContainer5 = document.getElementById('mediumWeatherContainer4');
        var parser5 = new DOMParser();
        var doc5 = parser5.parseFromString(mediumWeatherHTML5, 'text/html');
        var contentToExtract5 = doc5.querySelector('#wf7'); // 가져올 부분의 id
        // 가져온 부분을 두 번째 div에 넣기
        mediumWeatherContainer5.innerHTML = contentToExtract5.outerHTML;
    }
};
xhr5.send();

var xhr6 = new XMLHttpRequest();
xhr6.open('GET', 'MediumWeather', true);
xhr6.onreadystatechange = function() {
    if (xhr6.readyState === 4 && xhr6.status === 200) {
        // 응답에서 두 번째 필요한 부분 추출하기
        var mediumWeatherHTML6 = xhr6.responseText;
        var mediumWeatherContainer6 = document.getElementById('mediumWeatherContainer5');
        var parser6 = new DOMParser();
        var doc6 = parser6.parseFromString(mediumWeatherHTML6, 'text/html');
        var contentToExtract6 = doc6.querySelector('#wf8'); // 가져올 부분의 id
        // 가져온 부분을 두 번째 div에 넣기
        mediumWeatherContainer6.innerHTML = contentToExtract6.outerHTML;
    }
};
xhr6.send();

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
<div class="short-header">
  <div class="short-header-line">
  <!-- 메인 로고 -->
  <img src="${cp}/resources/img/main_logo.png" style="height:100px; width:200px"/>
  <!-- 메뉴 -->
   		<c:forEach var="i" begin="0" end="4">
   		<div class="short-header-menu" id="homeHeaderMenu${i}">
   		</div>
      	</c:forEach>
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
     	<form action="delete" method="post">
   			<button type="submit" class="btn-gradient yellow mini" >삭제</button>		
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
			        <c:if test="${item.fcstValue == '1'}">
	   							 <img id="sunny" class="sunny-image" src="${item.imageUrl}" alt="맑음 이미지">
							</c:if>
							<c:if test="${item.fcstValue == '3'}">
	    						<img id="Lots-of-cloud" class="clouds-image" src="${item.imageUrl}" alt="구름많음 이미지">
							</c:if>
							<c:if test="${item.fcstValue == '4'}">
	   							 <img id="cloud" class="cloud-image" src="${item.imageUrl}" alt="흐림 이미지">
							</c:if>
			       <!--  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
					fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" class="feather feather-moon">
					<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
					</svg> -->
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
<!--         <div class="" style="width: 800px;"> -->
<!--         	<div class="" style="width: 800px; max-width: 600px; overflow-x: scroll; border-radius: 10px; border: solid 3px rgba(54, 162, 235, 1);"> -->
<!-- 		        <div class="lineChart" style="height: 400px"> -->
<%-- 			        <canvas id="temperatureChart"></canvas>     --%>
		        
<!-- 			        <div> -->
<%-- 				    	<c:forEach var="item" items="${searchTomorrowWeather}"> --%>
<%-- 				       	   <c:if test="${item.category eq 'TMP'}"> --%>
<%-- 					           온도 ${item.fcstValue} --%>
<%-- 					       </c:if> --%>
<%-- 				       	</c:forEach> --%>
<!-- 				    </div> -->
<!-- 		        </div> -->
			    			
			
<!-- 			</div> -->
<!--         </div> -->
        <button type="button" class="btn-prev" onclick="scrollToPrev()"><img src="${cp}/resources/img/left_icon.ico" class="left-img" /></button>
		<div class="weather-table" style="overflow-x: auto; min-width:95%">
			<table>
				<tr>
			        <c:forEach var="item" items="${searchTmpWeather}">
			            <td>${item.targetTime}</td>
			        </c:forEach>
			    </tr>
			    <tr>
			    	<c:forEach var="item" items="${searchSkyWeather}">
			            <td>
				            <c:if test="${item.fcstValue == '1'}">
	   							 <img id="sunny" class="sunny-image" src="${item.imageUrl}" alt="맑음 이미지">
							</c:if>
							<c:if test="${item.fcstValue == '3'}">
	    						<img id="Lots-of-cloud" class="clouds-image" src="${item.imageUrl}" alt="구름많음 이미지">
							</c:if>
							<c:if test="${item.fcstValue == '4'}">
	   							 <img id="cloud" class="cloud-image" src="${item.imageUrl}" alt="흐림 이미지">
							</c:if>
			            </td>
			        </c:forEach>
			    </tr>
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
			    <tr id="rain-amount">
			    	<c:forEach var="item" items="${searchPcpWeather}">
			            <td>${item.fcstValue}</td>
			        </c:forEach>
			    </tr>
			    	<!-- 맑음 상태 -->
			</table>
<!-- 			<svg id="temperatureChart"></svg> -->
		</div>
		<button type="button" class="btn-next" onclick="scrollToNext()"><img src="${cp}/resources/img/right_icon.ico" class="right-img"/></button>
		
		<script>
			const data = [];
			for (let i = 0; i < searchTmpWeather.length; i++) {
			    data.push(searchTmpWeather[i].fcstValue);
			}
		
		    // SVG에 그래프 그리기
		    const svg = d3.select("#temperatureChart");
		
		    // 점 그리기
		    svg.selectAll("circle")
		        .data(data)
		        .enter()
		        .append("circle")
		        .attr("cx", (d, i) => i * (100 / data.length)) // 가로 방향으로 균일하게 점을 배치합니다.
		        .attr("cy", 50) // 세로 방향으로 중앙에 위치시킵니다.
		        .attr("r", 3) // 점의 반지름 설정
		        .style("fill", "red"); // 점의 색상 설정
		
		    // 직선 그리기
		    svg.append("line")
		        .attr("x1", 0) // 시작점 x 좌표
		        .attr("y1", 50) // 시작점 y 좌표 (중앙에 위치시킴)
		        .attr("x2", 100) // 끝점 x 좌표
		        .attr("y2", 50) // 끝점 y 좌표 (중앙에 위치시킴)
		        .style("stroke", "blue"); // 직선의 색상 설정
		</script>
    </div> 
    <div>주간 정보</div>
    <!-- 왼쪽 구역4 -->
    <div class="content-left-4">
	 	<div id="mediumWeatherContainer"></div>
    	<div id="mediumWeatherContainer1"></div>
    	<div id="mediumWeatherContainer2"></div>
    	<div id="mediumWeatherContainer3"></div>
    	<div id="mediumWeatherContainer4"></div>
    	<div id="mediumWeatherContainer5"></div>
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
  <div class="content-right">
    <!-- 오른쪽 구역1 -->
    <div class="content-right-1">
    <div class="home-center-right-map-btn">
                		<div class="switch-btn" id="switchBtn1"></div>
                		<div class="switch-btn" id="switchBtn2"></div>
                	</div>
                	<div class="short-center-right-map" id="homeCenterMap">
                	</div>
                	<div class="short-center-right-map-btn">
                		<div class="map-btn" id="mapBtn0"></div>
                		<div class="map-btn" id="mapBtn1"></div>
                		<div class="map-btn" id="mapBtn2"></div>
                	</div>
    </div>
    <!-- 오른쪽 구역2 -->
    <div class="content-right-2">
    	<div id="satellight"></div>
    </div>
    <!-- 오른쪽 구역3 -->
    <div class="content-right-3">
    </div>
  </div>
</div>
</div>
</body>
</html>
