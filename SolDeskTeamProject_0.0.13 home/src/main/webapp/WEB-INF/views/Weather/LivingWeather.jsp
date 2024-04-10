<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8mxlng67d7&submodules=geocoder"></script>
<script src="${cp}/resources/LivingLogic.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/LivingWeather.css">
<title>생활기상지수</title>
</head>
<body>
	<div class="main-living">
		<c:import url="/WEB-INF/views/include/header.jsp"/>
        <!-- 메인 홈 센터 시작 -->
        <div class="main-living-center-line">
            <div class="living-center-left-line">
                <div class="living-center-left-small-box-line">
                	<c:forEach var="i" begin="0" end="13">
                		<div class="living-center-top-box" id="livingCenterTopBox${i}"></div>
	        		</c:forEach>
                </div>
                <div class="living-center-left-big-box-line">
                    <div class="living-center-left-big-box" id="livingCenterBigBox0"></div>
                </div>
            </div>
            <div class="living-center-right-line">
                <div class="living-center-right-map-line">
                	<div class="living-center-right-map-btn">
                		<div class="switch-btn" id="switchBtn1"></div>
                		<div class="switch-btn" id="switchBtn2"></div>
                	</div>
                	
                	<div class="living-center-right-map" id="livingCenterMap">
                	</div>
                	
                	<div class="living-center-right-map-btn">
                		<div class="map-btn" id="mapBtn0"></div>
                		<div class="map-btn" id="mapBtn1"></div>
                		<div class="map-btn" id="mapBtn2"></div>
                	</div>
                </div>
            </div>
        </div>
        <!-- 메인 홈 센터 끝 -->
        
        <!-- 메인 홈 바텀 시작 -->
        <div class="main-living-bottom-line">
            <div class="living-bottom-icon" id="livingBottomIcon0"></div>
        	<c:forEach var="i" begin="0" end="4">
        		<div class="living-bottom-word" id="livingBottomWord${i}"></div>
			</c:forEach>
        </div>
        <!-- 메인 홈 바텀 끝 -->
    </div>
    <!-- 메인 홈 끝 -->

</body>
</html>