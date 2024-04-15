<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/Home.css">
<script src="${cp}/resources/HomeLogic.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7&submodules=geocoder"></script>
<meta charset="UTF-8">
<title>기상정보공유사이트 - (GJG)</title>
</head>
<body>
<!-- 메인 홈 시작 -->
    <div class="main-home">
		<c:import url="/WEB-INF/views/include/header.jsp"/>
        <!-- 메인 홈 센터 시작 -->
        <div class="main-home-center-line">
            <div class="home-center-left-line">
                <div class="home-center-left-small-box-line">
                	<c:forEach var="i" begin="0" end="13">
                		<div class="home-center-top-box" id="homeCenterTopBox${i}"></div>
	        		</c:forEach>
                </div>
                <div class="home-center-left-big-box-line">
                    <div class="home-center-left-big-box" id="homeCenterBigBox0"></div>
                </div>
            </div>
            <div class="home-center-right-line">
                <div class="home-center-right-map-line">
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