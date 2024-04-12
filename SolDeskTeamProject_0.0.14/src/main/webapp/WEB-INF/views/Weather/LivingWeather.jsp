<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미세먼지 페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${cp}/resources/LivingWeather.css">
<script src="${cp}/resources/LivingLogic.js"></script>
</head>
<body>

		<!-- 큰 틀 화면을 담을 div -->
	<div class="main-home">
		<c:import url="/WEB-INF/views/include/header.jsp"/>
		
		<div class="living-center-line">

			<div class="living-center-left-line">
				<div class="living-center-left-content">
				
				</div>
			</div>

			<div class="living-center-right-line">
				<div class="living-center-right-content">
				
				</div>
			</div>
			
		</div>
	</div>

</body>
</html>