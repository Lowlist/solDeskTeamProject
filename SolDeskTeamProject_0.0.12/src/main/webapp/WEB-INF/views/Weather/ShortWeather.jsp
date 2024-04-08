<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.tailwindcss.com"></script>
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
<script type="text/javascript">
<!--$(document).ready(function() { -->
function fetchData() {
    var serviceKey = "fpqEuKWzMPUU0PhKfNijGVZnZjweMezdxekVC6Y71Yb3Ki1h1WzMmnLZnqDioAGcwkbtEcRBa36OJrG6TABKHg%3D%3D"; // 서비스 키
    var apiUrl = "http://apis.data.go.kr/1360000/SatlitImgInfoService/getInsightSatlit";
    
    var currentDate = new Date();
    var currentTime = currentDate.toISOString().slice(0, 10).replace(/-/g, ''); // YYYYMMDD 형식으로 변환
    
    // Ajax 요청 설정
    $.ajax({
        url: apiUrl,
        type: "GET",
        dataType: "xml",
        data: {
            serviceKey: serviceKey,
            numOfRows: 10,
            pageNo: 1,
            sat: "g2",
            data: "ir105",
            area: "ko",
            time: currentTime
        },
        success: function(response) { // 올바른 위치에 success 콜백 함수를 작성합니다.
            // 응답 데이터에서 이미지 URL을 가져옵니다.
            var items = response.getElementsByTagName("satImgC-file");
            
            // 이미지를 표시할 div 요소를 가져옵니다.
            var container = document.getElementById("satellight");
            
            var currentIndex = 0; // 현재 이미지의 인덱스를 추적합니다.
            
            // 이미지를 클릭하여 다음 이미지로 넘어가는 기능을 추가합니다.
            container.addEventListener('click', function() {
                currentIndex = (currentIndex + 1) % items.length; // 다음 이미지의 인덱스를 계산합니다.
                showImage(currentIndex); // 다음 이미지를 표시합니다.
                resetTimer(); // 이미지가 클릭되면 타이머를 재설정합니다.
            });
            
            // 초기에 첫 번째 이미지를 표시합니다.
            showImage(currentIndex);
            
            // 타이머를 설정하여 일정 간격으로 이미지를 변경합니다.
            var timer = setInterval(function() {
                currentIndex = (currentIndex + 1) % items.length; // 다음 이미지의 인덱스를 계산합니다.
                showImage(currentIndex); // 다음 이미지를 표시합니다.
            }, 1000); // 1초마다 이미지 변경
            
            // showImage 함수 정의
            function showImage(index) {
                // 현재 이미지를 표시하기 전에 이전에 표시된 이미지를 삭제합니다.
                container.innerHTML = '';
                
                // 선택한 이미지를 생성하고 표시합니다.
                var imageUrl = items[index].textContent;
                var imgElement = document.createElement("img");
                imgElement.src = imageUrl;
                container.appendChild(imgElement);
            }
            
            // 타이머를 재설정하는 함수
            function resetTimer() {
                clearInterval(timer); // 기존 타이머를 정지합니다.
                timer = setInterval(function() {
                    currentIndex = (currentIndex + 1) % items.length; // 다음 이미지의 인덱스를 계산합니다.
                    showImage(currentIndex); // 다음 이미지를 표시합니다.
                }, 1000); // 1초마다 이미지 변경
            }
        },
        error: function(xhr, status, error) {
            // 오류 발생 시 처리할 코드
            console.error("Error:", error);
        }
    });
}
<!--});-->
</script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="main">
 <jsp:include page="../include/header.jsp"/> 
  <div class="main-body">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
      <div class="col-span-2 p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between mb-4">
          <div class="flex items-center space-x-2">
            <button class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 px-4 py-2">
              기상정보
            </button>
            <button
              type="button"
              role="combobox"
              aria-controls="radix-:r1n:"
              aria-expanded="false"
              aria-autocomplete="none"
              dir="ltr"
              data-state="closed"
              data-placeholder=""
              class="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
              id="location"
            >
              <span style="pointer-events: none;">지역선택</span>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="h-4 w-4 opacity-50"
                aria-hidden="true"
              >
                <path d="m6 9 6 6 6-6"></path>
              </svg>
            </button>
          </div>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="text-gray-600"
          >
            <path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
        </div>
        <div class="flex items-center justify-between">
          <div class="text-6xl font-bold">5.2° 올림</div>
          <div class="flex items-center space-x-4">
            <div class="text-sm">
              <p>습도 88%</p>
              <p>바람 2.5m/s - 3.8m/s</p>
            </div>
            <div class="text-sm">
              <p>미세먼지 보통</p>
              <p>일출 06:26</p>
            </div>
          </div>
        </div>
        <div class="mt-4">
          <div class="flex items-center justify-between">
            <div class="text-center">
              <div>11시</div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="text-blue-500"
              >
                <path d="M17.5 21H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"></path>
                <path d="M22 10a3 3 0 0 0-3-3h-2.207a5.502 5.502 0 0 0-10.702.5"></path>
              </svg>
              <div>6°</div>
            </div>
          </div>
        </div>
        <div class="mt-4 grid grid-cols-3 gap-4">
          <div class="text-center">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="text-blue-500"
            >
              <path d="M4 14.899A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.242"></path>
              <path d="M16 14v6"></path>
              <path d="M8 14v6"></path>
              <path d="M12 16v6"></path>
            </svg>
            <div>강수량</div>
            <div>0.5 mm</div>
          </div>
        </div>
      </div>
      <div class="p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between mb-4">
          <div class="font-bold text-lg">전국날씨</div>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="text-gray-600"
          >
            <circle cx="12" cy="12" r="1"></circle>
            <circle cx="12" cy="5" r="1"></circle>
            <circle cx="12" cy="19" r="1"></circle>
          </svg>
        </div>
        <div class="flex items-center justify-between">
          <div class="text-center">
            <div>서울</div>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="text-yellow-400"
            >
              <path d="M10 9a3 3 0 1 0 0 6"></path>
              <path d="M2 12h1"></path>
              <path d="M14 21V3"></path>
              <path d="M10 4V3"></path>
              <path d="M10 21v-1"></path>
              <path d="m3.64 18.36.7-.7"></path>
              <path d="m4.34 6.34-.7-.7"></path>
              <path d="M14 12h8"></path>
              <path d="m17 4-3 3"></path>
              <path d="m14 17 3 3"></path>
              <path d="m21 15-3-3 3-3"></path>
            </svg>
            <div>4.5°</div>
          </div>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mt-4">
      <div class="col-span-2 p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between">
          <div class="text-center">
            <div>월</div>
            <div>3.26.</div>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="text-blue-500"
            >
              <path d="M17.5 21H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"></path>
              <path d="M22 10a3 3 0 0 0-3-3h-2.207a5.502 5.502 0 0 0-10.702.5"></path>
            </svg>
            <div>4° / 13°</div>
          </div>
        </div>
      </div>
      <div class="p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between mb-4">
          <div class="font-bold text-lg">일출/일몰</div>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="text-gray-600"
          >
            <circle cx="12" cy="12" r="1"></circle>
            <circle cx="12" cy="5" r="1"></circle>
            <circle cx="12" cy="19" r="1"></circle>
          </svg>
        </div>
        <div class="flex items-center justify-between">
          <div class="text-center">
            <div>오늘 03.26.</div>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="text-yellow-500"
            >
              <path d="M12 2v8"></path>
              <path d="m4.93 10.93 1.41 1.41"></path>
              <path d="M2 18h2"></path>
              <path d="M20 18h2"></path>
              <path d="m19.07 10.93-1.41 1.41"></path>
              <path d="M22 22H2"></path>
              <path d="m8 6 4-4 4 4"></path>
              <path d="M16 18a4 4 0 0 0-8 0"></path>
            </svg>
            <div>06:26</div>
          </div>
          <div class="text-center">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="text-orange-500"
            >
              <path d="M12 10V2"></path>
              <path d="m4.93 10.93 1.41 1.41"></path>
              <path d="M2 18h2"></path>
              <path d="M20 18h2"></path>
              <path d="m19.07 10.93-1.41 1.41"></path>
              <path d="M22 22H2"></path>
              <path d="m16 6-4 4-4-4"></path>
              <path d="M16 18a4 4 0 0 0-8 0"></path>
            </svg>
            <div>18:50</div>
          </div>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mt-4">
      <div class="col-span-2 p-4 bg-white rounded-lg shadow">
      	
      	<!-- api 데이터 삽입 -->
      	<form action="NewInsert" method="post">
      	<div class="frame">
      	 <button type="submit" class="custom-btn btn-8"><span>New</span></button>
      	</div>
        </form>
        <form action="${cp}/Weather/searchWeather" method="post" class="home-serach-form">
             <input type="text" value="지역을 검색하세요" id="area" name="area">
             <button type="submit" class="btn btn-primary" value="검색">검색</button>
        </form>
     <button onclick="fetchData()">Load Images</button>
		<div id="satellight"></div>
	  
	   <table border="1" style="table-layout:fixed">
    <thead>
    </thead>
    <tbody>
    <tr>
    	<td style="width:20 0">습도:</td>
        <c:forEach var="item" items="${searchweather}">
                <c:if test="${item.category eq 'REH'}">
                   <td>${item.fcstValue}%</td>
                </c:if>
                <c:if test="${item.category eq 'SKY'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'POP'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'TMP'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'UUU'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'VEC'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'VVV'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <c:if test="${item.category eq 'PCP'}">
                   <tr>${item.fcstValue}</tr>
                </c:if>
                <!-- Add more conditions for other categories if needed -->
        </c:forEach>
    </tr>
    </tbody>
</table>

       
	
	
	
	
	
	<!-- 현재 시간 정보 (서울) 메인에 박아둘 정보 -->	
	<c:forEach var="value" items="${nowWeather}" varStatus="loop">
	    <c:if test="${loop.index == 0}">
	        현재 기온 : ${value}
	    </c:if>
	    <c:if test="${loop.index == 1}">
	        현재 풍속(동서) : ${value}
	    </c:if>
	    <c:if test="${loop.index == 2}">
	        현재 풍속(남북) : ${value}
	    </c:if>
	    <c:if test="${loop.index == 3}">
	        현재 풍향 : ${value}
	    </c:if>
	    <c:if test="${loop.index == 4}">
	        현재 상태 : ${value}
	    </c:if>
	    <c:if test="${loop.index == 5}">
	        현재 강수확률 : ${value}
	    </c:if>
	    <c:if test="${loop.index == 6}">
	        현재 강수량 : ${value}
	    </c:if>
	    <c:if test="${loop.index == 7}">
	        현재 습도 : ${value}
	    </c:if>
	</c:forEach>

<!--  데이터들을 가지고 와서 foreach문으로 뿌려주기 -->


        <div class="flex items-center justify-between">
          <div class="w-full h-48 bg-gray-200 rounded-lg"></div>
          <div class="w-full h-48 bg-gray-200 rounded-lg"></div>
        </div>
      </div>
      <div class="p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between mb-4">
          <div class="font-bold text-lg">강수확률</div>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="text-gray-600"
          >
            <circle cx="12" cy="12" r="1"></circle>
            <circle cx="12" cy="5" r="1"></circle>
            <circle cx="12" cy="19" r="1"></circle>
          </svg>
        </div>
        <div class="flex items-center justify-between">
          <div class="w-full"></div>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mt-4">
      <div class="col-span-2 p-4 bg-white rounded-lg shadow">
        <div class="flex items-center justify-between">
          <div class="w-full h-48 bg-gray-200 rounded-lg"></div>
          <div class="w-full h-48 bg-gray-200 rounded-lg"></div>
        </div>
      </div>
      <div class="p-4 bg-white rounded-lg shadow">
        <div class="text-xs text-gray-500"></div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
