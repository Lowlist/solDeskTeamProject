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
	href="${cp}/resources/DustStyle.css">
<script src="${cp}/resources/DustLogic.js"></script>
<!-- <script type="text/javascript" -->
<!-- 	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eidrzi1ypl"></script> -->
</head>
<body>
	<!-- <div id="map" style="width: 100%; height: 400px;"></div>
	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.3595704, 127.105399),
			zoom : 10
		};

		var map = new naver.maps.Map('map', mapOptions);
	</script> -->

	<!-- 큰 틀 화면을 담을 div -->
	<div class="dust-main">
		<!-- 메인 메뉴 배너를 담을 div -->
		<div class="dust-top-line">
			<div class="dust-top-icon-line">
				<div class="dust-top-icon" id="dustTopIconImg"></div>
				<div class="dust-top-icon" id="dustTopIconWord">기상정보공유사이트</div>
			</div>
			<div class="dust-top-menu-line">
				<!-- 좌측부터 1번으로 시작함 -->
				<c:forEach var="i" begin="0" end="2">
					<div class="dust-top-menu-word" id="dustTopMenuWord${i}"></div>
				</c:forEach>
			</div>
			<!-- 이곳에 메인 메뉴 배너의 내용을 넣어주세요 -->
		</div>

		<div class="dust-high-line">
			<div class="dust-high-icon-line" id="dustHighImg">
				<div id="dustHighIcon"></div>
			</div>
		</div>

				<div class="dust-center-left-header-line">
					<c:forEach var="i" begin="0" end="4">
						<div class="dust-center-left-header-icon"
							id="dustCenterLeftHeaderIcon${i}"></div>
					</c:forEach>
				</div>
		<div class="dust-center-line">
			<!-- 이곳에 메인 콘텐츠의 내용을 넣어주세요 -->
			
			<div class="dust-center-content-left">


				<div class="dust-center-content-main">

					<div class="dust-center-content-main-area">
						<c:forEach var="i" begin="0"
							end="${dust.response.body.totalCount - 1}">
							<c:set var="items" value="${dust.response.body.items}"/>
							<div class="item" id="item${i}"
								data-image-url1="${items.get(i).imageUrl1}"
								data-image-url2="${items.get(i).imageUrl2}"
								data-image-url3="${items.get(i).imageUrl3}"
								data-image-url4="${items.get(i).imageUrl4}"
								data-image-url5="${items.get(i).imageUrl5}"
								data-image-url6="${items.get(i).imageUrl6}"
								data-inform-data="${items.get(i).informData}"
								data-data-time="${items.get(i).dataTime}"
								data-inform-grade="${items.get(i).informGrade}">
							</div>
						</c:forEach>
					</div>
					
					<!-- <script>
					var mapOptions = {
						center : new naver.maps.LatLng(37.3595704, 127.105399),
						zoom : 10
					};

					var map = new naver.maps.Map('dust_center_content_left',mapOptions);
				</script> -->


			</div>
		</div>
			<div class="dust-center-right">
				<c:forEach var="i" begin="0" end="1">
					<c:set var="dustInfo"
						value="${dust.response.body.items.get(i).informCause}" />
					<c:set var="label" value="" />
					<c:choose>
						<c:when test="${i eq 0}">
							<c:set var="label" value="오늘 미세먼지 : " />
						</c:when>
						<c:when test="${i eq 1}">
							<c:set var="label" value="내일 미세먼지 예상 : " />
						</c:when>
					</c:choose>

					<div id="dustCenterRightContent" data-dusts="${dustInfo}">
						${label}
						<c:out value="${dustInfo}" />
					</div>
				</c:forEach>
			</div>
			<div class="dust-center-left-content-button"
						id="dustCenterLeftContentButton">></div>
	</div>
	</div>

</body>
</html>