<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미세먼지 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/DustStyle.css">
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
                <div class="dust-top-icon" id="dustTopIconWord"> 기상정보공유사이트</div>
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
		
		<div class="dust-center-line">
			<!-- 이곳에 메인 콘텐츠의 내용을 넣어주세요 -->
			<div class="dust-center-content-left">
			
				<div class="dust-center-left-content-button" id="dustCenterLeftContentButton">
					>
				</div>
				
				<div class="dust-center-left-header-line">
        	<c:forEach var="i" begin="0" end="4">
        		<div class="dust-center-left-header-icon" id="dustCenterLeftHeaderIcon${i}">
        		</div>
	        </c:forEach>
				
					
				
				</div>
				
				<div class= "dust-center-content-main" 
				<%-- id="dustCenterContentMain" data-jsondata="${jsonImageData}" --%>
				>
				<script>
    $(document).ready(function(){
        var totalCount = ${dust.response.body.totalCount}; // totalCount 가져오기
        var currentIndex = 0; // 현재 이미지의 인덱스를 나타내는 변수
        var currentTabIndex = 1; // 현재 탭 인덱스를 나타내는 변수 (1: 미세먼지, 2: 초미세먼지)
        var imageUrlsPm10 = [
            <c:forEach var="i" begin="0" end="${dust.response.body.totalCount - 1}" varStatus="loop">
                "${dust.response.body.items.get(loop.index).imageUrl1}",
                "${dust.response.body.items.get(loop.index).imageUrl2}",
                "${dust.response.body.items.get(loop.index).imageUrl3}"
                ${not loop.last ? ',' : ''}
            </c:forEach>
        ];
        var imageUrlsPm25 = [
            <c:forEach var="i" begin="0" end="${dust.response.body.totalCount - 1}" varStatus="loop">
                "${dust.response.body.items.get(loop.index).imageUrl4}",
                "${dust.response.body.items.get(loop.index).imageUrl5}",
                "${dust.response.body.items.get(loop.index).imageUrl6}"
                ${not loop.last ? ',' : ''}
            </c:forEach>
        ];
	
        // 초기 이미지 표시
        showImage();

     // 이미지를 표시하는 함수
        function showImage() {
            var imageUrlIndex = currentIndex % 3;
            var imageUrl;

            if (currentTabIndex === 1 && imageUrlsPm10 && imageUrlsPm10[currentIndex]) {
                imageUrl = imageUrlsPm10[currentIndex];
            } else if (currentTabIndex === 2 && imageUrlsPm25 && imageUrlsPm25[currentIndex]) {
                imageUrl = imageUrlsPm25[currentIndex];
            }

            // 이미지 출력
            if (imageUrl && imageUrl.trim() !== "") {
                $('.dust-center-content-main').empty().append($('<img>').attr('src', imageUrl));
            }
        }

        // 버튼 클릭 시 다음 이미지 표시
        $('.dust-center-left-content-button').click(function(){
            currentIndex++; // 다음 이미지로 이동

            showImage(); // 변경된 이미지 표시
        });

        // 미세먼지 탭 클릭 시
        $('#dustCenterLeftHeaderIcon0').click(function(){
            currentTabIndex = 1; // 탭 인덱스 설정
            currentIndex = 0; // 첫 번째 이미지부터 시작
            showImage(); // 변경된 이미지 표시
        });

        // 초미세먼지 탭 클릭 시
        $('#dustCenterLeftHeaderIcon1').click(function(){
            currentTabIndex = 2; // 탭 인덱스 설정
            currentIndex = 0; // 첫 번째 이미지부터 시작
            showImage(); // 변경된 이미지 표시
        });
    });
</script>
				</div>
				
				<!-- <script>
					var mapOptions = {
						center : new naver.maps.LatLng(37.3595704, 127.105399),
						zoom : 10
					};

					var map = new naver.maps.Map('dust_center_content_left',mapOptions);
				</script> -->
				

			</div>
			<div class="dustCenterRight">
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
		</div>
	</div>

</body>
</html>