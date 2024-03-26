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
${as.response.body.items.item.get(0).h6}
    <!-- 메인 홈 시작 -->
    <div class="main_home">

    <!-- 메인 홈 톱 시작 -->
        <div class="main_home_top_line">
            <div class="home_top_icon_line">
            </div>
            <div class="home_top_menu_line">
            </div>
        </div>
    <!-- 메인 홈 톱 끝 -->

    <!-- 메인 홈 하이 시작 -->
        <div class="main_home_high_line">
            <div class="home_high_icon_line">
            </div>
            <div class="home_high_serach_line">
                <div class="home_high_left_serach_line">
                </div>
                <div class="home_high_right_serach_line">
                </div>
            </div>
        </div>
    <!-- 메인 홈 하이 끝 -->

    <!-- 메인 홈 헤더 시작 -->
        <div class="main_home_header_line">

        </div>
    <!-- 메인 홈 헤더 끝 -->

    <!-- 메인 홈 센터 시작 -->
        <div class="main_home_center_line">
            <div class="home_center_left_line">
                <div class="home_center_left_top_line">
                </div>
                <div class="home_center_left_bottom_line">
                </div>
            </div>
            <div class="home_center_right_line">
            </div>
        </div>
    <!-- 메인 홈 센터 끝 -->

    <!-- 메인 홈 바텀 시작 -->
        <div class="main_home_bottom_line">

        </div>
    <!-- 메인 홈 바텀 끝 -->
    </div>

    <!-- 메인 홈 끝 -->
</body>
</html>