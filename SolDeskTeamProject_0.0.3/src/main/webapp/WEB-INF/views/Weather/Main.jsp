<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/WeatherHome.css">
<script src="${cp}/resources/WeatherHome.js"></script>
<meta charset="UTF-8">
<title>기상정보 공유사이트</title>
</head>
<body>
ㅋㅋㅋㅋㅋ
2024-03-28 09시 : ${living.response.body.items.item.get(0).h3}
<br>
2024-03-28 12시 : ${living.response.body.items.item.get(0).h6}
<br>
2024-03-28 15시 : ${living.response.body.items.item.get(0).h9}
<br>
2024-03-28 18시 : ${living.response.body.items.item.get(0).h12}
<br>
2024-03-28 21시 : ${living.response.body.items.item.get(0).h15}
<br>
2024-03-29 00시 : ${living.response.body.items.item.get(0).h18}
<br>
2024-03-29 03시 : ${living.response.body.items.item.get(0).h21}
<br>
2024-03-29 06시 : ${living.response.body.items.item.get(0).h24}
     <!-- 메인 홈 시작 -->
    <div class="main-home">
    <!-- 메인 홈 톱 시작 -->
        <div class="main-home-top-line">
            <div class="home-top-icon-line">
            </div>
            <div class="home-top-menu-line">
            </div>
        </div>
    <!-- 메인 홈 톱 끝 -->

    <!-- 메인 홈 하이 시작 -->
        <div class="main-home-high-line">
            <div class="home-high-icon-line">
            </div>
	        <div class="home-high-serach-line">
	            <div class="home-high-left-serach-line">
	            </div>
	            <div class="home-high-right-serach-line">
	            </div>
	        </div>
        </div>
    <!-- 메인 홈 하이 끝 -->

    <!-- 메인 홈 헤더 시작 -->
        <div class="main-home-header-line">

        </div>
    <!-- 메인 홈 헤더 끝 -->

    <!-- 메인 홈 센터 시작 -->
        <div class="main-home-center-line">
            <div class="home-center-left-line">
                <div class="home-center-left-top-line">
                </div>
                <div class="home-center-left-bottom-line">
                </div>
            </div>
            <div class="home-center-right-line">
            </div>
        </div>
    <!-- 메인 홈 센터 끝 -->

    <!-- 메인 홈 바텀 시작 -->
        <div class="main-home-bottom-line">

        </div>
    <!-- 메인 홈 바텀 끝 -->
    </div>

    <!-- 메인 홈 끝 -->
</body>
</html>