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
        <c:forEach var="search" items="${shortweather}">
		</c:forEach>
		
		<c:forEach var="weather" items="${nowWeather}">
			${weather.get(0).category}		
		</c:forEach>
		
		현재 지역 : 
		현재 기온 :
		현재 날씨 :
		현재 습도 : 
		현재 시간 :
		현재 강수량 :

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
