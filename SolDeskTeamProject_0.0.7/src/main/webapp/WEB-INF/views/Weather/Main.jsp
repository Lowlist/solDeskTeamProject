<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/WeatherHome.css">
<script src="${cp}/resources/MainLogic.js"></script>
<meta charset="UTF-8">
<title>기상정보공유사이트 - (GJG)</title>
</head>
<body>
<%-- 2024-03-27 09시 : ${air.response.body.items.item.get(0).h3}
<br>
2024-03-27 12시 : ${air.response.body.items.item.get(0).h6}
<br>
2024-03-27 15시 : ${air.response.body.items.item.get(0).h9}
<br>
2024-03-27 18시 : ${air.response.body.items.item.get(0).h12}
<br>
2024-03-27 21시 : ${air.response.body.items.item.get(0).h15}
<br>
2024-03-28 00시 : ${air.response.body.items.item.get(0).h18}
<br>
2024-03-28 03시 : ${air.response.body.items.item.get(0).h21}
<br>
2024-03-28 03시 : ${air.response.body.items.item.get(0).h21}
<br>
2024-03-20 평균기온:${asos.response.body.items.item.get(0).avgTa}
<br>
2024-03-27 09시 : ${uv.response.body.items.item.get(0).h3}
<br>
2024-03-27 12시 : ${uv.response.body.items.item.get(0).h6}
<br>
2024-03-27 15시 : ${uv.response.body.items.item.get(0).h9}
<br>
2024-03-27 18시 : ${uv.response.body.items.item.get(0).h12}
<br>
2024-03-27 21시 : ${uv.response.body.items.item.get(0).h15}
<br>
2024-03-28 00시 : ${uv.response.body.items.item.get(0).h18}
<br>
2024-03-28 03시 : ${uv.response.body.items.item.get(0).h21}
<br>
2024-03-28 03시 : ${uv.response.body.items.item.get(0).h21}
<br> --%>
	    <!-- 메인 홈 시작 -->
    <div class="main-home">
        <!-- 메인 홈 톱 시작 -->
        <div class="main-home-top-line">
            <div class="home-top-icon-line">
                <div class="home-top-icon" id="homeTopIconImg"></div>
                <div class="home-top-icon" id="homeTopIconWord"> 기상정보공유사이트</div>
            </div>
            <div class="home-top-menu-line">
                <!-- 좌측부터 1번으로 시작함 -->
                <c:forEach var="i" begin="0" end="2">
                	<div class="home-top-menu-word" id="homeTopMenuWord${i}"></div>
                </c:forEach>
            </div>
        </div>
        <!-- 메인 홈 톱 끝 -->
        <!-- 메인 홈 하이 시작 -->
        <div class="main-home-high-line">
            <div class="home-high-icon-line" id="homeHighImg">
            	<div id="homeHighIcon"></div>
            </div>
            <div class="home-high-serach-line">
                <div class="home-high-left-serach-line">
                    <form action="" method="get">
                        <input type="text" value="'관측'을 검색하세요" id="homeSearchWord">
                        <input type="submit" id="homeSearchBtn" data-searchMain="">
                    </form>
                </div>
                <div class="home-high-right-serach-line">
                    <div class="home-high-right-popular-serach-line">
	                    <c:forEach var="i" begin="0" end="9">
	                    	<div class="home-popular-serach" id="homePopularSerach${i}"></div>
	                	</c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- 메인 홈 하이 끝 -->

        <!-- 메인 홈 헤더 시작 -->
        <div class="main-home-header-line">
        	<c:forEach var="i" begin="0" end="4">
        		<div class="home-header-menu" id="homeHeaderMenu${i}"></div>
	        </c:forEach>
        </div>
        <!-- 메인 홈 헤더 끝 -->

        <!-- 메인 홈 센터 시작 -->
        <div class="main-home-center-line">
            <div class="home-center-left-line">
                <div class="home-center-left-small-box-line">
                	<c:forEach var="i" begin="0" end="6">
                		<div class="home-center-top-box" id="homeCenterTopBox${i}"></div>
	        		</c:forEach>
                </div>
                <div class="home-center-left-big-box-line">
                    <div class="home-center-left-big-box" id="homeCenterBigBox0"></div>
                </div>
            </div>
            <div class="home-center-right-line">
                <div class="home-center-right-big-box-line">
                    <div class="home-center-right-big-box" id="homeCenterBigBox1"></div>
                </div>
            </div>
        </div>
        <!-- 메인 홈 센터 끝 -->

        <!-- 메인 홈 바텀 시작 -->
        <div class="main-home-bottom-line">
            <div class="home-bottom-icon" id="homeBottomIcon0"></div>
        	<c:forEach var="i" begin="0" end="4">
        		<div class="home-bottom-word" id="homeBottomWord${i}"></div>
			</c:forEach>
        </div>
        <!-- 메인 홈 바텀 끝 -->
    </div>

    <!-- 메인 홈 끝 -->
</body>
</html>