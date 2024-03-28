<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<script src="${cp}/resources/WeatherHome.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
</h1>
<hr>
<h1>
<a href="Weather/Main?area=서울">메인홈페이지 테스트</a>
<a href="Weather/MediumWeather?area=서울">중기예보페이지 테스트</a>

</h1>
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>