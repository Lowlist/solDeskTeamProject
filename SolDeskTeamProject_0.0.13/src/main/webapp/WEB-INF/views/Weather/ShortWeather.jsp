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

<!-- shortWeather css -->
<link href="${cp}/resources/ShortWeather.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!-- 위쪽 헤더 -->
<jsp:include page="../include/header.jsp"/>
<!-- 안쪽 헤더 -->
<div class="inner_header">
  <!-- 메인 로고 -->
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
  <!-- 메뉴 -->
  <div class="menu">
    <!-- role은 태그의 구조 및 동작에 대한 정보(역할)을 전달하기 위한 목적일 뿐 -->
    <ul role="menubar">
      <li role="menuitem">
        <a href="#">홈</a>
      </li>
      <li role="menuitem">
        <a href="#">예보비교</a>
      </li>
      <li role="menuitem">
        <a href="#">미세먼지</a>
      </li>
      <li role="menuitem">
        <a href="#">지도</a>
      </li>
      <li role="menuitem">
        <a href="#">영상</a>
      </li>
      <li role="menuitem">
        <a href="#">기상특보</a>
      </li>
    </ul>
  </div>

  <!-- 로그인 -->
  <div class="login">
    <button>로그인</button>
  </div>

</div>

<!-- 내용 -->
<div class="main">
  <!-- 왼쪽 구역 -->
  <div class="content_left">
    <!-- 왼쪽 구역1 -->
    <div class="content_left_1">
      <button>기상정보</button>
      <select>
        <option value="">지역선택</option>
        <option value="">서울</option>
        <option value="">인천</option>
        <option value="">부산</option>
      </select>
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="20"
        height="20"
        viewBox="0 0 512 512"
      >
      <path d="M463.5 224H472c13.3 0 24-10.7 24-24V72c0-9.7-5.8-18.5-14.8-22.2s-19.3-1.7-26.2 5.2L413.4 96.6c-87.6-86.5-228.7-86.2-315.8 1c-87.5 87.5-87.5 229.3 0 316.8s229.3 87.5 316.8 0c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0c-62.5 62.5-163.8 62.5-226.3 0s-62.5-163.8 0-226.3c62.2-62.2 162.7-62.5 225.3-1L327 183c-6.9 6.9-8.9 17.2-5.2 26.2s12.5 14.8 22.2 14.8H463.5z"/></svg>
    </div>
    <!-- 왼쪽 구역2 -->
    <div class="content_left_2">
      <!-- api 데이터 삽입 -->
   		<form action="NewInsert" method="post">
   		<div class="frame">
   			<button type="submit" class="custom-btn btn-8"><span>New</span></button>
   		</div>
     	</form>
    </div>
    <!-- 왼쪽 구역3 -->
    <div class="content_left_3">
    	<form action="${cp}/Weather/searchWeather" method="post" class="home-serach-form">
			<input type="text" value="지역을 검색하세요" id="area" name="area">
            <button type="submit" class="btn btn-primary" value="검색">검색</button>
        </form>        
       <table>
        <!-- 표 머릿글 -->
        <!-- <thead>
        </thead> -->
        <!-- 표 본문글 -->
        <tbody>
          <!-- 시간별로 반복 -->
          <!-- 날짜 -->
<%-- 		<c:forEach var="date" begin="0" end="23" step="1"> --%>
		
<!-- 		<!-- 시간 --> -->
<%--           <c:forEach var="hour" begin="0" end="23" step="1"> --%>
<%--           	<c:set var="formattedHour" value="${hour < 10 ? '0' + hour : hour}" /> --%>
          	
<!--             <tr> -->
<%--               <td>${hour}시</td> --%>
<!--               각 카테고리의 값 출력 -->
<%--               <c:forEach var="item" items="${searchweather}"> --%>
<!--                   현재 시간과 카테고리가 일치할 때만 값을 표시 -->
<%--                   <c:if test="${item.fcstTime == formattedHour}"> --%>
<%--                       <c:choose> --%>
<%--                           <c:when test="${item.category eq 'TMP'}"> --%>
<%--                               <td>${item.fcstValue}</td> --%>
<%--                           </c:when> --%>
<%--                           <c:when test="${item.category eq 'VEC'}"> --%>
<%--                               <td>${item.fcstValue}</td> --%>
<%--                           </c:when> --%>
<%--                           <c:when test="${item.category eq 'PCP'}"> --%>
<%--                               <td>${item.fcstValue}</td> --%>
<%--                           </c:when> --%>
<!--                           추가 카테고리에 대한 처리 -->
<%--                       </c:choose> --%>
<%--                   </c:if> --%>
<%--               </c:forEach> --%>
<!--             </tr> -->
<%--           </c:forEach> --%>
<%--         </c:forEach> --%>
        </tbody>              
      </table>
    </div> 
    <!-- 왼쪽 구역4 -->
    <div class="content_left_4">
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
		        </c:forEach>
			    </tr>
		    </tbody>
		</table>
    </div>
    <!-- 왼쪽 구역5 -->
    <div class="content_left_5">
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
    </div>
    <!-- 왼쪽 구역6 -->
    <div class="content_left_6">왼6</div>
  </div>

  <!-- 오른쪽 구역 -->
  <div class="content_right">
    <!-- 오른쪽 구역1 -->
    <div class="content_right_1">오1</div>
    <!-- 오른쪽 구역2 -->
    <div class="content_right_2">오2</div>
    <!-- 오른쪽 구역3 -->
    <div class="content_right_3">오3</div>
    <!-- 오른쪽 구역4 -->
    <div class="content_right_4">오4</div>
    <!-- 오른쪽 구역5 -->
    <div class="content_right_5">오5</div>
  </div>
</div>
</body>
</html>
