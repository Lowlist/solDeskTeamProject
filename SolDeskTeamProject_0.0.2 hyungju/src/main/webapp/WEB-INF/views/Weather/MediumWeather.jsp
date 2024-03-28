<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${cp}/resources/MediumFc.css">
<title>Insert title here</title>
</head>
<body>
	${temper.response.body.items.item.get(0).regId}
	
	${weather.response.body.items.item.get(0).wf3Am}
    <!-- 중기예보 페이지 큰틀 -->
    <div class="medium-forecast">

        <!-- 중기예보 페이지 탑 -->
        <div class="medium-forecast-top-line">
            <div class="medium-top-icon-line">
                <div class="mediumIcons" id="goHome"><h1>메인페이지</h1></div>
                <div class="mediumIcons"><h2>페이지1</h2></div>
                <div class="mediumIcons"><h2>페이지2</h2></div>
                <div class="mediumIcons"><h2>페이지3</h2></div>
                <div class="mediumIcons"><h2>페이지4</h2></div>
                <div class="mediumIcons"><h2>페이지5</h2></div>
            </div>
        </div>
        <!-- 중기예보 페이지 끝 -->

        <!-- 중기예보 하이 페이지 시작 -->
        <div class="medium-high-line">
            <div class="medium-high-icon-line">
             <h1>대충 사이트내 기능들</h1>
            </div>
            <div class="home-high-serach-line">
                <div class="home-high-left-serach-line">
                </div>
                <div class="home-high-right-serach-line">
                </div>
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
                <div class="home-center-left-top-line">
                </div>
                <div class="home-center-left-bottom-line">
                </div>
            </div>
            <div class="home-center-right-line">
            </div>
        </div>
        <!-- 중기예보 센터 끝 -->

        <!-- 중기예보 바텀 시작 -->
        <div class="medium-bottom-line">

        </div>
        <!-- 중기예보 바텀 끝 -->
    </div>

    <!-- 중기예보 끝 -->
</body>
</html>